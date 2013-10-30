<%-- 
    Document   : game
    Created on : 30/07/2013, 1:13:18 PM
    Author     : Max, Jesse

    Page where the game is rendered.
--%>

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
        <link href="css/animate.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />

        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>TTT - Game On!</title>

        <noscript><meta http-equiv="refresh" content="0;URL=noscript.jsp"/></noscript>

        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="gamemethods.js"></script>


        <script>

            var onState = function(e) {
                var evt = e || window.event;
                var data;
                var state = jQuery.parseJSON(evt.data);
                if (state) { // only update if the string is not empty

                    if (state.open) {
                        document.getElementById("gameArea").style.display = 'none';
                        document.getElementById("quitButton").style.display = 'none';
                        document.getElementById("openWait").style.display = '';
                    }
                    else if (!state.waiting) {
                        opponent = state.Opponent.toString();
                        if (opponent != null) {
                            document.getElementById("team2").firstElementChild.innerHTML = opponent;
                        }
                        document.getElementById("openWait").style.display = 'none';
                        document.getElementById("gameArea").style.display = '';

                        //TODO parse state in
                        //variables:
                        //state.PlayerNumber
                        //state.isTurn
                        //state.Status
                        //state.Board
                        //state.Substatus
                        //state.Opponent
                        var subgame = 0;
                        var subgameWin;
                        var subWin;
                        for (a = 0; a < 3; a++) {
                            for (b = 0; b < 3; b++) {
                                var buttonNum = 0;
                                for (x = 0; x < 3; x++) {
                                    for (y = 0; y < 3; y++) {
                                        button = document.getElementById(a + '-' + b + '-' + x + '-' + y);
                                        buttonTrans = document.getElementById(a + '-' + b + '-' + x + '-' + y).firstElementChild;
                                        value = state.Board[subgame][buttonNum];
                                        subgameWin = document.getElementById(a + '-' + b);

                                        if ((state.Substatus[subgame][buttonNum] === "2")) {
                                            document.getElementById(a + '-' + b).firstElementChild.className = "subGame";
                                            document.getElementById(a + '-' + b + 'span').className = "subGameWin";
                                            document.getElementById(a + '-' + b + 'span').innerHTML = "<img src='images/oh_win2.png'>";
                                        } else if ((state.Substatus[subgame][buttonNum] === "1")) {
                                            document.getElementById(a + '-' + b).firstElementChild.className = "subGame";
                                            document.getElementById(a + '-' + b + 'span').className = "subGameWin";
                                            document.getElementById(a + '-' + b + 'span').innerHTML = "<img src='images/ex_win.png'>";
                                        }

                                        if (value == 1) {
                                            buttonTrans.src = 'images/ex.png';
                                            buttonTrans.className = "gameButton";
                                        }
                                        else if (value == 2) {
                                            buttonTrans.src = 'images/oh.png';
                                            buttonTrans.className = "gameButton";
                                        }
                                        else {
                                            buttonTrans.src = 'images/blank.png';

                                        }
                                        if ((state.isTurn === "true")) {
                                            button.disabled === true;
                                            document.getElementById("team1").className = 'playerLabel playerLabelHL animated bounce';
                                            document.getElementById("team1Alert").innerHTML = "YOUR TURN";
                                            document.getElementById("team2").className = 'playerLabel playerLabelLL';
                                            document.getElementById("team2Alert").innerHTML = "WAIT..";
                                        }
                                        else if ((state.isTurn === "false")) {
                                            button.disabled === true;
                                            document.getElementById("team2").className = 'playerLabel playerLabelHL animated bounce';
                                            document.getElementById("team2Alert").innerHTML = "OPPONENT'S TURN";
                                            document.getElementById("team1").className = 'playerLabel playerLabelLL';
                                            document.getElementById("team1Alert").innerHTML = "WAIT..";
                                        } else {
                                            button.disabled === false;
                                            document.getElementById("team2").className = 'playerLabel';
                                            document.getElementById("team1").className = 'playerLabel';
                                            document.getElementById("team2Alert").innerHTML = "";
                                            document.getElementById("team1Alert").innerHTML = "";
                                        }
                                        buttonNum++;
                                    }
                                }
                                subgame++;
                            }
                        }
                        if (state.Status === state.PlayerNumber) {
                            opponent = state.Opponent.toString();
                            if (opponent != null) {
                                document.getElementById("team2").firstElementChild.innerHTML = opponent;
                            }
                            document.getElementById("team1Alert").innerHTML = "WINS!";
                            document.getElementById("team1").className = 'playerLabel playerLabelWin animated flash';
                        } else if (state.Status === "2" || state.Status === "1") {
                            opponent = state.Opponent.toString();
                            if (opponent != null) {
                                document.getElementById("team2").firstElementChild.innerHTML = opponent;
                            }
                            document.getElementById("team2Alert").innerHTML = "WINS!";
                            document.getElementById("team2").className = 'playerLabel playerLabelWin animated flash';
                        } else if (state.Status === "3") {
                            document.getElementById("team2Alert").innerHTML = "IT'S A DRAW!";
                            document.getElementById("team2").className = 'playerLabel playerLabelDraw animated flash';

                            document.getElementById("team1Alert").innerHTML = "IT'S A DRAW!";
                            document.getElementById("team1").className = 'playerLabel playerLabelDraw animated flash';
                        }
                    }
                }
            };

            var source = new EventSource("state");
            source.onmessage = onState;
            source.addEventListener("state", onState);
            source.onclose = function() {
                console.log('Connection closed');
            }
            source.onerror = function(e) {
                //Ignore for now
                //console.log(e);
            }

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
                    document.getElementById("privateGameMenu").innerHTML = "<li><a href='#'>No friends online</a></li>";
                } else {
                    document.getElementById("loading").style.display = "none";
                }
            }

            function getGoogleImageURL(url) {
                var parts = url.split("?");
                return parts[0];
            }

            var leave = function() {
                $.post('leave', function(e) {
                    document.location.href = "home.jsp";
                });
            }
            var makeMove = function(a, b, x, y) {
                $.post(
                        "move",
                        {a: a, b: b, x: x, y: y}
                );
            }
            var opponent;



            $(window).unload(function() {
                $.post('leave');
            });

            window.onload = function() {


                var buttonFrame, newRow, newCell, subTable, newSubRow, newButton, buttonCell, subGameWin;
                buttonFrame = document.getElementById('gameframe');

                for (a = 2; a >= 0; a--) {
                    //Create a new row of subgames
                    newRow = buttonFrame.insertRow();
                    for (b = 2; b >= 0; b--) {
                        newCell = newRow.insertCell();
                        newCell.className = 'subTable';
                        newCell.id = (a + '-' + b);
                        subTable = document.createElement('table');
                        subGameWin = document.createElement('span');
                        subGameWin.id = (a + '-' + b + 'span');
                        newCell.appendChild(subTable);
                        newCell.appendChild(subGameWin);
                        for (i = 2; i >= 0; i--) {
                            newSubRow = subTable.insertRow();
                            for (j = 2; j >= 0; j--) {

                                buttonTrans = document.createElement('img');
                                buttonTrans.className = 'fadeGameButton gameButton';
                                buttonTrans.src = 'images/blank.png';
                                newButton = document.createElement('a');
                                newButton.href = '#';

                                newButton.id = a + '-' + b + '-' + i + '-' + j;
                                newButton.a = a;
                                newButton.b = b;
                                newButton.x = i;
                                newButton.y = j;

                                newButton.appendChild(buttonTrans);
                                newButton.onclick = function() {
                                    makeMove(this.a, this.b, this.x, this.y);
                                };
                                buttonCell = newSubRow.insertCell();
                                buttonCell.appendChild(newButton);
                            }
                        }
                    }
                }
                loadAnimation();
            };
        </script>

    </head>
    <body onunload="$.post('leave');">
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
                    document.getElementById("privateGameMenu").innerHTML = "<li><a href='#'>No friends online</a></li>";
                } else {
                    document.getElementById("loading").style.display = "none";
                }
            }

            function getFacebookImageURL(id) {
                var url = "https://graph.facebook.com/" + id + "/picture";
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
                            <li onclick="singlePlayer();"><a href="#" onclick="singlePlayer();">Play Default Bot</a></li>
                            <li onclick="multiPlayer();"><a href="#" onclick="multiPlayer();">Play Another User</a></li>
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
        <div id="quitButton" class="menuRight" onclick="leave();"><a href="#" onclick="leave();" class="buttons butons2">Quit</a></div>
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
        <table id="gameArea">
            <tr>
                <td>
                    <div id="team1" class="playerLabel"><h1><%= session.getAttribute("user")%></h1><span class="h3" id="team1Alert"></span></div>
                </td>
                <td>
                    <div class="gameDiv"><table id="gameframe"></table></div>
                </td>
                <td>
                    <div id="team2" class="playerLabel"><h1>Opponent</h1><span class="h3" id="team2Alert"></span></div>
                </td>
            </tr>
        </table>


        <div id="openWait" class="padTop">
            <div class="padBottom2 notices1">Waiting for another player to join..</div>
            <div class="padTop2"><button onclick="leave()" class="btn btn-xs">Cancel</button></div>
        </div>
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
