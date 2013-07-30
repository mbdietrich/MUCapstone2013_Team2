<%-- 
    Document   : game
    Created on : 30/07/2013, 1:13:18 PM
    Author     : Max, Jesse

    Page where the game is rendered.
--%>

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
        <link rel="stylesheet" type="text/css" href="style.css">
        <script type="text/javascript" src="jquery-1.8.3.js"></script>

        <script>
            var arrayHistory = [];
            window.onload = function() {
                var i, buttonFrame, newButton;
                buttonFrame = document.getElementById('gameframe');
                for (i = 0; i < 9; i++) {
                    for (j = 0; j < 9; j++) {
                        var fg = document.createElement('br');
                        //var vert = document.createElement('div');
                        //vert.class = 'vert';
                        newButton = document.createElement('input');
                        newButton.type = 'button';
                        if((j+i) % 2 == 0){
                        newButton.value = "X";
                        }
                        else
                        {
                        newButton.value = "O"; 
                        }
                        newButton.id = ((9 * i) + j) + 1;
                        var test = j % 3;
                        newButton.onclick = function() {
                            window.confirm('This is button ' + this.id);
                            arrayHistory[arrayHistory.length] = this.id;
                        };
                        buttonFrame.appendChild(newButton);
                        if (j === 8)
                        {
                            buttonFrame.appendChild(fg);
                        }
                    }
                }
            };
        </script>

    </head>
    <body>
        <h3>Game.jsp</h3>
        <table>
            <tr>
                <td>User Name</td>
                <td><%= session.getAttribute("_user")%></td>
            </tr>
            <tr>
                <td>GameSession:</td>
                <td> <%= session.getAttribute("_gamesession")%></td>
            </tr>
        </table>

        <p/>

        <hr/>
        <div id="gameframe"></div>   

        <hr/>
        <a href="leave">leave conversation</a>

    </body>
</html>