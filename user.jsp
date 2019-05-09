<!DOCTYPE html>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<%
//kicking out the user if has not logged in
if(session.getAttribute("uid")==null){
    response.sendRedirect("index.jsp");
}
session.setAttribute("test","true");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%
try{
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement(); 
    ResultSet rs=st.executeQuery("select * from score where uid='"+session.getAttribute("uid")+"'");
%>


<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OnlineTestApp</title>
    <link rel="stylesheet" type="text/css" media="screen" href="umain.css?v986">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
    $(document).ready(function(){
        $('#view1_1').click(function(){
            $("#hidden1_1").show();
            $("#hidden1_2").hide();
            $("#hidden2_1").hide();
            $("#hidden2_2").hide();
        });
        $('#view1_2').click(function(){
            $("#hidden1_1").hide();
            $("#hidden1_2").show();
            $("#hidden2_1").hide();
            $("#hidden2_2").hide();
        });
        $('#view2_1').click(function(){
            $("#hidden2_1").show();
            $("#hidden2_2").hide();
            $("#hidden1_1").hide();
            $("#hidden1_2").hide();
        });
        $('#view2_2').click(function(){
            $("#hidden2_1").hide();
            $("#hidden2_2").show();
            $("#hidden1_1").hide();
            $("#hidden1_2").hide();
        });
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
        <div id="sub-container">test 1<button id="t1">Start</button></div>
        <h1>General aptitude</h1>
        <div id="sub-container">test 2<button id="t2">Start</button></div>
    </div>
    <%
        Statement s1=con.createStatement();
        ResultSet r1=s1.executeQuery("select * from score where uid='"+session.getAttribute("uid")+"'");
    %>
    <div id="scores">
        <div id="te1">
            <span style="position:relative;left:5%">Test 1</span>
            <span style="position:relative;left:15%">No of tests Passed <button id="view1_1" style="width:15%;left:2%;position:relative;">view</button></span>
            <span style="position:relative;left:20%">All Tests <button id="view1_2" style="width:15%;left:2%;position:relative;">view</button></span>
        </div>
        <div id="hidden1_1">
        <%
            int count1=0,total1=0,sev=0,eig=0,nin=0,ten=0;
            out.print("<table class='tab1'>");
            out.print("<tr><th>attempt no</th><th>score</th></tr>");
            while(r1.next())
            {   
                if(r1.getString("testid").equals("t1") && r1.getInt("score")>6)
                {
                    switch(r1.getInt("score"))
                    {
                        case 7:sev++;break;
                        case 8:eig++;break;
                        case 9:nin++;break;
                        case 10:ten++;break;
                    }
                    count1++;
                    out.print("<tr><td>"+r1.getInt("attnum")+"</td><td>"+r1.getInt("score")+"</td></tr>");
                }
            }
            r1.beforeFirst();
        out.print("</table>");
        %>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                ['score', 'no of tests'],
                ['7', <%=sev%>],
                ['8', <%=eig%>],
                ['9', <%=nin%>],
                ['10', <%=ten%>]
            ]);
            var options = {'title':'Score Distribution', 'width':400, 'height':400 ,'backgroundColor': 'transparent',
            'chartArea.top':'5%','pieSliceText':'label' ,'legend':'none'};
            var chart = new google.visualization.PieChart(document.getElementById('piechart'));
            chart.draw(data, options);
        }
        </script>
        <div id="piechart"></div>
    </div>
<%
int ze=0,on=0,tw=0,th=0,fo=0,fi=0,si=0,se=0,ei=0,ni=0,te=0;
        out.print("<div id='hidden1_2'>");
            out.print("<table class='tab1'>");
            out.print("<tr><th>attempt no</th><th>score</th></tr>");
            while(r1.next())
            {
                if(r1.getString("testid").equals("t1"))
                {
                    switch(r1.getInt("score"))
                    {
                        case 0:ze++;break;
                        case 1:on++;break;
                        case 2:tw++;break;
                        case 3:th++;break;
                        case 4:fo++;break;
                        case 5:fi++;break;
                        case 6:si++;break;
                        case 7:se++;break;
                        case 8:ei++;break;
                        case 9:ni++;break;
                        case 10:te++;break;
                    }
                    out.print("<tr><td>"+r1.getInt("attnum")+"</td><td>"+r1.getInt("score")+"</td></tr>");
                    total1++;
                }
            }
            r1.beforeFirst();
        out.print("</table>");
        %>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
            var data = google.visualization.arrayToDataTable([
            ['score', 'no of tests'],
            ['0', <%=ze%>],
            ['1', <%=on%>],
            ['2', <%=tw%>],
            ['3', <%=th%>],
            ['4', <%=fo%>],
            ['5', <%=fi%>],
            ['6', <%=si%>],
            ['7', <%=se%>],
            ['8', <%=ei%>],
            ['9', <%=ni%>],
            ['10', <%=te%>]
            ]);
            var options = {'title':'Score Distribution', 'width':400, 'height':400 ,'backgroundColor': 'transparent',
            'chartArea.top':'5%','pieSliceText':'label' ,'legend':'none'};
            var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
            chart.draw(data, options);
            }
        </script>
