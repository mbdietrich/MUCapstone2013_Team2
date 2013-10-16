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
    String fbid = (String) session.getAttribute("fbid");
            
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
        <script src="gamemethods.js"></script>
        
        <script>
            
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
            
            //listen for game invites
            var source2 = new EventSource("GameInvites");
            source2.onmessage = function(event) {
                if (event.data) {
                    processGameInvites(event.data); //show game invites on page
                    updateInviteMenu("yes"); //show that there are invites in the menu
                } else {
                    updateInviteMenu("no"); //if no request, hide menu
                }
            };
            
            function updateInviteMenu(update) {
                if(update === "no") {
                    document.getElementById("menuInvites").style.display="none";
                } else {
                    document.getElementById("menuInvites").style.display="inline";
                }
            }
            
            var googleFriends;
            var facebookFriends;
            
            function processGameInvites(invites) {
                //frist, clear the table
                var parent = document.getElementById("gameInvites");
                while(parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }
                
                //if player logged in with google
                if("<%=fbid%>" === "0") {
                    // compare invites to google friends
                    var numItems = googleFriends.items.length;
                    for (var i=0;i<numItems;i++) {
                        if(invites.indexOf(googleFriends.items[i].id) !== -1) {
                            var x=document.getElementById('gameInvites').insertRow(0);
                            var y=x.insertCell(0);
                            var z=x.insertCell(1);
                            var imageURL = getGoogleImageURL(googleFriends.items[i].image.url);
                            y.innerHTML="<img src='"+imageURL+"' height='40' width='40'>";
                            z.innerHTML="<a href='JoinPrivateGame?friend="+googleFriends.items[i].displayName+"&friendID="+googleFriends.items[i].id+"'>"+googleFriends.items[i].displayName+" has challenged you to a game!</a>";
                        }
                    }
                } else {    //then player is logged in with facebook
                    $.each(response.data,function(index,friend) {
                       //console.log("friend: " + friend.name);
                       if(invites.indexOf(friend.id) !== -1) {
                           var x=document.getElementById('gameInvites').insertRow(0);
                           var y=x.insertCell(0);
                           var z=x.insertCell(1);
                           var imageURL = getFacebookImageURL(friend.id);
                           y.innerHTML="<img src='"+imageURL+"' height='40' width='40'>";
                           z.innerHTML="<a href='JoinPrivateGame?friend="+friend.name+"&friendID="+friend.id+"'>"+friend.name+" has challenged you to a game!</a>";
                       }
                    });
                }
            }
            
            
            //handle google invites
            var source = new EventSource("GoogleFriends");
            source.onmessage = function(event) {
                var gid = "<%=gid%>";
                if (event.data) { // only update if the string is not empty
                    if(gid !== "0") {   //only run if player is logged in with google
                        compareGoogleFriends(event.data);
                    }
                }
            };

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
                            y.innerHTML="<img src='"+imageURL+"' height='40' width='40'>";
                            var gid = "<%=gid%>";
                            z.innerHTML="<a href='SendPrivateGameInvite?me="+gid+"&friend="+googleFriends.items[i].id+"'>"+googleFriends.items[i].displayName+"</a>";
                        }
                    }
                }
                if(friendsToDisplay.length === 0) {
                    document.getElementById("loading").style.display = "none";
                    document.getElementById("noFriends").style.display = "inline";
                    document.getElementById("googleFriends").style.display = "none";
                } else {
                    document.getElementById("loading").style.display = "none";
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
        <div id="fb-root"></div>
        <script>
            // handle facebook friends
            window.fbAsyncInit = function() {
                FB.init({
                    appId: '689318734429599', // App ID
                    channelUrl: '//https://capstoneg2.jelastic.servint.net/ttt2/channel.html', // Channel File
                    status: true, // check login status
                    cookie: true, // enable cookies to allow the server to access the session
                    xfbml: true  // parse XFBML
                });

                // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
                // for any authentication related change, such as login, logout or session refresh. This means that
                // whenever someone who was previously logged out tries to log in again, the correct case below 
                // will be handled. 
                FB.Event.subscribe('auth.authResponseChange', function(response) {
                    // Here we specify what we do with the response anytime this event occurs. 
                    if (response.status === 'connected') {
                        // The response object is returned with a status field that lets the app know the current
                        // login status of the person. In this case, we're handling the situation where they 
                        // have logged in to the app.
                        //testAPI();
                        getFBFriends();
                    } else if (response.status === 'not_authorized') {
                        // In this case, the person is logged into Facebook, but not into the app, so we call
                        // FB.login() to prompt them to do so. 
                        // In real-life usage, you wouldn't want to immediately prompt someone to login 
                        // like this, for two reasons:
                        // (1) JavaScript created popup windows are blocked by most browsers unless they 
                        // result from direct interaction from people using the app (such as a mouse click)
                        // (2) it is a bad experience to be continually prompted to login upon page load.
                        FB.login();
                    } else {
                        // In this case, the person is not logged into Facebook, so we call the login() 
                        // function to prompt them to do so. Note that at this stage there is no indication
                        // of whether they are logged into the app. If they aren't then they'll see the Login
                        // dialog right after they log in to Facebook. 
                        // The same caveats as above apply to the FB.login() call here.
                        FB.login();
                    }
                });
            };

            // Load the SDK asynchronously
            (function(d) {
                var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement('script');
                js.id = id;
                js.async = true;
                js.src = "//connect.facebook.net/en_US/all.js";
                ref.parentNode.insertBefore(js, ref);
            }(document));
            
            // Here we run a very simple test of the Graph API after login is successful. 
            // This testAPI() function is only called in those cases. 
            function testAPI() {
                console.log('Welcome!  Fetching your information.... ');
                FB.api('/me', function(response) {
                    console.log('Good to see you, ' + response.name + '.');
                });
            }
            
            function getFBFriends() {
                FB.api('/me/friends', function(response) {
                    facebookFriends = response;
                });
            }
            
            var source = new EventSource("FacebookFriends");
            source.onmessage = function(event) {
                var fbid = "<%=fbid%>";
                if (event.data) { // only update if the string is not empty
                    if(fbid !== "0") {   //only run if player is logged in with facebook
                        compareFacebookFriends(event.data);
                    }
                }
            };
            
            function compareFacebookFriends(online) {
                //first, remove the table
                var parent = document.getElementById("facebookFriends");
                while(parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }
                //then, rebuild the table
                var friendsToDisplay = new Array();
                var onlinePlayers = online;
                
                //check if facebook friends are online
                $.each(facebookFriends.data,function(index,friend) {
                    //console.log("friend: " + friend.name);
                    if(onlinePlayers.indexOf(friend.id) !== -1) {    //if the facebook friend is online
                        friendsToDisplay.push(friend.name);
                        var x=document.getElementById('facebookFriends').insertRow(0);
                        var y=x.insertCell(0);
                        var z=x.insertCell(1);
                        var imageURL = getFacebookImageURL(friend.id);
                        y.innerHTML="<img src='"+imageURL+"' height='40 width='40'>";
                        var fbid = "<%=fbid%>";
                        z.innerHTML="<a href='SendPrivateGameInvite?me="+fbid+"&friend="+friend.id+"'>"+friend.name+"</a>";
                    }
                });
                if(friendsToDisplay.length === 0) {
                    document.getElementById("loading").style.display = "none";
                    document.getElementById("noFriends").style.display = "inline";
                    document.getElementById("facebookFriends").style.display = "none";
                } else {
                    document.getElementById("loading").style.display = "none";
                    document.getElementById("noFriends").style.display = "none";
                    document.getElementById("facebookFriends").style.display = "inline-table";
                }
            }
            
            function getFacebookImageURL(id) {
                var url = "https://graph.facebook.com/"+id+"/picture";
                return url;
            }
        </script>
        <div class="navBar1">
            <div class="menuLeft">
                <span><h1><a href="home.jsp">TIC TAC TOE</a></h1></span>
                
            </div>
            <nav class="menuRight">
                <ul>
                    <li><span>MENU</span>
                        <ul>
                            <li><a href="#" onclick="singlePlayer();">Play Default Bot</a></li>
                            <li><a href="#" onclick="multiPlayer();">Play Another User</a></li>
                            <li><a href="#" onclick="openPrivateGame();">Play Private Game</a></li>
                            <li><a href="boteditor.html">Create Bot</a></li>
                            <li><a href="#">Bot Lobby</a></li>
                            <li><a href="lobby.jsp">Game Lobby</a></li>
                            <li><a href="gamerecordmanager.jsp">Played Games</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            
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
                <span id="facebookButton" style="display:none">
                    <fb:login-button show-faces="true" width="200" max-rows="1" autologoutlink="true" scope="email"></fb:login-button>
                </span>
            </div> 
                    <div id="friends" style="width:50%; text-align:left; float:left">
                        <table id="googleFriends" align="center" style="display:none">
                        </table>
                        <table id="facebookFriends" align="center" style="display:none">
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
