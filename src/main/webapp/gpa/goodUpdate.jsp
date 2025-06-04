<%@page import="java.net.URLEncoder"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");
String hg_id = request.getParameter("hg_id");
String order = request.getParameter("order");
String userid = (String) session.getAttribute("userId");

GpaDao dao = new GpaDao();

String root = request.getContextPath();
order = URLEncoder.encode(order, "UTF-8");

if (userid != null && !"".equals(userid)) {
    if (!dao.hasUserRecommended(userid, num)) {
        dao.addRecommendation(userid, num);
    } else {
        // 이미 추천한 경우
        response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order + "&already=1");
        return;
    }
}

response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order);
%>
