<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="boardTitle" />
<jsp:setProperty name="board" property="boardContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		// memberID의 세션값이 존재한다면, memberID를 받아온 세션값으로 설정
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		
		// memberID가 없다면, login 페이지로 보내기
		if(memberID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.');");
			script.println("location.href = 'login2.jsp'");
			script.println("</script>");
		} else {
			// login 되어 있으면
			// 입력 안 된 사항 있으면 창 띄우기
			if (board.getBoardTitle() == null || board.getBoardContent() == null) {
	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.');");
				script.println("history.back()");
				script.println("</script>");
				
			} else {
				
				// dao 생성
				BoardDao memberdao = new BoardDao();
			
				// join() 함수 실행시켜서 각 values값들 빈으로 받아서 SQL문 실행
				int result = memberdao.write(board.getBoardTitle(), memberID, board.getBoardContent());
				
				// pk인 id가 중복될 때 오류 발생
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.');");
					script.println("history.back()");
					script.println("</script>");
				} 
				
				// 글쓰기 성공시 'board.jsp'로 넘어가기
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				} 
				
			}
				
			}
	


	
	%>
</body>
</html>