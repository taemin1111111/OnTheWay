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
        String sql = "INSERT INTO review VALUES (NULL, ?, ?, ?, ?, 0, NOW())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getUserid());
            pstmt.setString(2, dto.getHg_id());
            pstmt.setDouble(3, dto.getStars());
            pstmt.setString(4, dto.getContent());
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

        String sql = "SELECT rest_name FROM hg_data WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hg_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("rest_name");
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

        // 정렬 기준 처리
        String orderBy = "num DESC"; // 기본: 최신순
        if ("추천순".equals(order)) {
            orderBy = "good DESC";
        } else if ("평점 높은순".equals(order)) {
            orderBy = "stars DESC";
        } else if ("평점 낮은순".equals(order)) {
            orderBy = "stars ASC";
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
    //id중복 여부 찾기 이걸로 후기 아이디당 한번만 쓸수있게끔 
    public boolean hasUserRated(String userid, String hg_id) {
        boolean exists = false;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM review WHERE user_id = ? AND hg_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, hg_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return exists;
    }
 //==================굿 아이디당 하나  dao===============================================================
    // 이미 추천했는지 확인
    public boolean hasUserRecommended(String userId, String renum) {
        String sql = "SELECT COUNT(*) FROM good WHERE user_id = ? AND renum = ?";
        boolean exists = false;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, renum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return exists;
    }

    // 추천 기록 추가 + review 테이블 good 수 증가
    public void addRecommendation(String userId, String renum) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        String sql1 = "UPDATE review SET good = good + 1 WHERE num = ?";
        String sql2 = "INSERT INTO good (renum, user_id) VALUES (?, ?)";

        try {
            conn.setAutoCommit(false); // 트랜잭션 처리

            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setString(1, renum);
            pstmt1.executeUpdate();

            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setString(1, renum);
            pstmt2.setString(2, userId);
            pstmt2.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt2, null);
            db.dbClose(pstmt1, conn);
        }
    }
    public void manusRecommendation(String userId, String renum) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        String sql1 = "UPDATE review SET good = good - 1 WHERE num = ?";
        String sql2 = "INSERT INTO good (renum, user_id) VALUES (?, ?)";

        try {
            conn.setAutoCommit(false); // 트랜잭션 처리

            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setString(1, renum);
            pstmt1.executeUpdate();

            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setString(1, renum);
            pstmt2.setString(2, userId);
            pstmt2.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt2, null);
            db.dbClose(pstmt1, conn);
        }
    }
 // 평점 소유자인지 확인
    public boolean isOwnerOfReview(String num, String userid) {
        boolean result = false;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM review WHERE num = ? AND user_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            pstmt.setString(2, userid);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return result;
    }

    // 실제 삭제
    public void deleteGpa(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "DELETE FROM review WHERE num = ?";

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
