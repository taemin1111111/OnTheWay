<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>로그인/회원가입</title>
  <link rel="stylesheet" href="login.css" />
</head>
<body>
  <button id="openModalBtn">로그인 / 회원가입</button>

  <div id="loginModal" class="modal">
    <div class="modal-content">
      <span class="close" id="closeModalBtn">&times;</span>

      <div class="tab-buttons">
        <button id="loginTab" class="active">로그인</button>
        <button id="signupTab">회원가입</button>
      </div>

      <form id="loginForm" class="form active">
        <input type="email" placeholder="이메일" required />
        <input type="password" placeholder="비밀번호" required />
        <button type="submit">로그인</button>
        <div class="social-login">
          <button class="kakao">카카오로 로그인</button>
          <button class="naver">네이버로 로그인</button>
          <button class="google">Google로 로그인</button>
        </div>
      </form>

      <form action="REGaction.jsp" method="post" onsubmit="return check(this)">
      	<input type="text" name = 'name' placeholder="이름" required />
        <input type="text" name = 'id' placeholder="아이디" required />
        <input type="email" name = 'email' placeholder="이메일" required />
        <input type="password" name = 'password' placeholder="비밀번호" required />
        <input type="password" placeholder="비밀번호 확인" required />
        <button type="submit">회원가입</button>
      </form>
    </div>
  </div>

  <script src="login.js"></script>
</body>
</html>