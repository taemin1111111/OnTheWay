<%@page import="java.net.URLEncoder"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");
String type = request.getParameter("type");
String hg_id = request.getParameter("hg_id");
String order = request.getParameter("order");

GpaDao dao = new GpaDao();
if ("up".equals(type)) {
    dao.increaseGood(num);
} else if ("down".equals(type)) {
    dao.decreaseGood(num);
}
order = URLEncoder.encode(order, "UTF-8");
String root = request.getContextPath();
response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order);
%>
