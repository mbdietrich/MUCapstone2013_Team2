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
<!DOCTYPE html>
<html>
    <head>
        <style type="text/css">
            div.game{
                width:50px;
                height:50px;
                background:slategrey;
                font-size:50;
                margin:5px;
                border:#black 1px solid;
            }
        </style>
        <title>chat application TICTACTOE</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script type="text/javascript" src="jquery-1.8.3.js"></script>

        <script>
            
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
                    console.log("data received: " + state);
                    
                    if(state.open){
                        document.getElementById("gameframe").style.display = 'none';
                    }
                    else{
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
                                    value=state.Board[subgame][buttonNum]
                                    if(value==1){
                                        button.value="X";
                                    }
                                    else if(value==2){
                                        button.value="O";
                                    }
                                    else{
                                        button.value="  ";
                                    }
                                    if(state.isTurn==="true"){
                                        button.disabled===true;
                                    }
                                    else{
                                        button.disabled.false;
                                    }
                                    buttonNum++;
                                }
                            }
                            subgame++;
                        }
                    }
                    if (state.Status === "1" | state.Status === "2"){
                        window.alert("Player " + state.Status + " Wins");
                        window.location.href="/CapstoneProject/lobby.jsp";
                    }
                    }
                }
            };
            
            var source = new EventSource("state");
            source.addEventListener('move', onState, false);
            
            window.onload = function() {
                var buttonFrame, newRow, newCell, subTable, newSubRow, newButton, buttonCell;
                buttonFrame = document.getElementById('gameframe');

                for (a = 2; a >= 0; a--) {
                    //Create a new row of subgames
                    newRow = buttonFrame.insertRow();
                    for (b = 2; b >= 0; b--) {
                        newCell = newRow.insertCell();
                        subTable=document.createElement('table');
                        newCell.appendChild(subTable);
                        for (i = 2; i >= 0; i--) {
                            newSubRow=subTable.insertRow();
                            for (j = 2; j >= 0; j--) {
                                
                                newButton = document.createElement('input');
                                newButton.type = 'button';
                                
                                newButton.id=a+'-'+b+'-'+i+'-'+j;
                                newButton.a=a;
                                newButton.b=b;
                                newButton.x=i;
                                newButton.y=j;
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
        <h2>Game</h2>
        <table>
            <tr>
                <td>Logged in as</td>
                <td> <%= session.getAttribute("_user")%></td>
            </tr>
        </table>

        <p/>

        <hr/>
        <table id="gameframe"></table>   

        <hr/>
        
        <div id="nav">
            <table>
                <tr>
                    <td><a href="/CapstoneProject/lobby.jsp"><img src="images/home.png" alt="home"/></a></td>
                </tr>
                <tr>
                    <td><a href="/CapstoneProject/index.jsp"><img src="images/logout.png" alt="home"/></a></td>
                </tr>
            </table>
        </div>

    </body>
</html>