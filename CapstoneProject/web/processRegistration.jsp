<%--
    Document   : processRegistration
    Created on : Aug 19, 2013, 2:44:20 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "capstone.server.GameManager" %>

<%
    String userName = request.getParameter("userName");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
    
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"' OR email ='"+email+"'");
        if(rs.next()) {
            if(rs.getString(1).equals(userName)) {
                String message = "This username already exists";
                response.sendRedirect("accountManagement.jsp?error="+message);
            } else {
                String message = "A player has already registered with this email address";
                response.sendRedirect("accountManagement.jsp?error="+message);
            }
        } else {
            st.executeUpdate("INSERT into players (user, name, password, email) VALUES ('"+userName+"','"+name+"','"+password+"','"+email+"')");
            GameManager.newPlayer(request.getSession(), userName);
            response.sendRedirect("lobby.jsp");
        }
        st.close();

    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "Error: Registration could not be completed";
        response.sendRedirect("accountManagement.jsp?error="+message);
    }
 
%>