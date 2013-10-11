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
                        "GameRecordGet",
                        function(data){refresh(data.games);}
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
                        newLines = newLines + '<option id="' + data[i] + '">' + data[i] + "</option>";
                    }
                    document.getElementById("joinButton").innerHTML = '<br><button type="button" class="btn" onclick="requestJoinPublicGame();">Join</button>';
                }
                document.getElementById("gameList").innerHTML = newLines;
            }




        </script>
    </head>
    <body>
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
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle = "tooltip" title="Create new games, and view open games.">Games <b class="caret"></b></a>
                        <ul class="dropdown-menu active">
                            <li><a href="#" onclick="singlePlayer();">Play a bot</a></li>
                            <li><a href="#" onclick="multiPlayer();">Play a user</a></li>
                            <li><a href="#" onclick="openPrivateGame();">New Private Game</a></li>
                            <li><a href="lobby.jsp">Open Games</a></li>
                        </ul>
                    </li>
                    <li><a href="accountManagement.jsp" data-toggle="tooltip" title="Update your profile and find friends.">Profile</a></li>
                    <li><a href="gamerecordmanager.jsp" data-toggle="tooltip" title="Play your previous games.">Previous Game Player</li>
                </ul>
                <p class="navbar-text navbar-right">Hello, <%= session.getAttribute("user")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></p>                    
            </div>
        </nav>
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
    </body>
</html>
