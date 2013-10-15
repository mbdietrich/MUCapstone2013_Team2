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
        
        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>
        
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
            var joinPrivateGame = function() {
                var privName = document.getElementById("publicInput").value;
                $.post("create", {type: "private", player: privName}, function(e) {
                    document.location.href = "game.jsp";
                });
            }
            var openPrivateGame = function(){
                window.location = "privateGame.jsp";
                /*
                var user = session.user;
                $.post("create", {type: "newprivate"}, function(e) {
                    document.location.href= "game.jsp";
                })
                */
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
                            
                        };

            var loadGames = function() {
                $.getJSON(
                        "GetPublicGames",
                        function(data){refresh(data.games);}
                );
                $.getJSON(
                        "GetPrivateGames",
                        function(data){refresh(data.games);}
            );  
                    
            };

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
        <div class="navBar1">
            <div id="menuLeft">
                <span><a href="home.jsp"><img src="images/menu_header.png" alt="title"/></a></span>
                
            </div>
            <nav>
                <ul>
                    <li><a href="#"><img src="images/menu.png" id="menuIcon" alt="menu"/></a>
                    
                        <ul>
                            <li><a href="#">Play +</a>
                                <ul>
                                    <li><a href="#" onclick="singlePlayer();">Bot</a></li>
                                    <li><a href="#" onclick="multiPlayer();">User</a></li>
                                </ul>
                            </li>
                            <li><a href="#" onclick="openPrivateGame();">Private Game</a></li>
                            <li><a href="lobby.jsp">Public Games</a></li>
                            <li><a href="gamerecordmanager.jsp">Played Games</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="menuRight h3"><span>PUBLIC GAMES</span></div>
        </div>
        
        <div class="heading padBottom">Select a game to join: <br><br><button type="button" class="btn btn-xs" onclick="loadGames()">Click to refresh list.</button></div>
        <div>
            <select class="input-sm" multiple="no" id="gameList"></select> 
            <div id="joinButton"></div>
        </div>
        
    </body>
</html>
