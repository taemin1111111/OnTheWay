<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDto, user.UserDao" %>
<%
    request.setCharacterEncoding("UTF-8");
    String root = request.getContextPath();
    String username = (String) session.getAttribute("userId"); // Assuming this is the login ID

    UserDto user = null;
    if (username != null) {
        UserDao dao = new UserDao();
        user = dao.getUserSession(username); // Fetches user details based on login ID
    }

    // If user is not found or not logged in, redirect to login page
    if (user == null) {
        // response.sendRedirect(root + "/login.jsp?error=session_expired"); // Or some other appropriate page
        // For now, let's create a dummy user if not logged in, for display purposes in this example
        // In a real app, you'd redirect or show an error.
        user = new UserDto();
        user.setUsername("GuestUser"); // Placeholder
        user.setEmail("guest@example.com"); // Placeholder
        username = "GuestUser"; // for the header display
        // out.println("<script>alert('세션이 만료되었거나 로그인 정보가 없습니다. 로그인 페이지로 이동합니다.'); location.href='" + root + "/login.jsp';</script>");
        // return;
    }

    String error = request.getParameter("error");
    String success = request.getParameter("success"); // For success messages
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이 페이지 - <%= user.getUsername() %></title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f7f6;
      color: #333;
      line-height: 1.6;
    }

    .container {
      max-width: 800px;
      margin: 30px auto;
      padding: 20px;
    }

    header.page-header {
      background-color: #ffffff;
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .page-header .logo {
      font-size: 1.8em;
      font-weight: bold;
      color: #007bff;
      text-decoration: none;
    }

    .page-header .user-actions a {
      text-decoration: none;
      color: #007bff;
      margin-left: 20px;
      font-weight: 500;
    }
    .page-header .user-actions a:hover {
      text-decoration: underline;
    }

    .tab-menu {
      display: flex;
      border-bottom: 1px solid #dee2e6;
      margin-bottom: 25px;
    }

    .tab-btn {
      background-color: transparent;
      border: none;
      padding: 12px 25px;
      cursor: pointer;
      font-size: 1.1em;
      font-weight: 500;
      color: #6c757d;
      border-bottom: 3px solid transparent;
      transition: all 0.3s ease;
      margin-right: 5px;
    }

    .tab-btn:hover {
      color: #007bff;
    }

    .tab-btn.active {
      color: #007bff;
      border-bottom-color: #007bff;
      font-weight: 600;
    }

    .content-section {
      background-color: #ffffff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
    }
    
    .form-section h2 {
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 1.5em;
        color: #343a40;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #495057;
    }

    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="password"] {
      width: 100%;
      padding: 12px;
      border: 1px solid #ced4da;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 1em;
      transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }
    
    .form-group input[type="text"][readonly],
    .form-group input[type="email"][readonly] {
        background-color: #e9ecef;
        cursor: not-allowed;
    }

    .form-group input:focus {
      border-color: #80bdff;
      outline: 0;
      box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .btn {
      padding: 12px 25px;
      font-size: 1em;
      font-weight: 600;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      text-decoration: none; /* For <a> tags styled as buttons */
    }

    .btn-primary {
      background-color: #007bff;
      color: white;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }

    .btn-danger {
      background-color: #dc3545;
      color: white;
    }
    .btn-danger:hover {
      background-color: #c82333;
    }
    
    .btn-secondary {
      background-color: #6c757d;
      color: white;
    }
    .btn-secondary:hover {
      background-color: #545b62;
    }

    .form-actions {
        margin-top: 30px;
        text-align: right;
    }
    .form-actions .btn {
        margin-left: 10px;
    }

    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border: 1px solid transparent;
        border-radius: .25rem;
        font-size: 1em;
    }
    .alert-danger {
        color: #721c24;
        background-color: #f8d7da;
        border-color: #f5c6cb;
    }
    .alert-success {
        color: #155724;
        background-color: #d4edda;
        border-color: #c3e6cb;
    }

    /* Hide sections by default */
    #edit-profile-section, #withdraw-section {
        display: none;
    }
    #edit-profile-section.active-section, #withdraw-section.active-section {
        display: block;
    }

  </style>
