<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<%
//kicking out the user if has not logged in
if(session.getAttribute("uid")==null){
    response.sendRedirect("index.html");
}
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
<table border=1>
<tr><th>UserName</th><th>No of Questions Attempted</th><th>No of correct</th></tr>
<tr><td>dummy</td><td><%out.print(no_ques);%></td><td><%out.print(correct);%></td></tr>
</table>
<a href="user.jsp">click here to go back to home page</a>