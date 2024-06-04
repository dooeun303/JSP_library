<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

		try {
			// DB 연결
			String url = "jdbc:mariadb://codingmaker.net:33060/silverju00";
			String user = "silverju00";
			String password = "0000";

			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("데이터베이스 연결이 성공했습니다.");	

		} catch (SQLException ex) {
			System.out.println("데이터베이스 연결이 실패했습니다. <br>");
			System.out.println("SQLException: " + ex.getMessage());
			
		} finally {
//			if (conn != null)
//				conn.close();
		}
 
	%>