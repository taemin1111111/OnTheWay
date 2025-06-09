<%@page import="java.net.URLEncoder"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String num = request.getParameter("num");       // 리뷰 번호
String hg_id = request.getParameter("hg_id");   // 휴게소 id
String order = request.getParameter("order");   // 정렬 기준
String type = request.getParameter("type");     // up or down
String userid = (String) session.getAttribute("userId");

GpaDao dao = new GpaDao();
String root = request.getContextPath();
order = URLEncoder.encode(order, "UTF-8");

// 이미 추천 기록 있으면 막기
if (userid != null && !"".equals(userid)) {
    if (!dao.hasUserRecommended(userid, num)) {
        if ("up".equals(type)) {
            dao.addRecommendation(userid, num); 
        } else if ("down".equals(type)) {
           
            dao.manusRecommendation(userid, num); 
        }
    } else {
        response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order + "&already=1");
        return;
    }
}

response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order);
%>
