<%-- 
    Document   : index
    Created on : 21/07/2013, 9:51:01 AM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style type="text/css">
            div.game{
                width:50px;
                height:50px;
                background:slategrey;
                font-size:50;
                text-align:center;
                margin:5px;
                border:#black 1px solid;
            }
        </style>
        <script>
            function makeMove(){
                var cell1 = document.getElementById("cell1");
                var cell2 = document.getElementById("cell2");
                var cell3 = document.getElementById("cell3");
                var cell4 = document.getElementById("cell4");
                var cell5 = document.getElementById("cell5");
                var cell6 = document.getElementById("cell6");
                var cell7 = document.getElementById("cell7");
                var cell8 = document.getElementById("cell8");
                var cell9 = document.getElementById("cell9");
                
                cell1.innerHTML = Math.floor(Math.random()*3);
                cell2.innerHTML = Math.floor(Math.random()*3);
                cell3.innerHTML = Math.floor(Math.random()*3);
                cell4.innerHTML = Math.floor(Math.random()*3);
                cell5.innerHTML = Math.floor(Math.random()*3);
                cell6.innerHTML = Math.floor(Math.random()*3);
                cell7.innerHTML = Math.floor(Math.random()*3);
                cell8.innerHTML = Math.floor(Math.random()*3);
                cell9.innerHTML = Math.floor(Math.random()*3);
                
                
            }
        </script>
    <body>
        <table align="center">
            <tr>
            <td><div id="cell1" class="game">0</div></td>
            <td><div id="cell2" class="game">0</div></td>
            <td><div id="cell3" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell4" class="game">0</div></td>
            <td><div id="cell5" class="game">0</div></td>
            <td><div id="cell6" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell7" class="game">0</div></td>
            <td><div id="cell8" class="game">0</div></td>
            <td><div id="cell9" class="game">0</div></td>
            </tr>     
        </table>
        <hr style="width: 100%; height: 2px;">
        <form action="move">
        <input name="coordinates" size="50" value="PRESSBUTTON!!!"><br>
        </form>
        <button onclick="makeMove()">Make Move</button> 
        
    </body>
</html>
