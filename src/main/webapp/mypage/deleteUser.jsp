<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dao" class="user.UserDao" />



<%
    request.setCharacterEncoding("UTF-8");
    String password = request.getParameter("password");
    String userId = (String) session.getAttribute("userId");
    
    System.out.println("deleteUser.jsp called");
    System.out.println("password: " + password);
    System.out.println("userId: " + userId);

    if (dao.isPasswordCorrect(userId, password)) {
        dao.deleteUser(userId);
        session.invalidate();
        response.sendRedirect(request.getContextPath()+"");
       
    } else {
    	response.sendRedirect(request.getContextPath() + "/mypage/mypage.jsp?error=" + URLEncoder.encode("비밀번호가 틀렸습니다.", "UTF-8"));	
    }
%>