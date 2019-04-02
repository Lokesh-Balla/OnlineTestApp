<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
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
    request.setAttribute("data", "changed");
    request.getRequestDispatcher("index.html").forward(request, response);
} catch (SQLException e) {
    e.printStackTrace();
}
%>