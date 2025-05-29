package GpaData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class GpaDao {
DbConnect db=new DbConnect();

public void insertGpa(GpaDto dto){
	
	Connection conn=db.getConnection();
	PreparedStatement pstmt=null;
	
	
	String sql="insert into review values(null,null,?,?,?,0,now())";
	try {
		pstmt=conn.prepareStatement(sql);
		//서울만남(부산)휴게소
		pstmt.setString(1, "서울만남(부산)휴게소");
		pstmt.setDouble(2, dto.getStars());
		pstmt.setString(3, dto.getContent());
		pstmt.execute();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		db.dbClose(pstmt, conn);
	}
}
	
	
public List<GpaDto> getAllGpa() {
    List<GpaDto> list = new ArrayList<>();
    Connection conn = db.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "SELECT * FROM review ORDER BY num DESC";

    try {
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            GpaDto dto = new GpaDto();

            dto.setNum(rs.getString("num"));
            dto.setUserid(rs.getString("user_id"));         // null일 수 있음
            dto.setHgName(rs.getString("hg_name")); // null일 수 있음
            dto.setStars(rs.getDouble("stars"));
            dto.setContent(rs.getString("content"));
            dto.setGood(rs.getInt("good"));
            dto.setWriteday(rs.getTimestamp("writeday"));

            list.add(dto);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        db.dbClose(rs, pstmt, conn);
    }

    return list;
}
//평균 평점 구하는 메서드
public double getAverageStars() {
 double avg = 0;
 Connection conn = db.getConnection();
 PreparedStatement pstmt = null;
 ResultSet rs = null;

 String sql = "SELECT AVG(stars) AS avg_star FROM review";

 try {
     pstmt = conn.prepareStatement(sql);
     rs = pstmt.executeQuery();
     if (rs.next()) {
         avg = rs.getDouble("avg_star");
     }
 } catch (SQLException e) {
     e.printStackTrace();
 } finally {
     db.dbClose(rs, pstmt, conn);
 }

 return avg;
}
//평점 갯수 
public int getTotalCount() {
    int count = 0;
    Connection conn = db.getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "select count(*) from review";

    try {
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        db.dbClose(rs, pstmt, conn);
    }

    return count;
}
//추천수 +1
public void increaseGood(String num) {
 Connection conn = db.getConnection();
 PreparedStatement pstmt = null;

 String sql = "UPDATE review SET good = good + 1 WHERE num = ?";
 try {
     pstmt = conn.prepareStatement(sql);
     pstmt.setString(1, num);
     pstmt.executeUpdate();
 } catch (SQLException e) {
     e.printStackTrace();
 } finally {
     db.dbClose(pstmt, conn);
 }
}

//추천수 -1
public void decreaseGood(String num) {
 Connection conn = db.getConnection();
 PreparedStatement pstmt = null;

 String sql = "UPDATE review SET good = good - 1 WHERE num = ?";
 try {
     pstmt = conn.prepareStatement(sql);
     pstmt.setString(1, num);
     pstmt.executeUpdate();
 } catch (SQLException e) {
     e.printStackTrace();
 } finally {
     db.dbClose(pstmt, conn);
 }
}

}

