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
                                if ((j + i) % 2 == 0) {
                                    newButton.value = "X";
                                }
                                else
                                {
                                    newButton.value = "O";
                                }
                                newButton.id=a+'-'+b+'-'+i+'-'+j;
                                newButton.a=a;
                                newButton.b=b;
                                newButton.x=i;
                                newButton.y=j;
                                newButton.onclick = function() {
                                window.confirm('This button\'s coordinates are ' + this.a+','+this.b+';'+this.x+','+this.y);
                                arrayHistory[arrayHistory.length] = this.id;
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
    <body>
        <h3>Game.jsp</h3>
        <table>
            <tr>
                <td>User Name</td>
                <td><%= session.getAttribute("_user")%></td>
            </tr>
        </table>

        <p/>

        <hr/>
        <table id="gameframe"></table>   

        <hr/>

    </body>
</html>