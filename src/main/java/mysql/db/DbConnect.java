package mysql.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DbConnect {

	private String url;
	private String user;
	private String password;

	static final String MySqlDriver = "com.mysql.cj.jdbc.Driver";

	// 생성자 안에 드라이버 넣기
	public DbConnect() {
		try {
			Class.forName(MySqlDriver);

			// config.properties 파일 읽기
			Properties props = new Properties();
			InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties");

			if (input == null) {
				throw new RuntimeException("설정 파일을 찾을 수 없습니다.");
			}

			props.load(input);
			url = props.getProperty("db.url");
			user = props.getProperty("db.user");
			password = props.getProperty("db.password");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB 설정 로딩 실패: " + e.getMessage());
		}
	}

	// 오라클계정연결
	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("Mysql 연결 성공!!!");
		} catch (SQLException e) {
			System.out.println("Mysql 연결 실패!!!");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return conn;
	}

	// close 메서드 총4개,오버로딩 메서드
	public void dbClose(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dbClose(Statement stmt, Connection conn) {
		try {

			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dbClose(PreparedStatement pstmt, Connection conn) {
		try {

			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}