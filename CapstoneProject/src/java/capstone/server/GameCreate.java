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
 * 
 * Create a new game for a player to join
 */
public class GameCreate extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GameManager.newGame(request.getSession());
        
        //For now, single-player only
        this.getServletContext().getRequestDispatcher("/game.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Create a new game";
    }
}
