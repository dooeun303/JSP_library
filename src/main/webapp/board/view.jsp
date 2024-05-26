<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDao" %>
<%@ page import="member.Member"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> 

<title>게시글 보기 페이지</title>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	<%
		// member ID = 로그인 되어있는 사람이면 세션값으로 설정, 처음 오는 사람이면 null값으로 설정
		String memberID = null;
 		String adminID = null;
		if (session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if (session.getAttribute("adminID") != null) {
			adminID = (String) session.getAttribute("adminID");
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

 <header>
  <!-- 맨위에 바 (세션에 따라 로그인/회원가입 & 마이페이지) -->
    <div class="top-bar">
	  		<%	
				// 로그인 안 되어 있을 때는? 네비게이션 바에 접속, 로그인, 회원가입이 보이게 
				if((memberID == null)&(adminID == null)) {
			%>
				  <a href="../index2.jsp">도서관홈</a>
			      <a href="../member/login2.jsp">로그인</a>
 			      <a href="../member/join2.jsp">회원가입</a>
			<%
				// 회원 로그인 되어있을 때는?
				} else if (memberID != null){
			%>
			
				<a href="../index2.jsp">도서관홈</a>
				<a href="../mypage.jsp" role="button" aria-haspopup="true"
						aria-expanded="false">(마이페이지)<span class="caret"></span></a>
				<a href="../member/logoutAction.jsp">로그아웃</a>


			<%
				// 관리자 로그인 되어 있을 때는? 네비게이션 바에 회원관리, 로그아웃이 보이게ㅁ
				} else if (adminID != null) {
			%>
			
				<a href="../index2.jsp">도서관홈</a>
				<a href="../adminpage.jsp" role="button" aria-haspopup="true"
						aria-expanded="false">(관리자페이지)<span class="caret"></span></a>
				<a href="../member/logoutAction.jsp">로그아웃</a>

			<%
				}
			%>
      <div class="social-icons">
        <!-- 소셜 아이콘들을 여기에 추가하세요 -->
      </div>
    </div>
    
    <!-- 제목 -->
    <div class="title">
      <h1>책속에서 펼쳐지는 꿈, 순천도서관</h1>
      
      <form method="post" action="../search.jsp">
      <div class="input-group mb-3">
  		<input type="text" class="form-control" placeholder="자료를 검색하세요!" aria-label="Search book" aria-describedby="button-addon2">
  		<button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
	  </div>
	  </form>
      
    </div>
  </header>

<!-- 가운데 메인메뉴 -->
  <nav class="main-menu">
    <ul>
      <li><a href="../guide.jsp">이용안내</a></li>
      <li><a href="notice.jsp">(공지사항)</a></li>
      <li><a href="board.jsp">자유게시판</a></li>
      <li><a href="../recommend.jsp">(추천도서)</a></li>
    </ul>
  </nav>
  
  <p></p>

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
		
		<!--  목록버튼   -->
		<a href="board.jsp" class="btn btn-primary">목록</a>
		
		<!-- 글 작성자 자신이라면? 수정하기 -->
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