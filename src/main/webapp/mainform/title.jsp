<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>고속도로 휴게소 정보</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    nav.navbar {
      background-color: #ffffff !important;
      padding-top: 20px;
      padding-bottom: 20px; 
    }

    .nav-item > a {
      font-size: 20px;
      font-weight: 700;
    }

    .nav-item.dropdown > a::after {
      display: none !important;
    }

    .navbar-nav .dropdown-menu .dropdown-item {
      font-size: 20px;
      padding: 10px 20px;
    }

    .navbar-nav .nav-link {
      transition: background 0.4s ease, color 0.4s ease;
    }

    .navbar-nav .dropdown-menu .dropdown-item:hover,
    .navbar-nav .dropdown-menu .dropdown-item:focus {
      background: linear-gradient(90deg, #f5f5f5, #e0e0e0);
      color: #333 !important;
      border: none;
    }

    .navbar-nav .nav-link.dropdown-toggle:hover,
    .navbar-nav .nav-link.dropdown-toggle:focus {
      background: linear-gradient(90deg, #f5f5f5, #e0e0e0);
      color: #333 !important;
      border-radius: 6px;
    }

    .navbar-nav {
      justify-content: center; /* 중앙 정렬 */
      flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
    }

    #openModalBtn {
      padding: 10px 20px;
      font-size: 16px;
    }

    .modal {
      display: none;
      position: fixed;
      z-index: 9999;
      left: 0; top: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.5);
    }

    .modal-content {
      background: #fff;
      width: 100%;
      max-width: 400px;
      margin: 100px auto;
      padding: 30px;
      border-radius: 10px;
      position: relative;
      box-shadow: 0 0 15px rgba(0,0,0,0.2);
      text-align: center;
    }

    .close {
      position: absolute;
      right: 20px;
      top: 10px;
      font-size: 24px;
      cursor: pointer;
    }

    .tab-buttons {
      display: flex;
      justify-content: center;
      margin-bottom: 20px;
    }

    .tab-buttons button {
      flex: 1;
      padding: 10px;
      border: none;
      cursor: pointer;
      background: #eee;
      font-weight: bold;
    }

    .tab-buttons button.active {
      background: #007BFF;
      color: white;
    }

    .form {
      display: none;
    }

    .form.active {
      display: block;
    }

    input {
      display: block;
      width: 100%;
      max-width: 280px;
      margin: 10px auto;
      padding: 10px;
      box-sizing: border-box;
    }

    button[type="submit"] {
      width: 100%;
      max-width: 280px;
      margin: 10px auto;
      padding: 12px;
      background: #007BFF;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    .social-login {
      margin-top: 20px;
    }

    .social-login button {
      width: 100%;
      max-width: 280px;
      margin: 5px auto;
      padding: 10px;
      border: none;
      border-radius: 4px;
      font-weight: bold;
      cursor: pointer;
    }

    .kakao {
      background: #FEE500;
      color: #3C1E1E;
    }

    .naver {
      background: #03C75A;
      color: white;
    }

    .google {
      background: #DB4437;
      color: white;
    }
  </style>
</head>
<body>

<!-- 상단 네비게이션 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light px-4">
  <div class="container-fluid d-flex align-items-center justify-content-between">
    <div class="d-flex align-items-center">
      <a class="navbar-brand" href="">
        <img src="<%=root%>/image/rogo1.png" style="max-height: 60px;">
      </a>
      <ul class="navbar-nav d-flex flex-row ms-5">
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">교통정보</a>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">휴게소 소개</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">내용1</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">휴게소 찾기</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">휴게소 목록</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">푸드코드 정보</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">푸드코트 메뉴</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">고객센터</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">고객후기</a></li>
          </ul>
        </li>
      </ul>
    </div>
    <%
  String userName = (String) session.getAttribute("userName");
%>

<% if (userName == null) { %>
  <button id="openModalBtn" class="btn btn-primary">로그인 / 회원가입</button>
<% } else { %>
  <div class="d-flex align-items-center">
    <span class="me-3"><strong><%= userName %></strong>님 환영합니다</span>
    <a href="<%=root%>/login/logout.jsp" class="btn btn-outline-secondary">로그아웃</a>
  </div>
<% } %>
  </div>
</nav>

<!-- 로그인/회원가입 모달 -->
<div id="loginModal" class="modal">
  <div class="modal-content">
    <span class="close" id="closeModalBtn">&times;</span>
    <div class="tab-buttons">
      <button id="loginTab" class="active">로그인</button>
      <button id="signupTab">회원가입</button>
    </div>
<!--  -->
    <form id="loginForm" action="<%=root %>/login/loginaction.jsp" method="post" class="form active">
      <input type="text" name="id" placeholder="아이디" required />
      <input type="password" name="password" placeholder="비밀번호" required />
      <button type="submit">로그인</button>
      <div class="social-login">
        <button class="kakao">카카오로 로그인</button>
        <button class="naver">네이버로 로그인</button>
        <button class="google">Google로 로그인</button>
      </div>
    </form>

    <form id="signupForm" action="<%=root %>/login/REGaction.jsp" method="post" class="form" onsubmit="return check(this)">
      <input type="text" name="name" placeholder="이름" required />
      <input type="text" name="id" placeholder="아이디" required />
      <input type="email" name="email" placeholder="이메일" required />
      <input type="password" name="password" placeholder="비밀번호" required />
      <input type="password" name="passwordConfirm" placeholder="비밀번호 확인" required />
      <button type="submit">회원가입</button>
    </form>
  </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // 드롭다운 호버
  document.querySelectorAll('.dropdown-hover').forEach(function(dropdown){
    dropdown.addEventListener('mouseenter', function() {
      let toggle = this.querySelector('.dropdown-toggle');
      let dropdownInstance = bootstrap.Dropdown.getOrCreateInstance(toggle);
      dropdownInstance.show();
    });
    dropdown.addEventListener('mouseleave', function() {
      let toggle = this.querySelector('.dropdown-toggle');
      let dropdownInstance = bootstrap.Dropdown.getOrCreateInstance(toggle);
      dropdownInstance.hide();
    });
  });

  // 로그인 모달
  const modal = document.getElementById("loginModal");
  const openBtn = document.getElementById("openModalBtn");
  const closeBtn = document.getElementById("closeModalBtn");

  openBtn.onclick = () => modal.style.display = "block";
  closeBtn.onclick = () => modal.style.display = "none";
  window.onclick = e => {
    if (e.target === modal) modal.style.display = "none";
  };

  const loginTab = document.getElementById("loginTab");
  const signupTab = document.getElementById("signupTab");
  const loginForm = document.getElementById("loginForm");
  const signupForm = document.getElementById("signupForm");

  loginTab.onclick = () => {
    loginTab.classList.add("active");
    signupTab.classList.remove("active");
    loginForm.classList.add("active");
    signupForm.classList.remove("active");
  };

  signupTab.onclick = () => {
    signupTab.classList.add("active");
    loginTab.classList.remove("active");
    signupForm.classList.add("active");
    loginForm.classList.remove("active");
  };
</script>
</body>
</html>