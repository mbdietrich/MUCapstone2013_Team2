<%-- 
    Document   : register
    Created on : Aug 19, 2013, 2:26:11 PM
    Author     : luke
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    if(error==null || error=="null") {
        error="";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <title>Register</title>
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                if(trim(document.register.userName.value)==="")
                    {
                        alert("Please enter a user name.");
                        document.register.userName.focus();
                        return false;
                    }
                else if(trim(document.register.name.value)==="")
                    {
                        alert("Please enter your name");
                        document.register.name.focus();
                        return false;
                    }
                else if(trim(document.register.email.value)==="")
                    {
                        alert("Please enter your email address");
                        document.register.email.focus();
                        return false;
                    }
                else if(trim(document.register.password.value)==="")
                    {
                        alert("Please enter a password");
                        document.register.password.focus();
                        return false;
                    }
            }
        </script>
        
    </head>
    <body>
        <div id="content">
                <form name="register" onSubmit="return validate();" action="processRegistration.jsp" method="POST">
                    <table>
                        <tr>
                            <td>username</td>
                            <td><input id="userName" name="userName" type="text" size="20" placeholder="username" /></td>
                        </tr>
                        <tr>
                            <td>name</td>
                            <td><input id="name" name="name" type="text" size="20" placeholder="name" /></td>
                        </tr>
                        <tr>
                            <td>email</td>
                            <td><input id="email" name="email" type="text" size="20" placeholder="email" /></td>
                        </tr>
                        <tr>
                            <td>password</td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                        </tr>
                        <tr>
                            <td colspan ="2"><%=error%></td>
                        </tr>
                        <tr>
                            <td><input type="submit" name="submit" class="fade" /></td>
                        </tr>
                    </table>
                </form>
        </div>
    </body>
</html>
