<%@page import="hgDto.infoDto"%>
<%@page import="hgDao.infoDao"%>
<%@page import="java.sql.Date"%>
<%@page import="event.EventDao"%>
<%@page import="event.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");

    // 폼 데이터 받기
    String hgId =request.getParameter("hgId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String photoName = request.getParameter("photoFilename");

    /* System.out.println(hgId);
    System.out.println(title);
    System.out.println(content);
    System.out.println(photoName); */
    
    // DTO에 데이터 세팅
    infoDto dto = new infoDto();
    dto.setHgId(hgId);
    dto.setTitle(title);
    dto.setContent(content);
    dto.setPhotoName(photoName);
	
    
    
    
    // DAO를 통해 DB에 삽입
    infoDao dao=new infoDao();
    dao.insertInfo(dto);

 	// 리다이렉트
 	response.sendRedirect("../index.jsp?main=infoList/infoList.jsp");
%>
