package member;

import java.sql.*;

public class MemberDao {

	public Connection conn = null;
	public PreparedStatement pstmt = null;
	public ResultSet rs = null;
	
	public MemberDao() throws ClassNotFoundException, SQLException {

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
	}
	
	
	// 로그인
	public int login(String memberID, String memberPW) {

		String SQL = "SELECT member_pw, is_admin FROM member WHERE member_id = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(memberPW) && (rs.getInt(2)==1)) {
					return 1; // 로그인 성공 
				} else if (rs.getString(1).equals(memberPW) && (rs.getInt(2)==2)){
					return 2; // 관리자 로그인 성공
				} else {
					return 0; // 비번 불일치
				}
			}
			return -1; // ID없음 

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; // DB오류 
	}
	
	
	// 가입 
	public int join(Member member) {
		String SQL = "insert into member values (?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getMemberID());
			pstmt.setString(2, member.getMemberName());
			pstmt.setString(3, member.getMemberPW());
			pstmt.setInt(4, member.getMemberSN());
			pstmt.setString(5, member.getBirthDate());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} return -1; // DB 오류
		
	}
}