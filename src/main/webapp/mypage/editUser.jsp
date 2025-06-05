<%@ page import="user.UserDao" %>
<%@ page import="user.UserDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String userId = (String) session.getAttribute("userId");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String oldPass = request.getParameter("oldPass");
String newPass = request.getParameter("newPass");
String newPassConfirm = request.getParameter("newPassConfirm");


UserDao dao = new UserDao();
UserDto user = dao.getUserSession(userId);

if (user == null) {
    response.sendRedirect(request.getContextPath() + "/mypage/mypage.jsp?error=notfound");
    return;
}

// 1. 비밀번호 확인
if (!user.getPassword().equals(oldPass)) {
    response.sendRedirect(request.getContextPath() + "/mypage/mypage.jsp?error=비밀번호가 틀립니다.");
    return;
}

// 2. 비밀번호 변경 여부 확인
String finalPassword = user.getPassword(); // 기본은 기존 비밀번호
if (newPass != null && !newPass.isEmpty()) {
    if (!newPass.equals(newPassConfirm)) {
        response.sendRedirect(request.getContextPath() + "/mypage/mypage.jsp?error=새로운 비밀번호가 일치하지 않습니다");
        return;
    }
    finalPassword = newPass;
}

// 3. 업데이트
user.setUsername(nickname);
user.setEmail(email);
user.setPassword(finalPassword);

dao.updateUser(user);
System.out.println(dao.toString());	
response.sendRedirect(request.getContextPath() + "/mypage/mypage.jsp?success=1");
%>