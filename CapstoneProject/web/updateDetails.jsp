<%-- 
    Document   : updateDetails
    Created on : Sep 12, 2013, 9:14:20 PM
    Author     : luke
--%>

<%@page import="capstone.server.databaseAccess"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>

<%
    if(request.getParameter("link").equals("yes/")) {
        String userName = request.getParameter("oldUserName");
        String password = request.getParameter("password2");
        String fbid = request.getParameter("fbid");
        fbid = fbid.substring(0, fbid.length()-1);
        if(userName.equals(databaseAccess.checkLoginCredentials(userName, password))) {
            if(databaseAccess.addValue(userName, "fbid", fbid)) {
                GameManager.newPlayer(request.getSession(), userName);
                response.sendRedirect("accountManagement.jsp");
            } else {
                String message = "exception1";
                response.sendRedirect("fblogin.jsp?error="+message);
            }
        } else {
            String message = "login";
            response.sendRedirect("fblogin.jsp?error="+message);
        }

    } else {
        String oldUserName = request.getParameter("oldUserName");
        oldUserName = oldUserName.substring(0, oldUserName.length()-1);
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
            response.sendRedirect("accountManagement.jsp?error="+message);
            return;
        } else {
            if(!oldUserName.equals(userName)) {
                if(databaseAccess.playerExists(userName)) {
                    String message = "userName";
                    response.sendRedirect("accountManagement.jsp?error="+message);
                    return;
                }
            }
            if(!currentDetails.get("email").equals(email)) {
                if(databaseAccess.emailExists(email)) {
                    String message = "email";
                    response.sendRedirect("accountManagement.jsp?error="+message);
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
                response.sendRedirect("accountManagement.jsp");
            } else {
                String message = "exception";
                response.sendRedirect("accountManagement.jsp?error="+message);
            }
        }
    }
%>