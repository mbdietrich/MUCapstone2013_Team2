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
    
    String gid = (String) session.getAttribute("gid");
            
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
        
        
        <title>TTT - Private Game</title>
        
        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>
        
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        
        <script>
            var source = new EventSource("GoogleFriends");
            source.onmessage = function(event) {
                if (event.data) { // only update if the string is not empty
                    compareGoogleFriends(event.data);
                }
            };
            
            var source2 = new EventSource("GameInvites");
            source2.onmessage = function(event) {
                if (event.data) {
                    processGameInvites(event.data); //show game invites on page
                    updateInviteMenu("yes"); //show that there are invites in the menu
                } else {
                    updateInviteMenu("no"); //if no request, hide menu
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

function updateInviteMenu(update) {
    if(update === "no") {
        document.getElementById("menuInvites").style.display="none";
    } else {
        document.getElementById("menuInvites").style.display="inline";
    }
}

function processGameInvites(invites) {
    //frist, clear the table
    var parent = document.getElementById("gameInvites");
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.firstChild);
    }
        
    // compare invites to google friends
    var numItems = googleFriends.items.length;
    for (var i=0;i<numItems;i++) {
        if(invites.indexOf(googleFriends.items[i].id) !== -1) {
            var x=document.getElementById('gameInvites').insertRow(0);
            var y=x.insertCell(0);
            var z=x.insertCell(1);
            var imageURL = getGoogleImageURL(googleFriends.items[i].image.url);
            y.innerHTML="<img src='"+imageURL+" height='40' width='40'>";
            z.innerHTML="<a href='linktojoingame...'>"+googleFriends.items[i].displayName+" has challenged you to a game!</a>";
        }
    }
}

function compareGoogleFriends(online) {
    //first, remove the table
    var parent = document.getElementById("googleFriends");
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.firstChild);
    }
    //then, rebuild the table
    var friendsToDisplay = new Array();
    var numItems = googleFriends.items.length;
    var onlinePlayers = online;
    for (var i=0;i<numItems;i++) {
        if(onlinePlayers.indexOf(googleFriends.items[i].id) !== -1) {   //if the google friend is online
            if(friendsToDisplay.indexOf(googleFriends.items[i].displayName) === -1) {    
                friendsToDisplay.push(googleFriends.items[i].displayName);
                var x=document.getElementById('googleFriends').insertRow(0);
                var y=x.insertCell(0);
                var z=x.insertCell(1);
                var imageURL = getGoogleImageURL(googleFriends.items[i].image.url);
                y.innerHTML="<img src='"+imageURL+" height='40' width='40'>";
                var gid = "<%=gid%>";
                z.innerHTML="<a href='SendPrivateGameInvite?me="+gid+"&friend="+googleFriends.items[i].id+"'>"+googleFriends.items[i].displayName+"</a>";
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

function getGoogleImageURL(url) {
    var parts = url.split("?");
    return parts[0];
}
</script>
    </head>
    <body onload="load();">
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
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="menuRight h3"><span>PRIVATE GAME</span></div>
            <div class="menuRight h5" id="menuInvites" style="display:none"><span><a href="privateGame.jsp">You have been challenged to a game!</a></span></div>
        </div>
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
                    <div class="heading1 notices1">Select a friend to play against!</div>
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
                    <div id="friends" style="width:50%; text-align:left; float:left">
                    <table id="googleFriends" align="center" style="display:none">
                    </table>
                    <div id="loading"></div>
                    <div id="noFriends" style="display:none" class="padBottom heading notices2">None of your friends are currently online</div>
                    </div>
    
                    <div id="gInvites" style="width:50%; text-align:left; float:left">
                    <table id="gameInvites" align="center"></table>
                    </div>
                
                <script type="text/javascript">
      (function() {
       var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
       po.src = 'https://apis.google.com/js/client:plusone.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
     })();
    </script>
    </body>
</html>