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
import javax.servlet.http.HttpSession;



/**
 *
 * @author luke
 */
public class SocialLogin extends HttpServlet {
    
    public static Map<String, String> googlePlayerDetails = new ConcurrentHashMap<String, String>();
    public static Map<String, String> facebookPlayerDetails = new ConcurrentHashMap<String, String>();
    public static Map<String, HttpSession> emailDetails = new ConcurrentHashMap<String, HttpSession>();

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
        String name = request.getParameter("name");
        String gid = request.getParameter("gid");
        String email = request.getParameter("email");
        String fbid = request.getParameter("fbid");
        
        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("gid", gid);
        session.setAttribute("fbid", fbid);
        if(fbid.equals("0")) {
            this.googlePlayerDetails.put(name, gid);
        } else {
            this.facebookPlayerDetails.put(name, fbid);
        }
        
        //record email details
        this.emailDetails.put(email, session);
        
        GameManager.newPlayer(session, name);
        //forward player to the main page
        this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
    }
    
    public static String getOnlineGooglePlayers() {
        //Map onlinePlayers = this.playerDetails;
        Object[] playersKeys = googlePlayerDetails.values().toArray();
        String players = "";
        for(int i=0;i<playersKeys.length;i++) {
            players = players + playersKeys[i] +" ";
        }
        return players;
    }
    
    public static String getOnlineFacebookPlayers() {
        Object[] playersKeys = facebookPlayerDetails.values().toArray();
        String players = "";
        for(int i=0;i<playersKeys.length;i++) {
            players = players + playersKeys[i] +" ";
        }
        return players;
    }
    
    public static Map<String, HttpSession> getEmailDetails() {
        return emailDetails;
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
