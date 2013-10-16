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
 * @author luke
 */
public class FacebookFriends extends HttpServlet {
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
        PrintWriter out = response.getWriter();
        out.append("data: ");
        
        String onlinePlayers = SocialLogin.getOnlineFacebookPlayers();
        
        out.append(onlinePlayers);
        
        out.append("\n\n");
        response.flushBuffer();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Get Facebook players who are online";
    }// </editor-fold>
}