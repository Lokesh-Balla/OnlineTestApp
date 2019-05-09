<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<%
try {
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    String uid=request.getParameter("uid");
    String pwd=request.getParameter("pwd");
    String mail=request.getParameter("mail");
    String phn=request.getParameter("phn");
    Statement st=con.createStatement();
    out.print("select * from  users where uname='"+uid+"'");
    ResultSet rs=st.executeQuery("select * from  users where uname='"+uid+"' or email='"+mail+"'");
    if(rs.next()){
        session.setAttribute("message","false");
        request.getRequestDispatcher("index.jsp").forward(request, response);  
    }else{
        PreparedStatement ps=con.prepareStatement("insert into users values(?,?,?,?,?,?)");
        ps.setString(1, uid);
        ps.setString(2, pwd);
        ps.setString(3, mail);
        ps.setString(4, phn);
        ps.setInt(5,1);
        ps.setInt(6,1);
        ps.executeUpdate();
        session.setAttribute("message","true");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    //out.print("sfdsfd"); 
} catch (SQLException e) {
    e.printStackTrace();
}
%>