<div id="piechart1"></div>
    </div>

 <div id="te2">
            <span style="position:relative;left:5%">Test 2</span>
            <span style="position:relative;left:15%">No of tests Passed <button id="view2_1" style="width:15%;left:2%;position:relative;">view</button></span>
            <span style="position:relative;left:20%">All Tests <button id="view2_2" style="width:15%;left:2%;position:relative;">view</button></span>
        </div>

<div id="hidden2_1">
        <%
            int count2=0,total2=0,sev1=0,eig1=0,nin1=0,ten1=0;
            out.print("<table class='tab1'>");
            out.print("<tr><th>attempt no</th><th>score</th></tr>");
            while(r1.next())
            {   
                if(r1.getString("testid").equals("t2") && r1.getInt("score")>6)
                {
                    switch(r1.getInt("score"))
                    {
                        case 7:sev1++;break;
                        case 8:eig1++;break;
                        case 9:nin1++;break;
                        case 10:ten1++;break;
                    }
                    count2++;
                    out.print("<tr><td>"+r1.getInt("attnum")+"</td><td>"+r1.getInt("score")+"</td></tr>");
                }
            }
            r1.beforeFirst();
        out.print("</table>");
        %>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                ['score', 'no of tests'],
                ['7', <%=sev1%>],
                ['8', <%=eig1%>],
                ['9', <%=nin1%>],
                ['10', <%=ten1%>]
            ]);
            var options = {'title':'Score Distribution', 'width':400, 'height':400 ,'backgroundColor': 'transparent',
            'chartArea.top':'5%','pieSliceText':'label' ,'legend':'none'};
            var chart = new google.visualization.PieChart(document.getElementById('piechart2'));
            chart.draw(data, options);
        }
        </script>
        <div id="piechart2"></div>
    </div>


<%
int ze1=0,on1=0,tw1=0,th1=0,fo1=0,fi1=0,si1=0,se1=0,ei1=0,ni1=0,te1=0;
        out.print("<div id='hidden2_2'>");
            out.print("<table class='tab1'>");
            out.print("<tr><th>attempt no</th><th>score</th></tr>");
            while(r1.next())
            {
                if(r1.getString("testid").equals("t2"))
                {
                    switch(r1.getInt("score"))
                    {
                        case 0:ze1++;break;
                        case 1:on1++;break;
                        case 2:tw1++;break;
                        case 3:th1++;break;
                        case 4:fo1++;break;
                        case 5:fi1++;break;
                        case 6:si1++;break;
                        case 7:se1++;break;
                        case 8:ei1++;break;
                        case 9:ni1++;break;
                        case 10:te1++;break;
                    }
                    out.print("<tr><td>"+r1.getInt("attnum")+"</td><td>"+r1.getInt("score")+"</td></tr>");
                    total1++;
                }
            }
            r1.beforeFirst();
        out.print("</table>");
        %>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
            var data = google.visualization.arrayToDataTable([
            ['score', 'no of tests'],
            ['0', <%=ze1%>],
            ['1', <%=on1%>],
            ['2', <%=tw1%>],
            ['3', <%=th1%>],
            ['4', <%=fo1%>],
            ['5', <%=fi1%>],
            ['6', <%=si1%>],
            ['7', <%=se1%>],
            ['8', <%=ei1%>],
            ['9', <%=ni1%>],
            ['10', <%=te1%>]
            ]);
            var options = {'title':'Score Distribution', 'width':400, 'height':400 ,'backgroundColor': 'transparent',
            'chartArea.top':'5%','pieSliceText':'label' ,'legend':'none'};
            var chart = new google.visualization.PieChart(document.getElementById('piechart3'));
            chart.draw(data, options);
            }
        </script>
<div id="piechart3"></div>
    </div>


</div>
</div>
</body>
</html>
<%
}catch(SQLException e){
    e.printStackTrace();
}
%>
