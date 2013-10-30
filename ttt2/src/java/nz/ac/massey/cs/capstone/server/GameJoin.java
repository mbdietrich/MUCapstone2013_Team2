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
 * @author Max
 */
public class GameJoin extends HttpServlet {
    
    //Get all open game session IDs
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding ("UTF-8");
        response.getWriter().write(GameManager.getOpenGames());
        response.getWriter().close();
    }
    
    //Join an open game
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String GameID = request.getParameter("id");
        GameManager.joinGame(request.getSession(), GameID);
    }
    
    @Override
    public String getServletInfo() {
        return "Retrieve and join open games";
    }
}
