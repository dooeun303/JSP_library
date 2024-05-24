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
		
		// memberID 없으면 (로그인 안되어있으면) 로그인페이지로 보내기
		if (memberID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요!');");
			script.println("location.href = 'login2.jsp'");
			script.println("</script>");
			
		}
		
		// boardID 글 번호를 가져옴
		int boardID = 0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		// boardID가 0이면(글이 존재하지 않으면) 널 값 취급하여 유효하지 않다고 알람주기
		if (boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		
		}
		
		Board board = new BoardDao().getBoard(boardID);
		// 회원 ID와 게시글 작성자ID 가 다르면 권한 없다고 알람주기
		if (!memberID.equals(board.getMemberID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.');");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
				<!-- 당연히 로그인 되어 있는 것으로 간주함 -->
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
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
		<form method="post" action="updateAction.jsp?boardID=<%= boardID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			
				<!-- 테이블 제목 -->
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center; ">게시판 글수정 양식</th>

					</tr>
				</thead>
				
				<!-- 테이블 내용 -->
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글제목" name="boardTitle" maxlength="50" value="<%= board.getBoardTitle()%>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글내용" name="boardContent" maxlength="2048" style="height:350px;"> <%= board.getBoardContent()%></textarea></td>
					</tr>
				</tbody>
			</table>
			
			<!--  글쓰기 완료 submit  -->
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
		</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>