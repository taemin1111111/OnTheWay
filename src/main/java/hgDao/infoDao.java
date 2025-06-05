package hgDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
		
		String sql="select * from infoboard order by id";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				infoDto dto=new infoDto();
				
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setPhotoName(rs.getString("photoname"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				
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
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setName(rs.getString("name"));
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
	
	

}
