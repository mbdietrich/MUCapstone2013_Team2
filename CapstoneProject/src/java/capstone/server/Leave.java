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
 * Servlet for leaving a game
 */
public class Leave extends HttpServlet {
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GameManager.leave(request.getSession());
        this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
    }

        
    @Override
    public String getServletInfo() {
        return "Lets player leave the game";
    }
}
