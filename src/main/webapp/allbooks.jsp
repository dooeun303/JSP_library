<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" %>
<%@ page import="books.Books" %>
<%@ page import="books.BooksDao" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 도서 조회</title>
</head>
<body>

<h1>전체 도서 출력</h1>

<%
    request.setCharacterEncoding("utf-8");
    String name_1 = request.getParameter("name");
    Books books = new Books();
    books.setBookName(name_1);
    BooksDao dao = new BooksDao();
    List booksList = dao.listbooks(books);
%>

<table border=1 style="width:800px;align:center">
    <tr align=center bgcolor="#FFFF66">
        <th>아이디</th>
        <th>비밀번호</th>
        <th>이름</th>
        <th>이메일</th> 
    </tr>
    <%
        for(int i=0; i<booksList.size(); i++){
            Books bo = (Books) booksList.get(i);
            String id = bo.getBookID();
            String name = bo.getBookName();
            String writer = bo.getBookWriter();
            String publisher = bo.getBookPublisher();
    %>
    
    <tr align="center">
        <td><%= id %></td>
        <td><%= name %></td>
        <td><%= writer %></td>
        <td><%= publisher %></td>
    </tr>
    <%    
        }
    %>
</table>


</body>
</html>