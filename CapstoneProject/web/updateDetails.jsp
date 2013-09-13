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
    String userName = request.getParameter("userName");
    String name = request.getParameter("oldName");
    String email = request.getParameter("oldEmail");
    String password = request.getParameter("oldPassword");

    
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
        
        if(oldUserName != userName) {
            String message = "names to not match";
            response.sendRedirect("accountManagement.jsp?error="+message);
        }
        
        if (request.getParameter("oldUserName") != request.getParameter("userName")) {
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
            if(rs.next()) {
                String message = "This username already exists";
                response.sendRedirect("accountManagement.jsp?error="+message);
                return;
            }
        } else if (request.getParameter("oldEmal") != request.getParameter("email")) {
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE email ='"+email+"'");
            if(rs.next()) {
                String message = "A player has already registered with this email";
                response.sendRedirect("accountManagement.jsp?error="+message);
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