<%-- 
    Document   : logout
    Created on : Aug 20, 2013, 5:43:06 PM
    Author     : luke
--%>

<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
