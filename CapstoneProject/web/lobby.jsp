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

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        
        <title>TTT - Lobby</title>
        
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
                            
                            newLines = "";
                            
                            if(data.length === 0){
                                newLines = "<option class='alert-info'>Sorry, there are no open games available.</option>";
                            }else{
                                for(i=0;i<data.length; i++){
                                    newLines = newLines+'<option id="' + data[i]+ '">' + data[i] + "</option>";
                               }
                                document.getElementById("joinButton").innerHTML= '<br><button type="button" class="btn" onclick="requestJoinPublicGame();">Join</button>';
                            }
                            document.getElementById("gameList").innerHTML=newLines;
                            
                        }

            var loadGames = function() {
                
                $.getJSON(
                        "GetPublicGames",
                        function(data){refresh(data.games);}
                );
                    
            }

            window.onload = loadGames;

            var onGameCreate = function(data) {
                //TODO update lobby.jsp if the player has created a game
            }
            
            function requestJoinPublicGame() {
                var s = document.getElementById("gameList");
                var id = s[s.selectedIndex].id;
                joinPublicGame(id);
            }
            
        </script>
    </head>
    <body>
        <!--
        <ul class="nav nav-tabs">
                <li><a href="home.jsp">Home</span></a></li>
                <li class="active"><a href="lobby.jsp">Open Games</a></li>
                <li><a href="accountManagement.jsp">Profile</a></li>
                <li class="disabled"><a href="#">Game</a></li>
                <p class="navbar-text pull-right">Signed in as <a href="accountManagement.jsp"><%= session.getAttribute("user")%></a> | <a href="logout.jsp">Logout</a></p>
        </ul>
        -->
        <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp">tic tac toe</a>
                </div>

                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="home.jsp">Home</a></li>
                        <li class="dropdown active">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Games <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="singlePlayer();">Play a bot</a></li>
                                <li><a href="#" onclick="multiPlayer();">Play a user</a></li>
                                <li><a href="lobby.jsp">Open Games</a></li>
                            </ul>
                        </li>
                        <li><a href="accountManagement.jsp">Profile</a></li>
                    </ul>
                    <p class="navbar-text navbar-right">Hello, <%= session.getAttribute("user")%> | <a href="logout.jsp">Log out</a></p>                    
                </div>
            </nav>
        
        <div class="heading padBottom">Select a game to join: <br><br><button type="button" class="btn btn-xs" onclick="loadGames()">Click to refresh list.</button></div>
        <div>
            <select class="input-sm" multiple="no" id="gameList"></select> 
            <div id="joinButton"></div>
        </div>
        
    </body>
</html>
