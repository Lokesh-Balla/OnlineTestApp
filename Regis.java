import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
public class Regis extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            
            out.println("reached before connection");
            Class.forName("org.mariadb.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/dxc","root","traceon");
            out.println("connection established");
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
            
            // request.setAttribute("data",  "<br/>" + "changed");
            // request.getRequestDispatcher("index.html").forward(request, response);
            response.setContentType("text/html");
            out.print("Done");
        } catch (SQLException e) {
            out.println("in catch");
            e.printStackTrace();
        }
    }
}