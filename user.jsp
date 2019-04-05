<!DOCTYPE html>
<%
//kicking out the user if has not logged in
if(session.getAttribute("uid")==null){
    response.sendRedirect("index.html");
}
%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OnlineTestApp</title>
    <link rel="stylesheet" type="text/css" media="screen" href="umain.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class='topbar'>
<span id="userimg"><i class="fa fa-user-circle-o" aria-hidden="true"></i> <%=session.getAttribute("uid")%></span>
<span id="lbutton"><a href="logout.jsp">Logout <i class="fa fa-sign-out" aria-hidden="true"></i></a></span>
</div>
<div class='rest'>
<a href="questions.jsp">click me for test</a>
</div>
</body>
</html>