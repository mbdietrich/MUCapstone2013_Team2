<%-- 
    Document   : doLogin
    Created on : Aug 16, 2013, 6:33:12 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>

<%
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    try {
        Properties prop = new Properties();
        prop.load(new FileInputStream(System.getProperty("user.home") + "/mydb.cfg"));
        String dbhost = prop.getProperty("host").toString();
        String dbusername = prop.getProperty("username").toString();
        String dbpassword = prop.getProperty("password").toString();
        String dbdriver = prop.getProperty("driver").toString();
        
        Class.forName(dbdriver);
        java.sql.Connection con = DriverManager.getConnection(dbhost, dbusername, dbpassword);
        Statement st = con.createStatement();
        
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
        st.close();
        if(rs.next()) {
            if(rs.getString(3).equals(password)) {
                session.setAttribute("user", rs.getString(2));
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