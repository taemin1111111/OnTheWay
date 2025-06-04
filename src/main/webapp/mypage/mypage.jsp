
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDto"%>
<%@page import="user.UserDao"%>
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
	font-family: Arial, sans-serif;
	margin: 0;
	background: #e4f1fc;
}

.main-nav {
	padding: 0 20px;
	width: 100%;
	box-sizing: border-box;
}

.main-nav ul {
	list-style: none;
	display: flex;
	justify-content: center;
	margin: 0 auto;
	padding: 10px 0;
	width: fit-content;
}

.main-nav li {
	margin: 0 20px;
}

.main-nav a {
	text-decoration: none;
	font-weight: bold;
	font-size: 16px;
	color: #333;
	padding: 5px 10px;
	transition: color 0.3s, background-color 0.3s;
}

.main-nav a:hover {
	color: #0077cc;
	background-color: rgba(0, 119, 204, 0.05);
	font-weight: 700;
	border-radius: 6px;
}

header {
	background-color: #fff;
	padding: 15px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
}

#logo {
	display: flex;
	align-items: center;
	height: 60px;
}

#logo img {
	height: 50px;
	margin-top: 10px;
	margin-left: 20px;
}

.tab-menu {
	display: flex;
	padding-left: 40px;
	background: transparent;
	border-bottom: none;
	margin-top: 20px;
}

/* 기존 tab-btn 스타일 유지 */
.tab-btn {
	background: #E2F1FF;
	border: 1px solid #ccc;
	border-bottom: none;
	margin-right: 0px;
	padding: 10px 40px;
	cursor: pointer;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
	transition: background 0.3s, color 0.3s;
	position: relative;
	top: 1px;
	z-index: 2;
}

/* 기존 active 스타일 제거하고 아래로 대체 */
.tab-btn.btn-active {
	background-color: #ffffff;
	color: #0b6efd;
	font-weight: bold;
	border-bottom: 1px solid white;
}

.content {
	background: white;
	margin: 0 auto;
	padding: 20px;
	width: 1799px;
	height: 400px;
	border-radius: 0 0 10px 10px;
	border-top: none;
	position: relative;
	top: -1px;
	z-index: 1;
	border: 1px solid #ccc;
}

.tab-btn:hover {
	background: #e9ecef;
}

.profile-section {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.profile-img {
	width: 100px;
	height: 100px;
	border-radius: 10px;
	margin-right: 30px;
	border: 1px solid #ccc;
	background: #f0f0f0;
}

.edit-btn, .save-btn, .withdraw-btn {
	margin-right: 10px;
	padding: 5px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	background-color: #ddd;
	color: #333;
	font-weight: 600;
	transition: all 0.3s;
}

.btn-active {
	background-color: #0b6efd !important;
	color: white !important;
}

.form-section input {
	display: block;
	width: 300px;
	padding: 5px;
	margin: 10px 0;
	border: 1px solid #ccc;
	background: #f0f0f0;
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
        input.style.backgroundColor = '#fff';
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