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
    // AJAX에서 success 콜백을 위해 문자열로 응답
    out.print("ok");
%>
