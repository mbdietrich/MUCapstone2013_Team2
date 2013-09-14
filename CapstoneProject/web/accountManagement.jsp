<%-- 
    Document   : accountManagement
    Created on : Sep 12, 2013, 12:40:37 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                if(trim(document.manager.userName.value)==="")
                    {
                        alert("Please enter a user name.");
                        document.manager.userName.focus();
                        return false;
                    }
                else if(trim(document.manager.name.value)==="")
                    {
                        alert("Please enter your name");
                        document.manager.name.focus();
                        return false;
                    }
                else if(trim(document.manager.email.value)==="")
                    {
                        alert("Please enter your email address");
                        document.manager.email.focus();
                        return false;
                    }
                else if(trim(document.manager.password.value)==="")
                    {
                        alert("Please enter a password");
                        document.manager.password.focus();
                        return false;
                    }
                else if(trim(document.manager.confirmPassword.value)!== trim(document.manager.password.value))
                    {
                        alert("Passwords do not match");
                        document.manager.password.focus();
                        return false;
                    }
            }
            function validate1()
            {
                if(trim(document.manager.confirmPassword.value)!== trim(document.manager.newPassword.value))
                    {
                        alert("Passwords do not match");
                        document.manager.password.focus();
                        return false;
                    }
                else if(trim(document.manager.password.value)==="")
                    {
                        alert("Please enter your current password.");
                        document.manager.password.focus();
                        return false;
                    }
            }
        </script>
    </head>
    <%
    String exceptionError = "";
    String userNameError = "";
    String emailError = "";
    String passwordError = "";
    String error = request.getParameter("error");
    if(error==null || error=="null") {
        error="";
    } else {
        if(error.equals("userName")) {
            userNameError = "<font color='red'>Username already in use</font>";
        } else if (error.equals("email")) {
            emailError = "<font color='red'>A player has already registered this email</font>";
        } else if (error.equals("password")) {
            passwordError = "<font color='red'>Incorrect password</font>";
        } else if (error.equals("exception")) {
            exceptionError = "<font color='red'>An error occurred. Please try again.</font>";
        }
    }
    String userName = (String)session.getAttribute("user");
    if(userName != null) {
        try { 
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
            Statement st = con.createStatement();
        
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+userName+"'");
            String email = "";
            String fbid = "";
            if (rs.next()) {
                email = rs.getString(3);
                fbid = rs.getString(4);
            }
       
            st.close();
            
            %>
        <body>
            <script>
            // Additional JS functions here
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
                    dbid = <%=fbid%>
                    if(id != dbid) {
                        document.getElementById("fb").style.display="none";
                    } else {
                        document.getElementById("fbmsg").style.display="none";
                    }
                });
            }
            </script>
            <h1>Profile</h1>
            <div id="content">
                <a href="lobby.jsp" align="center">Lobby</a>
                    <form name="manager" onSubmit="return validate1();" action="updateDetails.jsp" method="POST">
                    <div id="wrapper" style="width:100%; text-align:center">
                    <br><br><br><br><br><br>
                    <table align="center">
                        <tr>
                            <td>User name:</td>
                            <td><input id="userName" name="userName" type="text" size="20" value=<%=userName%> /></td>
                            <td><%=userNameError%></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input id="email" name="email" type="text" size="20" value=<%=email%> /></td>
                            <td><%=emailError%></td>
                        </tr>
                        <tr id="fb">
                            <td>Link Facebook:</td>
                            <td colspan="2">
                                <!--
                                Below we include the Login Button social plugin. This button uses the JavaScript SDK to
                                present a graphical Login button that triggers the FB.login() function when clicked.

                                Learn more about options for the login button plugin:
                                /docs/reference/plugins/login/ -->

                                <fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
                            </td>
                        </tr>
                        <tr id="fbmsg">
                            <td>Link Facebook:</td>
                            <td colspan="2">The current logged in Facebook account is not linked to this player</td>
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
                            <input name="oldUserName" type="hidden" value=<%=userName%>/>
                            <input name="oldEmail" type="hidden" value=<%=email%>/>
                            <td colspan="2"><input type="submit" name="submit" value="Update Details" class="fade" /></td>
                        </tr>
                    </table>
                    </div>
                </form>
        </div>
    </body>
    <%
    }
    catch (Exception e) {
        e.printStackTrace();
        String message = "There was a problem logging you in";
        response.sendRedirect("index.jsp?error="+message);
        }
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
            <h1>Create Account</h1>
            <div id="content">
                <form name="manager" onSubmit="return validate();" action="processRegistration.jsp" method="POST">
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
                            <input name="fbid" type="hidden" value=<%=fbid%>/>
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
