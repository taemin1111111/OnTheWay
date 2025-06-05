<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="hgDto.infoDto"%>
<%@page import="hgDao.infoDao"%>
<%@page import="java.sql.Date"%>
<%@page import="event.EventDao"%>
<%@page import="event.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
	String uploadPath = application.getRealPath("/infoimage"); // 실제 물리적 경로
	MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());

	String fileName = multi.getFilesystemName("photo");
	String fullFilePath = uploadPath + File.separator + fileName;
	System.out.println("파일 저장 위치: " + fullFilePath);
	
    // 폼 데이터 받기s
    String hgId = multi.getParameter("hgId");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String photoName = multi.getFilesystemName("photo");

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
