<%-- 
    Document   : processRegistration
    Created on : Aug 19, 2013, 2:44:20 PM
    Author     : lowkeylukey
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>

<%
    String userName = request.getParameter("userName");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    Class.forName("com.mysql.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tictactoedb", "root", "stupidpasswords");
    Statement st = con.createStatement();
    
    ResultSet rs = st.executeQuery("SELECT * FROM users WHERE user ='"+userName+"' OR email ='"+email+"'");
    if(rs.next()) {
        if(rs.getString(2).equals(userName)) {
            String message = "This username already exists";
            response.sendRedirect("register.jsp?error="+message);
        } else {
            String message = "A player has already registered with this email address";
            response.sendRedirect("register.jsp?error="+message);
        }
    } else {
        st.executeUpdate("INSERT into users (user, name, password, email) VALUES ('"+userName+"','"+name+"','"+password+"','"+email+"')");
        session.setAttribute("user", userName);
        response.sendRedirect("lobby.jsp");
    }
 
%>