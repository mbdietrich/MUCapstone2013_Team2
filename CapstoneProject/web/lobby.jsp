<%-- 
    Document   : lobby
    Created on : 20/09/2013, 7:45:02 PM
    Author     : Max

    For advanced game settings, send the player here.
--%>

<%
    String userName = (String) session.getAttribute("user");
    if (userName == null) {
        response.sendRedirect("index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            var singlePlayer = function() {
                $.post("create", {type: "solo", botname: "DefaultBot"}, function(e) {
                    document.location.href = "game.jsp";
                });

            }
            var multiPlayer = function() {
                $.post("create", {type: "any"}, function(e) {
                    document.location.href = "game.jsp";
                });

            }
            var joinPublicGame = function(pubName) {
                $.post("create", {type: "public", player: pubName}, function(e) {
                    document.location.href = "game.jsp";
                });
            }
            var openGame = function() {
                $.post("create", {type: "open"}, onGameCreate);
            }


            var refresh = function(data) {
                            
                            players = data.toString().split("\n");
                            players.pop();
                            newLines = "";
                            
                            for(i=0;i<players.length; i++){
                                newLines = newLines+"<tr><td>"+players[i]+'</td><td><button type="button" class="btn btn-primary" onclick="joinPublicGame('+players[i]+'");>Join</button></td></tr>';
                            }
                            
                            document.getElementById("gameList").innerHTML=newLines;
                        }

            var loadGames = function() {
                $.get(
                        "GetPublicGames",
                        function(data){refresh(data);}
                );
            }

            window.onload = loadGames;

            var onGameCreate = function(data) {
                //TODO update lobby.jsp if the player has created a game
            }
        </script>
    </head>
    <body>
        
        <ul class="nav nav-tabs">
                <li rel="tooltip" title="Home"><a href="home.jsp"><span class="glyphicon glyphicon-home"></span></a></li>
                <li class="active" rel="tooltip" title="Lobby"><a href="lobby.jsp"><span class="glyphicon glyphicon-th-list"></span></a></li>
                <li><a href="accountManagement.jsp" rel="tooltip" title="Profile"><span class="glyphicon glyphicon-user"></span></a></li>
                <li class="disabled" rel="tooltip" title="Jabberwocky"><a href="#"><span class="glyphicon glyphicon-time"></span></a></li>
                <li class="align-right" rel="tooltip" title="Log out"><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
        </ul>
        <br><br>
        <div class="col-md-3 col-md-offset-3">
            <button type="button" class="btn btn-info" onclick="loadGames()"><span class="glyphicon glyphicon-refresh"></span></button>
            <table class="table table-hover" id="gameList">
            ...
            </table>
            
        </div>
        
            <script src="bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
