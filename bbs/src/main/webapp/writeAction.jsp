<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "java.io.File" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>

	<%
	String realFolder="";
	String saveFolder = "bbsUpload";		//사진을 저장할 경로
	String encType = "utf-8";				//변환형식
	int maxSize=5*1024*1024;	
	
	ServletContext context = this.getServletContext();		//절대경로를 얻는다
	realFolder = context.getRealPath(saveFolder);			//saveFolder의 절대경로를 얻음
			
	MultipartRequest multi = null;

	//파일업로드를 직접적으로 담당		
	multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());

	//form으로 전달받은 3가지를 가져온다
	String fileName = multi.getFilesystemName("fileName");
	String bbsTitle = multi.getParameter("bbsTitle");
	String bbsContent = multi.getParameter("bbsContent");
	String marketName = multi.getParameter("marketName");
	String LatLng = multi.getParameter("marketLatLng");
	String temp = LatLng.substring(1, LatLng.length()-1);

	String[] spl = temp.split(", ");
	String Lat = spl[0];
	String Lng = spl[1];


	bbs.setBbsTitle(bbsTitle);
	bbs.setBbsContent(bbsContent);
	bbs.setName(marketName);
	bbs.setLat(Lat);
	bbs.setLng(Lng);

	String userID = null;
	if(session.getAttribute("userID") != null){ 
		userID = (String) session.getAttribute("userID");
	}
	
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		if(bbs.getBbsTitle() == null||bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getName(), bbs.getLat(), bbs.getLng());
		
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				
				
				int bbsID=bbsDAO.getCurBbsId();
				
				if(fileName != null){
					File oldFile = new File(realFolder+"\\"+fileName);
					File newFile = new File(realFolder+"\\"+(bbsID)+"사진.jpg");
					oldFile.renameTo(newFile);
				}
				
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			} 
		}
	}
	
	
	%>

</body>
</html>
