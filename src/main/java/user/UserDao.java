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
    
    
    public UserDto getUserSession(String username) {
        UserDto user = null;
        String sql = "SELECT * FROM user WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserDto();
                user.setId(rs.getString("userId"));	
                user.setUsername(rs.getString("userName"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return user;
    }

    public boolean isIdPassMember(String m_id, String m_pass) {
        boolean idpass = false;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from user info where userId=? and password=?";

        try {
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, m_id);
           pstmt.setString(2, m_pass);
           rs = pstmt.executeQuery();
           if (rs.next()) {
              idpass = true;
           }

        } catch (SQLException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
        } finally {
           db.dbClose(rs, pstmt, conn);
        }

        return idpass;
     }
    public void insertUser(String id, String username, String password, String email, int role) {
        String sql = "INSERT INTO user (userId, userName, password, email, role, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
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
    
    public boolean isPasswordCorrect(String userId, String password) {
        String sql = "SELECT COUNT(*) FROM user WHERE userId = ? AND password = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void deleteUser(String userId) {
        String sql = "DELETE FROM user WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("User deleted successfully.");
            } else {
                System.out.println("No user found with the given userId.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(null, pstmt, conn);
        }
    }
    
    public void updateUser(UserDto user) {
        String sql = "UPDATE user SET username = ?, email = ?, password = ? WHERE userId = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
        	System.out.println("호출");
        	System.out.println(user.getUsername()+ user.getId());

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getId()); // 반드시 userId 사용

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
 // 아이디 중복 확인
    public boolean isUserIdExists(String userId) {
        String sql = "SELECT COUNT(*) FROM user WHERE userId = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // 이미 존재하면 true 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}