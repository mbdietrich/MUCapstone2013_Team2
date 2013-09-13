<%-- 
    Document   : lobby
    Created on : 30/07/2013, 1:12:16 PM
    Author     : Max, Jesse

    lobby.jsp is where the player is sent before a game starts, but after logging in.
--%>
<%
    String userName = (String)session.getAttribute("user");
    if(userName == null) {
        response.sendRedirect("index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <title>Lobby Page</title>
        
        <script>
            var singlePlayer = function() {
                $.post("create", {type: "solo", botname: "DefaultBot"}, function(e){document.location.href="game.jsp";});
                
            }
            var multiPlayer = function() {
                $.post("create", {type: "any"}, function(e){document.location.href="game.jsp";});
                
            }
            var openGame = function() {
                $.post("create", {type: "open"}, onGameCreate);
            }

            var onGameCreate = function(data) {
                //TODO update lobby.jsp if the player has created a game
            }
        </script>
    </head>
    <body>
        

        <div id="content">

            <table>
                <tr>
                    <td rowspan="2"><h3> Welcome <%= session.getAttribute("user")%></h3></td>
                    <td> <input type="image" src="images/single.png" alt="Play against a bot" onclick="singlePlayer();" /></td>
                    <td> <input type="image" src="images/multi.png" alt="Play against a person" onclick="multiPlayer();"/></td>
                </tr>
                <tr>

                    <td>
                        <form name="logout" action="logout.jsp" method="POST">
                            <input type="image" src="images/logout.png" alt="logout" class="fade" />
                        </form>
                    </td>
                </tr>
                <td>
                    <a href="accountManagement.jsp" align="center">Account Management</a>
                </td>
            </table>
        </div>
</html>
