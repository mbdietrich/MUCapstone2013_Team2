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
        response.setContentType("text");
        response.setCharacterEncoding("UTF-8");
        
        if(request.getParameter("type").equals("any")){
            if(GameManager.openGames.size()==0){
                GameManager.newGame(request.getSession());
                response.getWriter().write("created");
            }
            else{
                GameManager.joinAnyGame(request.getSession());
                response.getWriter().write("joined");
            }
            response.getWriter().close();
        }
        else{
        
        GameManager.newGame(request.getSession());
        
        if(request.getParameter("type").equals("solo")){
            //For now, only default bot
        GameManager.BotJoin(request.getSession());
        }
        
        
    }}

    @Override
    public String getServletInfo() {
        return "Create a new game";
    }
}
