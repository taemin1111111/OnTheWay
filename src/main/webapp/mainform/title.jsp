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
      font-family: Arial, sans-serif; /* 기본 글꼴 설정 */
      background: #f4f4f4; /* 배경색 설정 */
      margin: 0; /* 기본 여백 제거 */
      padding: 20px; /* 본문 패딩 설정 */
    }
    nav.navbar {
      background-color: #ffffff !important; /* 네비게이션 바 배경색 설정 */
      padding-top: 20px; /* 상단 패딩 설정 */
      padding-bottom: 20px; /* 하단 패딩 설정 */
      width: 100%; /* 전체 너비 설정 */
    }
    .nav-item > a {
      font-size: 20px; /* 링크 글꼴 크기 설정 */
      font-weight: 700; /* 링크 글꼴 두께 설정 */
    }
    .nav-item.dropdown > a::after {
      display: none !important; /* 드롭다운 화살표 제거 */
    }
    .navbar-nav .dropdown-menu .dropdown-item {
      font-size: 20px; /* 드롭다운 메뉴 아이템 글꼴 크기 설정 */
      padding: 10px 20px; /* 드롭다운 아이템 패딩 설정 */
    }
    .navbar-nav .nav-link {
      transition: background 0.4s ease, color 0.4s ease; /* 링크 호버 효과 설정 */
    }
    .navbar-nav .dropdown-menu .dropdown-item:hover,
    .navbar-nav .dropdown-menu .dropdown-item:focus {
      background: linear-gradient(90deg, #f5f5f5, #e0e0e0); /* 드롭다운 아이템 호버 색상 */
      color: #333 !important; /* 드롭다운 아이템 호버 글자 색상 */
      border: none; /* 드롭다운 아이템 경계 제거 */
    }
    .navbar-nav .nav-link.dropdown-toggle:hover,
    .navbar-nav .nav-link.dropdown-toggle:focus {
      background: linear-gradient(90deg, #f5f5f5, #e0e0e0); /* 드롭다운 링크 호버 색상 */
      color: #333 !important; /* 드롭다운 링크 호버 글자 색상 */
      border-radius: 6px; /* 드롭다운 링크 경계 둥글게 설정 */
    }
    .navbar-nav {
      justify-content: center; /* 중앙 정렬 */
      flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
    }
    #openModalBtn {
      padding: 10px 20px; /* 로그인 버튼 패딩 설정 */
      font-size: 16px; /* 로그인 버튼 글꼴 크기 설정 */
    }
    .modal {
      display: none; /* 모달 기본 숨김 */
      position: fixed; /* 모달 고정 위치 설정 */
      z-index: 9999; /* 모달의 z-index 설정 */
      left: 0; top: 0; /* 모달 위치 설정 */
      width: 100%; height: 100%; /* 모달 크기 설정 */
      background: rgba(0, 0, 0, 0.5); /* 모달 배경 색상 및 투명도 설정 */
    }
    .modal-content {
      background: #fff; /* 모달 내용 배경 색상 설정 */
      width: 100%; /* 모달 내용 너비 설정 */
      max-width: 400px; /* 모달 내용 최대 너비 설정 */
      margin: 100px auto; /* 모달 내용 중앙 정렬 */
      padding: 30px; /* 모달 내용 패딩 설정 */
      border-radius: 10px; /* 모달 내용 경계 둥글게 설정 */
      position: relative; /* 상대 위치 설정 */
      box-shadow: 0 0 15px rgba(0,0,0,0.2); /* 모달 그림자 설정 */
      text-align: center; /* 모달 내용 텍스트 중앙 정렬 */
    }
    .close {
      position: absolute; /* 닫기 버튼 위치 설정 */
      right: 20px; /* 오른쪽 여백 설정 */
      top: 10px; /* 위쪽 여백 설정 */
      font-size: 24px; /* 닫기 버튼 글꼴 크기 설정 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    .tab-buttons {
      display: flex; /* 버튼들을 flexbox로 배치 */
      justify-content: center; /* 버튼 중앙 정렬 */
      margin-bottom: 20px; /* 버튼 아래 여백 설정 */
    }
    .tab-buttons button {
      flex: 1; /* 버튼들 동일한 너비 설정 */
      padding: 10px; /* 버튼 패딩 설정 */
      border: none; /* 버튼 경계 제거 */
      cursor: pointer; /* 커서 포인터로 변경 */
      background: #eee; /* 버튼 배경 색상 설정 */
      font-weight: bold; /* 버튼 글꼴 두께 설정 */
    }
    .tab-buttons button.active {
      background: #007BFF; /* 활성화된 버튼 배경 색상 설정 */
      color: white; /* 활성화된 버튼 글자 색상 설정 */
    }
    .form {
      display: none; /* 기본적으로 폼 숨김 */
    }
    .form.active {
      display: block; /* 활성화된 폼 표시 */
    }
    input {
      display: block; /* 입력 필드 블록 요소로 설정 */
      width: 100%; /* 입력 필드 너비 100% 설정 */
      max-width: 280px; /* 입력 필드 최대 너비 설정 */
      margin: 10px auto; /* 입력 필드 마진 설정 */
      padding: 10px; /* 입력 필드 패딩 설정 */
      box-sizing: border-box; /* 박스 크기 계산 방법 설정 */
    }
    button[type="submit"] {
      width: 100%; /* 제출 버튼 너비 100% 설정 */
      max-width: 280px; /* 제출 버튼 최대 너비 설정 */
      margin: 10px auto; /* 제출 버튼 마진 설정 */
      padding: 12px; /* 제출 버튼 패딩 설정 */
      background: #007BFF; /* 제출 버튼 배경 색상 설정 */
      color: white; /* 제출 버튼 글자 색상 설정 */
      border: none; /* 제출 버튼 경계 제거 */
      border-radius: 5px; /* 제출 버튼 경계 둥글게 설정 */
      font-size: 16px; /* 제출 버튼 글꼴 크기 설정 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    .social-login {
      margin-top: 20px; /* 소셜 로그인 버튼 위 여백 설정 */
    }
    .social-login button {
      width: 100%; /* 소셜 로그인 버튼 너비 100% 설정 */
      max-width: 280px; /* 소셜 로그인 버튼 최대 너비 설정 */
      margin: 5px auto; /* 소셜 로그인 버튼 마진 설정 */
      padding: 10px; /* 소셜 로그인 버튼 패딩 설정 */
      border: none; /* 소셜 로그인 버튼 경계 제거 */
      border-radius: 4px; /* 소셜 로그인 버튼 경계 둥글게 설정 */
      font-weight: bold; /* 소셜 로그인 버튼 글꼴 두께 설정 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    .kakao {
      background: #FEE500; /* 카카오 로그인 버튼 배경 색상 설정 */
      color: #3C1E1E; /* 카카오 로그인 버튼 글자 색상 설정 */
    }
    .naver {
      background: #03C75A; /* 네이버 로그인 버튼 배경 색상 설정 */
      color: white; /* 네이버 로그인 버튼 글자 색상 설정 */
    }
    .google {
      background: #DB4437; /* Google 로그인 버튼 배경 색상 설정 */
      color: white; /* Google 로그인 버튼 글자 색상 설정 */
    }
  </style>
</head>
<body>
<!-- 상단 네비게이션 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light px-4">
  <div class="container-fluid d-flex align-items-center justify-content-between">
    <div class="d-flex align-items-center">
      <a class="navbar-brand" href="<%=root%>/index.jsp">
        <img src="<%=root%>/image/rogo1.png" style="max-height: 60px;">
      </a>
      <ul class="navbar-nav d-flex flex-row ms-5">
        <li class="nav-item dropdown me-3 dropdown-hover">
        <a class="nav-link" href="https://www.roadplus.co.kr/main/main.do" target="_blank">
    교통정보
</a>


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
            <li><a class="dropdown-item" href="<%=root%>/index.jsp?main=hg/hgRestInfo.jsp">휴게소 목록</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">푸드코드 정보</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=root%>/index.jsp?main=restFoodMenu.jsp">푸드코트 메뉴</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown me-3 dropdown-hover">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">고객센터</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=root%>/index.jsp?main=Question/QuestionForm.jsp">자주 묻는 질문</a></li>
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
        <a href="<%=root%>/mypage/mypage.jsp" class="me-3 text-decoration-none fw-bold text-dark">
          <%= userName %>님 환영합니다
        </a>
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