package hg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
// No longer need Vector as we expect a single DTO or null
// No longer need brand.brandDto
import mysql.db.DbConnect;

public class HgDao {

    DbConnect db = new DbConnect();

    public HgDto getHgByName(String hgNameParam) throws SQLException {
        HgDto hg = null; 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM hg.hg WHERE name = ?";

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hgNameParam); 

            rs = pstmt.executeQuery();

            if (rs.next()) {
                hg = new HgDto(); 
                
                hg.setId(rs.getString("id"));
                hg.setName(rs.getString("name"));
                hg.setTel_no(rs.getString("tel_no"));
                hg.setAddr(rs.getString("addr"));
                hg.setTruck(rs.getBoolean("truck"));
                hg.setMaintenance(rs.getBoolean("maintenance"));
                
            }
        } catch (SQLException e) {
            System.err.println("Error fetching hg by name '" + hgNameParam + "': " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            db.dbClose(rs, pstmt, conn); 
        }
        return hg;
    }
    
    public HgDto getHgByID(String hgIdParam) throws SQLException {
        HgDto hg = null; 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM hg.hg WHERE id = ?";

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hgIdParam); 

            rs = pstmt.executeQuery();

            if (rs.next()) {
                hg = new HgDto(); 
                
                hg.setId(rs.getString("id"));
                hg.setName(rs.getString("name"));
                hg.setTel_no(rs.getString("tel_no"));
                hg.setAddr(rs.getString("addr"));
                hg.setTruck(rs.getBoolean("truck"));
                hg.setMaintenance(rs.getBoolean("maintenance"));
                
            }
        } catch (SQLException e) {
            System.err.println("Error fetching hg by name '" + hgIdParam + "': " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            db.dbClose(rs, pstmt, conn); 
        }
        return hg;
    }

}