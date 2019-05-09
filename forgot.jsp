<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto|Roboto+Slab" rel="stylesheet">
    <link rel="stylesheet" type="text/css" media="screen" href="fmain.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){   
            $("#sup").click(function(){
                document.forms["reset"].submit();
            });
            $("#hide_alert_congo").click(function(){
                window.location.replace("index.jsp");
            });
            $("#hide_alert").click(function(){
                $("#psudo-alert").fadeToggle("800");
                $("#whiteb").fadeToggle("800");
            });
            $("#hide_alert_passnomatch").click(function(){
                $("#passnomatch").fadeToggle("800");
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
        <div class="forgot" id="forgot">
            <form action="forval.jsp" method="POST">
                <span class="header">Reset my password</span>
                <input type="email" required name="mail" maxlength="45" placeholder="Email Id"/>
                <input type="text" name="phn" maxlength="10" minlength="10" placeholder="Mobile Number"/>
                <input type="submit" id="sub"value="Submit"/>
            </form>
        </div>
        <div id="overlay" class="hidden">
            <form action="reset.jsp" name="reset" method="POST">
            <span class="header">Enter new password</span>
            <br/>
            <input type="password" id="new" name="new" placeholder="New password">
            
            <input type="password" id="newc" name="newc" placeholder="Conform password">
            <br/>
            <button class="button" id="sup">reset</button>
            </form>
        </div>
        </div>
        <div id='psudo-alert'>
            <h1>Sorry!</h1>
            <p>Your mobile and mail do not match any user try again</p>
            <button class='button' id='hide_alert'>OK</button>
        </div>
        <div id='congo'>
            <h1>Congrats</h1>
            <p>Your password is changed succesfully.</p>
            <button class='button' id='hide_alert_congo'>OK</button>
        </div>
        <div id='passnomatch'>
            <h1>Try again</h1>
            <p>passwords dont match. Please try again.</p>
            <button class='button' id='hide_alert_passnomatch'>OK</button>
        </div>
        <div id="whiteb"></div>
        <%
        if(session.getAttribute("mess")!=null){
            if(((String)session.getAttribute("mess")).equals("fail")){
                session.setAttribute("mess","none");
                out.print("<script>$('#psudo-alert').toggle();</script>");
                out.print("<script>$('#whiteb').toggle();</script>");
            }
            if(((String)session.getAttribute("mess")).equals("success")){
                session.setAttribute("mess","none");
                out.print("<script>$('#forgot').fadeToggle('800');</script>");
            }
            if(((String)session.getAttribute("mess")).equals("changed")){
                session.setAttribute("mess","none");
                out.print("<script>$('#congo').fadeToggle('800');</script>");
                out.print("<script>$('#whiteb').toggle();</script>");
            }
            if(((String)session.getAttribute("mess")).equals("notmatch")){
                session.setAttribute("mess","none");
                out.print("<script>$('#passnomatch').fadeToggle('800');</script>");
                out.print("<script>$('#whiteb').toggle();</script>");
            }
        }
    %>
    </div>
</body>
</html>