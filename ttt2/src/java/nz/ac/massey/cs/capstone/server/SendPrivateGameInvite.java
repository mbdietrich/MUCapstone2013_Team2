/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.server.util.GameManager;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author luke
 */
public class SendPrivateGameInvite extends HttpServlet {
    
    public static Map<String, String> invites = new ConcurrentHashMap<String, String>();

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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String playerID = request.getParameter("me");
            String friendID = request.getParameter("friend");
            
            //set up new game
            GameManager.newGame(request.getSession());
            response.getWriter().write("joined");
            GameManager.addPrivateName(request.getSession());
            
            //get gameID
            //String playerName = request.getSession().getAttribute("name").toString();
            //String gameID = GameManager.getGameID(playerName);
            
            
            this.invites.put(playerID, friendID);
            
            //need to transfer player to the game
            this.getServletContext().getRequestDispatcher("/game.jsp").forward(request, response);
            
    }
    
    public static String getInvites(String id) {
        String friendInvites = "";
        for (Map.Entry<String, String> entry : invites.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            if (value.equals(id)) {
                friendInvites = friendInvites + " " + key;
            }
        }
        return friendInvites;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
