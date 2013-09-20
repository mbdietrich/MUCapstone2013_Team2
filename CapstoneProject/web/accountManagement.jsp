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
        <div id="sessionname"><%= (String) session.getAttribute("user")%></div>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        
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
    String error = request.getParameter("error");
    String requestmessage = request.getParameter("requestmessage");
    if(requestmessage == null || requestmessage=="null") {
        requestmessage="";
    }
    if(error==null || error=="null") {
        error="";
    } else {
        if(error.equals("userName")) {
            userNameError = "<font color='red'>The requested username is not available</font>";
        } else if (error.equals("email")) {
            emailError = "<font color='red'>A player has already registered with this email</font>";
        } else if (error.equals("password")) {
            passwordError = "<font color='red'>Incorrect password</font>";
        } else if (error.equals("exception")) {
            exceptionError = "<font color='red'>An error occurred. Please try again.</font>";
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
        
            %>
        <body>
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
                    dbid = <%=fbid%>;
                    if(id != dbid) {
                        document.getElementById("fb").style.display="none";
                        document.getElementById("fbmsg").style.display="inline";
                    }
                });
            }
            </script>
            
            <a href="lobby.jsp" align="center">Lobby</a>
            <br>
            <div id="content">
                    <div id="playerinfo" style="width:50%; text-align:left; float:left">
                    <h2>My Details</h2>
                    <br><br>
                    <form name="manager" onSubmit="return validate1();" action="profile" method="POST">
                    <table align="center">
                        <tr>
                            <td>User name:</td>
                            <td><input id="userName" name="userName" type="text" size="20" value="<%=userName%>" /></td>
                            <td><%=userNameError%></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input id="email" name="email" type="text" size="20" value="<%=email%>" /></td>
                            <td><%=emailError%></td>
                        </tr>
                        <tr id="fb">
                            <td id="fb">Facebook:</td>
                            <td id="fb" colspan="2">
                                <!--
                                Below we include the Login Button social plugin. This button uses the JavaScript SDK to
                                present a graphical Login button that triggers the FB.login() function when clicked.

                                Learn more about options for the login button plugin:
                                /docs/reference/plugins/login/ -->

                                <fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
                            </td>
                        </tr>
                        <tr id="fbmsg" style="diplay:none">
                            <td id="fbmsg" colspan="3" style="display:none"><font color='red'>The current logged in Facebook account is not linked to this player</font></td>
                        </tr>
                        <tr>
                            <td>New password:</td>
                            <td><input id="newPassword" name="newPassword" type="password" size="20" placeholder="new password" /></td>
                            <td><input id="confirmpassword" name="confirmPassword" type="password" size="20" placeholder="confirm password" /></td>
                        </tr>
                        <tr>
                            <td>Current password</td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                            <td><%=passwordError%></td>
                        </tr>
                        <tr>
                            <td colspan ="2"><%=exceptionError%></td>
                        </tr>
                        <tr>
                            <input name="oldUserName" type="hidden" value="<%=userName%>"/>
                            <input name="oldEmail" type="hidden" value="<%=email%>"/>
                            <input name="form" type="hidden" value="update"/>
                            <td colspan="2"><input type="submit" name="submit" value="Update Details" class="fade" /></td>
                        </tr>
                    </table>
                    </div>
                </form>
                            
                            
                <div id="friends" style="width:50%; text-align:left; float:left">
                  
                    <form id="myfriends" name="friends" onSubmit="return validateFriends();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td><h2>My Friends</h2></td>
                            </tr>
                            <tr>
                                <td><select name="friendsField" multiple="no" style="width:300px">
                                        <%=friendCode%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <input name="player" type="hidden" value="<%=userName%>"/>
                                <input name="form" type="hidden" value="friends"/>
                                <td colspan="2"><input type="submit" name="submit" value="Delete Friend" class="fade" /></td>
                            </tr>
                    </form>
                    <br>
                    <form id="myrequests" name="friendRequests" onSubmit="return validateRequests();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td><h2>Friend Requests</h2></td>
                            </tr>
                            <tr>
                                <td><select name="friendRequestsField" multiple="no" style="width:300px">
                                        <%=requestCode%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <input name="player" type="hidden" value="<%=userName%>"/>
                                <input name="form" type="hidden" value="requests"/>
                                <td colspan="2"><input type="submit" name="submit" value="Accept Request" class="fade" /></td>
                            </tr>
                            <tr>
                                <td colspan="2"><input type="submit" name="submit" value="Decline Request" class="fade" /></td>
                            </tr>
                    </form>
                    <br><br><br><br>
                    <form name="addFriend" onSubmit="return validateAdd();" action="FriendManager" method="POST">
                        <table align="center">
                            <tr>
                                <td><h2>Add Friend</h2></td>
                            </tr>
                            <tr>
                                <td>Friend's username:</td>
                                <td><input type="text" id="friendAdd" name="friend" placeholder="friend"</td>
                            </tr>
                            <tr>
                                <td colspan ="2"><%=requestmessage%></td>
                            </tr>
                            <tr>
                                <input name="player" type="hidden" value="<%=userName%>"/>
                                <input name="form" type="hidden" value="add"/>
                                <td colspan="2"><input type="submit" name="submit" value="Send Request" class="fade" /></td>
                            </tr>
                    </form>
                    
                </div>
        </div>
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
            <h1>Create Profile</h1>
            <div id="content">
                <form name="manager" onSubmit="return validate();" action="profile" method="POST">
                    <div id="wrapper" style="width:100%; text-align:center">
                    <br><br><br><br><br><br>
                    <table align="center">
                        <tr>
                            <td>User name:</td>
                            <td><input id="userName" name="userName" type="text" size="20" <%=userNameValue%> /></td>
                            <td><%=userNameError%></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input id="email" name="email" type="text" size="20" <%=emailValue%> /></td>
                            <td><%=emailError%></td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                        </tr>
                        <tr>
                            <td>Confirm password:</td>
                            <td><input id="confirmpassword" name="confirmPassword" type="password" size="20" placeholder="confirm password" /></td>
                        </tr>
                        <tr>
                            <td colspan ="2"><%=exceptionError%></td>
                        </tr>
                        <tr>
                            <input name="form" type="hidden" value="register"/>
                            <td colspan="2"><input type="submit" name="submit" value="Save" class="fade" /></td>
                        </tr>
                    </table>
                    </div>
                </form>
        </div>
        </body>
        <%
    }
   %>
</html>
