/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max
 */
public class PlayerJoin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        
        try {  
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
        
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
        if(rs.next()) {
            if(rs.getString(3).equals(password)) {
                GameManager.newPlayer(request.getSession(), userName);
            } else {
                String message = "User name or password don't match";
                response.sendRedirect("index.jsp?error="+message);
                st.close();
                return;
            }
        } else {
            String message = "User name or password don't match";
            response.sendRedirect("index.jsp?error="+message);
            st.close();
            return;
        }
        st.close();
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "There was a problem logging you in";
        response.sendRedirect("index.jsp?error="+message);
        return;
    }
        
        
        
        // forward player to game lobby
        this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Log on to the server";
    }
    
}
