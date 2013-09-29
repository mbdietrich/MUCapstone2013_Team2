<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    String ifError = "none";
    if (error == null || error == "null") {
        error = "";
    } else {
        ifError = "inline";
    }
%>
<!DOCTYPE html>
<html>
    <head><!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />
        
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        
        <title>Tic Tac Toe</title>
        
        <script type="text/javascript" src="jquery-1.8.3.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script>
            function trim(s)
            {
                return s.replace(/^s*/, "").replace(/s*$/, "");
            }
            function validate()
            {
                if (trim(document.login.userName.value) === "")
                {
                    
                    makeAlert("Please enter a Username");
                    elem2 = document.getElementById("userName");
                    elem2.firstElementChild.focus();
                    return false;
                }
                else if (trim(document.login.password.value) === "")
                {
                    makeAlert("Please enter a password");
                    elem2 = document.getElementById("password");
                    elem2.firstElementChild.focus();
                    return false;
                }
            }
            
            function makeAlert(message){
                elem1 = document.getElementById('alert');
                    newel = document.createElement("div");
                    newel.setAttribute("class", "alert alert-warning alert-dismissable");
                    btn = document.createElement("button");
                    btn.setAttribute("type", "button");
                    btn.setAttribute("class","close");
                    btn.setAttribute("data-dismiss", "alert");
                    btn.setAttribute("aria-hidden", "true");
                    btn.innerHTML="&times;";
                    newel.appendChild(btn);
                    newel.innerHTML = newel.innerHTML.concat(message);
                    elem1.appendChild(newel);
            }
        </script>
    <body>

        <div id="fb-root"></div>
        <script>
            // Additional JS functions here
            window.fbAsyncInit = function() {
                FB.init({
                    appId: '689318734429599', // App ID
                    channelUrl: '//http://capstoneg2.jelastic.servint.net/CapstoneProject/channel.html', // Channel File
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
                        if(document.getElementById("fbLogin").style.display === "inline") {
                            fb();
                        }
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
            function fblogin() {
                FB.api('/me', function(response) {
                    if(response.status === 'connected') {
                        id = response.id;
                        name = response.name;
                        email = response.email;
                        window.location = "fblogin.jsp?fbid=" + id + "&fbname=" + name + "&fbemail=" + email + "&referer=both";
                    } else {
                        alert("You have not authorised Facebook");
                    }
                    
                });
            }
            
            function signinCallback(authResult) {
                if (authResult['access_token']) {
                    // Successfully authorized
                    if (authResult['error'] == undefined) {
                        gapi.auth.setToken(authResult); //store the returned token
                        if (document.getElementById("gLogin").style.display === "inline") {
                            gapi.client.load('oauth2', 'v2', function() {
                                var request = gapi.client.oauth2.userinfo.get();
                                request.execute(googleLogin);
                            });
                        }
                    }
                } else if (authResult['error']) {
                    // There was an error.
                    // Possible error codes:
                    //   "access_denied" - User denied access to your app
                    //   "immediate_failed" - Could not automatically log in the user
                    // console.log('There was an error: ' + authResult['error']);
                }
            }
            
            function googleLogin(obj) {
            var id = obj['id'];
            var name = obj['name'];
            var email = obj['email'];
            var url = obj['link'];
            window.location = "googleLogin.jsp?gid=" + id + "&gName=" + name + "&name=" + name + "&gemail=" + email + "&link=" + url + "&referer=both";
            }
            
            function fb() {
                document.getElementById("gLogin").style.display = "none";
                document.getElementById("userLogin").style.display = "none";
                FB.api('/me', function(response) {
                    if(response.status === 'connected') {
                        id = response.id;
                        name = response.name;
                        email = response.email;
                        window.location = "fblogin.jsp?fbid=" + id + "&fbname=" + name + "&fbemail=" + email + "&referer=both";
                    } else {
                        if(document.getElementById("fbLogin").style.display === "none") {
                            document.getElementById("fbLogin").style.display="table-cell";
                        } else {
                            document.getElementById("fbLogin").style.display="none";
                        }
                    }
                    
                });
            }
            
            function google() {
                document.getElementById("fbLogin").style.display = "none";
                document.getElementById("userLogin").style.display = "none";
                if(gapi.auth.getToken() != null) {
                    gapi.client.load('oauth2', 'v2', function() {
                        var request = gapi.client.oauth2.userinfo.get();
                        request.execute(googleLogin);
                    });
                } else {
                    if(document.getElementById("gLogin").style.display === "none") {
                        document.getElementById("gLogin").style.display="table-cell";
                    } else {
                        document.getElementById("gLogin").style.display="none";
                }
                }
            }
            
            function user() {
                document.getElementById("gLogin").style.display = "none";
                document.getElementById("fbLogin").style.display = "none";
                if(document.getElementById("userLogin").style.display === "none") {
                    document.getElementById("userLogin").style.display="table-cell";
                } else {
                    document.getElementById("userLogin").style.display="none";
                }
                
            }

        </script>

            <div id="Session" class="padBottom2"></div>
                    
                    <table align="center">
                                
                        <tr><td colspan="3" class="padBottom"><img src="images/icon.png" alt="login"/></td></tr>
                        <tr><td colspan="3" class="padBottom heading">tic tac toe</td></tr>
                        <tr>
                            <td>
                                <button type="button" onclick="fb();"class="btn btn-info" data-loading-text="Logging you in...">Log in with Facebook</button>
                            </td>
                            <td>
                                <button type="button" onclick="google();"class="btn btn-info" data-loading-text="Logging you in...">Log in with Google+</button>
                            </td>
                            <td>
                                <button type="button" onclick="user();"class="btn btn-info" data-loading-text="Logging you in...">Log in with username</button>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="3" style="text-align: right"><i>Or <a href="accountManagement.jsp" align="center">create a username & password</a></i></td>
                        </tr>
                        <tr>
                            <!-- facebook -->
                            <td colspan="3" id="fbLogin" style="display:none">
                                <fb:login-button show-faces="true" width="200" max-rows="1" autologoutlink="true" scope="email"></fb:login-button>
                            </td>
                            
                            <!-- google+ -->
                            <td colspan="3" id="gLogin" style="display:none">
                                <span id="signinButton">
                                    <span
                                        class="g-signin"
                                        data-callback="signinCallback"
                                        data-clientid="1062173662525.apps.googleusercontent.com"
                                        data-scope="https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
                                        data-cookiepolicy="single_host_origin"
                                        data-requestvisibleactions="http://schemas.google.com/AddActivity"
                                        data-scope="https://www.googleapis.com/auth/plus.login">
                                    </span>
                                </span>
                            </td>
                            
                            <!-- username/password -->
                            <td colspan="3" id="userLogin" style="display:<%=ifError%>">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form role="form" name="login" onSubmit="return validate();" action="login" method="POST">
                                            <div class="formPadding"><input name="userName" type="text" class="form-control" id="userName" placeholder="Username"/></div>
                                            <div class="formPadding"><input name="password" type="password" class="form-control" id="password" placeholder="Password"/></div>
                                            <div class="alert-danger"><%=error%></div>
                                            <div><button type="submit button" class="btn btn-xs" data-loading-text="Logging you in...">Log In</button></div>
                                        </form>
                                    </div>
                                </div>
                            </td>
                        </tr>
                </table>
            <script type="text/javascript">
                (function() {
                    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
                    po.src = 'https://apis.google.com/js/client:plusone.js';
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
                })();
            </script>
      
        </body>
</html>
