<%@page import="member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>순천시립도서관</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="styles.css"> 
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
	%>
 
  <header>
  <!-- 맨위에 바 (세션에 따라 로그인/회원가입 & 마이페이지) -->
    <div class="top-bar">
	  		<%	
				// 로그인 안 되어 있을 때는? 네비게이션 바에 접속, 로그인, 회원가입이 보이게 
				if((memberID == null)&(adminID == null)) {
			%>
				  <a href="index2.jsp">도서관홈</a>
			      <a href="member/login2.jsp">로그인</a>
 			      <a href="member/join2.jsp">회원가입</a>
			<%
				// 회원 로그인 되어있을 때는?
				} else if (memberID != null){
			%>
			
				<a href="index2.jsp">도서관홈</a>
				<a href="mypage.jsp" role="button" aria-haspopup="true"
						aria-expanded="false">(마이페이지)<span class="caret"></span></a>
				<a href="member/logoutAction.jsp">로그아웃</a>


			<%
				// 관리자 로그인 되어 있을 때는? 네비게이션 바에 회원관리, 로그아웃이 보이게ㅁ
				} else if (adminID != null) {
			%>
			
				<a href="index2.jsp">도서관홈</a>
				<a href="adminpage.jsp" role="button" aria-haspopup="true"
						aria-expanded="false">(관리자페이지)<span class="caret"></span></a>
				<a href="member/logoutAction.jsp">로그아웃</a>

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
      
      <form method="post" action="search.jsp">
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
      <li><a href="guide.jsp">(이용안내)</a></li>
      <li><a href="board/notice.jsp">(공지사항)</a></li>
      <li><a href="board/board.jsp">자유게시판</a></li>
      <li><a href="recommend.jsp">(추천도서)</a></li>
    </ul>
  </nav>


<!-- 사진 -->
  <section class="hero">
    <img src="background.png" alt="Library Background">
  </section>

  <footer>
    <div class="footer-content">
      <p>개인정보처리방침 | 이메일무단수집거부</p>
      <div class="footer-info">
        <p>순천도서관</p>
        <a href="https://www.scnu.ac.kr/SCNU/main.do">순천대 바로가기</a>
        <p>순천시 중앙로 232(석현동) | 061-749-6691</p>
        <!-- 여기에 추가 정보를 넣으세요 -->
      </div>
    </div>
  </footer>
</body>
</jsp>