<%-- 
    Document   : doLogin
    Created on : Aug 16, 2013, 6:33:12 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>

<%
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tictactoedb", "root", "stupidpasswords");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM users WHERE user ='"+userName+"'");
        if(rs.next()) {
            if(rs.getString(4).equals(password)) {
                session.setAttribute("user", userName);
                response.sendRedirect("lobby.jsp");
            } else {
                String message = "User name or password don't match";
                response.sendRedirect("index.jsp?error="+message);
            }
        } else {
            String message = "User name or password don't match";
            response.sendRedirect("index.jsp?error="+message);
        }
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "There was a problem logging you in";
        response.sendRedirect("index.jsp?error="+message);
    }
%>