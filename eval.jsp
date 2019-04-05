<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<link rel="stylesheet" type="text/css" media="screen" href="eval.css">
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
<%
int no_ques=0,correct=0,i=0;
try {
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs;
    while(i<10)
    {
        if(request.getParameter("op"+i)!=null)
        {
            no_ques++;
            rs=st.executeQuery("select ca from questions where qid="+request.getParameter("qid"+i));
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
</div>
    </div>
    <div style="margin-top: 25px;" style="float: left;">
        <button value="Homep" class="cl1" onclick="window.location.href = 'user.jsp';"> << Back to Home Page </button>
    </div>

    <div style="margin-top: 20px;" style="float: right;">
        <button value="LogO" class="cl2" onclick="window.location.href = 'logout.jsp';">Log Out</button>
    </div> 

</body>