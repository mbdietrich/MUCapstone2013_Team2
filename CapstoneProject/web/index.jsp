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
    <body>
        <h3>Login !!!!</h3>
        <div id="Session"></div>
        <form action="login" method="POST">
            <table>
                <tr><td>User:</td><td><input id="user" name="user" type="text" size="42" /></td></tr>
                <tr><td colspan="2"><input type="submit" value="join"/></td>
            </table>
        </form>
        
    </body>
</html>
