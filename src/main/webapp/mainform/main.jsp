<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세미프로젝트</title>
<style>
/* 공지사항, 이벤트 박스 크기 조절은 이걸로 조절해! */
.info-box {
	width: 40%; /* 이거 수정해! → 각각 박스 너비 */
	padding: 20px; /* 이거 수정해! → 박스 안 여백 */
	margin-right: 10%; /* 이거 수정해! → 박스 간격 */
	min-height: 250px; /* 이거 수정해! → 최소 높이 */
	max-height: 550x; /* 이거 수정해! → 최대 높이 */
	overflow-y: auto; /* 이거 수정해! → 내용 넘칠 때 세로 스크롤 */
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
	background-color: white;
	border-radius: 8px;
	display: inline-block;
	vertical-align: top;
}

.info-box:last-child {
	margin-right: 0;
}

.info-box h6 {
	text-align: center;
	margin-bottom: 15px;
	font-size: 30px; /* 이거 수정해! → 제목 글씨 크기 */
	font-weight: 700;
	color: #222; /* 이거 수정해! → 제목 색상 */
}

.info-box table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 0;
}

.info-box table thead th {
	font-size: 15px; /* 이거 수정해! → 테이블 헤더 글씨 크기 */
	font-weight: 700;
	color: #444; /* 이거 수정해! → 테이블 헤더 색상 */
	border-bottom: 1px solid #ddd;
	padding: 8px 0;
	text-align: left;
}

.info-box table thead th:nth-child(2) {
	text-align: center;
}

.info-box table tbody tr td a {
	font-size: 15px; /* 이거 수정해! → 링크 글씨 크기 */
	font-weight: 500;
	color: #333; /* 이거 수정해! → 링크 색상 */
	text-decoration: none;
}

.info-box table tbody tr td {
	vertical-align: middle;
	font-size: 18px; /* 이거 수정해! → 본문 글씨 크기 */
	color: #666; /* 이거 수정해! → 본문 글자 색 */
	padding: 7px 0;
	border-bottom: 1px solid #f1f1f1;
	text-align: left;
}

.info-box table tbody tr:hover {
	background-color: #f9f9f9;
}

.center-btn-wrap {
	text-align: center;
	margin-top: 15px;
}

.all-notice-btn {
	display: inline-flex;
	align-items: center;
	gap: 5px;
	font-size: 20px; /* 이거 수정해! → 버튼 글씨 크기 */
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

.main-wrap {
	width: 100%;
	text-align: center;
	margin-top: 40px;
}
</style>


</head>
<body>
	<div style="margin: 30px 0 10px 0; text-align: center;">
		<h5 style="font-size: 28px; font-weight: 700;">세미프로젝트</h5>
		<p style="font-size: 17px;">프로젝트 메인 화면 구성중입니다</p>
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
					<tr>
						<td><a href="#">공지사항 제목 1</a></td>
						<td style="text-align: center;">2024-05-22</td>
					</tr>
					<tr>
						<td><a href="#">공지사항 제목 2</a></td>
						<td style="text-align: center;">2024-05-21</td>
					</tr>
					<tr>
						<td><a href="#">공지사항 제목 3</a></td>
						<td style="text-align: center;">2024-05-20</td>
					</tr>
				</tbody>
			</table>
			<div class="center-btn-wrap">
				<a href="#" class="all-notice-btn"> <i class="bi bi-plus-circle"></i>
					전체 공지사항 보기
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
					<tr>
						<td><a href="#">이벤트 제목 1</a></td>
						<td style="text-align: center;">2025-06-01</td>
					</tr>
					<tr>
						<td><a href="#">이벤트 제목 2</a></td>
						<td style="text-align: center;">2025-05-28</td>
					</tr>
					<tr>
						<td><a href="#">이벤트 제목 3</a></td>
						<td style="text-align: center;">2025-05-20</td>
					</tr>
				</tbody>
			</table>
			<div class="center-btn-wrap">
				<a href="#" class="all-notice-btn"> <i class="bi bi-plus-circle"></i>
					전체 이벤트 보기
				</a>
			</div>
		</div>
	</div>
</body>
</html>
