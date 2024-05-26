<%@page import="member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<head>
	<script src="assets/js/color-modes.js"></script>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>이용안내 페이지</title>
	<link rel="stylesheet" href="styles.css"> 
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/jumbotron/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
	<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

 
 	<style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        width: 100%;
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
    </style>
</head>




<body>

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
      <li><a href="guide.jsp">이용안내</a></li>
      <li><a href="board/notice.jsp">(공지사항)</a></li>
      <li><a href="board/board.jsp">자유게시판</a></li>
      <li><a href="recommend.jsp">(추천도서)</a></li>
    </ul>
  </nav>









<main>
  <div class="container py-4">

    <div class="p-5 mb-4 bg-body-tertiary rounded-3" >
      <div class="container-fluid py-5" style="background-color: #DCDCDC; padding: 50px;">
        <h1 class="display-5 fw-bold">대출 & 반납</h1>
        <p class="col-md-8 fs-4">
        - 안내데스크 또는 무인대출반납기에서 대출해주십시오. <br>
      	- 대출기한: 14일 <br>
      	- 대출권수: 7권 <br>
      	- 대출기한 14일을 초과할 시, 연체일수*3일 만큼 대출이 정지됩니다.</p>
       </div>
    </div>

    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 p-5 text-bg-dark border rounded-3" style="margin: 2px;">
          <h2 class="display-5 fw-bold">주소 & 연락처</h2>
          <p>
          - 전라남도 순천시 OOO <br>
          - 061-123-4567
          </p>         
          </div>
      </div>
      
      <div class="col-md-6">
        <div class="h-100 p-5 bg-body-tertiary border rounded-3">
          <h2 class="display-5 fw-bold">운영시간</h2>
          <p>
          - 평일: 09:00 ~ 22:00 <br>
          - 주말: 09:00 ~ 18:00
          </p>
        </div>
      </div>
    </div>

    <footer class="pt-3 mt-4 text-body-secondary border-top">
      &copy; 2024
    </footer>
  </div>
</main>
<script src="assets/dist/js/bootstrap.bundle.min.js"></script>
</body>