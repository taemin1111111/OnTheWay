<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>프로필 페이지</title>
  <style>
    body {
      font-family: Arial, sans-serif; /* 기본 글꼴 설정 */
      margin: 0; /* 기본 여백 제거 */
      background: #e4f1fc; /* 배경색 설정 */
    }
    .main-nav {
      padding: 0 20px; /* 좌우 패딩 설정 */
      width: 100%; /* 전체 너비 설정 */
      box-sizing: border-box; /* 박스 크기 계산 방법 설정 */
    }
    .main-nav ul {
      list-style: none; /* 리스트 스타일 제거 */
      display: flex; /* 플렉스 박스를 사용하여 수평 정렬 */
      justify-content: center; /* 중앙 정렬 */
      margin: 0 auto; /* 좌우 마진 자동으로 설정 */
      padding: 10px 0; /* 상하 패딩 설정 */
      width: fit-content; /* 메뉴 너비만큼만 차지 */
    }
    .main-nav li {
      margin: 0 20px; /* 좌우 여백 설정 */
    }
    .main-nav a {
      text-decoration: none; /* 밑줄 제거 */
      font-weight: bold; /* 글꼴 두께 설정 */
      font-size: 16px; /* 글꼴 크기 설정 */
      color: #333; /* 글자 색상 설정 */
      padding: 5px 10px; /* 패딩 설정 */
      transition: color 0.3s, background-color 0.3s; /* 호버 효과에 대한 전환 효과 설정 */
    }
    .main-nav a:hover {
      color: #0077cc; /* 호버 시 글자 색상 변경 */
      background-color: rgba(0, 119, 204, 0.05); /* 호버 시 배경색 변경 */
      font-weight: 700; /* 호버 시 글자 두께 변경 */
      border-radius: 6px; /* 호버 시 모서리 둥글게 설정 */
    }
    /* 헤더 */
    header {
      background-color: #fff; /* 헤더 배경색 설정 */
      padding: 15px 40px; /* 상하 및 좌우 패딩 설정 */
      display: flex; /* 플렉스 박스를 사용하여 배치 */
      justify-content: space-between; /* 공간을 균등하게 배분 */
      align-items: center; /* 수직 중앙 정렬 */
      border-bottom: 1px solid #ddd; /* 하단 경계 설정 */
    }
    #logo {
      display: flex; /* 플렉스 박스를 사용하여 배치 */
      align-items: center; /* 수직 중앙 정렬 */
      height: 60px; /* 높이 설정 */
    }
    #logo img {
      height: 50px; /* 로고 이미지 높이 설정 */
      margin-top: 10px; /* 아래 여백 설정 */
      margin-left: 20px; /* 왼쪽 여백 설정 */
    }
    /* 탭 메뉴 (브라우저 탭 스타일) */
    .tab-menu {
      display: flex; /* 플렉스 박스를 사용하여 배치 */
      padding: 10px 50px; /* 상하 및 좌우 패딩 설정 */
      background: #d6ecfc; /* 배경색 설정 */
      border-bottom: 1px solid #ccc; /* 하단 경계 설정 */
      position: sticky; /* 스크롤 시 고정 */
      top: 0; /* 상단에 위치 */
      z-index: 1000; /* 다른 요소 위에 표시 */
    }
    .tab-btn {
      background: white; /* 배경색 설정 */
      border: 1px solid #ccc; /* 경계 설정 */
      border-bottom: none; /* 하단 경계 제거 */
      margin-right: -5px; /* 우측 여백 설정 */
      padding: 8px 20px; /* 패딩 설정 */
      cursor: pointer; /* 커서 포인터로 변경 */
      border-top-left-radius: 8px; /* 좌측 상단 모서리를 둥글게 설정 */
      border-top-right-radius: 8px; /* 우측 상단 모서리를 둥글게 설정 */
      transition: background 0.3s, color 0.3s; /* 호버 효과에 대한 전환 효과 설정 */
    }
    .tab-btn.active {
      background: #0d6efd; /* 활성화된 버튼 배경색 설정 */
      color: white; /* 활성화된 버튼 글자 색상 설정 */
      font-weight: bold; /* 글꼴 두께 설정 */
      border-bottom: 1px solid #0d6efd; /* 하단 경계 설정 */
    }
    .tab-btn:hover {
      background: #e9ecef; /* 호버 시 배경색 변경 */
    }
    /* 콘텐츠 */
    .content {
      background: white; /* 배경색 설정 */
      margin: 30px auto; /* 상하 마진 및 중앙 정렬 */
      padding: 20px; /* 패딩 설정 */
      width: 80%; /* 너비 설정 */
      border-radius: 10px; /* 모서리를 둥글게 설정 */
    }
    .profile-section {
      display: flex; /* 플렉스 박스를 사용하여 배치 */
      align-items: center; /* 수직 중앙 정렬 */
      margin-bottom: 20px; /* 하단 여백 설정 */
    }
    .profile-img {
      width: 100px; /* 프로필 이미지 너비 설정 */
      height: 100px; /* 프로필 이미지 높이 설정 */
      border-radius: 10px; /* 모서리를 둥글게 설정 */
      margin-right: 30px; /* 우측 여백 설정 */
      border: 1px solid #ccc; /* 경계 설정 */
      background: #f0f0f0; /* 배경색 설정 */
    }
    .edit-btn, .save-btn {
      margin-right: 10px; /* 우측 여백 설정 */
      padding: 5px 10px; /* 패딩 설정 */
      border: none; /* 경계 제거 */
      border-radius: 5px; /* 모서리를 둥글게 설정 */
      cursor: pointer; /* 커서를 포인터로 변경 */
    }
    .edit-btn {
      border: 1px solid #ccc; /* 경계 설정 */
    }
    .save-btn {
      background: limegreen; /* 배경색 설정 */
      color: white; /* 글자 색상 설정 */
    }
    .form-section input {
      display: block; /* 블록 요소로 설정 */
      width: 300px; /* 너비 설정 */
      padding: 5px; /* 패딩 설정 */
      margin: 10px 0; /* 상하 마진 설정 */
      border: 1px solid #ccc; /* 경계 설정 */
      background: #f0f0f0; /* 배경색 설정 */
    }
  </style>
