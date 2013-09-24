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
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />
        
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        
        <title>TTT - Home</title>
        
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
                        <li class="active"><a href="home.jsp">Home</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle = "tooltip" title="Create new games, and view open games.">Games <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="singlePlayer();">Play a bot</a></li>
                                <li><a href="#" onclick="multiPlayer();">Play a user</a></li>
                                <li><a href="lobby.jsp">Open Games</a></li>
                            </ul>
                        </li>
                        <li><a href="accountManagement.jsp" data-toggle="tooltip" title="Update your profile and find friends.">Profile</a></li>
                        
                    </ul>
                    <p class="navbar-text navbar-right">Hello, <%= session.getAttribute("user")%> | <a href="logout.jsp">Log out</a></p>                    
                </div>
            </nav>

            <div class="jumbotron">
                <div class="container">
                    <div class="heading1">Welcome <%= session.getAttribute("user")%>!</div>
                        <button type="button" class="btn btn-xs btn-default" onclick="singlePlayer();">Quick Game</button>
                </div>
            </div> 
    </body>
</html>
