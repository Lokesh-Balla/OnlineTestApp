<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<link rel="stylesheet" type="text/css" media="screen" href="eval.css?v12">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<script>
$(document).ready(function(){
    $("#pcerf").click(function(){
        window.open('certificate.jsp', '_blank');
    });
});
</script>
<%
int no_ques=0,correct=0,i=1;
try {
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs;
    String sql;
    if(request.getParameter("tid").equals("t1"))
    {
        sql="select ca from questions where qid=";
    }else{
        sql="select ca from testtwo where qid=";
    }
    while(i<=10)
    {
        if(request.getParameter("op"+i)!=null)
        {
            no_ques++;
            rs=st.executeQuery(sql+request.getParameter("qid"+i));
            rs.next();
            if(request.getParameter("op"+i).equals(rs.getString("ca")))
            {
                correct++;
            }
        }
        i++;
    }
}catch(SQLException e){
    e.printStackTrace();
}
%>
<body>
<div class="container" >
<table>
<tr><th>UserName</th><th>No of Questions Attempted</th><th>No of correct</th></tr>
<tr><td><%=session.getAttribute("uid")%></td><td><%out.print(no_ques);%></td><td><%out.print(correct);%></td></tr>
</table>
<%
try{
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from users where uname='"+session.getAttribute("uid")+"'");
    rs.next();
    Statement st1=con.createStatement();
    PreparedStatement ps=con.prepareStatement("insert into score values(?,?,?,?)");
    ps.setString(1,rs.getString("uname"));
    ps.setInt(2,correct);
    ps.setString(3,request.getParameter("tid"));
    if(request.getParameter("tid").equals("t1")){
        st1.executeUpdate("update users set att1='"+(rs.getInt("att1")+1)+"' where uname='"+session.getAttribute("uid")+"'");
        ps.setInt(4,rs.getInt("att1"));
    }else if(request.getParameter("tid").equals("t2")){
        st1.executeUpdate("update users set att2='"+(rs.getInt("att2")+1)+"' where uname='"+session.getAttribute("uid")+"'");
        ps.setInt(4,rs.getInt("att2"));
    }
    ps.executeUpdate();
}catch(SQLException e){
    e.printStackTrace();
}
%>
</div>
    </div>
    <div style="margin-top: 25px;" style="float: left;">
        <button value="Homep" class="cl1" onclick="window.location.href = 'user.jsp';"> << Back to Home Page </button>
    </div>

    <div style="margin-top: 20px;" style="float: right;">
        <button value="LogO" class="cl2" onclick="window.location.href = 'logout.jsp';">Log Out</button>
    </div> 
    <%
        if(correct>=7){
            session.setAttribute("cert","pass");
            out.print("<button id='pcerf'  target='_blank'>Print Certificate</button>");
        }
    %>
</body>