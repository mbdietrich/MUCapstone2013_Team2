<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    if(error==null || error=="null") {
        error="";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <!--
        <script>
               var divsession = document.getElementById("Session");
               divsession.innerHTML = session;
               window.onload = function() {
                   if(session.getAttribute("user")){
                       window.location.href("CapstoneProject/lobby.jsp");
                   }
               }
        </script>
        -->
        <!--<link rel="stylesheet" type="text/css" href="css/style2.css">-->
        
        <script>
            function trim(s)
            {
                return s.replace( /^s*/, "").replace( /s*$/, "");
            }
            function validate()
            {
                elem1 = document.getElementById('alert');
                if(trim(document.login.userName.value)==="")
                    {
                        
                        elem1.innerHTML = "Please enter a Username";
                        document.login.userName.focus();
                        return false;
                    }
                else if(trim(document.login.password.value)==="")
                    {
                        elem1.innerHTML = "Please enter a password";
                        document.login.password.focus();
                        return false;
                    }
            }
        </script>
    <body>
        <div id="fb-root"></div>
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
      testAPI();
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
   
   // Here we run a very simple test of the Graph API after login is successful. 
  // This testAPI() function is only called in those cases. 
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Good to see you, ' + response.name + '.');
    });
  }
</script>
       
        <!--<h3>Login !!!!</h3>-->
        <div id="Session"></div>
        <div  id="content">
            <div id="wrapper" style="width:100%; text-align:center">
                <br><br><br><br><br><br>
                <form name="login" onSubmit="return validate();" action="login" method="POST">
                    <table align="center">
                        <tr><td><img src="images/icon.png" alt="login"/></td></tr>
                        <tr><td><h2>tic tac toe</h2></td></tr>
                        <tr>
                            <td><input id="userName" name="userName" type="text" size="20" placeholder="username" align="center"/></td>
                        </tr>
                        <tr>
                            <td><input id="password" name="password" type="password" size="20" placeholder="password" align="center"/></td>
                        </tr>
                        <tr>
                            <td><div id="alert"></div><%=error%></td>
                        </tr>
                        <tr>
                            <td><input type="image" src="images/login2.png" alt="submit" class="fade" align="center"/></td>
                        </tr>
                        <tr>
                            <td><a href="register.jsp" align="center">Register</a></td>
                        </tr>
                        <tr>
                            <td colspan ="4">
                                <!--
                                Below we include the Login Button social plugin. This button uses the JavaScript SDK to
                                present a graphical Login button that triggers the FB.login() function when clicked.

                                Learn more about options for the login button plugin:
                                /docs/reference/plugins/login/ -->

                                <fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
                            </td>
                        </tr>
                    </table>
            </div>
                </form>
        </div>
    </body>
</html>
>>>>>>> 7523b9dee1031e442d64898d9f0bd403f9c88c11
