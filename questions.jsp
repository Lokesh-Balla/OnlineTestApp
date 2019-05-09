<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//kicking out the user if has not logged in
if(session.getAttribute("uid")==null){
    response.sendRedirect("index.jsp");
}
if(session.getAttribute("test")==null){
    response.sendRedirect("user.jsp");
}
session.removeAttribute("test");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%> 
<%
ArrayList<Integer>  mylist = new ArrayList<Integer>();
for(int i=1;i<=18;i++)
{
    mylist.add(i);
}
Collections.shuffle(mylist);
StringBuffer str = new StringBuffer("(");
for(int i=0;i<9;i++){
    str.append(mylist.get(i)+",");
}
str.append(mylist.get(9)+")");
try {
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs;
%>
<head>
<meta charset="utf-8">
</head>
<link href="https://fonts.googleapis.com/css?family=Roboto|Roboto+Slab" rel="stylesheet">
<link rel="stylesheet" type="text/css" media="screen" href="qmain.css?v22">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<script >
    //GLOBAL VARIABLES
    var arr = [0,0,0,0,0,0,0,0,0,0];
    var arr_ans = [0,0,0,0,0,0,0,0,0,0];
    var curr = '1';
    function submit()
    {
        $.confirm({
                title: 'Time Up',
                content: 'Your answers will be auto-submitted',
                useBootstrap: false,
                buttons: {
                    ok: function () {
                        document.forms["ques"].submit();
                    },
                }
            });
        
    }
    
    function startTimer(duration, display) {
        var start = Date.now(),
        diff,
        flag=0,
        minutes,
        seconds;
        function timer() {
            // get the number of seconds that have elapsed since 
            // startTimer() was called
            diff = duration - (((Date.now() - start) / 1000) | 0);

            // does the same job as parseInt truncates the float
            minutes = (diff / 60) | 0;
            seconds = (diff % 60) | 0;

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.textContent = minutes + ":" + seconds; 

            if(diff<2*60 && flag!=1)
            {
                $.alert({
                useBootstrap: false,
                title: 'Hurry Up!',
                content: 'Less than 2 minutes left.',
                });
                $('#time').css("color","red");
                flag=1;
            }
            if(flag==1 && diff==0)
            {
                submit();
            }

            if (diff <= 0) {
            // add one second so that the count down starts at the full duration
            // example 05:00 not 04:59
            start = Date.now() + 1000;
            }
        };
    // we don't want to wait a full second before the timer starts
    timer();
    setInterval(timer, 1000);
    }
    $(window).on('load', function () {
        //set timer here
        var Minutes = 0.5 * 60,
        display = document.querySelector('#time');
        $("#1").toggle();
        $('#prev').prop('disabled', true);
        startTimer(Minutes, display);
        $('#b1').css("background-color","#008CBA");
    });
    $(document).ready(function(){
        $('#sub').click( function () {
            $.confirm({
                title: 'Submit',
                content: 'Are you sure that you want to submit?',
                useBootstrap: false,
                buttons: {
                    confirm: function () {
                        document.forms["ques"].submit();
                    },
                    cancel: function () {
                        $.alert({
                            useBootstrap: false,
                            title: 'Cancelled',
                            content: 'Proceed with your test!',
                        });
                    },
                }
            });
        });

        //for next and previous
        $('#prev').click( function(){
            if(arr[curr-1]!=1){
                if(arr_ans[curr-1]!=1){
                    $('#b'+curr).css("background-color","grey");
                }
                else{
                    $('#b'+curr).css("background-color","green");
                }
            }else{
                $('#b'+curr).css("background-color","#FF8000");
            }
            if(arr[curr-2]!=1){
                $("#mark").text("mark");
                $("#mark").css("background-color","#FF8000");
            }else{
                $("#mark").text("unmark");
                $("#mark").css("background-color","#FF0000");
            }
            $('#'+curr).toggle();
            $('#'+curr).prev().toggle();
            if(arr[curr-2]!=1){
                if(arr_ans[curr-2]!=1)
                {
                    $('#b'+curr).prev().css("background-color","#008CBA");
                }
                else{
                    $('#b'+curr).prev().css("background-color","#00FF00");
                }
            }
            else{
                $('#b'+curr).prev().css("background-color","#ffda00");
            }
            curr=$('#'+curr).prev().attr('id');
            if(curr=='1'){
                $('#prev').prop('disabled', true);
            }
            if(curr!='10'){
                $('#next').prop('disabled', false);
            }
        });

        $("#mark").click(function(){
            if($("#mark").text()=="unmark"){
                arr[curr-1]=0;
                if(arr_ans[curr-1]!=1){
                    $("#b"+curr).css("background-color","#008cba");
                }else{
                    $("#b"+curr).css("background-color","#00FF00");
                }
                $("#mark").text("mark");
                $("#mark").css("background-color","#FF8000");
            }else{
                arr[curr-1]=1;
                $("#b"+curr).css("background-color","ffda00");
                $("#mark").text("unmark");
                $("#mark").css("background-color","#FF0000");
            }
        });

        $('#next').click( function(){
            if(arr[curr-1]!=1){
                if(arr_ans[curr-1]!=1){
                    $('#b'+curr).css("background-color","grey");
                }
                else{
                    $('#b'+curr).css("background-color","green");
                }
            }else{
                $('#b'+curr).css("background-color","#FF8000");
            }
            if(arr[curr]!=1){
                $("#mark").text("mark");
                $("#mark").css("background-color","#FF8000");
            }else{
                $("#mark").text("unmark");
                $("#mark").css("background-color","#FF0000");
            }
            $('#'+curr).toggle();
            $('#'+curr).next().toggle();
            if(arr[curr]!=1){
                if(arr_ans[curr]!=1)
                {
                    $('#b'+curr).next().css("background-color","#008CBA");
                }
                else{
                    $('#b'+curr).next().css("background-color","#00ff00");
                }
            }
            else{
                $('#b'+curr).next().css("background-color","#ffda00");
            }
            curr=$('#'+curr).next().attr('id');
            if(curr!='1'){
                $('#prev').prop('disabled', false);
            }
            if(curr=='10'){
                $('#next').prop('disabled', true);
            }
        });

        //left panel buttons
        $('.lpane').click(function(){
            $('#'+curr).toggle();
            if(arr[curr-1]!=1){
                if(arr_ans[curr-1]==1){
                    $('#b'+curr).css("background-color","green");
                }else{
                    $('#b'+curr).css("background-color","grey");
                }
            }
            else{
                $('#b'+curr).css("background-color","#ff8000");
            }
            $('#'+$(this).val()).toggle();
            if(arr[$(this).val()-1]!=1){
                if(arr_ans[$(this).val()-1]!=1){
                    $('#b'+$(this).val()).css("background-color","#008CBA");
                }else{
                    $('#b'+$(this).val()).css("background-color","#00FF00");
                }
                $("#mark").text("mark");
                $("#mark").css("background-color","#FF8000");
            }else{
                $('#b'+$(this).val()).css("background-color","ffda00");
                $("#mark").text("unmark");
                $("#mark").css("background-color","#FF0000");
            }
            curr=$(this).val();
            if(curr=='1'){
               $('#prev').prop('disabled', true);
               $('#next').prop('disabled', false);
            }
            else if(curr=="10")
            {
               $('#next').prop('disabled', true);
               $('#prev').prop('disabled', false);
            }
            else{
              $('#next').prop('disabled', false);
              $('#prev').prop('disabled', false);  
            }
        });

        // changing color of answer question
        $('input').click(function(){
            var str=$(this).attr('name');
            arr_ans[parseInt(str.slice(2))-1]=1;
            if(arr[parseInt(str.slice(2))-1]!=1)
            $('#b'+str.slice(2)).css("background-color","#00ff00");
        });
    });
</script>
<body>
    <div class='nav'>
        <span style='left:0%'><i class="fa fa-user-circle-o" aria-hidden="true"></i> <%=session.getAttribute("uid")%></span><span>Time : </span><span id="time">00:00</span>
    </div>
    <div class='left'>
        <button class="lpane" id="b1" value='1'>1</button>
        <button class="lpane" id="b2" value='2'>2</button>
        <button class="lpane" id="b3" value='3'>3</button>
        <button class="lpane" id="b4" value='4'>4</button>
        <button class="lpane" id="b5" value='5'>5</button>
        <button class="lpane" id="b6" value='6'>6</button>
        <button class="lpane" id="b7" value='7'>7</button>
        <button class="lpane" id="b8" value='8'>8</button>
        <button class="lpane" id="b9" value='9'>9</button>
        <button class="lpane" id="b10" value='10'>10</button>
        <div id="legend" style='position:absolute;bottom:25'>
            <ul class='legend-labels' type='none' style='padding:0'>
                <li><span style='background: grey;'></span>unanswered</li>
                <li><span style='background: #00FF00;'></span>answered</li>
                <li><span style='background: #FF8000;'></span>marked</li>
                <li><span style='background: #FFDA00;'></span>marked selected</li>
                <li><span style='background: #008CBA;'></span>selected</li>
            </ul>
        </div>
    </div>
    <div class='container'>
        <form name="ques" method="POST" action="eval.jsp">
              <% 
                int i=1;
                String sql=new String();
                if(request.getParameter("tid").equals("t1")){
                    sql="select * from questions where qid=";
                    out.print("<input type='hidden' name='tid' value='t1'>");
                }else if(request.getParameter("tid").equals("t2")){
                    sql="select * from testtwo where qid=";
                     out.print("<input type='hidden' name='tid' value='t2'>");
                }
                while(i<11){
                    rs=st.executeQuery(sql+mylist.get(i));
                    rs.next();
                    ArrayList<Integer>  options = new ArrayList<Integer>();
                    for(int j=1;j<=4;j++){
                        options.add(j);
                    }
                    Collections.shuffle(options);
                    out.print("<div class='qblock' id='"+i+"' style='display:none;'><table><tr><td>"+i+") "+rs.getString("ques")+"</td></tr><tr class='blank_row'></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='"+options.get(0)+"'/>"+rs.getString("op"+options.get(0))+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='"+options.get(1)+"'/>"+rs.getString("op"+options.get(1))+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='"+options.get(2)+"'/>"+rs.getString("op"+options.get(2))+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='"+options.get(3)+"'/>"+rs.getString("op"+options.get(3))+"</td></tr>");
                    out.print("<input type='hidden' value='"+rs.getString("qid")+"' name='qid"+i+"'></table></div>");
                    i++;
                }
                %>  
            <%  } catch (SQLException e) {
                    e.printStackTrace();
            }
            %>
        </form>
    <div class='botnav'>
        <button id='prev' class="nn"><span>Prev</span></button>
        <button id='mark' class="nn"> Mark </button>
        <button id='next' class="nn" ><span>Next</span></button>
    </div>
    <div class='bootnav'>
    <button id="sub" class="nn1">submit</button>
    </div>
</div>
</body>   