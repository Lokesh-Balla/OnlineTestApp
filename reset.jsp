<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.io.*" %>
<%
try{
    Class.forName("org.mariadb.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
    Statement st=con.createStatement();
    String newo=""+request.getParameter("new");
    String newc=""+request.getParameter("newc");
    if(!newo.equals(newc)){
        out.print("sf");
        session.setAttribute("mess","notmatch");
        request.getRequestDispatcher("forgot.jsp").forward(request, response); 
    }else{
        int i=st.executeUpdate("update users set password='"+request.getParameter("new")+"' where email='"+session.getAttribute("mail")+"' and mobile='"+session.getAttribute("phn")+"'");
        if(i==1){
            session.removeAttribute("mail");
            session.removeAttribute("phn");
            session.setAttribute("mess","changed");
            request.getRequestDispatcher("forgot.jsp").forward(request, response); 
        }else{
            session.setAttribute("mess","notchanged");
            request.getRequestDispatcher("forgot.jsp").forward(request, response); 
        }
    }

}catch(SQLException e){
    e.printStackTrace();
}
%>