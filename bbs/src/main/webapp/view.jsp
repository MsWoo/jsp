<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import ="java.io.PrintWriter" %>
	<%@ page import = "java.io.File" %>
	<%@page import ="bbs.Bbs" %>
	<%@page import ="bbs.BbsDAO" %>
	<%@page import ="comment.Comment" %>
	<%@page import ="comment.CommentDAO" %>
	<%@page import ="java.util.ArrayList" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP게시판 웹 사이트</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38e09686761a47687ac5b433471d5364&libraries=services"></script>
</head>

<body>
	<%
		String userID = null;
		int admin = 0;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			admin = (Integer) session.getAttribute("admin");
			}
		int bbsID= 0;
		if(request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	<nav class="navbar navbar-expand-sm bg-light navbar-light">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target= "#bs-example-navbar-collapse-1"
				aria-exapnded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class = "active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
					</li>
			</ul>
			<%
				}else{
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
			<% 
				}
			
			%>
			

		</div>
	</nav>
	<div class = "container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style = "width: 20%;">글 제목</td>
						<td colspan = "2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan = "2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan = "2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td colspan = "2"><%= bbs.getBbsUCount() %></td>
					</tr>
					<tr>
						<td>좋아요</td>
						<td colspan = "2"><%= bbs.getBbsLikey() %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td style ="min-height: 200px; text-align: left;"><%= bbs.getBbsContent() %></td>

						
					<%
					String real = "C:\\JSP\\workspaceee\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\bbs\\bbsUpload";
					File viewFile = new File(real+"\\"+bbsID+"사진.jpg");
					if(viewFile.exists()){ 
					%>
							<td colspan="6"><br><br><img src = "bbsUpload/<%=bbsID %>사진.jpg" border="300px" width="300px" height="300px"><br><br>
					<% 
					}
					else {
					%>
						<td colspan="6"><br><br>
					<%
					} 
					%>
					<td>
					<%
			 		if(!(bbs.getLat().equals("0") && bbs.getLng().equals("0"))) {
			 		%>
					<div id="map" style="width:500px;height:400px;"></div>
					<%
			 		}
			 		%>
					</td>
					
					</tr>
					
				</tbody>				
			</table>

			<a href ="likey.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">추천</a>

			<a href = "bbs.jsp" class="btn btn-primary">목록</a>
			<%
				new BbsDAO().count(bbsID);
			 	if( (userID != null && userID.equals(bbs.getUserID())) || admin == 1) {
			 %>
					 <a href ="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					 <a onclick="return confirm('정말로 삭제 하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
			 <%
			 	}
			 %>
		</div>
		
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
		<tbody>
		<%
		ArrayList<Comment> list = new CommentDAO().getList(bbsID);
		if(list.size() != 0){
			for(int i = 0; i<list.size(); i++){
		%>		
					<tr>
						<td><%= list.get(i).getWriter() %></td>
						<td><%= list.get(i).getContent() %></td>
					</tr>
		<%
			}
		}
		%>
		
		</tbody>				
		</table>
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">

				<tbody>
					<tr>
					<td style = "width: 20%;"><div><%= (String) session.getAttribute("userID") %></div></td>
					
					<td><div><textarea id="comment_content" name="comment_content"></textarea></div></td>
					
					<td><div><p><a href="#" onclick="comment()">[댓글등록]</a></div></td>
						
					</tr>
				</tbody>				
		</table>

		
	</div>
	
	<script>
		function comment(){
			location.href="comment.jsp?bbsID=<%= bbsID %>&&writer=<%= (String) session.getAttribute("userID") %>&&content="+document.getElementById("comment_content").value;
		}
	</script>
	
	<script>
		var container = document.getElementById('map');
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		var name = "<%=bbs.getName()%>";
		var lat = "<%=bbs.getLat()%>";
		var lng = "<%=bbs.getLng()%>";

		var options = {
			center: new kakao.maps.LatLng(lat, lng),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    map : map,
		    title: name,
		    position: new kakao.maps.LatLng(lat, lng)
		
		}); 
		
		(function(marker, title) {
			
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });
            
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            
		})(marker, marker.getTitle());

		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}

		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
