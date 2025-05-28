<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 평점 테이블</title>

<!-- 폰트 -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<style>
body {
	font-family: 'Nanum Myeongjo', serif;
	padding: 20px;
}

/* 흰색공간 조절! → 본문 최대 너비 및 중앙 정렬 */
.custom-content-wrapper {
	max-width: 1400px; /* 흰색공간 조절! */
	margin: 0 auto;
	padding: 0 16px;
}

.summary {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.star {
	color: #FFD700;
	font-size: 24px;
	margin: 0 5px;
}

.order-btn {
	background-color: transparent;
	border: none;
	font-weight: bold;
	font-size: 18px;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 5px;
	margin-right: 105px;
}

table.review-table {
	width: 100%;
	margin-top: 20px;
	border-collapse: collapse;
}

table.review-table th, table.review-table td {
	border: 1px solid #000;
	padding: 12px;
	text-align: center;
	vertical-align: middle;
}

table.review-table th {
	background-color: #f8f9fa;
	font-weight: bold;
}

.review-table th:nth-child(1), .review-table td:nth-child(1) {
	width: 10%; /* 평점칸 이거 수정해! */
}

.review-table th:nth-child(2), .review-table td:nth-child(2) {
	width: 15%; /* 아이디칸 이거 수정해! */
}

.review-table th:nth-child(3), .review-table td:nth-child(3) {
	width: 50%; /* 후기칸 이거 수정해! */
}

.review-table th:nth-child(4), .review-table td:nth-child(4) {
	width: 10%;
}

.review-table th:nth-child(5), .review-table td:nth-child(5) {
	width: 4%;
	font-size: 13px;
}

.review-table th:nth-child(6), .review-table td:nth-child(6) {
	width: 8%;
	font-size: 13px;
}

.thumb-buttons .btn {
	margin: 0 3px;
}

/* 후기 작성 버튼 크기 및 위치 조절 가능하게 */
.review-write-btn {
	padding: 10px 24px; /* 이거 변경해! */
	font-size: 16px; /* 이거 변경해! */
	display: inline-block;
}

.review-button-container {
	text-align: right;
	margin-top: 30px; /* 이거 변경해! */
}

.review-form {
	display: none;
	margin-top: 20px;
}

.review-form table {
	width: 100%;
	border-collapse: collapse;
}

.review-form th, .review-form td {
	border: 1px solid #000;
	padding: 10px;
	text-align: center;
}

.review-form textarea {
	width: 100%;
	height: 60px;
	resize: none;
}

/* 작성완료 / 취소 버튼 위치 조절 */
.form-buttons-container {
	text-align: right;
	margin-top: 10px; /* 이거 변경해! */
}

.form-buttons-container button {
	padding: 8px 20px; /* 이거 변경해! → 버튼 내부 여백 */
	font-size: 14px; /* 이거 변경해! → 버튼 글자 크기 */
	margin-left: 6px; /* 이거 변경해! → 버튼 사이 간격 */
}
</style>

<script>
    let orderModes = ["추천순", "추천낮은순", "최신순"];
    let currentOrderIndex = 0;

    function toggleOrder() {
        currentOrderIndex = (currentOrderIndex + 1) % orderModes.length;
        document.getElementById("orderText").innerText = orderModes[currentOrderIndex];
    }

    function toggleReviewForm() {
        const form = document.getElementById("reviewForm");
        const writeBtn = document.getElementById("reviewWriteBtn");
        if (form.style.display === "none") {
            form.style.display = "block";
            writeBtn.style.display = "none";
        } else {
            form.style.display = "none";
            writeBtn.style.display = "inline-block";
        }
    }
</script>
</head>
<body>
	<jsp:include page="/mainform/title.jsp" />

	<div class="custom-content-wrapper">
		<div class="summary">
			<div>
				<div>
					<strong>##휴게소 평균 평점</strong> <span class="star">★</span> ## <small>(5점만점)</small>
				</div>
				<div>
					<strong>##개의 평점</strong>
				</div>
			</div>
			<div>
				<button class="order-btn" onclick="toggleOrder()">
					<i class="bi bi-arrow-down-up"></i> <span id="orderText">추천순</span>
				</button>
			</div>
		</div>

		<table class="review-table">
			<thead>
				<tr>
					<th>평점</th>
					<th>아이디</th>
					<th>방문객 후기</th>
					<th>후기 작성일</th>
					<th>후기 추천수</th>
					<th>평점 추천</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>##</td>
					<td>##</td>
					<td>##</td>
					<td>##</td>
					<td>##</td>
					<td class="thumb-buttons">
						<button class="btn btn-sm btn-outline-success">
							<i class="bi bi-hand-thumbs-up"></i>
						</button>
						<button class="btn btn-sm btn-outline-danger">
							<i class="bi bi-hand-thumbs-down"></i>
						</button>
					</td>
				</tr>
			</tbody>
		</table>

		<!-- 후기 작성 폼 -->
		<div class="review-form" id="reviewForm">
			<table>
				<thead>
					<tr>
						<th>평점</th>
						<th>아이디</th>
						<th>후기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>##</td>
						<td>##</td>
						<td><textarea placeholder="후기를 입력하세요..."></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="form-buttons-container">
				<button class="btn btn-sm btn-primary" onclick="toggleReviewForm()">✅
					작성완료</button>
				<button class="btn btn-sm btn-secondary"
					onclick="toggleReviewForm()">❌ 취소</button>
			</div>
		</div>

		<!-- 후기 작성 버튼 -->
		<div class="review-button-container">
			<button id="reviewWriteBtn" class="btn btn-primary review-write-btn"
				onclick="toggleReviewForm()">✍️ 후기 작성</button>
		</div>
	</div>

	<jsp:include page="/mainform/footer.jsp" />
</body>
</html>
