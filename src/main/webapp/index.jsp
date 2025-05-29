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

<!-- ✅ Swiper.js CDN 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<style>
/* ----------- 전체 공통 스타일 ----------- */
body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}

/* ----------- 중앙 본문 흰 여백 스타일 ----------- */
.centered-content {
    max-width: 1500px;     /* 여기 수정해!! → 최대 너비 조절 */
    margin: 0 auto;
    padding: 0 20px;       /* 여기 수정해!! → 좌우 여백 조절 */
}

/* ----------- main.jsp 스타일 ----------- */
.info-box {
    width: 48%;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
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

/* ----------- footer.jsp 스타일 ----------- */
.footer {
    margin-top: 50px;
    padding: 20px;
    background-color: #eee;
    text-align: center;
}
</style>
</head>
<body>

    <!-- 전체 폭 title -->
    <jsp:include page="mainform/title.jsp" />

    <!-- 중앙 정렬된 본문 -->
    <div class="centered-content">
        <jsp:include page="mainform/photo.jsp" />
        <jsp:include page="mainform/main.jsp" />
    </div>

    <!-- 전체 폭 footer -->
    <jsp:include page="mainform/footer.jsp" />

</body>
</html>
