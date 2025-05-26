<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세미프로젝트</title>

<!-- 구글 폰트: Noto Sans KR -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- 부트스트랩 CSS & JS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<style>
/* ----------- [title.jsp 관련 스타일] ----------- */
body {
    font-family: 'Noto Sans KR', sans-serif;
}
nav.navbar {
    background-color: #ffffff !important;
}
.nav-item > a {
    font-size: 21px;
    font-weight: 500;
}
.nav-item.dropdown > a::after {
    display: none !important;
}
.login-font {
    font-family: Arial, sans-serif !important;
    font-size: 18px;
    font-weight: 700;
    letter-spacing: 0.5px;
}

/* ----------- [photo.jsp 관련 스타일] ----------- */
.carousel img {
    width: 100%;
    height: auto;
}
.carousel-item img {
    height: 55vh;
    object-fit: cover;
}

/* ----------- [main.jsp 관련 스타일] ----------- */
.info-box {
    width: 48%;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    background-color: white;
    border-radius: 8px;
}

/* 공지사항 제목 스타일 */
.info-box h6 {
    text-align: center;
    margin-bottom: 15px;
    font-size: 30px;
    font-weight: 700;
    color: #222222;
}

/* 테이블 헤더 */
.info-box table thead th {
    font-size: 18px;
    font-weight: 700;
    color: #444444;
}

/* 날짜 헤더 중앙 정렬 */
.info-box table thead th:nth-child(2) {
    text-align: center;
}

/* 링크 스타일 */
.info-box table tbody tr td a {
    font-size: 20px;
    font-weight: 500;
    color: #333;
    text-decoration: none;
}

/* 일반 내용 */
.info-box table tbody tr td {
    vertical-align: middle;
    font-size: 18px;
    color: #666666;
}

/* 호버 배경색 */
.info-box table tbody tr:hover {
    background-color: #f9f9f9;
}

/* 전체 공지사항 보기 버튼 스타일 */
.all-notice-btn {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    font-size: 16px;
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

/* 자주가는 메뉴 버튼 */
.info-box.d-flex .btn {
    font-size: 18px;
    padding: 10px 0;
}
.info-box.d-flex .btn-outline-success {
    color: #2c7a2c;
    border-color: #2c7a2c;
}
.info-box.d-flex .btn-outline-success:hover {
    background-color: #2c7a2c;
    color: white;
}

/* 공통 footer */
.footer {
    margin-top: 50px;
    padding: 20px;
    background-color: #eee;
    text-align: center;
}
</style>
</head>
<body>
    <jsp:include page="mainform/title.jsp" />
    <jsp:include page="mainform/photo.jsp" />
    <jsp:include page="mainform/main.jsp" />
    <jsp:include page="mainform/footer.jsp" />
</body>
</html>
