<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty name="member" property="memberID" />
<jsp:setProperty name="member" property="memberPW" />
<jsp:setProperty name="member" property="memberName" />
<jsp:setProperty name="member" property="memberSN" />
<jsp:setProperty name="member" property="birthDate" />

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
		if (session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		
		// memberID가 존재한다면, 다시 가입하지 못하게 main.jsp로 보내기
		if (memberID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.');");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	
		// 입력 안 된 사항 있으면 창 띄우기
		if (member.getMemberID() == null || member.getMemberPW() == null || member.getMemberName() == null || member.getMemberSN() <= 0 ||
			member.getBirthDate() == null ) {
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back()");
			script.println("</script>");
			
		} else {
			
			// dao 생성
			MemberDao memberdao = new MemberDao();
		
			// join() 함수 실행시켜서 각 values값들 빈으로 받아서 SQL문 실행
			int result = memberdao.join(member);
			
			// pk인 id가 중복될 때 오류 발생
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다. DB오류가 발생했습니다.');");
				script.println("history.back()");
				script.println("</script>");
			} 
			
			// 가입 성공시 'main.jsp'로 넘어가기
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('가입에 성공했습니다!');");
				script.println("location.href = 'index2.jsp'");
				script.println("</script>");
			} 
			
		}

	
	%>
</body>
</html>