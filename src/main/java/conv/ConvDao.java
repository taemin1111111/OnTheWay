package conv;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import mysql.db.DbConnect;

public class ConvDao {
	DbConnect db=new DbConnect();

    public Vector<ConvDto> getConvsByName(String hgName) throws SQLException {
        Vector<ConvDto> brandList = new Vector<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT id, hg_name, conv_name, conv_desc FROM hg.hg_conv WHERE hg_name = ?";

        try {
            conn = db.getConnection(); // Get connection from your DbConnect class
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hgName); // Set the hg_name parameter

            rs = pstmt.executeQuery();

            while (rs.next()) {
            	ConvDto brand = new ConvDto();
                brand.setId(rs.getInt("id"));
                brand.setHg_name(rs.getString("hg_name"));
                brand.setConv_name(rs.getString("conv_name"));
                brand.setConv_desc(rs.getString("conv_desc"));
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
