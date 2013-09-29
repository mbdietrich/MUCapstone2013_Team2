<%-- 
    Document   : googleLogin
    Created on : Sep 29, 2013, 2:54:24 PM
    Author     : luke
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "capstone.server.GameManager" %>
<%@ page import= "capstone.server.databaseAccess" %>
<%@ page import = "java.util.Map" %>

<%
    String id = request.getParameter("gid");
    String userName = request.getParameter("name");
    if(userName == null || userName == "null") {
        userName = "";
    }
    String email = request.getParameter("gemail");
    if(email == null || email == "null") {
        email = "";
    }
    
    String link = request.getParameter("link");
    String gName = request.getParameter("gName");
    
    String referer = request.getParameter("referer");
    String userNamePlaceholder = "placeholder='username'";
    if(referer.equals("link")) {
        userNamePlaceholder = "value='"+userName+"'";
    }
    
    Map details = databaseAccess.getPlayerDetailsByGID(id);
    if(!details.isEmpty()) {
        GameManager.newPlayer(request.getSession(), details.get("userName").toString());
        response.sendRedirect("home.jsp");
        return;
    } else {
        String exceptionError = "";
        String exceptionError1 = "";
        String userNameError = "";
        String emailError = "";
        String passwordError = "";
        String error = request.getParameter("error");
        if(error==null || error=="null") {
            error="";
        } else {
            if(error.equals("userName")) {
                userNameError = "<font color='red'>The requested username is not available</font>";
            } else if (error.equals("email")) {
                emailError = "<font color='red'>A player has already registered with this email</font>";
            } else if (error.equals("exception")) {
                exceptionError = "<font color='red'>An error occurred. Please try again.</font>";
            } else if (error.equals("exception1")) {
                exceptionError1 = "<font color='red'>An error occurred. Please try again.</font>";
            } else if (error.equals("login")) {
                exceptionError1 = "<font color='red'>Incorrect username or password</font>";
            }
        }
        %>
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Profile</title>
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
                    function validate2()
                    {
                        if(trim(document.manager.oldUserName.value)==="")
                            {
                                alert("Please enter your username");
                                document.manager.oldUserName.focus();
                                return false;
                            }
                        else if(trim(document.manager.password2.value)==="")
                            {
                                alert("Please enter your password");
                                document.manager.password2.focus();
                                return false;
                            }
                    }
                    function referer() {
                        var referer = "<%=referer%>";
                        if(referer === "link") {
                            document.getElementById("new account").style.display="none";
                        }
                    }
                </script>
            </head>
            <body onload="referer();">
                <h1>Link your Google+ profile to a new or existing game account</h1>
                <div id="new account">
                    <h2 align="center">Link to new account</h2>
                        <div id="content">
                            <form name="manager" onSubmit="return validate();" action="google" method="POST">
                                <div id="wrapper" style="width:100%; text-align:center">
                                <br>
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
                                    <input name="fbid" type="hidden" value="<%=id%>"/>
                                    <input name="form" type="hidden" value="register"/>
                                    <input name="gName" type="hidden" value="<%=gName%>"/>
                                    <input name="link" type="hidden" value="<%=link%>"/>
                                    <td colspan="2"><input type="submit" name="submit" value="Save" class="fade" /></td>
                                </tr>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
                <br><br><br>
                <div id="link account">
                    <h2 align="center">Link to existing account</h2>
                        <div id="content">
                            <form name="manager" onSubmit="return validate2();" action="google" method="POST">
                                <div id="wrapper" style="width:100%; text-align:center">
                                <br>
                                <table align="center">
                                <tr>
                                    <td>User name:</td>
                                    <td><input id="userName" name="userName" type="text" size="20" <%=userNamePlaceholder%> /></td>
                                </tr>
                                <tr>
                                    <td>Password:</td>
                                    <td><input id="password" name="password" type="password" size="20" placeholder="password" /></td>
                                </tr>
                                <tr>
                                    <td colspan ="2"><%=exceptionError1%></td>
                                </tr>
                                <tr>
                                    <input name="gid" type="hidden" value="<%=id%>"/>
                                    <input name="form" type="hidden" value="update"/>
                                    <input name="referer" type="hidden" value="<%=referer%>"/>
                                    <input name="gName" type="hidden" value="<%=gName%>"/>
                                    <input name="link" type="hidden" value="<%=link%>"/>
                                    <input name="email" type="hidden" value="<%=email%>"/>
                                    <td colspan="2"><input type="submit" name="submit" value="Save" class="fade" /></td>
                                </tr>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </body>
        </html>
        <%
    }
%>