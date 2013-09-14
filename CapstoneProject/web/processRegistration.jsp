<%--
    Document   : processRegistration
    Created on : Aug 19, 2013, 2:44:20 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>

<%
    String userName = request.getParameter("userName");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String fbid = request.getParameter("fbid");
    fbid = fbid.substring(0, fbid.length()-1);
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        Statement st = con.createStatement();
    
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"' OR email ='"+email+"'");
        if(rs.next()) {
            if(rs.getString(1).equals(userName)) {
                String message = "userName";
                response.sendRedirect("accountManagement.jsp?error="+message+"&name="+name+"&email="+email);
            } else {
                String message = "email";
                response.sendRedirect("accountManagement.jsp?error="+message+"&name="+name+"&userName="+userName);
            }
        } else {
            st.executeUpdate("INSERT into players (user, name, password, email, fbid) VALUES ('"+userName+"','"+name+"','"+password+"','"+email+"','"+fbid+"')");
            GameManager.newPlayer(request.getSession(), userName);
            response.sendRedirect("lobby.jsp");
        }
        st.close();

    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "exception";
        response.sendRedirect("accountManagement.jsp?error="+message);
    }
 
%>