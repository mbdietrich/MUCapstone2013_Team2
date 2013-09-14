<%-- 
    Document   : accountManagement
    Created on : Sep 12, 2013, 12:40:37 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                if(trim(document.manager.userName.value)==="")
                    {
                        alert("Please enter a user name.");
                        document.manager.userName.focus();
                        return false;
                    }
                else if(trim(document.manager.name.value)==="")
                    {
                        alert("Please enter your name");
                        document.manager.name.focus();
                        return false;
                    }
                else if(trim(document.manager.email.value)==="")
                    {
                        alert("Please enter your email address");
                        document.manager.email.focus();
                        return false;
                    }
                else if(trim(document.manager.password.value)==="")
                    {
                        alert("Please enter a password");
                        document.manager.password.focus();
                        return false;
                    }
                else if(trim(document.manager.confirmPassword.value)!== trim(document.manager.password.value))
                    {
                        alert("Passwords do not match");
                        document.manager.password.focus();
                        return false;
                    }
            }
            function validate1()
            {
                if(trim(document.manager.confirmPassword.value)!== trim(document.manager.newPassword.value))
                    {
                        alert("Passwords do not match");
                        document.manager.password.focus();
                        return false;
                    }
                else if(trim(document.manager.password.value)==="")
                    {
                        alert("Please enter your current password.");
                        document.manager.password.focus();
                        return false;
                    }
            }
        </script>
    </head>
    <%
    String error = request.getParameter("error");
    if(error==null || error=="null") {
        error="";
    }
    String userName = (String)session.getAttribute("user");
    if(userName != null) {
        try { 
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
            Statement st = con.createStatement();
        
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
            String name = "";
            String email = "";
            if (rs.next()) {
                name = rs.getString(2);
                email = rs.getString(4);
            }
       
            st.close();
            
            %>
        <body>
        <h1>Profile</h1>
        <div id="content">
                <form name="manager" onSubmit="return validate1();" action="updateDetails.jsp" method="POST">
                    <div id="wrapper" style="width:100%; text-align:center">
                    <br><br><br><br><br><br>
                    <table align="center">
                        
                        <tr>
                            <td>User name:</td>
                            <td><input id="userName" name="userName" type="text" size="20" value=<%=userName%> /></td>
                        </tr>
                        <tr>
                            <td>Name:</td>
                            <td><input id="name" name="name" type="text" size="20" value=<%=name%> /></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input id="email" name="email" type="text" size="20" value=<%=email%> /></td>
                        </tr>
                        <tr>
                            <td>New password:</td>
                            <td><input id="newPassword" name="newPassword" type="password" size="20" placeholder="new password" /></td>
                        </tr>
                        <tr>
                            <td>Confirm password:</td>
                            <td><input id="confirmpassword" name="confirmPassword" type="password" size="20" placeholder="confirm password" /></td>
                        </tr>
                        <tr>
                            <td colspan ="2"><%=error%></td>
                        </tr>
                        <tr>
                            <td>Current password</td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                        </tr>
                        <tr>
                            <input name="oldUserName" type="hidden" value=<%=userName%>/>
                            <input name="oldEmail" type="hidden" value=<%=email%>/>
                            <td colspan="2"><input type="submit" name="submit" value="Update Details" class="fade" /></td>
                        </tr>
                    </table>
                    </div>
                </form>
        </div>
    </body>
        <%
        }
        catch (Exception e) {
            e.printStackTrace();
            String message = "There was a problem logging you in";
            response.sendRedirect("index.jsp?error="+message);
        }
        
    } else {
        %>
        <body>
            <h1>Create Account</h1>
        <div id="content">
                <form name="manager" onSubmit="return validate();" action="processRegistration.jsp" method="POST">
                    <div id="wrapper" style="width:100%; text-align:center">
                    <br><br><br><br><br><br>
                    <table align="center">
                        
                        <tr>
                            <td>User name:</td>
                            <td><input id="userName" name="userName" type="text" size="20" placeholder="username" /></td>
                        </tr>
                        <tr>
                            <td>Name:</td>
                            <td><input id="name" name="name" type="text" size="20" placeholder="name" /></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input id="email" name="email" type="text" size="20" placeholder="email" /></td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                        </tr>
                        <tr>
                            <td>Confirm password:</td>
                            <td><input id="confirmpassword" name="confirmPassword" type="password" size="20" placeholder="confirm password" /></td>
                        </tr>
                        <tr>
                            <td colspan ="2"><%=error%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><input type="submit" name="submit" value="Save" class="fade" /></td>
                        </tr>
                    </table>
                    </div>
                </form>
        </div>
        </body>
        <%
    }
   %>
        
    
    
</html>
