<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%
try{
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select uname from users where email='"+request.getParameter("mail")+"' and mobile='"+request.getParameter("phn")+"'");
    if(rs.next()){
        session.setAttribute("mess","success");
        session.setAttribute("mail",request.getParameter("mail"));
        session.setAttribute("phn",request.getParameter("phn"));
        response.sendRedirect("forgot.jsp");
    }else{
        session.setAttribute("mess","fail");
        request.getRequestDispatcher("forgot.jsp").forward(request, response); 
    }
}catch(SQLException e){
    e.printStackTrace();
}
%>