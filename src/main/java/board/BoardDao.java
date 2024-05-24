package board;

import java.sql.*;
import java.util.ArrayList;

public class BoardDao {

	public Connection conn = null;
//	public PreparedStatement pstmt = null;
	public ResultSet rs = null;
	
	public BoardDao() throws ClassNotFoundException, SQLException {

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
	
	
	// 날짜 가져오기 
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB오류
	}
	
	
	// 다음 가져오기 (게시글 번호)
	public int getNext() {
		String SQL = "SELECT board_id FROM board ORDER BY board_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			
		} catch (Exception e) { // 첫 번째 게시물인 경우
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
	
	
	// 작성
	public int write(String boardTitle, String memberID, String boardContent) {
		String SQL = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, memberID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) { // 첫 번째 게시물인 경우
			e.printStackTrace();
		}
		return -1; // DB오류
		
	}
	
	
	// 글 목록
	public ArrayList<Board> getList(int pageNumber) {
		
		String SQL = "SELECT * FROM board WHERE board_id < ? "
				+ "AND board_available = 1 ORDER BY board_id DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 6이란 값이 나옴(?)
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setMemberID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				list.add(board);
			}
			
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return list;
		
	}
	
	
	// 페이징처리: 10단위로 끊김 -> 게시글이 10개라면 다음 페이지가 없음.
	public boolean nextPage(int pageNumber) {

		String SQL = "SELECT * FROM board WHERE board_id < ? AND board_available = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 6이란 값이 나옴(?)
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; // 다음 페이지가 있으면 true
			}
			
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return false; // 다음 페이지 없으면 false
	}
	
	
	// 게시글 보기
	public Board getBoard(int boardID) {

		// board_id로 board 객체 검색
		String SQL = "SELECT * FROM board WHERE board_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			
			// 
			if (rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setMemberID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				return board;
			}
			
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return null; // 다음 페이지 없으면 false
	}
	
	
	// 게시글 수정
	public int update(int boardID, String boardTitle, String boardContent) {
		String SQL = "UPDATE board SET board_title = ?, board_content = ? WHERE board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID);
			
			return pstmt.executeUpdate();
			 
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
	
	// 게시글 삭제
	public int delete(int boardID) {
		String SQL = "UPDATE board SET board_available = 0 WHERE board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
			 
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return -1; // DB오류
	}
	
}