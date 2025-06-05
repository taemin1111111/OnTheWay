<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDto"%>
<%@page import="user.UserDao"%>
<%
    String root = request.getContextPath(); // 현재 웹 애플리케이션의 컨텍스트 경로를 가져옴
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
      padding-left: 40px; /* 왼쪽 패딩 설정 */
      background: transparent; /* 배경색 투명 */
      border-bottom: none; /* 하단 경계 제거 */
      margin-top: 20px; /* 상단 여백 설정 */
    }
    /* 탭 버튼들 */
    .tab-btn {
      background: #E2F1FF; /* 배경색 설정 */
      border: 1px solid #ccc; /* 경계 설정 */
      border-bottom: none; /* 하단 경계 제거 */
      margin-right: 0px; /* 우측 여백 설정 */
      padding: 10px 40px; /* 패딩 설정 */
      cursor: pointer; /* 커서를 포인터로 변경 */
      border-top-left-radius: 8px; /* 좌측 상단 모서리를 둥글게 설정 */
      border-top-right-radius: 8px; /* 우측 상단 모서리를 둥글게 설정 */
      transition: background 0.3s, color 0.3s; /* 호버 효과에 대한 전환 효과 설정 */
      position: relative; /* 상대 위치 설정 */
      top: 1px; /* content 박스와 붙게 살짝 올리기 */
      z-index: 2; /* z-index 설정 */
    }
    /* 활성 탭 버튼 */
    .tab-btn.btn-active {
      background-color: #ffffff; /* 활성화된 버튼 배경색 설정 */
      color: #0b6efd; /* 활성화된 버튼 글자 색상 설정 */
      font-weight: bold; /* 글꼴 두께 설정 */
      border-bottom: 1px solid white; /* 하단 경계 설정 */
    }
    /* 콘텐츠 영역 */
    .content {
      background: white; /* 배경색 흰색 */
      margin: 0 auto; /* 상하 마진 제거 및 중앙 정렬 */
      padding: 20px; /* 패딩 설정 */
      width: 1799px; /* 너비 설정 */
      height: 400px; /* 높이 설정 */
      border-radius: 0 0 10px 10px; /* 하단 모서리를 둥글게 설정 */
      border-top: none; /* 탭과 연결되도록 상단 보더 제거 */
      position: relative; /* 상대 위치 설정 */
      top: -1px; /* 탭과 붙게 설정 */
      z-index: 1; /* z-index 설정 */
      border: 1px solid #ccc; /* 경계 설정 */
    }
    .tab-btn:hover {
      background: #e9ecef; /* 호버 시 배경색 변경 */
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
    .edit-btn, .save-btn, .withdraw-btn {
      margin-right: 10px; /* 우측 여백 설정 */
      padding: 5px 15px; /* 패딩 설정 */
      border: none; /* 경계 제거 */
      border-radius: 5px; /* 모서리를 둥글게 설정 */
      cursor: pointer; /* 커서를 포인터로 변경 */
      background-color: #ddd; /* 배경색 설정 */
      color: #333; /* 글자 색상 설정 */
      font-weight: 600; /* 글꼴 두께 설정 */
      transition: all 0.3s; /* 모든 속성에 대한 전환 효과 설정 */
    }
    .btn-active {
      background-color: #0b6efd !important; /* 활성화된 버튼 배경색 설정 */
      color: white !important; /* 활성화된 버튼 글자 색상 설정 */
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
<%
    request.setCharacterEncoding("UTF-8");
    String username = (String) session.getAttribute("userId");

    System.out.println(username);
    
    UserDao dao = new UserDao(); 
    UserDto user = dao.getUserSession(username);
    System.out.println(user.toString());
    
    String error = request.getParameter("error");
%>
<script>
<% if (error != null && !error.isEmpty()) { %>
    alert("<%= error %>");
<% } %>
</script>
	<div class="tab-menu">
		<button class="tab-btn active" onclick="showSection('edit')">회원정보수정</button>
		<button class="tab-btn" onclick="showSection('activity')">나의활동내역</button>
		<button class="tab-btn" onclick="showSection('withdraw')">회원탈퇴</button>
	</div>
	<div class="content">
		<!-- 회원정보수정 -->
		<form id="edit" action="<%=request.getContextPath()%>/mypage/editUser.jsp" method="post"
			style="display: flex; flex-direction: column;">
			<div class="profile-section">
				<div class="profile-img"></div>
				<button type="button" class="edit-btn" onclick="editProfile(this)">수정</button>
				<button type="submit" class="save-btn">완료</button>
			</div>
			<div class="form-section">
			    닉네임 <input type="text" name="nickname" placeholder="닉네임" readonly 
			           value="<%= user != null ? user.getUsername() : "" %>" />
			
			    이메일 <input type="email" name="email" placeholder="이메일" readonly 
			           value="<%= user != null ? user.getEmail() : "" %>" />
				기존 비밀번호 <input type="password" name="oldPass" placeholder="비밀번호 확인" readonly required />
				새로운 비밀번호 <input type="password" name="newPass" placeholder="새로운 비밀번호 입력" readonly />
				새로운 비밀번호 재입력<input type="password" name="newPassConfirm" placeholder="새로운 비밀번호 재입력" readonly />
			</div>
		</form>
		<!-- 나의활동내역 -->
		<form id="activity" style="display: none;">
			<p>나의 활동 내역 내용이 들어갈 공간입니다.</p>
		</form>
		<!-- 회원탈퇴 -->
		<form id="withdraw" action="<%=request.getContextPath()%>/mypage/deleteUser.jsp" method="post"
			style="display: none;">
			<input type="password" name="password" placeholder="비밀번호를 입력해주세요" required />
			<button type="submit" class="withdraw-btn"
				onclick="return confirmWithdrawal(this)">회원 탈퇴하기</button>
		</form>
	</div>
	<script>
    function showSection(section) {
      // 모든 콘텐츠 영역 숨기기
      document.getElementById('edit').style.display = 'none';
      document.getElementById('activity').style.display = 'none';
      document.getElementById('withdraw').style.display = 'none';
      // 선택한 콘텐츠만 보이기
      document.getElementById(section).style.display = section === 'edit' ? 'flex' : 'block';
      // 탭 버튼 스타일 변경
      document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('btn-active');
      });
      document.querySelector(`.tab-btn[onclick="showSection('${section}')"]`).classList.add('btn-active');
    }
    function editProfile(button) {
      document.querySelectorAll('#edit .form-section input').forEach(input => {
        input.removeAttribute('readonly');
        input.style.backgroundColor = '#fff'; // 배경색도 바꾸기 (선택사항)
      });
      document.querySelector('.edit-btn').classList.add('btn-active');
      document.querySelector('.save-btn').classList.remove('btn-active');
    }
    function confirmWithdrawal(button) {
      return confirm('정말로 회원 탈퇴를 하시겠습니까?');
    }
    
    
    document.getElementById('edit').addEventListener('submit', function(e) {
    	  console.log("EDIT form submitted to:", this.action);
    	});

    	document.getElementById('withdraw').addEventListener('submit', function(e) {
    	  console.log("WITHDRAW form submitted to:", this.action);
    	});
  </script>
</body>
</html>