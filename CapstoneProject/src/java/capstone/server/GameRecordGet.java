/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Steve
 */
public class GameRecordGet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        response.setContentType("text");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        if (request.getParameter("type").equals("games")) {
            String recordedGames = GameManager.getRecordedGames(request.getSession());
            out.append(recordedGames);
            response.flushBuffer();
        }
        if (request.getParameter("type").equals("coords")) {
            String coords = GameManager.getRecordedGameCoords(request.getParameter("gameID"));
            out.append(coords);
            response.flushBuffer();
        }
    }
}
