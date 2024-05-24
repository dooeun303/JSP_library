<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty name="member" property="memberID" />
<jsp:setProperty name="member" property="memberPW" />

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
		String adminID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if (session.getAttribute("adminID") != null) {
			adminID = (String) session.getAttribute("adminID");
		}
		
		// memberID가 존재한다면, 다시 로그인하지 못하게 main.jsp로 보내기
		if(memberID != null || adminID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.');");
			script.println("location.href = '../index2.jsp'");
			script.println("</script>");
		}
		
		
		// dao 생성 
 		MemberDao memberdao = new MemberDao();
		
		// 로그인 정보 받아오기
		int result = memberdao.login(member.getMemberID(), member.getMemberPW());
		
		if (result == 1) {
			
			// 로그인 성공시 세션값 받아와서 로그인 유지시키기 
			session.setAttribute("memberID", member.getMemberID());
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../index2.jsp'");
			script.println("</script>");
			
		} else if (result == 2) { // 관리자 로그인
			
			// 로그인 성공시 세션값 받아와서 로그인 유지시키기 
			session.setAttribute("adminID", member.getMemberID());
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 로그인에 성공했습니다.');");
			script.println("location.href = '../index2.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.');");
			script.println("history.back()");
			script.println("</script>");
		} 
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.');");
			script.println("history.back()");
			script.println("</script>");
		} 
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back()");
			script.println("</script>");
		} 
	
	%>
</body>
</html>