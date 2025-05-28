package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class UserDao {
	
		DbConnect db = new DbConnect();
		
	    public boolean isValidUser(String username, String password) {
	        boolean isValid = false;

	        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            conn = db.getConnection();
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, username);
	            pstmt.setString(2, password);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                isValid = true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            db.dbClose(rs, pstmt, conn);
	        }

	        return isValid;
	    }
	}
