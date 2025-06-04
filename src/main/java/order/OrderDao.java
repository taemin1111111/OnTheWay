package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class OrderDao {
	DbConnect db = new DbConnect();

	public void insertOrder(OrderDto dto) {
		String sql = "INSERT INTO orders (merchant_uid, imp_uid, userId, userName, email, orderName, orderPrice, created_at) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMerchant_uid());
	        pstmt.setString(2, dto.getImp_uid());
	        pstmt.setString(3, dto.getUserId());
	        pstmt.setString(4, dto.getUserName());
	        pstmt.setString(5, dto.getEmail());
	        pstmt.setString(6, dto.getOrderName());
	        pstmt.setInt(7, dto.getOrderPrice());
	        pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		
	}

}
