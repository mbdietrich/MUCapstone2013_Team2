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
                        document.getElementById("gameframe").style.display = 'none';
                    }
                    else if(!state.waiting){
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
                                        button.className = "btn btn-default";
                                        buttonTrans.className = "glyphicon glyphicon-remove";
                                        //button.value = "X";
                                    }
                                    else if(value==2){
                                        button.className = "btn btn-default";
                                        buttonTrans.className = "glyphicon glyphicon-ban-circle";
                                        //button.value = "O";
                                    }
                                    else{
                                        button.className = "btn btn-info";
                                        buttonTrans.className = "glyphicon glyphicon-minus";
                                        //button.value = "  ";
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
                    if (state.Status === state.PlayerNumber){
                        window.alert("YOU WIN!");
                        $.post('leave');
                        window.location.href="/CapstoneProject/home.jsp";
                    }else if (state.Status === "2" || state.Status === "1"){
                        window.alert("SORRY, YOU LOSE.");
                        $.post('leave');
                        window.location.href="/CapstoneProject/home.jsp";
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
                                
                                buttonTrans = document.createElement('span');
                                newButton = document.createElement('button');
                                newButton.type = 'button';
                                newButton.className = 'btn btn-default';
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
            
        <div class="padBottom heading"><%= session.getAttribute("user")%> vs Opponent</div>
        <table id="gameframe" align="center"></table>   
    </body>
</html>
