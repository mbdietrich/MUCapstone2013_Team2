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
        <script type="text/javascript" src="gamemethods.js"</script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        

        <title>TTT - Game Record Manager</title>

        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>

        <script>
            var loadGames = function() {
                $.getJSON(
                        "GameRecordGet",{type: "games"},function(data){refresh(data.games);}
                )
            }
           var currentCoords;
           var count = 0;
           
           var firstplayer = true;
           
           var loadCoords = function() {
               show();
               var gameID = document.getElementById("gameList");
               var stru = gameID.options[gameID.selectedIndex].id;

                $.getJSON(
                        "GameRecordGet",{type: "coords", gameid: stru},function(data){setCurrentGame(data.coords);}
                )
            }
            
            var setCurrentGame = function(game){
                //currentCoords = null;
                //alert(game);           
                currentCoords = game;
                count = 0;
                firstplayer = true;
                document.getElementById("gameframe").innerHTML = "";
                initiate();
            };
            
            var playGame = function(){
                var tempbutton = document.getElementById(currentCoords[count]).firstElementChild;
                    if(firstplayer === true){
                        tempbutton.src = 'images/ex.png';
                        tempbutton.className ="gameButton";
                        firstplayer = false;
                        count += 1;
                    }
                    else{
                        tempbutton.src = 'images/oh.png';
                        tempbutton.className ="gameButton";
                        firstplayer = true;
                        count += 1;
                    }
                };

                //buttonTrans.src = 'images/ex.png';
                //alert(tt);
            
            
                
                var initiate = function() {


                var buttonFrame, newRow, newCell, subTable, newSubRow, newButton, buttonCell;
                buttonFrame = document.getElementById('gameframe');

                for (a = 2; a >= 0; a--) {
                    //Create a new row of subgames
                    newRow = buttonFrame.insertRow();
                    for (b = 2; b >= 0; b--) {
                        newCell = newRow.insertCell();
                        subTable = document.createElement('table');
                        subTable.className = 'subTable';
                        newCell.appendChild(subTable);
                        for (i = 2; i >= 0; i--) {
                            newSubRow = subTable.insertRow();
                            for (j = 2; j >= 0; j--) {

                                //buttonTrans = document.createElement('span');
                                //newButton = document.createElement('button');
                                //newButton.type = 'button';
                                //newButton.className = 'btn btn-default';

                                buttonTrans = document.createElement('img');
                                buttonTrans.className = 'fadeGameButton gameButton';
                                buttonTrans.src = 'images/blank.png';
                                newButton = document.createElement('a');
                                //newButton.type = 'button';
                                

                                newButton.id = a.toString() + b.toString() + i.toString() + j.toString();
                                newButton.a = a;
                                newButton.b = b;
                                newButton.x = i;
                                newButton.y = j;
                                //newButton.href = alert(newButton.id);

                                newButton.appendChild(buttonTrans);
                                buttonCell = newSubRow.insertCell();
                                buttonCell.appendChild(newButton);
                            }
                        }
                    }
                }
            };
            var functionOnLoad = function(){
                initiate();
                loadGames();
                hide();
            }
            var hide = function(){
                document.getElementById("playButton").style.visibility = "hidden"; 
            }
            var show = function(){
                document.getElementById("playButton").style.visibility = "visible"; 
            }
            window.onload = functionOnLoad;
            
            var refresh = function(data) {

                newLines = "";

                if (data.length === 0) {
                    newLines = "<option class='alert-info'>Sorry, there are no recorded games available.</option>";
                } else {
                    for (i = 0; i < data.length; i++) {
                        if(data[i].p2 === ""){data[i].p2 = "Bot";}
                        newLines = newLines + '<option id="' + data[i].gid + '">' + data[i].p1 +" vs " +data[i].p2+ "</option>";
                    }
                    document.getElementById("joinButton").innerHTML = '<br><button type="button" class="btn" onclick="loadCoords();">Open</button>';
                }
                document.getElementById("gameList").innerHTML = newLines;
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
        <table >
            <tr>
                <td><div class="heading padBottom">Select a game to play: <br><br><button type="button" class="btn btn-xs" onclick="loadGames();">Click to refresh list.</button></div>
                    <div>
                        <select class="input-sm" multiple="no" id="gameList"></select> 
                        <div id="joinButton"></div>
                    </div></td>
                <td><table id="gameframe"></table></td>
                <td><a id="playButton" href="#" onclick="playGame();"><image src= "images/play.png"></button>Next Move</td>
            </tr>
            
        </table>
        
    </body>
</html>
