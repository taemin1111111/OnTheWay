package brand;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import mysql.db.DbConnect;


public class BrandDao {
	
	DbConnect db=new DbConnect();

    public Vector<BrandDto> getBrandsByName(String hgName) throws SQLException {
        Vector<BrandDto> brandList = new Vector<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT id, hg_name, brand_name, brand_id FROM hg.hg_brand WHERE hg_name LIKE ?";

        try {
            conn = db.getConnection(); // Get connection from your DbConnect class
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hgName + "%"); // Set the hg_name parameter

            rs = pstmt.executeQuery();

            while (rs.next()) {
                BrandDto brand = new BrandDto();
                brand.setId(rs.getInt("id"));
                brand.setHg_name(rs.getString("hg_name"));
                brand.setBrand_name(rs.getString("brand_name"));
                brand.setBrand_id(rs.getString("brand_id"));
                brandList.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log it
            throw e; // Re-throw the exception so the caller is aware
        } finally {
            db.dbClose(rs, pstmt, conn); // Assuming dbClose handles nulls properly
        }
        return brandList;
    }
 
    }