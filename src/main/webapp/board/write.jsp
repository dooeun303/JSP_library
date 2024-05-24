<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="styles.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>

	<%
		// member ID = 로그인 되어있는 사람이면 세션값으로 설정, 처음 오는 사람이면 null값으로 설정
		String memberID = null;
		if (session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
	%>

	<nav class="navbar navbar-default">
	
		<!-- 네비게이션 바 - 헤더  -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>				
			</button>
			<a class="navbar-brand" href="login2.jsp">순천대 도서관</a>	
		</div>
		
		
		<!-- 네비게이션 바 - 내렸을때 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="navbar-nav">
				<li><a href="login2.jsp">메인</a></li>
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%	
				// 로그인 안 되어 있을 때는? 네비게이션 바에 접속, 로그인, 회원가입이 보이게 
				if(memberID == null) {
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login2.jsp">로그인</a></li>
						<li><a href="join2.jsp">회원가입</a></li>
					</ul>
				</li>
				</ul>
			<%
				// 로그인 되어 있을 때는? 네비게이션 바에 회원관리, 로그아웃이 보이게ㅁ
				} else {
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
				</ul>
			<%
			}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			
				<!-- 테이블 제목 -->
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center; ">게시판 글쓰기 양식</th>

					</tr>
				</thead>
				
				<!-- 테이블 내용 -->
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글제목" name="boardTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글내용" name="boardContent" maxlength="2048" style="height:350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			
			<!--  글쓰기 완료 submit  -->
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>