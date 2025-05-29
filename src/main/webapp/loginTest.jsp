<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 테스트용 로그인 정보 저장
    session.setAttribute("loginUserId", "testUser123");
    session.setAttribute("loginUserName", "UserName123");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테스트 로그인</title>
</head>
<body>
    <h2>로그인 완료</h2>
    <p>로그인 사용자 ID: <strong><%= session.getAttribute("loginUserId") %></strong></p>
    <p>로그인 사용자 이름: <strong><%= session.getAttribute("loginUserName") %></strong></p>
    <a href="restFoodMenu.jsp">[푸드코트 메뉴로 이동]</a>
    <br><br>
    <a href="logout.jsp">[로그아웃]</a>
</body>
</html>
