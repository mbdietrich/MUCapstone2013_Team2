/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max
 */
public class PlayerJoin extends HttpServlet {

    private static final boolean LOCAL_TEST = true;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        
        if(!LOCAL_TEST){
  
        String dbResponse = databaseAccess.checkLoginCredentials(userName, password);
        if(dbResponse.equals("loginError")) {
            String message = "User name or password don't match";
            response.sendRedirect("index.jsp?error="+message);
        } else if(dbResponse.equals("exception")) {
            String message = "There was a problem logging you in";
        response.sendRedirect("index.jsp?error="+message);
        } else {
            GameManager.newPlayer(request.getSession(), dbResponse);
            // forward player to the main page
            this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
        }
        }
        //If LOCAL_TEST, skip db auth
        else{
            GameManager.newPlayer(request.getSession(), userName+"_LOCALTEST");
            // forward player to the main page
            this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Log on to the server";
    }
    
}
