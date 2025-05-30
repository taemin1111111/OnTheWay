package GpaData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class GpaDao {
    DbConnect db = new DbConnect();

    // 평점 인서트
    public void insertGpa(GpaDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO review VALUES (NULL, NULL, ?, ?, ?, 0, NOW())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getHg_id());
            pstmt.setDouble(2, dto.getStars());
            pstmt.setString(3, dto.getContent());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    // 전체 테스트용
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
                dto.setUserid(rs.getString("user_id"));
                dto.setHg_id(rs.getString("hg_id"));
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

    // 특정 휴게소의 평균 평점 구하기
    public double getAverageStarsByHgId(String hg_id) {
        double avg = 0;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT AVG(stars) AS avg_star FROM review WHERE hg_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hg_id);
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

    // 특정 휴게소의 리뷰 개수 구하기
    public int getCountByHgId(String hg_id) {
        int count = 0;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM review WHERE hg_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hg_id);
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

    // 추천수 +1
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

    // 추천수 -1
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

    // 휴게소 이름 가져오기
    public String getHgName(String hg_id) {
        String name = "";
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT name FROM hg WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hg_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return name;
    }

    // 휴게소별 후기 페이징 및 order순으로 정보 가져오기
    public List<GpaDto> getReviewsByHgIdPaging(String hg_id, int start, int count, String order) {
        List<GpaDto> list = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 🔥 정렬 기준 처리
        String orderBy = "good DESC"; // 기본은 추천순
        if ("추천낮은순".equals(order)) {
            orderBy = "good ASC";
        } else if ("최신순".equals(order)) {
            orderBy = "num DESC";
        }

        String sql = "SELECT * FROM review WHERE hg_id = ? ORDER BY " + orderBy + " LIMIT ?, ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hg_id);
            pstmt.setInt(2, start);
            pstmt.setInt(3, count);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                GpaDto dto = new GpaDto();
                dto.setNum(rs.getString("num"));
                dto.setUserid(rs.getString("user_id"));
                dto.setHg_id(rs.getString("hg_id"));
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

}
