<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%
try{
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select uname,password from users where uname='"+request.getParameter("uid")+"' and password='"+request.getParameter("pwd")+"'");
    if(rs.next()){
        session.setAttribute("uid",rs.getString("uname"));
        response.sendRedirect("user.jsp");
    }else{
        session.setAttribute("message","lfail");
        request.getRequestDispatcher("index.jsp").forward(request, response); 
    }
}catch(SQLException e){
    e.printStackTrace();
}
%>