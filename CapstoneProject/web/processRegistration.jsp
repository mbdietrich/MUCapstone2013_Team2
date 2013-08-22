<%-- 
    Document   : processRegistration
    Created on : Aug 19, 2013, 2:44:20 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>

<%
    String userName = request.getParameter("userName");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
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
    
        ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"' OR email ='"+email+"'");
        st.close();
        if(rs.next()) {
            if(rs.getString(1).equals(userName)) {
                String message = "This username already exists";
                response.sendRedirect("register.jsp?error="+message);
            } else {
                String message = "A player has already registered with this email address";
                response.sendRedirect("register.jsp?error="+message);
            }
        } else {
            st.executeUpdate("INSERT into players (user, name, password, email) VALUES ('"+userName+"','"+name+"','"+password+"','"+email+"')");
            session.setAttribute("user", name);
            response.sendRedirect("lobby.jsp");
        }
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "Error: Registration could not be completed";
        response.sendRedirect("register.jsp?error="+message);
    }
 
%>