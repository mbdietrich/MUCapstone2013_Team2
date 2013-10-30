/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.server.util.GameManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max Servlet for leaving a game
 */
public class Leave extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //if player is leaving a private game they have invited someone to, remove the invitation
        SendPrivateGameInvite.invites.remove(request.getSession().getAttribute("gid").toString());
        SendPrivateGameInvite.invites.remove(request.getSession().getAttribute("fbid").toString());
        
        try{
        GameManager.leave(request.getSession());
        }
        finally{
        if (request.getParameter("redirect") != null) {
            this.getServletContext().getRequestDispatcher(request.getParameter("redirect")).forward(request, response);
        }
        else{
            this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
        }
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            GameManager.leave(request.getSession());
        } finally {
            this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Lets player leave the game";
    }
}
