<%-- 
    Document   : index
    Created on : 21/07/2013, 9:51:01 AM
    Author     : Max, Jesse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script>
               var divsession = document.getElementById("Session");
               divsession.innerHTML = session;
               window.onload = function() {
                   if(session.getAttribute("user")){
                       window.location.href("CapstoneProject/lobby.jsp");
                   }
               }
        </script>
        <link rel="stylesheet" type="text/css" href="css/style2.css">
    <body>
        <!--<h3>Login !!!!</h3>-->
        <div id="Session"></div>
        <div  id="content">
                <form action="login" method="POST">
                    <table>
                        <tr>
                            <td><img src="images/login1.png" alt="login" /></td>
                            <td><input id="user" name="user" type="text" size="20" placeholder="username" /></td>
                            <td><input type="image" src="images/login2.png" alt="submit" class="fade" /></td>
                        </tr>
                    </table>
                </form>
        </div>
    </body>
</html>
