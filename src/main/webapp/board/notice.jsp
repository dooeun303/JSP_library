<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDao" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="styles.css">
<title>자유게시판</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>

</head>
<body>

	<%
		// member ID = 로그인 되어있는 사람이면 세션값으로 설정, 처음 오는 사람이면 null값으로 설정
		String memberID = null;
		if (session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		
		int pageNumber = 1; // 기본 페이지 1
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<a class="navbar-brand" href="../index2.jsp">순천대 도서관</a>	
		</div>
		
		
		<!-- 네비게이션 바 - 내렸을때 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="navbar-nav">
				<li><a href="index2.jsp">메인</a></li>
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center; ">번호</th>
						<th style="background-color: #eeeeee; text-align: center; ">제목</th>
						<th style="background-color: #eeeeee; text-align: center; ">작성자</th>
						<th style="background-color: #eeeeee; text-align: center; ">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDao boarddao = new BoardDao();
						ArrayList<Board> list = boarddao.getList(pageNumber);
						for (int i=0; i<list.size(); i++) {
					%>
						<tr>
							<td><%= list.get(i).getBoardID() %></td>
							<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"> <%= list.get(i).getBoardTitle() %></a></td>
							<td><%= list.get(i).getMemberID() %></td>
							<td><%= list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11, 13)
								+ "시" + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber - 1%> class="btn btn-success btn-arraw-left">이전</a>
			<% 
				}if (boarddao.nextPage(pageNumber + 1)) {
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber + 1%> class="btn btn-success btn-arraw-left">다음</a>
			<% 
				}
			%>	
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> <!--  관리자세션 접속시 글쓰기 가능 -->
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>