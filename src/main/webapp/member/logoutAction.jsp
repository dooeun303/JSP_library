<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body> 

	<!-- 세션 뺏고 'main.jsp'로 이동 -->
	<%
		session.invalidate();
	%>
	
	<script>
		location.href = '../index2.jsp';
	</script>
</body>
</html>