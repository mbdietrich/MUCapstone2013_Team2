<%-- 
    Document   : privateGame
    Created on : Oct 10, 2013, 11:25:47 AM
    Author     : luke
--%>
<%@page import="capstone.server.GameManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collection"%>
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
        
        <script>
            var source = new EventSource("GoogleFriends");
            source.onmessage = function(event) {
                console.log("on message");
                if (event.data) { // only update if the string is not empty
                    compareGoogleFriends(event.data);
                }
            };
            
            var googleFriends;
            
            
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
                $.post("create", {type: "newprivate"}, function(e) {
                    document.location.href= "game.jsp";
                })
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
            
            function signinCallback(authResult) {
  if (authResult['access_token']) {
    // Update the app to reflect a signed in user
    // Hide the sign-in button now that the user is authorized, for example:
    document.getElementById('signinButton').setAttribute('style', 'display: none');
    gapi.client.load('plus', 'v1', function() {
        var request = gapi.client.plus.people.list({
            'userId' : 'me',
            'collection' : 'visible'
        });
    
        request.execute(function(resp) {
            googleFriends = resp;
        });
    });
    document.getElementById("loading").style.display = "none";
    document.getElementById("googleFriends").style.display = "inline-table";
    
  } else if (authResult['error']) {
    // Update the app to reflect a signed out user
    // Possible error values:
    //   "user_signed_out" - User is signed-out
    //   "access_denied" - User denied access to your app
    //   "immediate_failed" - Could not automatically log in the user
    console.log('Sign-in state: ' + authResult['error']);
  }
}

function compareGoogleFriends(online) {
    //first, remove the table
    var parent = document.getElementById("googleFriends");
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.firstChild);
    }

    var friendsToDisplay = new Array();
    var numItems = googleFriends.items.length;
    var onlinePlayers = online;
    for (var i=0;i<numItems;i++) {
        if(onlinePlayers.indexOf(googleFriends.items[i].id) !== -1) {   //if the google friend is online
            if(friendsToDisplay.indexOf(googleFriends.items[i].displayName) === -1) {    
                friendsToDisplay.push(googleFriends.items[i].displayName);
                var x=document.getElementById('googleFriends').insertRow(0);
                var y=x.insertCell(0);
                y.innerHTML=googleFriends.items[i].displayName;
            }
        }
    }
    if(friendsToDisplay.length === 0) {
        document.getElementById("noFriends").style.display = "inline";
        document.getElementById("googleFriends").style.display = "none";
    } else {
        document.getElementById("noFriends").style.display = "none";
        document.getElementById("googleFriends").style.display = "inline-table";
    }
}
</script>
    </head>
    <body onload="load();">
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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle="tooltip" title="Create new games, and view open games.">Games <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="singlePlayer();">Play a bot</a></li>
                                <li><a href="#" onclick="multiPlayer();">Play a user</a></li>
                                <li><a href="#" onclick="openPrivateGame();">New Private Game</a></li>
                                <li><a href="lobby.jsp">Open Games</a></li>
                            </ul>
                        </li>
                        <li><a href="accountManagement.jsp" data-toggle="tooltip" title="Update your profile and find friends.">Profile</a></li>
                        
                    </ul>
                    <p class="navbar-text navbar-right">Hello, <%= session.getAttribute("user")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></p>                    
                </div>
            </nav>
    <script src="sonic.js"></script>
    <script>
        var loader = new Sonic({

		width: 50,
		height: 50,

		stepsPerFrame: 1,
		trailLength: 1,
		pointDistance: .02,
		fps: 30,

		fillColor: '#05E2FF',

		step: function(point, index) {
			
			this._.beginPath();
			this._.moveTo(point.x, point.y);
			this._.arc(point.x, point.y, index * 7, 0, Math.PI*2, false);
			this._.closePath();
			this._.fill();

		},

		path: [
			['arc', 25, 25, 15, 0, 360]
		]

	});
        
        function load() {
        loader.play();
        document.getElementById("loading").appendChild(loader.canvas);
        }
    </script>

            

            <div class="jumbotron">
                <div class="container">
                    <div class="heading1">Select a friend to play against!</div>
                </div>
                <span id="signinButton" style="display:none">
  <span
    class="g-signin"
    data-callback="signinCallback"
    data-clientid="1062173662525.apps.googleusercontent.com"
    data-cookiepolicy="single_host_origin"
    data-requestvisibleactions="http://schemas.google.com/AddActivity"
    data-scope="https://www.googleapis.com/auth/plus.login">>
  </span>
</span>
            </div> 
                
                    <table id="googleFriends" align="center" style="display:none">
                    </table>
                <div id="loading"></div>
                <div id="noFriends" style="display:none" class="padBottom heading">None of your friends are currently online</div>
                
                <script type="text/javascript">
      (function() {
       var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
       po.src = 'https://apis.google.com/js/client:plusone.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
     })();
    </script>
    </body>
</html>