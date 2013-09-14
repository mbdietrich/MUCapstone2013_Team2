<%-- 
    Document   : fblogin
    Created on : Sep 14, 2013, 4:01:20 PM
    Author     : lowkeylukey
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>

<%
    String id = request.getParameter("fbid");
    String userName = request.getParameter("fbname");
    String email = request.getParameter("fbemail");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
    
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE fbid ='"+id+"'");
        if(rs.next()) {
            userName = rs.getString(1);
            GameManager.newPlayer(request.getSession(), userName);
            response.sendRedirect("lobby.jsp");
        } else {
            response.sendRedirect("accountManagement.jsp?userName="+userName+"&email="+email+"&fbid="+id);        
        }
        st.close();

    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "exception";
        response.sendRedirect("accountManagement.jsp?error="+message);
    }
 
%>