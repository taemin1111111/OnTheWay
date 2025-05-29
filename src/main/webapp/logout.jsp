<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    session.invalidate();  // 세션 전체 삭제
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
</head>
<body>
    <h2>로그아웃 되었습니다</h2>
    <p>세션이 초기화되었습니다.</p>
    <a href="loginTest.jsp">[로그인 페이지로 이동]</a>
</body>
</html>
