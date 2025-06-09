<%@page import="user.UserDao"%>
<%@page import="user.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<%
   
   request.setCharacterEncoding("utf-8");
   
   //데이타 읽어서 dto넣기
   UserDto dto=new UserDto();
   String id=request.getParameter("id");
   String name=request.getParameter("name");
   String pass=request.getParameter("password");
   String email=request.getParameter("email");
   String redirect = request.getParameter("redirect");
   if (redirect == null || redirect.equals("")) {
       redirect = "../index.jsp"; // fallback
   }
   int role=0;
   
   dto.setId(id);
   dto.setUsername(name);
   dto.setPassword(pass);
   dto.setEmail(email);
   dto.setRole(role);
   
   //dao_insert
   UserDao dao=new UserDao();
   dao.insertUser(id, name, pass, email, role);
   
   //가입성공페이지로 이동
   response.sendRedirect(redirect);
%>
<body>

</body>
</html>