</head>
<body>

<header class="page-header">
  <a href="<%= root %>/" class="logo">MyApplication</a>
  <div class="user-actions">
    <% if (username != null && !username.equals("GuestUser")) { %>
      <span>안녕하세요, <%= user.getUsername() %>님</span>
      <a href="<%= root %>/logout.jsp">로그아웃</a>
    <% } else { %>
      <a href="<%= root %>/login.jsp">로그인</a>
    <% } %>
  </div>
</header>

<div class="container">
  <div class="tab-menu">
    <button id="tab-edit" class="tab-btn active" onclick="showSection('edit-profile')">회원정보수정</button>
    <button id="tab-withdraw" class="tab-btn" onclick="showSection('withdraw')">회원탈퇴</button>
  </div>

  <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger" role="alert">
      <%= error %>
    </div>
  <% } %>
  <% if (success != null && !success.isEmpty()) { %>
    <div class="alert alert-success" role="alert">
      <%= success %>
    </div>
  <% } %>

  <div class="content-section">
    <!-- 회원정보수정 -->
    <section id="edit-profile-section" class="form-section active-section">
      <h2>회원정보 수정</h2>
      <form action="<%= root %>/mypage/editUser.jsp" method="post">
        <div class="form-group">
          <label for="nickname">닉네임 (아이디)</label>
          <%-- Assuming username is the login ID and should not be changed --%>
          <input type="text" id="nickname" name="nickname" value="<%= user.getUsername() %>" readonly />
        </div>
        <div class="form-group">
          <label for="email">이메일</label>
          <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />
        </div>
        <hr style="margin: 30px 0;">
        <h3>비밀번호 변경</h3>
        <div class="form-group">
          <label for="oldPass">기존 비밀번호</label>
          <input type="password" id="oldPass" name="oldPass" placeholder="비밀번호 변경 시 필수 입력" />
          <small style="display:block; margin-top:5px; color: #6c757d;">비밀번호를 변경하려면 현재 비밀번호를 입력하세요.</small>
        </div>
        <div class="form-group">
          <label for="newPass">새로운 비밀번호</label>
          <input type="password" id="newPass" name="newPass" placeholder="새로운 비밀번호 (8자 이상)" />
        </div>
        <div class="form-group">
          <label for="newPassConfirm">새로운 비밀번호 재입력</label>
          <input type="password" id="newPassConfirm" name="newPassConfirm" placeholder="새로운 비밀번호 재입력" />
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">정보 저장하기</button>
        </div>
      </form>
    </section>

    <!-- 회원탈퇴 -->
    <section id="withdraw-section" class="form-section">
      <h2>회원 탈퇴</h2>
      <p>회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다. 정말로 탈퇴하시겠습니까?</p>
      <form action="<%= root %>/mypage/deleteUser.jsp" method="post">
        <div class="form-group">
          <label for="password-withdraw">비밀번호 확인</label>
          <input type="password" id="password-withdraw" name="password" required placeholder="비밀번호를 입력해주세요" />
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-danger" onclick="return confirm('정말로 회원 탈퇴를 하시겠습니까? 모든 정보가 영구적으로 삭제됩니다.');">회원 탈퇴하기</button>
        </div>
      </form>
    </section>
  </div>
</div>

<script>
  function showSection(sectionId) {
    // Hide all sections
    document.querySelectorAll('.form-section').forEach(section => {
      section.classList.remove('active-section');
    });
    // Show the target section
    document.getElementById(sectionId + '-section').classList.add('active-section');

    // Update active tab
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
    if (sectionId === 'edit-profile') {
        document.getElementById('tab-edit').classList.add('active');
    } else if (sectionId === 'withdraw') {
        document.getElementById('tab-withdraw').classList.add('active');
    }
  }

  // Initialize: show the first tab content by default
  document.addEventListener('DOMContentLoaded', function() {
    showSection('edit-profile'); 
  });
</script>

</body>
</html>