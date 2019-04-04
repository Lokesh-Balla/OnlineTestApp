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
    PreparedStatement ps=con.prepareStatement("insert into users values(?,?,?,?,?)");
    String uid=request.getParameter("uid");
    String pwd=request.getParameter("pwd");
    String mail=request.getParameter("mail");
    String phn=request.getParameter("phn");
    ps.setString(1, uid);
    ps.setString(2, pwd);
    ps.setString(3, mail);
    ps.setString(4, phn);
    ps.setInt(5,1);
    ps.executeUpdate();
} catch (SQLException e) {
    e.printStackTrace();
}
%>