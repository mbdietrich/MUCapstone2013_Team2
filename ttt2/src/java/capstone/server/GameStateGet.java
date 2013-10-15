/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/event-stream");
        response.setCharacterEncoding ("UTF-8");
        String state=GameManager.getGame(request.getSession());
        
        PrintWriter out = response.getWriter();
        out.append("retry: 50\n");
        out.append("data:");
        out.append(state);
        out.append("\n\n");
        response.flushBuffer();
    }

    @Override
    public String getServletInfo() {
        return "Return the game state";
    }
}