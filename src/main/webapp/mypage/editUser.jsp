<%@ page import="user.UserDao" %>
<%@ page import="user.UserDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
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
    response.sendRedirect(request.getContextPath() + "/index.jsp?main=/mypage/mypage.jsp?error=notfound");
    return;
}

// 1. 비밀번호 확인
if (!user.getPassword().equals(oldPass)) {
	String message = "비밀번호가 틀렸습니다."; // 전달할 메시지
	String encodedMessage = URLEncoder.encode(message, "UTF-8"); // UTF-8로 인코딩
	response.sendRedirect(request.getContextPath() + "/index.jsp?main=/mypage/mypage.jsp?error=" + encodedMessage);
    return;
}

// 2. 비밀번호 변경 여부 확인
String finalPassword = user.getPassword(); // 기본은 기존 비밀번호
if (newPass != null && !newPass.isEmpty()) {
    if (!newPass.equals(newPassConfirm)) {
    	String message = "새로운 비밀번호가 일치하지 않습니다."; // 전달할 메시지
    	String encodedMessage = URLEncoder.encode(message, "UTF-8"); // UTF-8로 인코딩
    	response.sendRedirect(request.getContextPath() + "/index.jsp?main=/mypage/mypage.jsp?error=" + encodedMessage);
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
String message = "회원 정보가 성공적으로 수정되었습니다."; // 전달할 메시지
String encodedMessage = URLEncoder.encode(message, "UTF-8"); // UTF-8로 인코딩
response.sendRedirect(request.getContextPath() + "/index.jsp?main=/mypage/mypage.jsp?success=" + encodedMessage);
%>