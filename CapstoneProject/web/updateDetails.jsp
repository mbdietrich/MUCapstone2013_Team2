<%-- 
    Document   : updateDetails
    Created on : Sep 12, 2013, 9:14:20 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>


<%
    String oldUserName = request.getParameter("oldUserName");
    oldUserName = oldUserName.substring(0, oldUserName.length()-1);
    String oldEmail = request.getParameter("oldEmail");
    oldEmail = oldEmail.substring(0, oldEmail.length()-1);
    String userName = request.getParameter("userName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String newPassword = request.getParameter("newPassword");
    if(newPassword.equals("")) {
        newPassword = password;
    }
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user='"+oldUserName+"'");
        if(rs.next()) {
            if(!rs.getString(2).equals(password)) {
                String message = "password";
                response.sendRedirect("accountManagement.jsp?error="+message);
                st.close();
                return;
                }
            }
        if (!oldUserName.equals(userName)) {
            rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
            if(rs.next()) {
                String message = "userName";
                response.sendRedirect("accountManagement.jsp?error="+message);
                st.close();
                return;
            }
        } else if (!oldEmail.equals(email)) {
            rs = st.executeQuery("SELECT * FROM players WHERE email ='"+email+"'");
            if(rs.next()) {
                String message = "email";
                response.sendRedirect("accountManagement.jsp?error="+message);
                st.close();
                return;
            }
        }
        st.executeUpdate("UPDATE players SET user='"+userName+"', email='"+email+"', password='"+newPassword+"' WHERE user='"+oldUserName+"'");
        GameManager.newPlayer(request.getSession(), userName);
        response.sendRedirect("accountManagement.jsp");
        st.close();
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "exception";
        response.sendRedirect("accountManagement.jsp?error="+message);
    }
%>