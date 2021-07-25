<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import ="java.io.PrintWriter" %>
<%@page import ="bbs.BbsDAO" %>
<%@page import ="bbs.Bbs" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%
		int bbsID = Integer.parseInt(request.getParameter("bbsID"));
		new BbsDAO().likey(bbsID);
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = \"view.jsp?bbsID="+bbsID+"\"");
		script.println("</script>");

	%>
</body>
</html>
