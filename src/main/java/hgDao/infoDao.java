package hgDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import event.EventDto;
import hgDto.infoDto;
import mysql.db.DbConnect;

public class infoDao {
	
	DbConnect db=new DbConnect();
	
	public List<infoDto> getBoardList() //전체리스트
	{
		List<infoDto> list=new ArrayList<infoDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from infoboard";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				infoDto dto=new infoDto();
				
				dto.setId(rs.getInt("id"));
				dto.setHgId(rs.getString("hgId"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));				
				dto.setPhotoName(rs.getString("photoname"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadcount(rs.getInt("readcount"));
				
				list.add(dto);
				
				
				
				
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		

		
		
		return list;
		
	}
	
	
	public infoDto getData(String id) //상세페이지
	{
		infoDto dto=new infoDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from infoboard where id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				dto.setId(rs.getInt("id"));
				dto.setHgId(rs.getString("hgId"));
				dto.setTitle(rs.getString("title"));
				dto.setPhotoName(rs.getString("photoname"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadcount(rs.getInt("readcount"));
				
				
				
				
				
				
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		
		
		
		
		
		return dto;
		
		
		
	}
	
	public void updateReadCount(String id) //조회수
	{
		String sql="update infoboard set readcount=readcount+1 where id=?";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void deleteBoard(String id) //삭제
	{
		String sql="delete from infoboard where id=?";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		
		
	}
	
	
	public void insertInfo(infoDto dto) { //데이터 추가
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;

		String sql = "INSERT INTO infoboard (hgId, title, content, photoname, readcount, writeday) "
				+ "VALUES (?, ?, ?, ?,0, NOW())";

		try {
			pstmt=conn.prepareStatement(sql);

			
			pstmt.setString(1, dto.getHgId());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhotoName());
			
			pstmt.execute();
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public int getTotalCount()
	{
		int n=0;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) from infoboard";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				n=rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}

		return n;
	}
	
	public List<infoDto> getList(int start,int perpage)
	{
		List<infoDto> list=new ArrayList<infoDto>();
		String sql="select * from infoboard limit ?,?";
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);
			//실행
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				infoDto dto=new infoDto();
				dto.setId(rs.getInt("id"));
				dto.setHgId(rs.getString("hgId"));
				dto.setTitle(rs.getString("title"));
				dto.setPhotoName(rs.getString("photoname"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadcount(rs.getInt("readcount"));
				//list 에 추가
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public List<infoDto> searchByRestName(String restName) {
	    List<infoDto> list = new ArrayList<>();
	    Connection conn =db.getConnection();
	    String sql = "SELECT * FROM infoboard WHERE hgId IN (SELECT id FROM hg_data WHERE rest_name LIKE ?)";
	    try (
	    		
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, "%" + restName + "%");
	        ResultSet rs = ps.executeQuery();
	        while(rs.next()) {
	            infoDto dto = new infoDto();
	            // dto 필드 셋팅
	            dto.setId(rs.getInt("id"));
	            dto.setTitle(rs.getString("title"));
	            dto.setWriteday(rs.getTimestamp("writeday"));
	            dto.setReadcount(rs.getInt("readcount"));
	            dto.setHgId(rs.getString("hgId"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	

}
