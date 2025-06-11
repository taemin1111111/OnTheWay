package event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class EventDao {

	DbConnect db = new DbConnect();

	// 이벤트 DB 삽입 쿼리 
	public void insertEvent(EventDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO event (hg_id, title, content, photo, startday, endday, created_at) "
				+ "VALUES (?, ?, ?, ?, ?, ?, NOW())";

		try {
			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getHgId());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhoto());
			pstmt.setString(5, dto.getStartday());
			pstmt.setString(6, dto.getEndday());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	// 전체 이벤트 데이터 반환
	public List<EventDto> getAllEvents() {
		List<EventDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM event ORDER BY id DESC";

		try {
			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				EventDto dto = new EventDto();

				dto.setId(rs.getString("id")); // 컬럼명이 id면
				dto.setHgId(rs.getString("hg_id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPhoto(rs.getString("photo"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setCreatedAt(rs.getTimestamp("created_at")); // created_at이 datetime or timestamp면

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return list;
	}

	// 이벤트 data 하나 반환
	public EventDto getEventById(String id) {
		EventDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM event WHERE id = ?";

		try {
			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new EventDto();
				dto.setId(rs.getString("id"));
				dto.setHgId(rs.getString("hg_id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPhoto(rs.getString("photo"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setCreatedAt(rs.getTimestamp("created_at"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return dto;
	}

	// 이벤트 삭제
	public void deleteEventById(String id) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = db.getConnection();
	        String sql = "DELETE FROM event WHERE id = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(pstmt, conn);
	    }
	}
	
}
