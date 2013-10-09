/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author luke
 */
public class SocialLogin extends HttpServlet {

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
        String email = request.getParameter("email");
        //If fbid = 0, not registered
        String fbid = request.getParameter("fbid");
        //If gid = 0, not registered
        String gid = request.getParameter("gid");
        String name = request.getParameter("name");
        
        //Check whether email address has already been registered
        if(databaseAccess.emailExists(email)) {
            //If email exists, check whether Facebook or Google is registered
            Map details = databaseAccess.getPlayerDetailsByEmail(email);
            if(!gid.equals("0")) {
                //Need to add gid to player details
                if(!databaseAccess.addGID(email, gid)) {
                    String message = "There was a problem logging you in";
                    response.sendRedirect("index.jsp?error="+message);
                    return;
                }
            }
            if(!fbid.equals("0")) {
                //Need to add fbid to player details
                if(!databaseAccess.addFBID(email, fbid)) {
                    String message = "There was a problem logging you in";
                    response.sendRedirect("index.jsp?error="+message);
                    return;
                }
            }
            //Otherwise, log the player in
            GameManager.newPlayer(request.getSession(), (String)details.get("userName"));
            //forward player to the main page
            this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
        } else {
            
            //If email doesn't exist, load player details in database
            Map details = new HashMap();
            details.put("userName", name);
            details.put("email", email);
            details.put("gid", gid);
            details.put("fbid", fbid);
            if(databaseAccess.addPlayer(details)) {
            //if(databaseAccess.registerPlayer(name, email, gid, fbid)) {
                //log the player in
                GameManager.newPlayer(request.getSession(), name);
                //forward player to the main page
                this.getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
            } else {
                String message = "There was a problem logging you in";
                response.sendRedirect("index.jsp?error="+message);
            }
        }
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
