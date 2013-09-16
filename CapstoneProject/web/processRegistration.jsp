<%--
    Document   : processRegistration
    Created on : Aug 19, 2013, 2:44:20 PM
    Author     : luke
--%>

<%@ page import= "capstone.server.databaseAccess" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>

<%
    String userName = request.getParameter("userName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String fbid = request.getParameter("fbid");
    if(fbid.equals("void")) {
        fbid="";
    } else {
        fbid = fbid.substring(0, fbid.length()-1);
    }
    
    Map details = databaseAccess.getPlayerDetails(userName);
    if(details.isEmpty()) {
        details = new HashMap();
        details.put("userName", userName);
        details.put("email", email);
        details.put("password", password);
        details.put("fbid", fbid);
        if(databaseAccess.addPlayer(details)) {
            GameManager.newPlayer(request.getSession(), userName);
            response.sendRedirect("lobby.jsp");
        } else {
            String message = "exception";
            response.sendRedirect("accountManagement.jsp?error="+message);
        }
    } else {
        if(details.get("userName").equals(userName)) {
            String message = "userName";
            response.sendRedirect("accountManagement.jsp?error="+message+"&email="+email);
        } else if(details.get("email").equals(email)) {
            String message = "email";
            response.sendRedirect("accountManagement.jsp?error="+message+"&userName="+userName);
        }
    }
%>