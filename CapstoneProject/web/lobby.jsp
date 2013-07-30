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
        <title>Lobby Page</title>
    </head>
    <body>
        <h3> Welcome <%= session.getAttribute("user") %><%= session.getAttribute("playerid") %></h3>
        <form action="create" method="POST">
            <input type="submit" value="New Game">
        </form>
</html>
