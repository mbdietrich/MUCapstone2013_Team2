<%-- 
    Document   : addFriend
    Created on : Sep 15, 2013, 9:55:08 PM
    Author     : luke
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="capstone.server.databaseAccess"%>

<%
    String player = request.getParameter("player");
    String friend = request.getParameter("friend");
    if(databaseAccess.addFriend(player, friend)) {
        String message = "Friend request sent";
        response.sendRedirect("accountManagement.jsp?requestmessage="+message);
    } else {
        String message = "Friend request could not be sent";
        response.sendRedirect("accountManagement.jsp?requestmessage="+message);
    }
%>
