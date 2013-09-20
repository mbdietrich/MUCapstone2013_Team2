<%-- 
    Document   : lobby
    Created on : 30/07/2013, 1:12:16 PM
    Author     : Max, Jesse

    lobby.jsp is where the player is sent before a game starts, but after logging in.
--%>
<%
    String userName = (String) session.getAttribute("user");
    if (userName == null) {
        response.sendRedirect("index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head><!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">

        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lobby Page</title>

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
            var joinPublicGame = function() {
                var pubName = document.getElementById("publicInput").value;
                $.post("create", {type: "public", player: pubName}, function(e) {
                    document.location.href = "game.jsp";
                });
            }
            var openGame = function() {
                $.post("create", {type: "open"}, onGameCreate);
            }


            var loadGames = function() {
                $.get(
                        "GetPublicGames",
                        function(data) {
                            //alert(data.toString());
                            // set as content in div with id conversations
                            $("#gameList").html(data);
                        }
                );
            }
            $().ready(function() {
                // load conversation after page is loaded
                loadGames();
            });



            var onGameCreate = function(data) {
                //TODO update lobby.jsp if the player has created a game
            }
        </script>
    </head>
    <body>


        <ul class="nav nav-tabs">
            <li class="active"><a href="#">Home</a></li>
            <li><a class="disabled" href="#">Lobby</a></li>
            <li><a href="accountManagement.jsp">Profile</a></li>
            
            <li class="align-right"><a href="logout.jsp">Log Out</a></li>
        </ul>

        <div id="content">

            <div class="jumbotron">
                <div class="container">
                    <h2>Welcome <%= session.getAttribute("user")%>!</h1>
                </div>
            </div><br><br>
            <div class="row">
                <div class="col-md-3 col-md-offset-3">
                    <div class="btn-group-vertical">
                        <button type="button" class="btn btn-info" onclick="singlePlayer();">Play against a bot</button>
                        <button type="button" class="btn btn-info" onclick="multiPlayer();">Play against a user</button>
                    </div>
                </div>
                    
                </div>
            </div>

            <br><br>

            


            <table>
                <tr>

                    <td>
                        <form name="logout" action="logout.jsp" method="POST">
                            <input type="image" src="images/logout.png" alt="logout" class="fade" />
                        </form>
                    </td>
                </tr>
                <td>
                    <a href="accountManagement.jsp" align="center">Profile</a>
                </td>
            </table>
            <table border="0" align="left">
                <tr><td><div id="gameList"></div></td></tr>
            </table>
            <b>Open Games <button onclick="loadGames()">refresh</button></b>  <br>
            <!-- load conversation when button is pressed loaded -->
            <input type="text" id="publicInput"></input><button onclick="joinPublicGame();">Join</button>


        </div>

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
