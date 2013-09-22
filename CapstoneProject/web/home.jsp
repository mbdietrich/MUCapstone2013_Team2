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
            var joinPrivateGame = function() {
                var privName = document.getElementById("publicInput").value;
                $.post("create", {type: "private", player: privName}, function(e) {
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
        <ul class="nav nav-tabs nav-justified padBottom">
                <li class="active"><a href="home.jsp"><span class="glyphicon glyphicon-home"></span></a></li>
                <li ><a href="lobby.jsp"><span class="glyphicon glyphicon-th-list"></span></a></li>
                <li><a href="accountManagement.jsp"><span class="glyphicon glyphicon-user"></span></a></li>
                <li class="disabled"><a href="#"><span class="glyphicon glyphicon-time"></span></a></li>
                <li class="align-right"><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
        </ul>

            <div class="jumbotron">
                <div class="container">
                    <div class="heading1">Welcome <%= session.getAttribute("user")%>!</div>

                    <div class="btn-group-vertical">
                        <button type="button" class="btn btn-info" onclick="singlePlayer();">Play against a bot</button>
                        <button type="button" class="btn btn-info" onclick="multiPlayer();">Play against a user</button>
                    </div>

                </div>
            </div> 
    </body>
</html>
