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

        <title>TTT - Game Record Manager</title>

        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>

        <script>
            var loadGames = function() {
                $.getJSON(
                        "GameRecordGet",{type: "games"},function(data){refresh(data.games);}
                )
            }
           var loadCoords = function() { 
               var gameID = document.getElementById("gameList");
               var stru = gameID.options[gameID.selectedIndex].id;

                $.getJSON(
                        "GameRecordGet",{type: "coords", gameid: stru},function(data){alert(data.games);}
                )
            }
            
            window.onload = function() {


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
                                //newButton.href = '#';

                                newButton.id = a + '-' + b + '-' + i + '-' + j;
                                newButton.a = a;
                                newButton.b = b;
                                newButton.x = i;
                                newButton.y = j;

                                newButton.appendChild(buttonTrans);
                                buttonCell = newSubRow.insertCell();
                                buttonCell.appendChild(newButton);
                            }
                        }
                    }
                }
            };
            var refresh = function(data) {

                newLines = "";

                if (data.length === 0) {
                    newLines = "<option class='alert-info'>Sorry, there are no recorded games available.</option>";
                } else {
                    for (i = 0; i < data.length; i++) {
                        newLines = newLines + '<option id="' + data[i].gid + '">' + data[i].p1 + "</option>";
                    }
                    document.getElementById("joinButton").innerHTML = '<br><button type="button" class="btn" onclick="loadCoords();">Open</button>';
                }
                document.getElementById("gameList").innerHTML = newLines;
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
                            <li><a href="accountManagement.jsp">Profile</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="menuRight h3"><span>PLAYED GAMES</span></div>
        </div>
        <table >
            <tr>
                <td><div class="heading padBottom">Select a game to play: <br><br><button type="button" class="btn btn-xs" onclick="loadGames();">Click to refresh list.</button></div>
                    <div>
                        <select class="input-sm" multiple="no" id="gameList"></select> 
                        <div id="joinButton"></div>
                    </div></td>
                <td><table id="gameframe"></table></td>
            </tr>
        </table>
            <button onclick="loadCoords()">Load Coords</button>
    </body>
</html>
