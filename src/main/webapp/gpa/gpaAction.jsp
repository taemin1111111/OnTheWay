<%@page import="GpaData.GpaDto"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="GpaData.GpaDao"/>
<jsp:useBean id="dto" class="GpaData.GpaDto"/>
<jsp:setProperty property="*" name="dto"/>
<%
    dao.insertGpa(dto);
    response.sendRedirect("gpa.jsp?success=1"); 
%>

