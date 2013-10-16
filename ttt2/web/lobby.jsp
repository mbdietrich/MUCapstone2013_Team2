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
            var source = new EventSource("GameInvites");
            source.onmessage = function(event) {
                if (event.data) {
                    updateInviteMenu("yes"); //show that there are invites in the menu
                } else {
                    updateInviteMenu("no"); //if no request, hide menu
                }
            };
            
            function updateInviteMenu(update) {
                if(update === "no") {
                    document.getElementById("menuInvites").style.display="none";
                } else {
                    document.getElementById("menuInvites").style.display="inline";
                }
            }
            
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
            <div class="menuLeft">
                <span><h1><a href="home.jsp">TIC TAC TOE</a></h1></span>
                
            </div>
            <nav class="menuRight">
                <ul>
                    <li><span>MENU</span>
                        <ul>
                            <li><a href="#" onclick="singlePlayer();">Play Default Bot</a></li>
                            <li><a href="#" onclick="multiPlayer();">Play Another User</a></li>
                            <li><a href="#" onclick="openPrivateGame();">Play Private Game</a></li>
                            <li><a href="boteditor.html">Create Bot</a></li>
                            <li><a href="#">Bot Lobby</a></li>
                            <li><a href="lobby.jsp">Game Lobby</a></li>
                            <li><a href="gamerecordmanager.jsp">Played Games</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <div class="menuRight h5" id="menuInvites" style="display:none"><span><a href="privateGame.jsp">You have been challenged to a game!</a></span></div>
        </div>
        
        <div class="heading padBottom">Select a game to join: <br><br><button type="button" class="btn btn-xs" onclick="loadGames()">Click to refresh list.</button></div>
        <div>
            <select class="input-sm" multiple="no" id="gameList"></select> 
            <div id="joinButton"></div>
        </div>
        
    </body>
</html>
