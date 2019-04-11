<%
session.invalidate();
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache"); 
response.sendRedirect("index.jsp");
%>