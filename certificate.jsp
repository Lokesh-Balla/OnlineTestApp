<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate</title>
    <link href="https://fonts.googleapis.com/css?family=Pacifico|Playball" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $('#cmd').click(function(){
        $('#cmd').hide();
        window.print();
        $('#cmd').show();
    });
});
<%
  if(session.getAttribute("cert")==null)
  {
    response.sendRedirect("user.jsp");
  }
  session.removeAttribute("cert");
%>
</script>
<style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
    }
    
    .hero-image {
      background-image: url("back.png");
      height: 100%;
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
      position: relative;
    }
    
    .hero-text {
      text-align: center;
      position: absolute;
      top: 45%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: white;
      font-family: 'Playball', cursive;
    }
    
    .hero-text button {
      border: none;
      outline: 0;
      display: inline-block;
      padding: 10px 25px;
      color: black;
      background-color: #ddd;
      text-align: center;
      cursor: pointer;
    }
    
    .hero-text button:hover {
      background-color: #555;
      color: white;
    }
    p{
        font-family: 'Pacifico', cursive;
        font-size: 2em;
    }
    h3{
        font-size:3em;
    }
    </style>
    </head>
    <body>
    
    <div class="hero-image">
      <div class="hero-text">
        <h1 style="font-size:5em">Certificate of  Excellence</h1>
        <p>Congrats you passed in our exam</p>
        <h3><%=session.getAttribute("uid")%></h3>
        <button id="cmd">Print me</button>
      </div>
    </div>
    
    
    </body>
</html>