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
        
        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>
        
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="jquery.layout-latest.min.js"></script>
        
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
            var openPrivateGame = function(){
                window.location = "privateGame.jsp";
                /*
                $.post("create", {type: "newprivate"}, function(e) {
                    document.location.href= "game.jsp";
                })*/
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
                            <li><a href="accountManagement.jsp">Profile</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="menuRight h3"><span>HOME</span></div>
        </div>

            <div class="jumbotron">
                <div class="container">
                    <div class="notices"><h2>Welcome <%= session.getAttribute("user")%>!</h2></div>
                    <div class="buttons buttons1"><a href="#" onclick="singlePlayer();">Quick Game</a></div>
                </div>
            </div> 
        
    </body>
</html>
