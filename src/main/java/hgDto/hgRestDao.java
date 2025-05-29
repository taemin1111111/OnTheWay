package hgDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hgDao.hgRestDto;
import mysql.db.DbConnect;

public class hgRestDao {
	
	DbConnect db=new DbConnect();
	
	public List<hgRestDto> getRestList()
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from hg";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTel_no(rs.getString("tel_no"));
				dto.setAddr(rs.getString("addr"));
				dto.setTruck(rs.getInt("truck"));
				dto.setMaintenance(rs.getInt("maintenance"));
				
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
	
	public String getReview() {
		
		int rnd=0;
		String star="";
		
		
		rnd=(int)(Math.random()*3)+3;
		
		switch(rnd)
		{
		case 1:
			star="★☆☆☆☆";
			break;
			
		case 2:
			star="★★☆☆☆";
			break;
			
		case 3:
			star="★★★☆☆";
			break;
			
		case 4:
			star="★★★★☆";
			break;
			
		case 5:
			star="★★★★★";
			break;
		}
		
		
		
		
		
		
		
		
		
		return star;
		
	}
	
	public List<hgRestDto> getData(String searchName)
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from hg.hg where name LIKE ?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchName + "%");
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
				
				dto.setName(rs.getString("name"));
				dto.setTel_no(rs.getString("tel_no"));
				dto.setAddr(rs.getString("addr"));
				dto.setTruck(rs.getInt("truck"));
				dto.setMaintenance(rs.getInt("maintenance"));
				
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
	
	public List<hgRestDto> getRestAddrList()
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select addr, name from hg";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
				
				
				dto.setAddr(rs.getString("addr"));
				dto.setName(rs.getString("name"));
				
				
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
	
	
	
	
	
	
	
	
	

}
