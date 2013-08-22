<%-- 
    Document   : index
    Created on : 21/07/2013, 9:51:01 AM
    Author     : Max, Jesse
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
        <!--
        <script>
               var divsession = document.getElementById("Session");
               divsession.innerHTML = session;
               window.onload = function() {
                   if(session.getAttribute("user")){
                       window.location.href("CapstoneProject/lobby.jsp");
                   }
               }
        </script>
        -->
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                if(trim(document.login.userName.value)==="")
                    {
                        alert("Please enter a user name.");
                        document.login.userName.focus();
                        return false;
                    }
                else if(trim(document.login.password.value)==="")
                    {
                        alert("Please enter a password");
                        document.login.password.focus();
                        return false;
                    }
            }
        </script>
    <body>
       
        <!--<h3>Login !!!!</h3>-->
        <div id="Session"></div>
        <div  id="content">
                <form name="login" onSubmit="return validate();" action="doLogin.jsp" method="POST">
                    <table>
                        <tr>
                            <td><img src="images/login1.png" alt="login" /></td>
                            <td><input id="userName" name="userName" type="text" size="20" placeholder="username" /></td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                            <td><input type="image" src="images/login2.png" alt="submit" class="fade" /></td>
                        </tr>
                        <tr>
                            <td><a href="register.jsp">Register</a></td>
                        </tr>
                        <tr>
                            <td colspan ="4"><%=error%></td>
                        </tr>
                    </table>
                </form>
        </div>
    </body>
</html>
