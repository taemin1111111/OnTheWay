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
      display: flex; /* 활성화된 폼 표시 */
      flex-direction: column;
      align-items: center;
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
      text-align: center; /* 입력창 내부 텍스트 정렬 */
    }
    /* 소셜 로그인 버튼 스타일 */
    .social-login {
      margin-top: 10px; /* 상단 여백 */
    }
    .social-login button {
      width: 100%; /* 전체 너비 */
      max-width: 250px; /* 최대 너비 */
      margin: 5px auto; /* 상단 하단 여백 및 중앙 정렬 */
      padding: 10px; /* 패딩 */
      border: none; /* 테두리 제거 */
      border-radius: 4px; /* 모서리 둥글게 */
      font-weight: bold; /* 글자 두께 */
      cursor: pointer; /* 커서 포인터로 변경 */
    }
    .top-links {
  width: 320px; /* 적당히 넉넉한 너비 설정 */
  display: flex;
  justify-content: flex-end;
  align-items: center;
  flex-shrink: 0;
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
  <nav class="main-nav">
  <ul>
    <li><a href="https://www.roadplus.co.kr/main/main.do" target="_blank">교통정보</a></li>
    <li><a href="<%=root%>/index.jsp?main=hg/hgRestInfo.jsp">휴게소 찾기</a></li>
    <li><a href="<%=root%>/index.jsp?main=restFoodMenu.jsp">푸드코트 정보</a></li>
    <li><a href="<%=root%>/index.jsp?main=Question/QuestionForm.jsp">고객센터</a></li>
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
      <a href="<%=root%>/index.jsp?main=mypage/mypage.jsp" class="me-3 text-decoration-none fw-bold text-dark" style="white-space: nowrap;">
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
      <input type="hidden" name="redirect" id="redirectInput" />
      <button type="submit">로그인</button> <!-- 로그인 버튼 -->
    </form>
    <form id="signupForm" action="<%=root %>/login/REGaction.jsp" method="post" class="form" onsubmit="return check(this)"> <!-- 회원가입 폼 -->
      <input type="text" name="name" placeholder="이름" required /> <!-- 이름 입력 필드 -->
      <input type="text" name="id" placeholder="아이디" required onblur="checkDuplicateId(this.value)" />
	  <span id="idCheckMessage" style="color:red;"></span>
      <input type="email" name="email" placeholder="이메일" required /> <!-- 이메일 입력 필드 -->
      <input type="password" name="password" placeholder="비밀번호" required /> <!-- 비밀번호 입력 필드 -->
      <input type="password" name="passwordConfirm" placeholder="비밀번호 확인" required /> <!-- 비밀번호 확인 필드 -->
      <input type="hidden" name="redirect" id="redirectInput" />
      <button type="submit">회원가입</button> <!-- 회원가입 버튼 -->
    </form>
  </div>
</div>
<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> <!-- Bootstrap JS 링크 -->
<script>
  // 로그인 모달 관련
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

  // 비밀번호 확인
  function check(form) {
    const password = form.querySelector("input[name='password']").value;
    const passwordConfirm = form.querySelector("input[name='passwordConfirm']").value;
    if (password !== passwordConfirm) {
      alert("비밀번호가 일치하지 않습니다.");
      return false;
    }
    return true;
  }
  document.addEventListener("DOMContentLoaded", () => {
	  const redirectUrl = window.location.href;
	  const redirectInputs = document.querySelectorAll("input[name='redirect']");
	  redirectInputs.forEach(input => input.value = redirectUrl);
	});

  function checkDuplicateId(userId) {
	  if (!userId) return;
	  fetch(`<%=request.getContextPath()%>/login/checkId.jsp?userId=` + encodeURIComponent(userId))
	    .then(res => res.json())
	    .then(data => {
	      const message = document.getElementById("idCheckMessage");
	      if (data.exists) {
	        message.textContent = "이미 사용 중인 아이디입니다.";
	      } else {
	        message.textContent = "사용 가능한 아이디입니다.";
	        message.style.color = "green";
	      }
	    })
	    .catch(err => {
	      console.error("ID 중복 확인 중 오류 발생:", err);
	    });
	}
</script>
</body>
</html>