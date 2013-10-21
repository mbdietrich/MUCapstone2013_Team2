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
    <head>

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <script type="text/javascript" src="gamemethods.js"</script>
        <script src="bootstrap/js/bootstrap.min.js"></script>


        <title>TTT - Game Record Manager</title>

        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>

        <script>
            //listen for game invites
            var sourceInvites = new EventSource("GameInvites");
            sourceInvites.onmessage = function(event) {
                if (event.data) {
                    processGameInvites(event.data); //show game invites on page
                    updateInviteMenu("yes"); //show that there are invites in the menu
                } else {
                    processGameInvites(event.data); //show game invites on page
                    updateInviteMenu("no"); //if no request, hide menu
                }
            };

            function updateInviteMenu(update) {
                if (update === "no") {
                    document.getElementById("challengeMenu").style.visibility = "hidden";
                } else {
                    document.getElementById("challengeMenu").style.visibility = "visible";

                }
            }

            var googleFriends;
            var facebookFriends;

            function processGameInvites(invites) {
                //frist, clear the table
                var parent = document.getElementById("challengeMenu");
                while (parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }

                var insert = "<li><span>CHALLENGES!</span><ul>";

                //if player logged in with google
                if ("<%=fbid%>" === "0") {
                    // compare invites to google friends
                    var numItems = googleFriends.items.length;
                    for (var i = 0; i < numItems; i++) {
                        if (invites.indexOf(googleFriends.items[i].id) !== -1) {
                            var imageURL = getGoogleImageURL(googleFriends.items[i].image.url);
                            insert = insert + "<li><img src='" + imageURL + "' height='40' width='40'>";
                            insert = insert + "<a href='JoinPrivateGame?friend=" + googleFriends.items[i].displayName + "&friendID=" + googleFriends.items[i].id + "'>" + googleFriends.items[i].displayName + "</a></li>";
                        }
                    }
                    insert = insert + "</ul></li>";
                    document.getElementById("challengeMenu").innerHTML = insert;
                } else {    //then player is logged in with facebook
                    $.each(facebookFriends.data, function(index, friend) {
                        if (invites.indexOf(friend.id) !== -1) {
                            var imageURL = getFacebookImageURL(friend.id);
                            insert = insert + "<li><img src='" + imageURL + "' height='40' width='40'>";
                            insert = insert + "<a href='JoinPrivateGame?friend=" + friend.name + "&friendID=" + friend.id + "'>" + friend.name + "</a></li>";
                        }
                    });
                    insert = insert + "</ul></li>";
                    document.getElementById("challengeMenu").innerHTML = insert;
                }
            }

            //handle google invites
            var sourceGFriends = new EventSource("GoogleFriends");
            sourceGFriends.onmessage = function(event) {
                var gid = "<%=gid%>";
                if (event.data) { // only update if the string is not empty
                    if (gid !== "0") {   //only run if player is logged in with google
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
                            'userId': 'me',
                            'collection': 'visible'
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
                var parent = document.getElementById("privateGameMenu");
                while (parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }
                //then, rebuild the table
                var friendsToDisplay = new Array();
                var numItems = googleFriends.items.length;
                var onlinePlayers = online;
                for (var i = 0; i < numItems; i++) {
                    if (onlinePlayers.indexOf(googleFriends.items[i].id) !== -1) {   //if the google friend is online
                        if (friendsToDisplay.indexOf(googleFriends.items[i].displayName) === -1) {
                            friendsToDisplay.push(googleFriends.items[i].displayName);
                            var imageURL = getGoogleImageURL(googleFriends.items[i].image.url);
                            var gid = "<%=gid%>";
                            document.getElementById("privateGameMenu").innerHTML = "<li><a href='SendPrivateGameInvite?me=" + gid + "&friend=" + googleFriends.items[i].id + "'><img src='" + imageURL + "' height='40' width='40'>" + googleFriends.items[i].displayName + "</a></li>";
                        }
                    }
                }
                if (friendsToDisplay.length === 0) {
                    document.getElementById("loading").style.display = "none";
                    document.getElementById("privateGameMenu").innerHTML = "<li>No friends online</li>";
                } else {
                    document.getElementById("loading").style.display = "none";
                }
            }

            function getGoogleImageURL(url) {
                var parts = url.split("?");
                return parts[0];
            }

            var loadGames = function() {
                $.getJSON(
                        "GameRecordGet", {type: "games"}, function(data) {
                    refresh(data.games);
                }
                );
            };
            var currentCoords;
            var count = 0;
            var firstplayer = true;

            var loadCoords = function() {
                show();
                var gameID = document.getElementById("gameList");
                var stru = gameID.options[gameID.selectedIndex].id;

                $.getJSON(
                        "GameRecordGet", {type: "coords", gameid: stru}, function(data) {
                    setCurrentGame(data.coords);
                }
                );
            };

            var identify = function() {

            }


            var setCurrentGame = function(game) {
                //currentCoords = null;
                //alert(game);           
                currentCoords = game;
                count = 0;
                firstplayer = true;
                document.getElementById("gameframe").innerHTML = "";
                initiate();
            };

            var playGame = function() {
                var tempbutton = document.getElementById(currentCoords[count]).firstElementChild;
                if (firstplayer === true) {
                    tempbutton.src = 'images/ex.png';
                    tempbutton.className = "gameButton";
                    firstplayer = false;
                    count += 1;
                }
                else {
                    tempbutton.src = 'images/oh.png';
                    tempbutton.className = "gameButton";
                    firstplayer = true;
                    count += 1;
                }
            };
            var initiate = function() {
                var buttonFrame, newRow, newCell, subTable, newSubRow, newButton, buttonCell;
                buttonFrame = document.getElementById('gameframe');

                for (a = 2; a >= 0; a--) {
                    //Create a new row of subgames
                    newRow = buttonFrame.insertRow();
                    for (b = 2; b >= 0; b--) {
                        newCell = newRow.insertCell();
                        subTable = document.createElement('table');
                        subTable.className = 'subTable';
                        newCell.appendChild(subTable);
                        for (i = 2; i >= 0; i--) {
                            newSubRow = subTable.insertRow();
                            for (j = 2; j >= 0; j--) {
                                buttonTrans = document.createElement('img');
                                buttonTrans.className = 'fadeGameButton gameButton';
                                buttonTrans.src = 'images/blank.png';
                                newButton = document.createElement('a');
                                newButton.id = a.toString() + b.toString() + i.toString() + j.toString();
                                newButton.appendChild(buttonTrans);
                                buttonCell = newSubRow.insertCell();
                                buttonCell.appendChild(newButton);
                            }
                        }
                    }
                }
            };
            var functionOnLoad = function() {
                initiate();
                loadGames();
                hide();
            };
            var hide = function() {
                document.getElementById("playButton").style.visibility = "hidden";
                document.getElementById("backButton").style.visibility = "hidden";
            };
            var show = function() {
                document.getElementById("playButton").style.visibility = "visible";
                document.getElementById("backButton").style.visibility = "visible";
            };

            window.onload = functionOnLoad;

            var refresh = function(data) {

                newLines = "";

                if (data.length === 0) {
                    newLines = "<option class='alert-info'>Sorry, there are no recorded games available.</option>";
                } else {
                    for (i = 0; i < data.length; i++) {
                        if (data[i].p2 === "") {
                            data[i].p2 = "Bot";
                        }
                        newLines = newLines + '<option id="' + data[i].gid + '">' + "X " + data[i].p1 + " vs " + data[i].p2 + " O" + "</option>";
                    }
                    document.getElementById("joinButton").innerHTML = '<br><button type="button" class="btn" onclick="loadCoords();">Open</button>';
                }
                document.getElementById("gameList").innerHTML = newLines;
            }
        </script>
    </head>
    <body onload="loadAnimation();">
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

            var sourceFBFriends = new EventSource("FacebookFriends");
            sourceFBFriends.onmessage = function(event) {
                var fbid = "<%=fbid%>";
                if (event.data) { // only update if the string is not empty
                    if (fbid !== "0") {   //only run if player is logged in with facebook
                        compareFacebookFriends(event.data);
                    }
                }
            };

            function compareFacebookFriends(online) {
                //first, remove the table
                var parent = document.getElementById("privateGameMenu");
                while (parent.hasChildNodes()) {
                    parent.removeChild(parent.firstChild);
                }
                //then, rebuild the table
                var friendsToDisplay = new Array();
                var onlinePlayers = online;

                //check if facebook friends are online
                $.each(facebookFriends.data, function(index, friend) {
                    //console.log("friend: " + friend.name);
                    if (onlinePlayers.indexOf(friend.id) !== -1) {    //if the facebook friend is online
                        friendsToDisplay.push(friend.name);
                        var imageURL = getFacebookImageURL(friend.id);
                        var fbid = "<%=fbid%>";
                        document.getElementById("privateGameMenu").innerHTML = "<li><a href='SendPrivateGameInvite?me=" + fbid + "&friend=" + friend.id + "'><img src='" + imageURL + "' height='40 width='40'>" + friend.name + "</a></li>";
                    }
                });
                if (friendsToDisplay.length === 0) {
                    document.getElementById("loading").style.display = "none";
                    document.getElementById("privateGameMenu").innerHTML = "<li>No friends online</li>";
                } else {
                    document.getElementById("loading").style.display = "none";
                }
            }

            function getFacebookImageURL(id) {
                var url = "https://graph.facebook.com/" + id + "/picture";
                return url;
            }
            var backGame = function() {
                if (count !== 0) {
                    var tempbutton = document.getElementById(currentCoords[count - 1]).firstElementChild;
                    tempbutton.src = 'images/blank.png';
                    tempbutton.className = 'fadeGameButton gameButton';
                    count -= 1;
                    if (firstplayer === true) {
                        firstplayer = false;
                    }
                    else {
                        firstplayer = true;
                    }
                }
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
                            <li><a href="#">Play Private Game</a>
                                <ul id="privateGameMenu"></ul>
                                <ul id="loading"></ul>
                            </li>
                            <li><a href="boteditor.html">Create Bot</a></li>
                            <li><a href="botLobby.jsp">Bot Lobby</a></li>
                            <li><a href="lobby.jsp">Game Lobby</a></li>
                            <li><a href="gamerecordmanager.jsp">Played Games</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
                <ul style="visibility:hidden" id="challengeMenu">
                </ul>
            </nav>
        </div>
        <script src="sonic.js"></script>
        <script>
                var loader = new Sonic({
                    width: 100,
                    height: 50,
                    stepsPerFrame: 1,
                    trailLength: 1,
                    pointDistance: .1,
                    fps: 15,
                    padding: 10,
                    //step: 'fader',

                    fillColor: '#ffffff',
                    setup: function() {
                        this._.lineWidth = 20;
                    },
                    path: [
                        ['line', 0, 20, 100, 20],
                        ['line', 100, 20, 0, 20]
                    ]

                });

                function loadAnimation() {
                    initiate();
                    loadGames();
                    hide();
                    loader.play();
                    document.getElementById("loading").appendChild(loader.canvas);
                }
        </script>
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
        <table>
            <tr>
                <td><div class="heading padBottom">Select a game to play: <br><br><button type="button" class="btn btn-xs" onclick="loadGames();">Click to refresh list.</button></div>
                    <div>
                        <select class="input-sm" multiple="no" id="gameList"></select> 
                        <div id="joinButton"></div>
                    </div></td>
                <td><table id="gameframe"></table></td>
                <td><a id="playButton" href="#" onclick="playGame();"><image src= "images/play.png"></button>Next Move</br></a>
                    <a id="backButton" href="#" onclick="backGame();"><image src="images/back.png"></button>Back Move</a>
                </td>
            </tr> 
        </table>

        <script type="text/javascript">
                (function() {
                    var po = document.createElement('script');
                    po.type = 'text/javascript';
                    po.async = true;
                    po.src = 'https://apis.google.com/js/client:plusone.js';
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(po, s);
                })();
        </script>
    </body>
</html>
