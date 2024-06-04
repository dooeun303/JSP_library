package books;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BooksDao {

	public Connection conn = null;
	public PreparedStatement pstmt = null;
	public ResultSet rs = null;
	
	public BooksDao() throws ClassNotFoundException, SQLException {

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
	
	// 책검색
	public List<Books> allInfo() {
		List<Books> booksList = new ArrayList<Books>();
		String sql = "";
		try {
			sql = "select * from books";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { // rs.next()는 다음값이 존재하는가를 묻는 것임. 값이 있으면 true를 반환하기에 없을때까지 돌 것임.
				// 고로 전체 멤버빈객체를 구성할 정보 긁어옴
				Books books = new Books(); // 반복문 돌때마다 새로운 멤버빈객체를 만들어서 추가해야 하기에 안에서 선언
				books.setBookID(rs.getString("book_id"));
				books.setBookName(rs.getString("book_name"));
				books.setBookWriter(rs.getString("book_writer"));
				books.setBookPublisher(rs.getString("book_publisher"));
				booksList.add(books);


			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return booksList;
	}
}
