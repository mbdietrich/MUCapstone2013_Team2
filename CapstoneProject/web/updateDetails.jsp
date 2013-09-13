<%-- 
    Document   : updateDetails
    Created on : Sep 12, 2013, 9:14:20 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "capstone.server.GameManager" %>


<%
    String oldUserName = request.getParameter("oldUserName");
    oldUserName = oldUserName.substring(0, oldUserName.length()-1);
    String oldEmail = request.getParameter("oldEmail");
    oldEmail = oldEmail.substring(0, oldEmail.length()-1);
    String userName = request.getParameter("userName");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
        
        if (!oldUserName.equals(userName)) {
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
            if(rs.next()) {
                String message = "This username already exists";
                response.sendRedirect("accountManagement.jsp?error="+message);
                st.close();
                return;
            }
        } else if (!oldEmail.equals(email)) {
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE email ='"+email+"'");
            if(rs.next()) {
                String message = "A player has already registered with this email";
                response.sendRedirect("accountManagement.jsp?error="+message);
                st.close();
                return;
            }
        }
        st.executeUpdate("UPDATE players SET user='"+userName+"', name='"+name+"', email='"+email+"', password='"+password+"' WHERE user='"+oldUserName+"'");
        GameManager.newPlayer(request.getSession(), userName);
        response.sendRedirect("lobby.jsp");
        st.close();
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "Error: Update could not be completed";
        response.sendRedirect("accountManagement.jsp?error="+message);
    }
 
%>