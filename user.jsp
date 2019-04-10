<!DOCTYPE html>
<%
//kicking out the user if has not logged in
if(session.getAttribute("uid")==null){
    response.sendRedirect("index.jsp");
}
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OnlineTestApp</title>
    <link rel="stylesheet" type="text/css" media="screen" href="umain.css?v1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
    $(document).ready(function(){
        $('#tb').click(function(){
            $("#welcome").css("z-index",-1);
            $("#scores").css("z-index",-1);
            $("#tests").css("z-index",1);
        });
        $('#sb').click(function(){
            $("#welcome").css("z-index",-1);
            $("#tests").css("z-index",-1);
            $("#scores").css("z-index",1);
        });
        $('#t1').click(function(){
            $('input[name=tid]').val('t1');
            document.forms["test"].submit();
        });
        $('#t2').click(function(){
            $('input[name=tid]').val('t2');
            document.forms["test"].submit();
        });
    });
    </script>
</head>
<body>
<form name="test" action="questions.jsp" method="POST">
<input type="hidden" name="tid">
</form>
<div class='topbar'>
<span id="userimg"><i class="fa fa-user-circle-o" aria-hidden="true"></i> <%=session.getAttribute("uid")%></span>
<span id="lbutton"><a href="logout.jsp">Logout <i class="fa fa-sign-out" aria-hidden="true"></i></a></span>
</div>
<div class="container">
    <div id="left">
        <table id="tab">
            <tr><td><button id="sb">scores</button></td></tr>
            <tr><td><button id="tb">tests</button></td></tr>
        </table>
    </div>
    <div id="welcome">
        <h1>Welcome, back!</h1>
        <h2>Instructions</h2>
        <p>on your left you will two buttons</p>
        <ul>
        <li>click the "tests" button to access available tests</li>
        <li>click the "score" button to analyse your past performance</li>
        </ul>
        <p>or you can logout in the topbar</p>
    </div>
    <div id="tests">
        <h1>CSE tests</h1>
        <div id="sub-container">test1<button id="t1">Start</button></div>
        <h1>General aptitude</h1>
        <div id="sub-container">test1<button id="t2">Start</button></div>
    </div>
    <div id="scores">
        <h1>scores</h1>
    </div>
</div>
</body>
</html>