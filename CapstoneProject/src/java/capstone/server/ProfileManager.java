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
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author lowkeylukey
 */
public class ProfileManager extends HttpServlet {

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
        if(request.getParameter("form").equals("update")) {
            //update player details
            String oldUserName = request.getParameter("oldUserName");
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String newPassword = request.getParameter("newPassword");
            if(newPassword.equals("")) {
                newPassword = password;
            }
    
            Map currentDetails = databaseAccess.getPlayerDetails(oldUserName);
            if(!currentDetails.get("password").equals(password)) {
                String message = "password";
                this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                return;
            } else {
                if(!oldUserName.equals(userName)) {
                    if(databaseAccess.playerExists(userName)) {
                        String message = "userName";
                        this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                        return;
                    }
                }
            if(!currentDetails.get("email").equals(email)) {
                if(databaseAccess.emailExists(email)) {
                    String message = "email";
                    this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                    return;
                }
            }
            Map details = new HashMap();
            details.put("oldUserName", oldUserName);
            details.put("userName", userName);
            details.put("email", email);
            details.put("password", newPassword);
        
            if(databaseAccess.updatePlayerDetails(details)) {
                GameManager.newPlayer(request.getSession(), userName);
                this.getServletContext().getRequestDispatcher("/accountManagement.jsp").forward(request, response);
            } else {
                String message = "exception";
                this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                }
            }
        } else if(request.getParameter("form").equals("register")) {
            //register a new player
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
    
            Map details = databaseAccess.getPlayerDetails(userName);
            if(details.isEmpty()) {
                details = new HashMap();
                details.put("userName", userName);
                details.put("email", email);
                details.put("password", password);
                if(databaseAccess.addPlayer(details)) {
                    GameManager.newPlayer(request.getSession(), userName);
                    this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
                } else {
                    String message = "exception";
                    this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                }
            } else {
                if(details.get("userName").equals(userName)) {
                    String message = "userName";
                    this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                } else if(details.get("email").equals(email)) {
                    String message = "email";
                    this.getServletContext().getRequestDispatcher("/accountManagement.jsp?error="+message).forward(request, response);
                }
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
