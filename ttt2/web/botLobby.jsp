<%-- 
    Document   : botLobby
    Created on : Oct 18, 2013, 12:02:17 PM
    Author     : luke
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
        <script src="gamemethods.js"></script>
        
        <title>TTT - Bot Lobby</title>
        
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
            
            var botSource = new EventSource("GetBots");
            botSource.onmessage = function(event) {
                updateBotList(event.data);
            }
            
            function updateBotList(details) {
                var parent = document.getElementById("botList");
                while(parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }
                
                var botDetails = details.split(", ");
                var i = 0;
                var newLines = "";
                if(botDetails.length === 1) {
                    newLines = "<option class='alert-info'>Sorry, there are no bots available to play.</option>";
                } else {
                    while (i+1 < botDetails.length) {
                        newLines = newLines + '<option id="' + botDetails[i+1] + '">' + botDetails[i] + "</option>";
                        i = i+2;
                    }
                    document.getElementById("joinButton").innerHTML = '<br><button type="button" class="btn" onclick="requestPlayBot();">Play</button>';
                }
                document.getElementById("botList").innerHTML = newLines;
            }
            
            
            function requestPlayBot() {
                var s = document.getElementById("botList");
                var id = s[s.selectedIndex].value;
                $.post("create", {type: "bot", botID: id}, function(e) {
                    document.location.href = "game.jsp";
                });
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
                            <li><a href="botLobby.jsp">Bot Lobby</a></li>
                            <li><a href="lobby.jsp">Game Lobby</a></li>
                            <li><a href="gamerecordmanager.jsp">Played Games</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <div class="menuRight h5" id="menuInvites" style="display:none"><span><a href="privateGame.jsp">You have been challenged to a game!</a></span></div>
        </div>
        
        <div class="heading padBottom">Select a bot to play.<br><br></div>
        <div>
            <select class="input-sm" multiple="no" id="botList"></select> 
            <div id="joinButton"></div>
        </div>
        
    </body>
</html>
