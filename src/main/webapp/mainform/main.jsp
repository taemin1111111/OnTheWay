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
        display: inline-block;
        vertical-align: top;
        margin-right: 2%;
    }
    .info-box:last-child { margin-right: 0; }
    .info-box h6 {
        text-align: center;
        margin-bottom: 15px;
        font-size: 30px;
        font-weight: 700;
        color: #222;
    }
    .info-box table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 0;
    }
    .info-box table thead th {
        font-size: 18px;
        font-weight: 700;
        color: #444;
        border-bottom: 1px solid #ddd;
        padding: 8px 0;
        text-align: left;
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
        color: #666;
        padding: 7px 0;
        border-bottom: 1px solid #f1f1f1;
        text-align: left;
    }
    .info-box table tbody tr:hover {
        background-color: #f9f9f9;
    }
    /* 버튼만 중앙정렬 */
    .center-btn-wrap {
        text-align: center;
        margin-top: 15px;
    }
    .all-notice-btn {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        font-size: 20px;
        color: #2c7a2c;
        cursor: pointer;
        text-decoration: none;
        background: none;
        border: none;
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
    /* 부모 div에서 좌우로 나란히 */
    .main-wrap {
        width: 100%;
        text-align: center;
        margin-top: 40px;
    }
</style>
<!-- bi-plus-circle 쓸 거면 아래 CDN 필요. index에 있으면 이거도 빼! -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
<div style="margin:30px 0 10px 0; text-align:center;">
  <h5 style="font-size:28px; font-weight:700;">세미프로젝트</h5>
  <p style="font-size:17px;">프로젝트 메인 화면 구성중입니다</p>
</div>
<div class="main-wrap">
  <div class="info-box">
    <h6>공지사항</h6>
    <table>
      <thead>
        <tr>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><a href="#">공지사항 제목 1</a></td><td style="text-align:center;">2024-05-22</td></tr>
        <tr><td><a href="#">공지사항 제목 2</a></td><td style="text-align:center;">2024-05-21</td></tr>
        <tr><td><a href="#">공지사항 제목 3</a></td><td style="text-align:center;">2024-05-20</td></tr>
      </tbody>
    </table>
    <div class="center-btn-wrap">
      <a href="#" class="all-notice-btn">
        <i class="bi bi-plus-circle"></i> 전체 공지사항 보기
      </a>
    </div>
  </div>
  <div class="info-box">
    <h6>이벤트</h6>
    <table>
      <thead>
        <tr>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><a href="#">이벤트 제목 1</a></td><td style="text-align:center;">2025-06-01</td></tr>
        <tr><td><a href="#">이벤트 제목 2</a></td><td style="text-align:center;">2025-05-28</td></tr>
        <tr><td><a href="#">이벤트 제목 3</a></td><td style="text-align:center;">2025-05-20</td></tr>
      </tbody>
    </table>
    <div class="center-btn-wrap">
      <a href="#" class="all-notice-btn">
        <i class="bi bi-plus-circle"></i> 전체 이벤트 보기
      </a>
    </div>
  </div>
</div>

</body>
</html>
