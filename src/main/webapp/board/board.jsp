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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="styles.css"> 
<link rel="stylesheet" href="css/bootstrap.css">
<title>자유게시판</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>

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
		
		int pageNumber = 1; // 기본 페이지 1
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
  
  
	<p><br></p>
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
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>