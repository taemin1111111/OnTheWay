<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세미프로젝트</title>
<style>
    .info-box {
        width: 48%;
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
        padding: 20px;
        background-color: white;
        border-radius: 8px;
    }
    .info-box h6 {
        text-align: center;
        margin-bottom: 15px;
        font-size: 30px;
        font-weight: 700;
        color: #222222;
    }
    .info-box table thead th {
        font-size: 18px;
        font-weight: 700;
        color: #444444;
    }
    .info-box table thead th:nth-child(2) {
        text-align: center;
    }
    .info-box table tbody tr td a {
        font-size: 20px;
        font-weight: 500;
        color: #333;
        text-decoration: none;
    }
    .info-box table tbody tr td {
        vertical-align: middle;
        font-size: 18px;
        color: #666666;
    }
    .info-box table tbody tr:hover {
        background-color: #f9f9f9;
    }
    /* 전체 공지사항 보기 버튼 스타일 */
    .all-notice-btn {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        font-size: 20px;
        color: #2c7a2c;
        cursor: pointer;
        margin-top: 15px;
        text-decoration: none;
    }
    .all-notice-btn:hover {
        color: #1b4d1b;
        text-decoration: underline;
    }
    .all-notice-btn i {
        font-size: 24px;
    }
    .footer {
        margin-top: 50px;
        padding: 20px;
        background-color: #eee;
        text-align: center;
    }
</style>
</head>
<body>
<div class="container mt-5 text-center">
  <h5>세미프로젝트</h5>
  <p>프로젝트 메인 화면 구성중입니다</p>
</div>
<div class="container mt-4 d-flex justify-content-between align-items-stretch">
  <div class="info-box">
    <h6>공지사항</h6>
    <table class="table table-bordered mb-0">
      <thead>
        <tr>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><a href="#">공지사항 제목 1</a></td><td>2024-05-22</td></tr>
        <tr><td><a href="#">공지사항 제목 2</a></td><td>2024-05-21</td></tr>
        <tr><td><a href="#">공지사항 제목 3</a></td><td>2024-05-20</td></tr>
      </tbody>
    </table>
    <a href="#" class="all-notice-btn">
      <i class="bi bi-plus-circle"></i> 전체 공지사항 보기
    </a>
  </div>
  <div class="info-box">
    <h6 class="text-center">이벤트</h6>
    <table class="table table-bordered mb-0">
      <thead>
        <tr>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><a href="#">이벤트 제목 1</a></td><td>2025-06-01</td></tr>
        <tr><td><a href="#">이벤트 제목 2</a></td><td>2025-05-28</td></tr>
        <tr><td><a href="#">이벤트 제목 3</a></td><td>2025-05-20</td></tr>
      </tbody>
    </table>
    <a href="#" class="all-notice-btn">
      <i class="bi bi-plus-circle"></i> 전체 이벤트 보기
    </a>
  </div>
</div>
<div class="footer">
  &copy; 2025 쌍용 세미
</div>
</body>
</html>
