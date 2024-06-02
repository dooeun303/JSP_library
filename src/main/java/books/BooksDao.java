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
	public List listbooks(Books books) {
		List<Books> booksList = new ArrayList<Books>();
		String name_1 = books.getBookName();
		try {
			String SQL = "select * from books";
			
			if((name_1 != null && name_1.length() != 0)) {
				SQL += " where book_name=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, name_1);
			} else {
				pstmt = conn.prepareStatement(SQL);
			}
			ResultSet rs = pstmt.executeQuery();
            
			while(rs.next()) {
                String b1 = rs.getString("book_id");
                String b2 = rs.getString("book_name");
                String b3 = rs.getString("book_writer");
                String b4 = rs.getString("book_publisher");
                
            	Books bo = new Books();
                bo.setBookID(b1);
                bo.setBookName(b2);
                bo.setBookWriter(b3);
                bo.setBookPublisher(b4);
                
                booksList.add(bo);
            }
			rs.close();
			pstmt.close();
			conn.close();
                
		} catch (Exception e) {
			e.printStackTrace();
		}
		return booksList;
	}
	
}
