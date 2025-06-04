<%@page import="java.net.URLEncoder"%>
<%@page import="GpaData.GpaDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String num = request.getParameter("num");
    String hg_id = request.getParameter("hg_id");
    String order = request.getParameter("order");

    String userid = (String) session.getAttribute("userId");
    
   
    GpaDao dao = new GpaDao();

    // 유효성 확인: 로그인 상태 + 자기 글만 삭제
    if (userid != null && dao.isOwnerOfReview(num, userid)) {
        dao.deleteGpa(num);
    }

    String root = request.getContextPath();
    order = URLEncoder.encode(order, "UTF-8");

     response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order);
%>
