<%@page import="java.sql.Date"%>
<%@page import="event.EventDao"%>
<%@page import="event.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");

    // 폼 데이터 받기
    String hgId = request.getParameter("hgId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String startday = request.getParameter("startday");
    String endday = request.getParameter("endday");
    String photo = request.getParameter("photoFilename");

    // DTO에 데이터 세팅
    EventDto dto = new EventDto();
    dto.setHgId(hgId);
    dto.setTitle(title);
    dto.setContent(content);
    dto.setStartday(startday);
    dto.setEndday(endday);
    dto.setPhoto(photo);

    // DAO를 통해 DB에 삽입
    EventDao dao = new EventDao();
    dao.insertEvent(dto);

 	// 리다이렉트
 	response.sendRedirect("../index.jsp?main=event/eventList.jsp");
%>
