<%-- 
    Document   : accountManagement
    Created on : Sep 12, 2013, 12:40:37 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page import="capstone.server.databaseAccess"%>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Iterator" %>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/style.css" rel="stylesheet" media="screen">
        <link rel="shortcut icon" href="images/ttt_icon.ico" />
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        
        <title>TTT - Profile</title>
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                if(trim(document.body.manager.userName.value)==="")
                    {
                        alert("Please enter a user name.");
                        document.body.manager.userName.focus();
                        return false;
                    }
                else if(trim(document.body.manager.email.value)==="")
                    {
                        alert("Please enter your email address");
                        document.body.manager.email.focus();
                        return false;
                    }
                else if(trim(document.body.manager.password.value)==="")
                    {
                        alert("Please enter a password");
                        document.body.manager.password.focus();
                        return false;
                    }
                else if(trim(document.body.manager.confirmPassword.value)!== trim(document.body.manager.password.value))
                    {
                        alert("Passwords do not match");
                        document.body.manager.password.focus();
                        return false;
                    }
            }
            function validate1()
            {
                if(trim(document.body.manager.confirmPassword.value)!== trim(document.body.manager.newPassword.value))
                    {
                        alert("Passwords do not match");
                        document.body.manager.password.focus();
                        return false;
                    }
                else if(trim(document.body.manager.password.value)==="")
                    {
                        alert("Please enter your current password.");
                        document.body.manager.password.focus();
                        return false;
                    }
            }
            function validateAdd()
            {
                if(trim(document.getElementById("friendAdd").value)==="")
                    {
                        alert("Please enter a username.");
                        document.body.manager.friendAdd.focus();
                        return false;
                    }
                    
               myName = trim(document.getElementById("sessionname").innerHTML);
               
               if(trim(document.getElementById("friendAdd").value)===myName)
                    {
                        alert("Cannot add yourself as a friend.");
                        document.body.manager.friendAdd.focus();
                        return false;
                    }
            }
            function validateRequests()
            {
                if(trim(document.body.manager.friendRequestsField.value)==="")
                    {
                        alert("Please select a request.");
                        document.body.manager.friendRequestsField.focus();
                        return false;
                    }
            }
            function validateFriends()
            {
                if(trim(document.body.manager.friendsField.value)==="")
                    {
                        alert("Please select a friend.");
                        document.body.manager.friendsField.focus();
                        return false;
                    }
            }
        </script>
    </head>
    <%
    // error handling
    String exceptionError = "";
    String userNameError = "";
    String emailError = "";
    String passwordError = "";
    String delinkError = "";
    String error = request.getParameter("error");
    String requestmessage = request.getParameter("requestmessage");
    if(requestmessage == null || requestmessage=="null") {
        requestmessage="";
    }
    if(error==null || error=="null") {
        error="";
    } else {
        if(error.equals("userName")) {
            userNameError = "The requested username is not available";
        } else if (error.equals("email")) {
            emailError = "A player has already registered with this email";
        } else if (error.equals("password")) {
            passwordError = "Incorrect password";
        } else if (error.equals("exception")) {
            exceptionError = "An error occurred. Please try again.";
        } else if (error.equals("delinkerror")) {
            delinkError = ">Error: try again.";
        }
    }
    
    // if user logged in, display profile information
    String userName = (String)session.getAttribute("user");
    if(userName != null) {
        Map details = databaseAccess.getPlayerDetails(userName);
        String email = "";
        String fbid = "";
        if(!details.isEmpty()) {
            email = (String)details.get("email");
            fbid = (String)details.get("fbid");
        }
        
        //get friends
        String friendCode = "";
        List<String> friends = databaseAccess.getFriends(userName);
        Iterator<String> iterator = friends.iterator();
        while(iterator.hasNext()) {
            String name = iterator.next();
            friendCode = friendCode + "<option value ='"+name+"'>"+name+"</option>";
        }
        
        //get friend requests
        String requestCode = "";
        List<String> friendRequests = databaseAccess.getFriendRequests(userName);
        Iterator<String> iteratorRequests = friendRequests.iterator();
        while(iteratorRequests.hasNext()) {
            String name = iteratorRequests.next();
            requestCode = requestCode + "<option value ='"+name+"'>"+name+"</option>";
        }  
        
        //check if linked to google account
        String gLink = "";
        String gName = "";
        String googleLinked = "no";
        if(!details.get("gid").equals("")) {
            gLink = (String)details.get("gLink");
            gName = (String)details.get("gName");
            googleLinked = "yes";
        }
        
            %>
        <script>
        function social() {
            var linked = "<%=googleLinked%>";  
            if(linked === "yes") {
                document.getElementById("googleNotLinked").style.display = "none";
            } else {
                document.getElementById("googleLinked").style.display = "none";
            }
         }
         </script>
        <body onload="social();">
            <script>
            function signinCallback(authResult) {
                if (authResult['access_token']) {
                    // Successfully authorized
                    if (authResult['error'] == undefined) {
                        gapi.auth.setToken(authResult); //store the returned token
                        if (document.getElementById("googleButton").style.display !== "none") {
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
            window.location = "google?form=link&gid=" + id + "&gName=" + name + "&userName=" + "<%=userName%>" + "&gLink=" + url;
            }
            function google() {
                if(document.getElementById("googleButton").style.display === "none") {
                    document.getElementById("googleButton").style.display="inherit";
                } else {
                    document.getElementById("googleButton").style.display="none";
                }
            }
            </script>
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
                        <li><a href="home.jsp">Home</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-toggle="tooltip" title="Create new games, and view open games.">Games <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="singlePlayer();">Play a bot</a></li>
                                <li><a href="#" onclick="multiPlayer();">Play a user</a></li>
                                <li><a href="#" onclick="openPrivateGame();">New Private Game</a></li>
                                <li><a href="lobby.jsp">Open Games</a></li>
                            </ul>
                        </li>
                        <li class="active"><a href="accountManagement.jsp" data-toggle="tooltip" title="Update your profile and find friends.">Profile</a></li>
                        
                    </ul>
                    <p class="navbar-text navbar-right">Hello, <%= session.getAttribute("user")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></p>                     
                </div>
            </nav>
                
            <div id="fb-root"></div>
            
            <script>
            // Facebook
            window.fbAsyncInit = function() {
            FB.init({
                appId      : '689318734429599', // App ID
                channelUrl : '//http://capstoneg2.jelastic.servint.net/CapstoneProject/channel.html', // Channel File
                status     : true, // check login status
                cookie     : true, // enable cookies to allow the server to access the session
                xfbml      : true  // parse XFBML
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
                    checkAgainstDB();
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
            (function(d){
                var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
                if (d.getElementById(id)) {return;}
                js = d.createElement('script'); js.id = id; js.async = true;
                js.src = "//connect.facebook.net/en_US/all.js";
                ref.parentNode.insertBefore(js, ref);
            }(document));
   
            function checkAgainstDB() {
                FB.api('/me', function(response) {
                    id = response.id;
                    dbid = "<%=fbid%>";
                    name = "<%=userName%>";
                    // if player not linked to facebook, link
                    if(dbid === "") {
                        var check = confirm("Link "+response.name+"'s Facebook account?");
                        if(check==true) {
                            window.location = "fblogin.jsp?fbid=" + id + "&fbname=" + name + "&referer=link";
                        }
                    }else if(id != dbid) {
                        document.getElementById("fbmsg").style.display="inline";
                    } else {
                        document.getElementById("fbdelink").style.display="inline";
                    }
                });
            }
            </script>
            
<!-------------------------------------DETAILS PANEL-------------------------------------------------------->
            
            <div id="playerinfo" style="width:50%; text-align:left; float:left">
                            <table>
                                <tr>
                                    <td class="padBottom heading">My Details</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form name="manager" onSubmit="return validate1();" action="profile" method="POST">
                                                    <div class="formPadding">
                                                        <div class="formPadding">Username:</div>
                                                        <div class="formPadding"><input id="userName" class="form-control"  name="userName" type="text" size="20" value="<%=userName%>" /></div>
                                                        <div class="alert-danger"><%=userNameError%></div>
                                                    </div>
                                                    <div class="formPadding">
                                                        <div class="formPadding">Email:</div>
                                                        <div class="formPadding"><input id="email" class="form-control"  name="email" type="text" size="20" value="<%=email%>" /></div>
                                                        <div class="alert-danger"><%=emailError%></div>
                                                    </div>
                                                    <div class="formPadding">
                                                        <div class="formPadding">Password:</div>
                                                        <div class="formPadding"><input id="password" class="form-control"  name="password" type="password" size="20" placeholder="current password" /></div>
                                                        <div class="formPadding"><input id="newPassword" class="form-control"  name="newPassword" type="password" size="20" placeholder="new password" /></div>
                                                        <div class="formPadding"><input id="confirmpassword" class="form-control"  name="confirmPassword" type="password" size="20" placeholder="confirm password" /></div>
                                                        <div class="alert-danger"><%=exceptionError%></div>
                                                    </div>
                                                    
                                                    <div><input name="oldUserName" type="hidden" value="<%=userName%>"/></div>
                                                    <div><input name="oldEmail" type="hidden" value="<%=email%>"/></div>
                                                    <div><input name="form" type="hidden" value="update"/></div>
                                                    <div><button type="submit" class="btn btn-xs">Update</button></div>
                                                </form>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        
<!---------------------------------------FACEBOOK PANEL---------------------------------------------------------------->                                   
                        <table>
                            <tr>
                                <td>
                                    <div class="panel panel-default">
                                        <div class="panel-body"> 
                                        <div id="fb" class="heading2">Facebook:</div> 
                                            <div>Click below to link your Facebook account.</div>

                                                    <!--
                                                    Below we include the Login Button social plugin. This button uses the JavaScript SDK to
                                                    present a graphical Login button that triggers the FB.login() function when clicked.

                                                    Learn more about options for the login button plugin:
                                                    /docs/reference/plugins/login/ -->

                                           <div><fb:login-button show-faces="false" width="200" max-rows="1" autologoutlink="true" scope="email" ></fb:login-button></div>
                                       </div>
                                   </div>
                               </td>
                           </tr>
                            <tr>
                                <td>
                                    <div> 
                                    <div id="fbdelink" style="display:none">
                                        <form name="delinkfb" action="facebook" method="POST">
                                        <input name="userName" type="hidden" value="<%=userName%>"/>
                                        <input name="form" type="hidden" value="delink"/>
                                        <button type="submit" class="btn btn-xs">Delink Facebook Account</button>
                                        </form>
                                    </div>
                                    <div><%=delinkError%></div>
                                    </div>
                                    <div id="fbmsg" style="diplay:none">
                                    <div class="alert-danger" id="fbmsg" colspan="3" style="display:none">Another player is <br>logged into Facebook<br> on this computer.</div>
                                    </div>
                                </td>
                            </tr>
                            
                        </table>
                                    
<!---------------------------------------GOOGLE PANEL---------------------------------------------------------------->                                   
                        <table id="googleLinked">
                            <tr>
                                <td>
                                    <div class="panel panel-default">
                                        <div class="panel-body"> 
                                        <div id="fb" class="heading2">Google+:</div> 
                                           <div><a href="<%=gLink%>" target="_blank"><%=gName%>'s</a> profile is linked to this account.</div>
                                           <div><a href="google?form=delink&userName=<%=userName%>  ">Remove link</a></div>
                                       </div>
                                   </div>
                               </td>
                           </tr>
                        </table>
                        <table id="googleNotLinked">
                            <tr>
                                <td>
                                    <div class="panel panel-default">
                                        <div class="panel-body"> 
                                        <div id="fb" class="heading2">Google+:</div>
                                        <div><button type="button" onclick="google();"class="btn btn-info" data-loading-text="Logging you in...">Link Google+</button></div>
                                        <br>
                                           <div id="googleButton" style="display:none"><span id="signinButton">
                                    <span
                                        class="g-signin"
                                        data-callback="signinCallback"
                                        data-clientid="1062173662525.apps.googleusercontent.com"
                                        data-scope="https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
                                        data-cookiepolicy="single_host_origin"
                                        data-requestvisibleactions="http://schemas.google.com/AddActivity"
                                        data-scope="https://www.googleapis.com/auth/plus.login">
                                    </span>
                                </span></div>
                                       </div>
                                   </div>
                               </td>
                           </tr>
                        </table>
            </div>

<!------------------------------------FRIEND LIST PANEL---------------------------------------------------------------------------->


                <div id="friends" style="width:50%; text-align:left; float:left">
                  
                    <form id="myfriends" name="friends" onSubmit="return validateFriends();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td class="padBottom heading">My Friends</td>
                            </tr>
                            <tr>
                                <td><select class="input-sm" name="friendsField" multiple="no" style="width: 250px">
                                        <%=friendCode%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <input name="player" type="hidden" value="<%=userName%>"/>
                                <input name="form" type="hidden" value="friends"/>
                                <br><td><button type="submit" class="btn btn-xs" value="Delete Friend">unfriend</button></td>
                                <!--<td colspan="2"><input type="submit" name="submit" value="Delete Friend" class="fade" /></td>-->
                            </tr>
                        </table>
                    </form>
                                
                    <form id="myrequests" name="friendRequests" onSubmit="return validateRequests();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td class="padBottom heading">Friend Requests</td>
                            </tr>
                            <tr>
                                <td><select class="input-sm" name="friendRequestsField" multiple="no" style="width: 250px">
                                        <%=requestCode%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <input name="player" type="hidden" value="<%=userName%>"/>
                                <input name="form" type="hidden" value="requests"/>
                                <br><td class="padBottom"><button type="submit" name="submit" class="btn btn-xs" value="Accept Request">accept</button>    
                                <button type="submit" name="submit" class="btn btn-xs" value="Decline Request">decline</button></td>
                            </tr>
                        </table>
                    </form>

                    <form name="addFriend" onSubmit="return validateAdd();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td class="padBottom heading">New Friend</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="input-group">

                                        <input type="text" class="form-control" id="friendAdd" name="friend" placeholder="friend's username"/>
                                            <span class="input-group-btn">
                                                <button class="btn " type="submit"><span class="glyphicon glyphicon-plus"></span></button>
                                                <input name="player" type="hidden" value="<%=userName%>"/>
                                                <input name="form" type="hidden" value="add"/>
                                            </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan ="2"><%=requestmessage%></td>
                            </tr>
                            <tr>
                            </tr>
                        </table>
                    </form>
                    
                </div>
    <script type="text/javascript">
                (function() {
                    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
                    po.src = 'https://apis.google.com/js/client:plusone.js';
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
                })();
    </script>
    </body>
    <%
    // if user not logged in, present registration page
    } else {
        String userNameValue = "placeholder='username'";
        String emailValue = "placeholder='email'";
        String fbid = "";
        if(request.getParameter("userName") != null) {
            userNameValue = "value='"+request.getParameter("userName")+"'";
        }
        if(request.getParameter("email") != null) {
            emailValue = "value='"+request.getParameter("email")+"'";
        }
        if(request.getParameter("fbid") != null) {
            fbid = request.getParameter("fbid");
        }
        %>
        <body>
            
            <div class="padBottom2"></div>
                
                    <table align="center">
                        <tr><td class="padBottom"><img src="images/icon.png" alt="login"/></td></tr>
                        <tr>
                            <td class="padBottom heading">Create Profile</td>
                        </tr>                 
                        <tr>
                            <td>
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form name="manager" onSubmit="return validate();" action="profile" method="POST">
                                            <div class="formPadding"><input id="userName" class="form-control formPadding" name="userName" type="text" size="20" <%=userNameValue%> /></div>
                                            <div class="alert-danger"><%=userNameError%></div>
                                            <div class="formPadding"><input id="email" class="form-control formPadding" name="email" type="text" size="20" <%=emailValue%> /></div>
                                            <div class="alert-danger"><%=emailError%></div>
                                            <div class="formPadding"><input id="password" class="form-control formPadding" name="password" type="password" size="20" placeholder="password" /></div>
                                            <div class="formPadding"><input id="confirmpassword" class="form-control" name="confirmPassword" type="password" size="20" placeholder="confirm password" /></div>
                                            <div class="alert-danger"><%=exceptionError%></div>
                                            <div><input name="form" type="hidden" value="register"/></div>
                                            <div><input type="submit" name="submit" value="Save" class="btn btn-xs" /></div>
                                        </form>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><i>or <a href="index.jsp" align="center">Log In</a></i></td>
                        </tr>
                    </table>
                
                        <script type="text/javascript" src="jquery-1.8.3.js"></script>
                        <!-- Include all compiled plugins (below), or include individual files as needed -->
                        <script src="bootstrap/js/bootstrap.min.js"></script>
        </body>
        <%
    }
   %>
</html>
