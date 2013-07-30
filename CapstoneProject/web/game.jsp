<%-- 
    Document   : game
    Created on : 30/07/2013, 1:13:18 PM
    Author     : Max

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
            // post a new message
            var postMessage = function() {
                var data = $("#message").val();
                $.post(
                        "post",
                        data,
                        function() {
                            displayPost("me",data,true);
                        }
                );
            };

            // display a post
            var displayPost = function(user,text,thisUser) {
                var clazz = thisUser?"thisuser":"otheruser";
                var count = 0;
                var tr = '<tr class="' + clazz + '"><td class="message_user">'+ user + '</td><td class="message_text">' + text + '</td></tr>';
                //tr =  clazz + ' ' + user + '' + text;
                //for (var s=0; i<9 ;s++)
                //{
                //    tr = '<div id="' + i + '" + class="' + clazz + '"><td class="message_user">'+ user + '</td><td class="message_text">' + text.charAt[count] + '</td></div>';
                //    tr = "hello";
                //}
                       
                document.getElementById("conversation").innerHTML = tr;
           
           
            // listen to server push
            var source = new EventSource("fetch");
            source.onmessage = function(event) {
                if (event.data) { // only update if the string is not empty
                    console.log("data received: " + event.data);
                    var messages = jQuery.parseJSON(event.data);
                    for (var i in messages) {
                        displayPost(messages[i].user,messages[i].text,false);
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
                    <td><%= session.getAttribute("_user") %></td>
                </tr>
                <tr>
                    <td>GameSession:</td>
                    <td> <%= session.getAttribute("_gamesession") %></td>
                </tr>
            </table>
           
            <p/>
           
            <hr/>
           
        <table align="center">
        <tr><td>
        <table>
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
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell10" class="game">0</div></td>
            <td><div id="cell11" class="game">0</div></td>
            <td><div id="cell12" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell13" class="game">0</div></td>
            <td><div id="cell14" class="game">0</div></td>
            <td><div id="cell15" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell16" class="game">0</div></td>
            <td><div id="cell17" class="game">0</div></td>
            <td><div id="cell18" class="game">0</div></td>
            </tr>    
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell19" class="game">0</div></td>
            <td><div id="cell20" class="game">0</div></td>
            <td><div id="cell21" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell22" class="game">0</div></td>
            <td><div id="cell23" class="game">0</div></td>
            <td><div id="cell24" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell25" class="game">0</div></td>
            <td><div id="cell26" class="game">0</div></td>
            <td><div id="cell27" class="game">0</div></td>
            </tr>    
        </table>
        </td>
        </tr>
                <tr><td>
        <table>
            <tr>
            <td><div id="cell28" class="game">0</div></td>
            <td><div id="cell29" class="game">0</div></td>
            <td><div id="cell30" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell31" class="game">0</div></td>
            <td><div id="cell32" class="game">0</div></td>
            <td><div id="cell33" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell34" class="game">0</div></td>
            <td><div id="cell35" class="game">0</div></td>
            <td><div id="cell36" class="game">0</div></td>
            </tr>    
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell37" class="game">0</div></td>
            <td><div id="cell38" class="game">0</div></td>
            <td><div id="cell39" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell40" class="game">0</div></td>
            <td><div id="cell41" class="game">0</div></td>
            <td><div id="cell42" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell43" class="game">0</div></td>
            <td><div id="cell44" class="game">0</div></td>
            <td><div id="cell45" class="game">0</div></td>
            </tr>    
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell46" class="game">0</div></td>
            <td><div id="cell47" class="game">0</div></td>
            <td><div id="cell48" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell49" class="game">0</div></td>
            <td><div id="cell50" class="game">0</div></td>
            <td><div id="cell51" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell52" class="game">0</div></td>
            <td><div id="cell53" class="game">0</div></td>
            <td><div id="cell54" class="game">0</div></td>
            </tr>    
        </table>
        </td>
        </tr> 
                <tr><td>
        <table>
            <tr>
            <td><div id="cell55" class="game">0</div></td>
            <td><div id="cell56" class="game">0</div></td>
            <td><div id="cell57" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell58" class="game">0</div></td>
            <td><div id="cell59" class="game">0</div></td>
            <td><div id="cell60" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell61" class="game">0</div></td>
            <td><div id="cell62" class="game">0</div></td>
            <td><div id="cell63" class="game">0</div></td>
            </tr>    
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell64" class="game">0</div></td>
            <td><div id="cell65" class="game">0</div></td>
            <td><div id="cell66" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell67" class="game">0</div></td>
            <td><div id="cell68" class="game">0</div></td>
            <td><div id="cell69" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell70" class="game">0</div></td>
            <td><div id="cell71" class="game">0</div></td>
            <td><div id="cell72" class="game">0</div></td>
            </tr>    
        </table></td><td>
        <table>
            <tr>
            <td><div id="cell73" class="game">0</div></td>
            <td><div id="cell74" class="game">0</div></td>
            <td><div id="cell75" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell76" class="game">0</div></td>
            <td><div id="cell77" class="game">0</div></td>
            <td><div id="cell78" class="game">0</div></td>
            </tr>
            <tr>
            <td><div id="cell79" class="game">0</div></td>
            <td><div id="cell80" class="game">0</div></td>
            <td><div id="cell81" class="game">0</div></td>
            </tr>    
        </table>
        </td>
        </tr> 
        </table>
            <hr/>
            <a href="leave">leave conversation</a>
           
    </body>
</html>