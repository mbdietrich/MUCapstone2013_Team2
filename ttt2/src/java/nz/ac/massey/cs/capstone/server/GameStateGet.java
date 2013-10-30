/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.server.util.GameManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max
 */
public class GameStateGet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        response.setContentType("text/event-stream");
        response.setCharacterEncoding ("UTF-8");
        PrintWriter out = response.getWriter();
        out.append("event: state\n\n");
        out.append("retry: 50\n");
        out.append("data:");
        try{
            String state=GameManager.getGame(request.getSession());
            out.append(state);
            
        }
        catch(Exception e){
            out.append("{\"waiting\": \"true\"}");
        }
        out.append("\n\n");
        response.flushBuffer();
    }

    @Override
    public String getServletInfo() {
        return "Return the game state";
    }
}