<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath(); // 현재 컨텍스트 경로를 가져옴
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" /> <!-- 문자 인코딩 설정 -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/> <!-- 반응형 웹을 위한 설정 -->
  <title>고속도로 휴게소 정보</title> <!-- 페이지 제목 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" /> <!-- Bootstrap CSS 링크 -->
  <style>
    /* CSS 스타일 정의 */
    body {
      font-family: Arial, sans-serif; /* 기본 폰트 설정 */
      background: #e4f1fc; /* 배경색 설정 */
      margin: 0;
      padding-top: 0px;
      position: relative;
    }
    header {
      background-color: #fff; /* 헤더 배경색 */
      padding: 15px 40px; /* 헤더 패딩 */
      display: flex; /* 플렉스박스 레이아웃 사용 */
      justify-content: space-between; /* 요소 간격 조정 */
      align-items: center; /* 수직 중앙 정렬 */
      border-bottom: 1px solid #ddd; /* 하단 경계선 */
      position: relative;
    }
    /* 로고 스타일 */
    #logo {
      display: flex;
      align-items: center;
      height: 60px;
    }
    #logo img {
      height: 50px; /* 로고 이미지 높이 */
      margin-top: 10px; /* 상단 여백 */
      margin-left: 20px; /* 좌측 여백 */
    }
    /* 네비게이션 스타일 */
    .main-nav {
      padding: 0 20px; /* 네비게이션 패딩 */
      width: 100%; /* 전체 너비 */
      box-sizing: border-box; /* 박스 모델 설정 */
    }
    .main-nav ul {
      list-style: none; /* 리스트 스타일 제거 */
      display: flex; /* 플렉스박스 레이아웃 사용 */
      justify-content: center; /* 중앙 정렬 */
      margin: 0 auto; /* 자동 마진 */
      padding: 10px 0; /* 패딩 */
      width: fit-content; /* 콘텐츠에 맞게 너비 조정 */
      position: relative;
    }
    /* 네비게이션 항목 스타일 */
    .main-nav li {
      margin: 0 20px; /* 항목 간격 */
      position: relative;
    }
    .main-nav a {
      text-decoration: none; /* 밑줄 제거 */
      font-weight: bold; /* 글자 두께 */
      font-size: 16px; /* 글자 크기 */
      color: #333; /* 글자 색상 */
      padding: 5px 10px; /* 패딩 */
      transition: color 0.3s, background-color 0.3s; /* 호버 시 효과 */
    }
    .main-nav a:hover {
      color: #0077cc; /* 호버 시 글자 색상 */
      background-color: rgba(0, 119, 204, 0.05); /* 호버 시 배경색 */
      font-weight: 700; /* 호버 시 글자 두께 */
      border-radius: 6px; /* 호버 시 모서리 둥글게 */
    }
    /* 드롭다운 메뉴 스타일 */
    .main-nav .dropdown {
      position: relative;
    }
    .main-nav .dropdown-toggle::after {
      display: none !important; /* 드롭다운 화살표 제거 */
    }
    .main-nav .dropdown-menu {
      display: none; /* 기본적으로 드롭다운 숨김 */
      position: fixed; /* 고정 위치 */
      top: 80px; /* 위치 조정 */
      left: 50%;
      transform: translateX(-50%); /* 중앙 정렬 */
      background: rgba(255, 255, 255, 0.9); /* 배경색 */
      border: none;
      border-radius: 10px; /* 모서리 둥글게 */
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* 그림자 효과 */
      padding: 20px; /* 패딩 */
      min-width: 800px; /* 최소 너비 */
      overflow-x: auto; /* 수평 스크롤 가능 */
      display: flex; /* 플렉스박스 레이아웃 사용 */
      align-items: center; /* 수직 중앙 정렬 */
      justify-content: space-between; /* 요소 간격 조정 */
      transition: opacity 0.3s ease; /* 투명도 변화 효과 */
      opacity: 0; /* 초기 투명도 */
      z-index: 1000; /* 최상위 레이어 */
    }
    .main-nav .dropdown:hover .dropdown-menu {
      display: flex; /* 호버 시 드롭다운 표시 */
      opacity: 1; /* 호버 시 투명도 변경 */
    }
    /* 드롭다운 메뉴 내용 스타일 */
    .dropdown-menu .menu-content {
      display: flex; /* 플렉스박스 레이아웃 사용 */
      align-items: center; /* 수직 중앙 정렬 */
      width: 100%; /* 전체 너비 */
    }
    .dropdown-menu .menu-text {
      flex: 1; /* 남은 공간 차지 */
      padding: 10px 20px; /* 패딩 */
    }
    .dropdown-menu .menu-text h4 {
      margin: 0 0 10px 0; /* 제목 마진 */
      font-size: 18px; /* 제목 크기 */
      color: #333; /* 제목 색상 */
    }
    .dropdown-menu .menu-text p {
      margin: 5px 0; /* 문단 마진 */
      font-size: 14px; /* 문단 크기 */
      color: #666; /* 문단 색상 */
    }
    .dropdown-menu .menu-image {
      flex: 0 0 300px; /* 고정 너비 */
      height: 200px; /* 고정 높이 */
      background-size: cover; /* 배경 이미지 크기 조정 */
      background-position: center; /* 배경 이미지 중앙 정렬 */
      border-radius: 8px; /* 모서리 둥글게 */
    }
    .dropdown-menu .dropdown-item {
      font-size: 16px; /* 항목 글자 크기 */
      padding: 5px 10px; /* 패딩 */
      color: #333; /* 항목 색상 */
      text-align: left; /* 텍스트 왼쪽 정렬 */
      transition: all 0.3s ease; /* 호버 시 효과 */
      white-space: nowrap; /* 줄 바꿈 방지 */
      text-decoration: none; /* 밑줄 제거 */
      display: block; /* 블록 요소로 설정 */
    }
    .dropdown-menu .dropdown-item:hover,
    .dropdown-menu .dropdown-item:focus {
      background: linear-gradient(90deg, #0077cc, #005fa3); /* 호버 시 배경 그라디언트 */
      color: #fff !important; /* 호버 시 글자 색상 */
      border-radius: 5px; /* 호버 시 모서리 둥글게 */
    }
    /* 로그인/로그아웃 버튼 스타일 */
    #openModalBtn, .btn-outline-secondary {
      padding: 10px 10px; /* 패딩 */
      font-size: 16px; /* 글자 크기 */
      white-space: nowrap; /* 줄 바꿈 방지 */
      text-overflow: ellipsis; /* 텍스트 오버플로우 처리 */
      width: 150px; /* 고정 너비 */
    }
    /* 모달 스타일 */
    .modal {
      display: none; /* 기본적으로 숨김 */
      position: fixed; /* 고정 위치 */
      z-index: 9999; /* 최상위 레이어 */
      left: 0; top: 0; /* 페이지 전체를 덮음 */
      width: 100%; height: 100%; /* 전체 너비 및 높이 */
      background: rgba(0, 0, 0, 0.5); /* 배경 색상 */
    }
    .modal-content {
      background: #fff; /* 모달 배경색 */
      width: 100%; /* 전체 너비 */
      max-width: 400px; /* 최대 너비 */
      margin: 100px auto; /* 상단 여백 및 중앙 정렬 */
      padding: 30px; /* 패딩 */
      border-radius: 10px; /* 모서리 둥글게 */
      position: relative; /* 상대 위치 */
      box-shadow: 0 0 15px rgba(0,0,0,0.2); /* 그림자 효과 */
      text-align: center; /* 텍스트 중앙 정렬 */
    }
    .close {
      position: absolute; /* 절대 위치 */
      right: 20px; /* 우측 여백 */
      top: 10px; /* 상단 여백 */
      font-size: 24px; /* 글자 크기 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    /* 탭 버튼 스타일 */
    .tab-buttons {
      display: flex; /* 플렉스박스 레이아웃 사용 */
      justify-content: center; /* 중앙 정렬 */
      margin-bottom: 20px; /* 하단 여백 */
    }
    .tab-buttons button {
      flex: 1; /* 남은 공간 차지 */
      padding: 10px; /* 패딩 */
      border: none; /* 테두리 제거 */
      cursor: pointer; /* 커서 포인터로 변경 */
      background: #eee; /* 기본 배경색 */
      font-weight: bold; /* 글자 두께 */
    }
    .tab-buttons button.active {
      background: #007BFF; /* 활성화된 버튼 배경색 */
      color: white; /* 활성화된 버튼 글자색 */
    }
    /* 폼 스타일 */
    .form {
      display: none; /* 기본적으로 숨김 */
    }
    .form.active {
      display: block; /* 활성화된 폼 표시 */
    }
    input {
      display: block; /* 블록 요소로 설정 */
      width: 100%; /* 전체 너비 */
      max-width: 280px; /* 최대 너비 */
      margin: 10px auto; /* 상단 하단 여백 및 중앙 정렬 */
      padding: 10px; /* 패딩 */
      box-sizing: border-box; /* 박스 모델 설정 */
    }
    button[type="submit"] {
      width: 100%; /* 전체 너비 */
      max-width: 280px; /* 최대 너비 */
      margin: 10px auto; /* 상단 하단 여백 및 중앙 정렬 */
      padding: 12px; /* 패딩 */
      background: #007BFF; /* 배경색 */
      color: white; /* 글자색 */
      border: none; /* 테두리 제거 */
      border-radius: 5px; /* 모서리 둥글게 */
      font-size: 16px; /* 글자 크기 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    /* 소셜 로그인 버튼 스타일 */
    .social-login {
      margin-top: 20px; /* 상단 여백 */
    }
    .social-login button {
      width: 100%; /* 전체 너비 */
      max-width: 280px; /* 최대 너비 */
      margin: 5px auto; /* 상단 하단 여백 및 중앙 정렬 */
      padding: 10px; /* 패딩 */
      border: none; /* 테두리 제거 */
      border-radius: 4px; /* 모서리 둥글게 */
      font-weight: bold; /* 글자 두께 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    .kakao {
      background: #FEE500; /* 카카오 버튼 배경색 */
      color: #3C1E1E; /* 카카오 버튼 글자색 */
    }
    .naver {
      background: #03C75A; /* 네이버 버튼 배경색 */
      color: white; /* 네이버 버튼 글자색 */
    }
    .google {
      background: #DB4437; /* 구글 버튼 배경색 */
      color: white; /* 구글 버튼 글자색 */
    }
  </style>
</head>
<body>
<!-- 상단바 -->
<header>
  <a href="<%=root%>/index.jsp" id="logo"> <!-- 로고 링크 -->
    <img src="<%=root%>/image/rogo1.png" alt="로고"> <!-- 로고 이미지 -->
  </a>
  <nav class="main-nav"> <!-- 네비게이션 메뉴 -->
    <ul>
      <li class="dropdown"> <!-- 드롭다운 메뉴 시작 -->
        <a class="dropdown-toggle" href="javacsript:void(0)" role="button" data-bs-toggle="dropdown">교통정보</a> <!-- 드롭다운 토글 -->
        <ul class="dropdown-menu"> <!-- 드롭다운 메뉴 -->
          <li class="menu-content">
            <div class="menu-text">
              <h4>교통정보</h4>
              <p><a class="dropdown-item" href="https://www.roadplus.co.kr/main/main.do" target="_blank">실시간 교통정보</a></p> <!-- 링크 -->
              <p><a class="dropdown-item" href="#">교통안내</a></p>
            </div>
            <div class="menu-image" style="background-image: url('https://via.placeholder.com/300x200');"></div> <!-- 이미지 -->
          </li>
        </ul>
      </li>
      <!-- 추가 드롭다운 메뉴들 -->
      <li class="dropdown">
        <a class="dropdown-toggle" href="javascript:void(0)" role="button" data-bs-toggle="dropdown">휴게소 소개</a>
        <ul class="dropdown-menu">
          <li class="menu-content">
            <div class="menu-text">
              <h4>휴게소 소개</h4>
              <p><a class="dropdown-item" href="#">휴게소 역사</a></p>
              <p><a class="dropdown-item" href="#">휴게소 특징</a></p>
            </div>
            <div class="menu-image" style="background-image: url('https://via.placeholder.com/300x200');"></div>
          </li>
        </ul>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" href="javascript:void(0)" role="button" data-bs-toggle="dropdown">휴게소 찾기</a>
        <ul class="dropdown-menu">
          <li class="menu-content">
            <div class="menu-text">
              <h4>휴게소 찾기</h4>
              <p><a class="dropdown-item" href="<%=root%>/index.jsp?main=hg/hgRestInfo.jsp">휴게소 목록</a></p>
              <p><a class="dropdown-item" href="#">휴게소 검색</a></p>
            </div>
            <div class="menu-image" style="background-image: url('https://via.placeholder.com/300x200');"></div>
          </li>
        </ul>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" href="javascript:void(0)" role="button" data-bs-toggle="dropdown">푸드코트 정보</a>
        <ul class="dropdown-menu">
          <li class="menu-content">
            <div class="menu-text">
              <h4>푸드코트 정보</h4>
              <p><a class="dropdown-item" href="<%=root%>/index.jsp?main=restFoodMenu.jsp">푸드코트 메뉴</a></p>
              <p><a class="dropdown-item" href="#">추천 메뉴</a></p>
            </div>
            <div class="menu-image" style="background-image: url('https://via.placeholder.com/300x200');"></div>
          </li>
        </ul>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" href="javascript:void(0)" role="button" data-bs-toggle="dropdown">고객센터</a>
        <ul class="dropdown-menu">
          <li class="menu-content">
            <div class="menu-text">
              <h4>고객센터</h4>
              <p><a class="dropdown-item" href="#">고객후기</a></p>
              <p><a class="dropdown-item" href="#">문의하기</a></p>
            </div>
            <div class="menu-image" style="background-image: url('https://via.placeholder.com/300x200');"></div>
          </li>
        </ul>
      </li>
    </ul>
  </nav>
  <%
    String userName = (String) session.getAttribute("userName"); // 세션에서 사용자 이름 가져오기
  %>
  <% if (userName == null) { %> <!-- 사용자 이름이 없을 때 -->
    <div class="top-links">
      <button id="openModalBtn" class="btn btn-primary">로그인 / 회원가입</button> <!-- 로그인/회원가입 버튼 -->
    </div>
  <% } else { %> <!-- 사용자 이름이 있을 때 -->
    <div class="top-links d-flex align-items-center">
      <a href="<%=root%>/mypage/mypage.jsp" class="me-3 text-decoration-none fw-bold text-dark" style="white-space: nowrap;">
        <%= userName %>님 환영합니다 <!-- 사용자 이름 표시 -->
      </a>
      <a href="<%=root%>/login/logout.jsp" class="btn btn-outline-secondary">로그아웃</a> <!-- 로그아웃 버튼 -->
    </div>
  <% } %>
</header>
<!-- 로그인/회원가입 모달 -->
<div id="loginModal" class="modal"> <!-- 모달 시작 -->
  <div class="modal-content">
    <span class="close" id="closeModalBtn">×</span> <!-- 모달 닫기 버튼 -->
    <div class="tab-buttons"> <!-- 탭 버튼 -->
      <button id="loginTab" class="active">로그인</button> <!-- 로그인 탭 -->
      <button id="signupTab">회원가입</button> <!-- 회원가입 탭 -->
    </div>
    <form id="loginForm" action="<%=root %>/login/loginaction.jsp" method="post" class="form active"> <!-- 로그인 폼 -->
      <input type="text" name="id" placeholder="아이디" required /> <!-- 아이디 입력 필드 -->
      <input type="password" name="password" placeholder="비밀번호" required /> <!-- 비밀번호 입력 필드 -->
      <button type="submit">로그인</button> <!-- 로그인 버튼 -->
      <div class="social-login"> <!-- 소셜 로그인 버튼들 -->
        <button class="kakao">카카오로 로그인</button>
        <button class="naver">네이버로 로그인</button>
        <button class="google">Google로 로그인</button>
      </div>
    </form>
    <form id="signupForm" action="<%=root %>/login/REGaction.jsp" method="post" class="form" onsubmit="return check(this)"> <!-- 회원가입 폼 -->
      <input type="text" name="name" placeholder="이름" required /> <!-- 이름 입력 필드 -->
      <input type="text" name="id" placeholder="아이디" required /> <!-- 아이디 입력 필드 -->
      <input type="email" name="email" placeholder="이메일" required /> <!-- 이메일 입력 필드 -->
      <input type="password" name="password" placeholder="비밀번호" required /> <!-- 비밀번호 입력 필드 -->
      <input type="password" name="passwordConfirm" placeholder="비밀번호 확인" required /> <!-- 비밀번호 확인 필드 -->
      <button type="submit">회원가입</button> <!-- 회원가입 버튼 -->
    </form>
  </div>
</div>
<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> <!-- Bootstrap JS 링크 -->
<script>
  // 로그인 모달
  const modal = document.getElementById("loginModal"); // 모달 요소
  const openBtn = document.getElementById("openModalBtn"); // 로그인 버튼
  const closeBtn = document.getElementById("closeModalBtn"); // 모달 닫기 버튼
  openBtn.onclick = () => modal.style.display = "block"; // 모달 열기
  closeBtn.onclick = () => modal.style.display = "none"; // 모달 닫기
  window.onclick = e => {
    if (e.target === modal) modal.style.display = "none"; // 모달 외부 클릭 시 닫기
  };
  const loginTab = document.getElementById("loginTab"); // 로그인 탭
  const signupTab = document.getElementById("signupTab"); // 회원가입 탭
  const loginForm = document.getElementById("loginForm"); // 로그인 폼
  const signupForm = document.getElementById("signupForm"); // 회원가입 폼
  loginTab.onclick = () => {
    loginTab.classList.add("active"); // 로그인 탭 활성화
    signupTab.classList.remove("active"); // 회원가입 탭 비활성화
    loginForm.classList.add("active"); // 로그인 폼 활성화
    signupForm.classList.remove("active"); // 회원가입 폼 비활성화
  };
  signupTab.onclick = () => {
    signupTab.classList.add("active"); // 회원가입 탭 활성화
    loginTab.classList.remove("active"); // 로그인 탭 비활성화
    signupForm.classList.add("active"); // 회원가입 폼 활성화
    loginForm.classList.remove("active"); // 로그인 폼 비활성화
  };
  // 비밀번호 확인
  function check(form) {
    const password = form.querySelector("input[name='password']").value; // 비밀번호
    const passwordConfirm = form.querySelector("input[name='passwordConfirm']").value; // 비밀번호 확인
    if (password !== passwordConfirm) {
      alert("비밀번호가 일치하지 않습니다."); // 비밀번호 불일치 경고
      return false; // 폼 제출 중지
    }
    return true; // 폼 제출 허용
  }
  document.addEventListener("DOMContentLoaded", function () {
    // 모든 드롭다운 초기화
    const dropdowns = document.querySelectorAll(".dropdown"); // 드롭다운 요소들
    dropdowns.forEach(dropdown => {
      const toggle = dropdown.querySelector(".dropdown-toggle"); // 드롭다운 토글
      const menu = dropdown.querySelector(".dropdown-menu"); // 드롭다운 메뉴
      toggle.addEventListener("click", function (e) {
        e.preventDefault(); // 기본 클릭 동작 방지
        // 열려있는 모든 드롭다운 닫기
        dropdowns.forEach(d => {
          if (d !== dropdown) {
            d.querySelector(".dropdown-menu").style.display = "none"; // 다른 드롭다운 숨김
            d.querySelector(".dropdown-menu").style.opacity = "0"; // 다른 드롭다운 투명도 변경
          }
        });
        // 현재 드롭다운 토글
        if (menu.style.display === "flex") {
          menu.style.display = "none"; // 드롭다운 숨김
          menu.style.opacity = "0"; // 드롭다운 투명도 변경
        } else {
          menu.style.display = "flex"; // 드롭다운 표시
          menu.style.opacity = "1"; // 드롭다운 투명도 변경
        }
      });
    });
    // 다른 곳 클릭 시 모두 닫기
    window.addEventListener("click", function (e) {
      if (!e.target.closest(".dropdown")) { // 드롭다운 외부 클릭 시
        dropdowns.forEach(d => {
          const menu = d.querySelector(".dropdown-menu");
          menu.style.display = "none"; // 드롭다운 숨김
          menu.style.opacity = "0"; // 드롭다운 투명도 변경
        });
      }
    });
  });
</script>
</body>
</html>