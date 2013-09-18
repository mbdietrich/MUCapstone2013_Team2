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
public class GetPublicGames extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/event-stream");
        response.setCharacterEncoding ("UTF-8");
        String publicGames = GameManager.getPublicGames();
        
        
       PrintWriter out = response.getWriter();
       out.append(publicGames);
        //out.append("retry: 1000\n");
       /*
        out.append("event: games\n");
        out.append("data:");
        
        // json encode messages
        out.append('[');
        boolean first = true;
        for (Message message:messages) {
            if (first) first=false;
            else out.append(',');
            out.append(message.toJSON());
        }
        out.append(']');
        
        out.append("\n\n");*/
        response.flushBuffer();
    }

    @Override
    public String getServletInfo() {
        return "fetch game list";
    }
}