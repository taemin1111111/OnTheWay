<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");
String type = request.getParameter("type"); // "up" 또는 "down"

GpaDao dao = new GpaDao();
if ("up".equals(type)) {
    dao.increaseGood(num);
} else if ("down".equals(type)) {
    dao.decreaseGood(num);
}

// 다시 후기 페이지로 리다이렉트
response.sendRedirect("gpa.jsp");
%>
