package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class UserDao {
    DbConnect db = new DbConnect();

    public UserDto getUser(String username, String password) {
        UserDto user = null;
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
                user = new UserDto();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("createdAt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return user;
    }

    public boolean isValidUser(String username, String password) {
        UserDto user = getUser(username, password);
        return user != null;
    }
    public void insertUser(String id, String username, String password, String email, int role) {
        String sql = "INSERT INTO user (userId, username, password, email, role, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, username);
            pstmt.setString(3, password);
            pstmt.setString(4, email);
            pstmt.setInt(5, role);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(null, pstmt, conn);
        }
    }
}