</head>
<body>
  <!-- 헤더 -->
  <header>
    <a href="<%=request.getContextPath() %>/index.jsp" id="logo"> <!-- 메인 페이지로 이동 -->
      <img src="../imgway/way.png" alt="로고">
    </a>
    <!-- 내비게이션 바 -->
    <nav class="main-nav">
      <ul>
        <li><a href="#">교통정보</a></li>
        <li><a href="#">휴게소 찾기</a></li>
        <li><a href="#">휴게소 소개</a></li>
        <li><a href="<%=request.getContextPath()%>/restFoodMenu.jsp">푸드코트 정보</a></li>
        <li><a href="#">고객센터</a></li>
      </ul>
    </nav>
  </header>
  <!-- 탭 메뉴 -->
  <div class="tab-menu">
    <button class="tab-btn active" onclick="showSection('edit')">회원정보수정</button>
    <button class="tab-btn" onclick="showSection('activity')">나의활동내역</button>
    <button class="tab-btn" onclick="showSection('withdraw')">회원탈퇴</button>
  </div>
  <!-- 콘텐츠 영역 -->
  <div class="content">
    <!-- 회원정보수정 섹션 -->
    <div id="edit" style="display: flex; flex-direction: column;">
      <div class="profile-section">
        <div class="profile-img"></div>
        <button class="edit-btn" onclick="editProfile()">수정</button>
        <button class="save-btn" onclick="saveProfile()">완료</button>
      </div>
      <div class="form-section">
        <input type="text" placeholder="닉네임" readonly />
        <input type="text" placeholder="아이디" readonly />
        <input type="text" placeholder="이메일" readonly />
        <input type="text" placeholder="성년월일" readonly />
      </div>
    </div>
    <!-- 나의활동내역 섹션 -->
    <div id="activity" style="display: none;">
      <p>나의 활동 내역 내용이 들어갈 공간입니다.</p>
    </div>
    <!-- 회원탈퇴 섹션 -->
    <div id="withdraw" style="display: none;">
      <button onclick="confirmWithdrawal()">회원 탈퇴하기</button>
    </div>
  </div>
  <script>
    function showSection(section) {
      // 모든 섹션 숨기기
      document.getElementById('edit').style.display = 'none';
      document.getElementById('activity').style.display = 'none';
      document.getElementById('withdraw').style.display = 'none';
      // 선택한 섹션만 보이기
      if (section === 'edit') {
        document.getElementById('edit').style.display = 'flex';
      } else if (section === 'activity') {
        document.getElementById('activity').style.display = 'block';
      } else if (section === 'withdraw') {
        document.getElementById('withdraw').style.display = 'block';
      }
      // 모든 탭 버튼 비활성화
      const tabs = document.querySelectorAll('.tab-btn');
      tabs.forEach(tab => tab.classList.remove('active'));
      // 선택한 탭 버튼 활성화
      document.querySelector(`.tab-btn[onclick="showSection('${section}')"]`).classList.add('active');
    }
    function editProfile() {
      // 수정 버튼 클릭 시 입력란 활성화
      const inputs = document.querySelectorAll('.form-section input');
      inputs.forEach(input => {
        input.removeAttribute('readonly');
        input.style.backgroundColor = '#fff'; // 배경색도 바꾸기 (선택사항)
      });
    }
    function saveProfile() {
      // 완료 버튼 클릭 시 입력란 비활성화
      const inputs = document.querySelectorAll('.form-section input');
      inputs.forEach(input => {
        input.setAttribute('readonly', true);
        input.style.backgroundColor = '#f0f0f0';
      });
      alert('정보가 저장되었습니다!');
    }
    function confirmWithdrawal() {
      if (confirm('정말로 회원 탈퇴를 하시겠습니까?')) {
        alert('회원 탈퇴가 완료되었습니다.');
        // 회원 탈퇴 처리 로직 추가 예정
      }
    }
  </script>
</body>
</html>