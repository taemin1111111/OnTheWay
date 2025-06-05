<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>고속도로 메인 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Krona+One&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', Arial, sans-serif;
	background: #f5f6f5;
	margin: 0;
	padding-top: 0px;
	position: relative;
}

.container {
	width: 80%;
	margin: 0 auto;
	padding: 20px 0;
}

.main-title {
	text-align: center;
	margin-bottom: 40px;
}

.main-title h1 {
	font-size: 28px;
	font-weight: 700;
	color: #333;
	text-shadow: -1px -1px 0 #000;
}

.main-title p {
	font-size: 16px;
	color: #666;
}

.event-section, .notice-section {
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	padding: 20px;
	margin-bottom: 30px;
	margin-top: 100px
}

.notice-section {
	max-width: 600px;
	width: 90%;
	margin: 0 auto 30px;
}

.section-title {
	font-size: 24px;
	font-weight: 700;
	color: #333;
	margin-bottom: 20px;
	text-align: center;
}

.event-list {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}

.event-card {
	width: 32%;
	border: 1px solid #eee;
	border-radius: 8px;
	overflow: hidden;
	text-align: center;
	transition: transform 0.2s;
}

.event-card:hover {
	transform: translateY(-5px);
}

.event-card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.event-card .event-info {
	padding: 15px;
}

.event-card .event-info h5 {
	font-size: 16px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.event-card .event-info p {
	font-size: 14px;
	color: #666;
	margin: 0;
}

.more-btn {
	display: block;
	text-align: center;
	margin-top: 20px;
}

.more-btn a {
	display: inline-flex;
	align-items: center;
	gap: 5px;
	font-size: 16px;
	color: #2c7a2c;
	text-decoration: none;
}

.more-btn a:hover {
	color: #1b4d1b;
	text-decoration: underline;
}

.notice-table {
	width: 100%;
	border-collapse: collapse;
}

.notice-table th, .notice-table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #eee;
}

.notice-table th {
	font-size: 14px;
	font-weight: 700;
	color: #444;
}

.notice-table td {
	font-size: 14px;
	color: #666;
}

.notice-table td a {
	color: #333;
	text-decoration: none;
}

.notice-table td a:hover {
	text-decoration: underline;
}

.footer {
	background: #eee;
	padding: 20px;
	text-align: center;
	margin-top: 50px;
}

.hero-section {
	position: relative;
	width: 100%;
	height: 400px;
	overflow: hidden;
}

.hero-section img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	animation: zoomIn 15s ease-in-out forwards;
	z-index: 1;
}

.hero-text {
	position: absolute;
	top: 20%;
	width: 100%;
	text-align: center;
	z-index: 2;
	color: white;
	text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.6);
}

.hero-text h1 {
	font-family: 'Krona One', sans-serif;
	font-size: 48px;
	font-weight: 800;
	margin: 0;
}

.hero-text p {
	font-size: 20px;
	margin-top: 10px;
}

@keyframes zoomIn {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(1.1);
  }
}

.search-bar-container {
  background: #fff;
  padding: 10px 0;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  z-index: 1000;
  width: 100%;
  display: flex;
  justify-content: center;
}

.search-input {
  width: 400px;
  max-width: 90vw;
  font-size: 16px;
  border-radius: 30px;
  padding-left: 20px;
  transition: box-shadow 0.3s ease;
}

.search-input:focus {
  box-shadow: 0 0 8px rgba(40, 167, 69, 0.6);
  border-color: #28a745;
  outline: none;
}

.btn-success {
  border-radius: 30px;
  padding: 8px 20px;
  font-weight: 600;
}
</style>
</head>
<body>
	<!-- 메인 히어로 섹션 -->
	<div class="hero-section">
		<img src="<%=root%>/imgway/wayway.jpg" alt="고속도로 이미지">
		<div class="hero-text">
			<h1>OnTheWay</h1>
			<p>전국 고속도로 정보.</p>
		</div>
	</div>
	
	<!-- 검색창 섹션 -->
<div class="search-bar-container">
  <form action="<%=root%>/searchResults.jsp" method="get" class="d-flex justify-content-center">
    <input 
      type="text" 
      name="query" 
      class="form-control search-input" 
      placeholder="검색어를 입력하세요" 
      aria-label="검색어" 
      required />
    <button type="submit" class="btn btn-success ms-2">
      <i class="bi bi-search"></i> 검색
    </button>
  </form>
</div>

	<!-- 이벤트 섹션 -->
	<div class="event-section">
		<div class="section-title">이벤트</div>
		<div class="event-list">
			<div class="event-card">
				<img src="<%=root%>/imgway/ye.jpg" alt="이벤트 1">
				<div class="event-info">
					<h5>시흥 연꽃 축제</h5>
					<p>2025.07.22(화) ~ 2025.07.23(수)</p>
				</div>
			</div>
			<div class="event-card">
				<img src="<%=root%>/imgway/ma.jpg" alt="이벤트 2" style="height: 300px;">
				<div class="event-info">
					<h5>논산 딸기 축제</h5>
					<p>2025.03.27(목) ~ 2025.03.30(일)</p>
				</div>
			</div>
			<div class="event-card">
				<img src="<%=root%>/imgway/su.png" alt="이벤트 3"
					style="width: 300px; height: 300px;">
				<div class="event-info">
					<h5>여수 밤 바다 축제</h5>
					<p>2025.08.22(금) ~ 2025.08.24(일)</p>
				</div>
			</div>
		</div>
		<div class="more-btn">
			<a href="<%=root%>/event/eventList.jsp"><i
				class="bi bi-arrow-right-circle"></i> 더 보기</a>
		</div>
	</div>

	<!-- 공지사항 섹션 -->
	<div class="notice-section">
		<div class="section-title">공지사항</div>
		<table class="notice-table">
			<thead>
				<tr>
					<th>제목</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="#">TLS 1.0, TLS 1.1 비활성화 관련 공지</a></td>
					<td>2025.04.18</td>
				</tr>
				<tr>
					<td><a href="#">고속도로 공공데이터포털 파일 저장장치 서비스 전환 관련 알림</a></td>
					<td>2025.04.10</td>
				</tr>
				<tr>
					<td><a href="#">고속도로 공공데이터 포털 순연(서비스 일부) 알림</a></td>
					<td>2025.04.05</td>
				</tr>
			</tbody>
		</table>
		<div class="more-btn">
			<a href="<%=root%>/noticeList.jsp"><i class="bi bi-plus-circle"></i>
			전체 공지사항 보기</a>
		</div>
	</div>
	</div>
</body>
</html>