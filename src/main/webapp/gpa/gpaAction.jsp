<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="GpaData.GpaDao" />
<jsp:useBean id="dto" class="GpaData.GpaDto" />
<jsp:setProperty property="*" name="dto" />

<%
    String userid = request.getParameter("userid");
    String hg_id = request.getParameter("hg_id");

    String root = request.getContextPath();
    String order = request.getParameter("order");
    order = URLEncoder.encode(order, "UTF-8");

    if (dao.hasUserRated(userid, hg_id)) {
        response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&hg_id=" + hg_id + "&order=" + order + "&duplicate=1");
    } else {
        dao.insertGpa(dto);
        response.sendRedirect(root + "/index.jsp?main=gpa/gpa.jsp&success=1&hg_id=" + hg_id + "&order=" + order);
    }
%>
