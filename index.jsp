<%
//Redirecting user if he is already logged in
if(session.getAttribute("uid")!=null){
    response.sendRedirect("user.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Welcome</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Roboto|Roboto+Slab" rel="stylesheet">
    <link rel="stylesheet" type="text/css" media="screen" href="main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#sin").click(function(){
                $("#sinin").fadeToggle("800");
                $("#left-overlay").fadeToggle("800");
            });
            $("#sup").click(function(){
                $("#sinin").fadeToggle("800");
                $("#left-overlay").fadeToggle("800");
            });
            $("#hide_alert").click(function(){
                $("#psudo-alert").fadeToggle("800");
                $("#whiteb").fadeToggle("800");
            });
            $("#hide_alert_false").click(function(){
                $("#psudo-alert-false").fadeToggle("800");
                $("#whiteb").fadeToggle("800");
            });
            $("#hide_lvalid_false").click(function(){
                $("#lvalid-false").fadeToggle("800");
                $("#whiteb").fadeToggle("800");
            });
        });
    </script>
</head>
<body>
<div id="particles-js">
    <div class="container">
            <script type="text/javascript" src="js/particles.min.js"></script>
            <script type="text/javascript" src="js/app.js"></script>   
        <div class="sign-up" id="sinup">
            <form action="reg.jsp" method="POST">
                <span class="header">Sign Up</span>
                <input type="text" name="uid" required maxlength="30" placeholder="Username"/>
                <input type="password" required name="pwd" minlength="6" maxlength="30" placeholder="Password"/>
                <input type="email" required name="mail" maxlength="45" placeholder="Email Id"/>
                <input type="text" name="phn" maxlength="10" minlength="10" placeholder="Mobile Number"/>
                <input type="submit" value="Sign Up"/>
            </form>
        </div>
        <div class="sign-in" id="sinin">
            <form action="lvalidate.jsp" method="POST">
                <span class="header">Sign In</span>
                <input type="text" name="uid" required maxlength="30" placeholder="Username"/>
                <input type="password" required name="pwd" minlength="6" maxlength="30" placeholder="Password"/>
                <input type="submit" value="Sign In"/>
                <a href="forgot.jsp">forgot password?</a>
            </form> 
        </div>
        <div id="left-overlay" class="hidden">
            <h1>Join Us</h1>
            <h3>Hi if this is your first time here then please sign up here</h3>
            <button class="button" id="sup">Sign Up</button>
        </div>
        <div id="right-overlay" class="hidden">
            <h1>Welcome Back</h1>
            <h3>If you already have an account then click here to SignIn</h3>
            <button class="button" id="sin">Sign In</button>
        </div>
    </div>
    <div id='psudo-alert'>
        <h1>congrats</h1>
        <p>succesfully registered with online test you can now login with your credentials click ok to continue</p>
        <button class='button' id='hide_alert'>OK</button>
    </div>
    <div id='psudo-alert-false'>
        <h1>Sorry</h1>
        <p>Given username or email already exists try again.</p>
        <button class='button' id='hide_alert_false'>OK</button>
    </div>
    <div id='lvalid-false'>
        <h1>Sorry</h1>
        <p>Given username or password is incorrect please try again.</p>
        <button class='button' id='hide_lvalid_false'>OK</button>
    </div>
    <div id="whiteb"></div>
    <%
    if(session.getAttribute("message")!=null){
        if(((String)session.getAttribute("message")).equals("lfail")){
        out.print("<script>$('#lvalid-false').toggle();</script>");
        out.print("<script>$('#whiteb').toggle();</script>");
        session.setAttribute("message","none");
    }
    else if(((String)session.getAttribute("message")).equals("true")){
        out.print("<script>$('#psudo-alert').toggle();</script>");
        out.print("<script>$('#whiteb').toggle();</script>");
        session.setAttribute("message","none");    
    }
    else if(((String)session.getAttribute("message")).equals("false")){
        out.print("<script>$('#psudo-alert-false').toggle();</script>");
        out.print("<script>$('#whiteb').toggle();</script>");
        session.setAttribute("message","none");
    }
    }
    %>
</div>
</body>
</html>
