<%-- 
    Document   : game
    Created on : 30/07/2013, 1:13:18 PM
    Author     : Max, Jesse

    Page where the game is rendered.
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
        
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />
        
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>TTT - Game On!</title>
        
        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>
        
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>

        
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
            var leave = function(){
                $.post('leave', function(e){
                    document.location.href = "home.jsp";
                });
            }
            var makeMove = function(a, b, x, y){
                $.post(
                        "move", 
                        {a:a,b:b,x:x,y:y}
                    );
            }
            
            var onState = function(e) {
                var evt = e || window.event;
                var data;
                var state = jQuery.parseJSON(evt.data);
                if (state) { // only update if the string is not empty
                    
                    if(state.open){
                        document.getElementById("isTurnAlert").style.display = 'none';
                        document.getElementById("gameframe").style.display = 'none';
                        document.getElementById("openWait").style.display = '';
                    }
                    else if(!state.waiting){
                    document.getElementById("openWait").style.display = 'none';
                    document.getElementById("gameframe").style.display = '';

                    //TODO parse state in
                    //variables:
                    //state.PlayerNumber
                    //state.isTurn
                    //state.Status
                    //state.Board
                    var subgame=0;
                    for(a = 0;a<3;a++){
                        for(b = 0;b<3;b++){
                            var buttonNum=0;
                            for(x = 0;x<3;x++){
                                for(y = 0;y<3;y++){
                                    button=document.getElementById(a+'-'+b+'-'+x+'-'+y);
                                    buttonTrans=document.getElementById(a+'-'+b+'-'+x+'-'+y).firstElementChild;
                                    value=state.Board[subgame][buttonNum];
                                    if(value==1){
                                        buttonTrans.src = 'images/ex.png';
                                        buttonTrans.className ="gameButton";
                                    }
                                    else if(value==2){
                                        buttonTrans.src = 'images/oh.png';
                                        buttonTrans.className = "gameButton";
                                    }
                                    else{
                                        buttonTrans.src = 'images/blank.png';
                                    }
                                    if(state.isTurn==="true"){
                                        button.disabled===true;
                                        document.getElementById("isTurnAlert").innerHTML = "YOUR TURN";
                                        document.getElementById("isTurnAlert").style.display = '';
                                        document.getElementById("isTurnAlert").className = 'alert alert-info';
                                    }
                                    else{
                                        button.disabled===false;
                                        document.getElementById("isTurnAlert").innerHTML = "Waiting..";
                                        document.getElementById("isTurnAlert").style.display = '';
                                        document.getElementById("isTurnAlert").className = 'alert alert-warning';
                                    }
                                    buttonNum++;
                                }
                            }
                            subgame++;
                        }
                    }
                    if (state.Status === state.PlayerNumber){
                        //window.alert("YOU WIN!");
                        document.getElementById("isTurnAlert").innerHTML = "YOU WIN!";
                        document.getElementById("isTurnAlert").style.display = '';
                        document.getElementById("isTurnAlert").className = 'alert alert-success';
                        //$.post('leave');
                        //window.location.href="/CapstoneProject/home.jsp";
                    }else if (state.Status === "2" || state.Status === "1"){
                        //window.alert("SORRY, YOU LOSE.");
                        document.getElementById("isTurnAlert").innerHTML = "YOU LOSE.";
                        document.getElementById("isTurnAlert").style.display = '';
                        document.getElementById("isTurnAlert").className = 'alert alert-danger';
                        //$.post('leave');
                        //window.location.href="/CapstoneProject/home.jsp";
                    }
                    //if (state.Status === "1" | state.Status === "2"){
                     //   window.alert("Player " + state.Status + " Wins");
                     //   window.location.href="/CapstoneProject/home.jsp";
                    //}
                    }
                }
            };
            
            
                source = new EventSource("state");
                source.onmessage = onState;
                
                $(window).unload(function () {
                    $.post('leave');
                });
                
                window.onload = function() {
                
                
                var buttonFrame, newRow, newCell, subTable, newSubRow, newButton, buttonCell;
                buttonFrame = document.getElementById('gameframe');

                for (a = 2; a >= 0; a--) {
                    //Create a new row of subgames
                    newRow = buttonFrame.insertRow();
                    for (b = 2; b >= 0; b--) {
                        newCell = newRow.insertCell();
                        subTable=document.createElement('table');
                        subTable.className = 'subTable';
                        newCell.appendChild(subTable);
                        for (i = 2; i >= 0; i--) {
                            newSubRow=subTable.insertRow();
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
                                newButton.href = '#';         
                                
                                newButton.id=a+'-'+b+'-'+i+'-'+j;
                                newButton.a=a;
                                newButton.b=b;
                                newButton.x=i;
                                newButton.y=j;
                                
                                newButton.appendChild(buttonTrans);
                                newButton.onclick = function() {
                                    makeMove(this.a,this.b,this.x,this.y);
                                };
                                buttonCell=newSubRow.insertCell();
                                buttonCell.appendChild(newButton);
                            }
                        }
                    }
                }
            };
        </script>

    </head>
    <body onunload="$.post('leave');">
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
                            <li><a href="#">Profile</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            </div>
            
        
        
        <table>
            <tr>
                <td>
                    <div id="team1" class="gameDiv"><h1><%= session.getAttribute("user")%></h1></div>
                </td>
                <td>
                    <div class="gameDiv"><table class="gameDiv" id="gameframe"></table></div>
                </td>
                <td>
                    <div id="team2" class="gameDiv"><h1>Opponent</h1></div>
                </td>
            </tr>
        </table>
        
        
        <div id="openWait" class="padTop">Waiting for another player to join..</div>
        <!--<button onclick="leave()">Leave</button>
        <div><p id="isTurnAlert" class="padBottom"></p></div>-->
    </body>
</html>
