<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="http://ajax.googleapis.com/ajax/jibs/jqeury/1.11.3/jquery.mis.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<title>맛집 투어</title>
</head>
<body>
	<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-expand-sm bg-light navbar-light" role="navigation">
		<!-- 네비게이션 -->
		<div class="navbar-header">


			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">맛집 찾아</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">추천 게시판</a></li>
				<li><a href="searchLocate.jsp">지역검색</a></li>
				<li><a href="searchName.jsp">가게이름검색</a></li>
			</ul>
			<%
			// 로그인 하지 않았을 때 보여지는 화면
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
			</ul>
			<%
			// 로그인이 되어 있는 상태에서 보여주는 화면
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<div style="width: 800px;margin: 100px;">
		<div id="carousel-example-generic" class="carousel slide">
			<ol class="carousel-indicators">
			
<!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1">
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<!-- 아미지 설정- -->
					<img src="images/eat.jpeg" style="width: 800px;height:180px;">
					<div class="carousel-caption" style="color: black;"></div>
				</div>
				<div class="item">
					<img src="images/eat1.jpeg" style="width: 800px;height:180px;">
					<div class="carousel-caption" style="color: black;"></div>
				</div>
				<div class="item">
					<img src="images/3.jpeg" style="width: 800px;height:180px">
					<div class="carousel-caption" style="color: black;"></div>
				</div>
			</div>
			<!-- 왼쪽 화살표 버튼 -->
			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev"> <!-- 왼쪽 화살표 --> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			</a>
			<!-- 오른쪽 화살표 버튼 -->
			<a class="right carousel-control" href="#carousel-example-generic"
				role="button" data-slide="next"> <!-- 오른쪽 화살표 --> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			</a>
		</div>
	</div>
	<script>
		$(function() {
			// 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
			$('#carousel-example-generic').carousel({
				// 슬리아딩 자동 순환 지연 시간
				// false면 자동 순환하지 않는다.
				interval : 2500,
				// hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
				pause : "hover",
				// 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
				wrap : true,
				// 키보드 이벤트 설정 여부(?)
				keyboard : true
			});
		});
	</script>

	<div class="container">
		<h3>이번달 핫 랭킹 TOP 3</h3>
		<div class="row">
			<div class="col-md-4">
				<a href="http://localhost:8181/project/view.jsp?bbsID=27" class="thumbnail"> <img
					src="images/1.jpg" alt="city1" style="width: 300px; height: 150px">
				</a>
			</div>
			<div class="col-md-4">
				<a href="images/2.jpeg" class="thumbnail"> <img
					src="images/2.jpeg" alt="city2" style="width: 300px; height: 150px">
				</a>
			</div>
			<div class="col-md-4">
				<a href="bbs.jsp" class="thumbnail"> <img src="images/3.jpeg"
					alt="city3" style="width: 300px; height: 150px">
				</a>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
