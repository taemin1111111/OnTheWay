package GpaData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class GpaDao {
DbConnect db=new DbConnect();

public void insertGpa(GpaDto dto){
	
	Connection conn=db.getConnection();
	PreparedStatement pstmt=null;
	
	
	String sql="insert into review values(null,null,null,?,?,?,now())";
	try {
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, dto.getStars());
		pstmt.setString(2, dto.getContent());
		pstmt.setInt(3, dto.getGood());
		pstmt.execute();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		db.dbClose(pstmt, conn);
	}
}
	
	
	
}

