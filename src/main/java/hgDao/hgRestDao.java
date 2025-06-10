package hgDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hgDto.hgRestDto;
import mysql.db.DbConnect;

public class hgRestDao {
	
	DbConnect db=new DbConnect();
	
	public List<hgRestDto> getRestList()
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="SELECT hg.*, hg_data.latitude,hg_data.address, hg_data.id, hg_data.longitude, hg_data.has_lpg_station, hg_data.has_ev_station,hg_data.has_pharmacy\r\n"
				+ "FROM hg\r\n"
				+ "LEFT JOIN hg_data ON hg.tel_no = hg_data.tel_no\r\n"
				+ "WHERE hg_data.id IS NOT NULL;";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
			
				dto.setName(rs.getString("name"));
				dto.setTel_no(rs.getString("tel_no"));
				dto.setAddress(rs.getString("address"));
				dto.setTruck(rs.getInt("truck"));
				dto.setMaintenance(rs.getInt("maintenance"));
				dto.setLatitude(rs.getDouble("latitude"));
				dto.setLongitude(rs.getDouble("longitude"));
				dto.setId2(rs.getInt("id"));
				dto.setLpg(rs.getString("has_lpg_station"));
				dto.setEv(rs.getString("has_ev_station"));
				dto.setPharm(rs.getString("has_pharmacy"));
				
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
	
	public List<hgRestDto> getData(String searchName, String lpg, String ev, String pharm)
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//String sql="select * from hg.hg where name LIKE ?";
		/*String sql="SELECT hg.*, hg_data.latitude, hg_data.longitude, hg_data.id, hg_data.has_lpg_station, hg_data.has_ev_station,hg_data.has_pharmacy FROM hg LEFT JOIN hg_data ON hg.tel_no = hg_data.tel_no where hg_data.id IS NOT NULL and name LIKE ?;";*/
		String sql = "SELECT hg.*, hg_data.latitude, hg_data.address, hg_data.id, hg_data.longitude, hg_data.has_lpg_station, hg_data.has_ev_station, hg_data.has_pharmacy "
		           + "FROM hg "
		           + "LEFT JOIN hg_data ON hg.tel_no = hg_data.tel_no "
		           + "WHERE hg_data.id IS NOT NULL and name LIKE ? ";	
		
		if("Y".equals(lpg)) {
		    sql += "AND hg_data.has_lpg_station = 'Y' ";
		}
		if("Y".equals(ev)) {
		    sql += "AND hg_data.has_ev_station = 'Y' ";
		}
		if("Y".equals(pharm)) {
		    sql += "AND hg_data.has_pharmacy = 'Y' ";
		}
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchName + "%");
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
				
				dto.setName(rs.getString("name"));
				dto.setTel_no(rs.getString("tel_no"));
				dto.setAddress(rs.getString("address"));
				dto.setLatitude(rs.getDouble("latitude"));
				dto.setLongitude(rs.getDouble("longitude"));
				dto.setId2(rs.getInt("id"));
				dto.setLpg(rs.getString("has_lpg_station"));
				dto.setEv(rs.getString("has_ev_station"));
				dto.setPharm(rs.getString("has_pharmacy"));
				
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
				
				
				
				dto.setAddress(rs.getString("addr"));
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
	
	
	public List<hgRestDto> getLpgList(String lpg, String ev, String pharm)
	{
		List<hgRestDto> list=new ArrayList<hgRestDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql = "SELECT hg.*, hg_data.latitude, hg_data.address, hg_data.id, hg_data.longitude, hg_data.has_lpg_station, hg_data.has_ev_station, hg_data.has_pharmacy "
		           + "FROM hg "
		           + "LEFT JOIN hg_data ON hg.tel_no = hg_data.tel_no "
		           + "WHERE hg_data.id IS NOT NULL ";
		/*if(lpg.equals("Y")&&ev.equals("Y")&&pharm.equals("Y")) {
			sql+="AND hg_data.has_lpg_station = 'Y' AND hg_data.has_ev_station = 'Y' AND hg_data.has_pharmacy = 'Y'";
		}
		else if(lpg.equals("Y")&&ev.equals("Y")&&pharm.equals("N")) {
			sql+="AND hg_data.has_lpg_station = 'Y' AND hg_data.has_ev_station = 'Y' AND hg_data.has_pharmacy = 'N'   ";
		}
		else if(lpg.equals("Y")&&ev.equals("N")&&pharm.equals("Y")) {
			sql+="AND hg_data.has_lpg_station = 'Y' AND hg_data.has_ev_station = 'N' AND hg_data.has_pharmacy = 'Y'   ";
		}
		else if(lpg.equals("Y")&&ev.equals("N")&&pharm.equals("N")) {
			sql+="AND hg_data.has_lpg_station = 'Y' AND hg_data.has_ev_station = 'N' AND hg_data.has_pharmacy = 'N'   ";
		}
		else if(lpg.equals("N")&&ev.equals("Y")&&pharm.equals("N")) {
			sql+="AND hg_data.has_lpg_station = 'N' AND hg_data.has_ev_station = 'Y' AND hg_data.has_pharmacy = 'N'   ";
		}
		else if(lpg.equals("N")&&ev.equals("N")&&pharm.equals("N")) {
			sql+="AND hg_data.has_lpg_station = 'N' AND hg_data.has_ev_station = 'N' AND hg_data.has_pharmacy = 'N'   ";
		}
		else if(lpg.equals("N")&&ev.equals("Y")&&pharm.equals("Y")) {
			sql+="AND hg_data.has_lpg_station = 'N' AND hg_data.has_ev_station = 'Y' AND hg_data.has_pharmacy = 'Y'   ";
		}
		else if(lpg.equals("N")&&ev.equals("N")&&pharm.equals("Y")) {
			sql+="AND hg_data.has_lpg_station = 'N' AND hg_data.has_ev_station = 'N' AND hg_data.has_pharmacy = 'Y'   ";
		}*/
		
		if("Y".equals(lpg)) {
		    sql += "AND hg_data.has_lpg_station = 'Y' ";
		}
		if("Y".equals(ev)) {
		    sql += "AND hg_data.has_ev_station = 'Y' ";
		}
		if("Y".equals(pharm)) {
		    sql += "AND hg_data.has_pharmacy = 'Y' ";
		}
		
		
		
		
		
		
		
		
		
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				hgRestDto dto=new hgRestDto();
				
			
				dto.setName(rs.getString("name"));
				dto.setTel_no(rs.getString("tel_no"));
				//dto.setAddr(rs.getString("addr"));
				dto.setTruck(rs.getInt("truck"));
				dto.setMaintenance(rs.getInt("maintenance"));
				dto.setLatitude(rs.getDouble("latitude"));
				dto.setLongitude(rs.getDouble("longitude"));
				dto.setId2(rs.getInt("id"));
				dto.setLpg(rs.getString("has_lpg_station"));
				dto.setEv(rs.getString("has_ev_station"));
				dto.setPharm(rs.getString("has_pharmacy"));
				dto.setAddress(rs.getString("address"));
				
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
