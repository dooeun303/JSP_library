<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDao" %>
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
		
		// boardID 글 번호를 가져옴
		int boardID = 0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		// boardID가 0이면 널 값 취급하여 유효하지 않다고 알람주기
		if (boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
			
		}
		
		// boardID 가져온 번호로 board 객체 생성
		Board board = new BoardDao().getBoard(boardID);
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
			<a class="navbar-brand" href="index2.jsp">순천대 도서관</a>	
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
		
			<!-- 테이블 제목 -->
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center; ">게시판 글보기 양식</th>

				</tr>
			</thead>
			
			<!-- 테이블 내용 -->
			<tbody>
				<tr>
					<td style="width: 20%;">글제목</td>
					<td colspan="2"><%= board.getBoardTitle() %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="2"><%= board.getMemberID() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%= board.getBoardDate().substring(0, 11) + board.getBoardDate().substring(11, 13)
								+ "시" + board.getBoardDate().substring(14, 16) + "분" %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
			</tbody>
		</table>
	
		
		<!-- 글 작성자 관리자라면? 수정하기 -->
		<%
			if(memberID != null && memberID.equals(board.getMemberID())) {
		%>
				<a href="update.jsp?boardID=<%= boardID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardID=<%= boardID %>" class="btn btn-primary">삭제</a>
		<%
			}
		%>


		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>