<%-- 
    Document   : lobby
    Created on : 30/07/2013, 1:12:16 PM
    Author     : Max, Jesse

    lobby.jsp is where the player is sent before a game starts, but after logging in.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script>
            session.setAttribute("user","Happyface");
            session.setAttribute("playerid", "player1");
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <title>Lobby Page</title>
    </head>
    <body>
        <div id="content">
            <form action="create" method="POST">
                <table>
                    <tr>
                        <td rowspan="2"><h3> Welcome <%= session.getAttribute("_user") %></h3></td>
                        <td> <input type="image" src="images/newGame.png" alt="submit" /></td>
                    </tr>
                    <tr>
                  
                        <td> <a href="/CapstoneProject/index.jsp"><img src="images/logout.png" alt="logout"/></a></td>
                    </tr>
                </table>
            </form>
        </div>
</html>
