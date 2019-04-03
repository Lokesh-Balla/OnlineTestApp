<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
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
    ResultSet rs=st.executeQuery("select * from questions where qid in "+str);
%>

<link rel="stylesheet" type="text/css" media="screen" href="qmain.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<script >
    //GLOBAL VARIABLES
    var curr = '1';
    function submit()
    {
        $.alert({
            useBootstrap: false,
            title: 'Time Up',
            content: 'Your answers will be auto-submitted',
        });
        document.forms["ques"].submit();
    }
    setTimeout(submit,1000*60*60+1000);
    function startTimer(duration, display) {
        var start = Date.now(),
        diff,
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
        var Minutes = 60 * 60,
        display = document.querySelector('#time');
        $("#1").toggle();
        startTimer(Minutes, display);
    });
    $(document).ready(function(){
        $('#sub').click( function () {
            $.confirm({
                title: 'Confirm!',
                content: 'Simple confirm!',
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
            $('#'+curr).toggle();
            $('#'+curr).prev().toggle();
            curr=$('#'+curr).prev().attr('id');
        });
        $('#next').click( function(){
            $('#'+curr).toggle();
            $('#'+curr).next().toggle();
            curr=$('#'+curr).next().attr('id');
        });

        //left panel buttons
        $('.lpane').click(function(){
            $('#'+curr).toggle();
            $('#'+$(this).val()).toggle();
            curr=$(this).val();
        });
    });
</script>
<body>
    <div class='nav'>
        <span>Timer:</span><span id="time">00:00</span>
    </div>
    <div class='left'>
        <button class="lpane" value='1'>1</button>
        <button class="lpane" value='2'>2</button>
        <button class="lpane" value='3'>3</button>
        <button class="lpane" value='4'>4</button>
        <button class="lpane" value='5'>5</button>
        <button class="lpane" value='6'>6</button>
        <button class="lpane" value='7'>7</button>
        <button class="lpane" value='8'>8</button>
        <button class="lpane" value='9'>9</button>
        <button class="lpane" value='10'>10</button>
    </div>
    <div class='container'>
        <form name="ques" method="POST" action="#">
              <% 
              int i=1;
              while(rs.next()){
                    out.print("<div class='qblock' id='"+i+"' style='display:none;'><table><tr><th>"+rs.getString("ques")+"</th></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='1'/>"+rs.getString("op1")+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='1'/>"+rs.getString("op2")+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='1'/>"+rs.getString("op3")+"</td></tr>");
                    out.print("<tr class='shuff'><td><input type='radio' name='op"+i+"' value='1'/>"+rs.getString("op4")+"</td></tr>");
                    out.print("</table></div>");
                    i++;
              }
              %>  
            <% } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
        </form>
    <div id="a"></div>
    <div class='botnav'>
        <button id='prev'>prev</button>
        <button id='next'>next</button>
    <button id="sub">submit</button>
    </div>
</div>
</body>   