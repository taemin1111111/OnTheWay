<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GpaData.GpaDto"%>
<%@page import="java.util.List"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 평점 테이블</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<style>
/* 전체 스타일 유지 */
body {
	font-family: 'Nanum Myeongjo', serif;
	padding: 20px;
}
.custom-content-wrapper {
	max-width: 1400px;
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
	width: 12%;
}
.review-table th:nth-child(2), .review-table td:nth-child(2) {
	width: 16%;
}
.review-table th:nth-child(3), .review-table td:nth-child(3) {
	width: 40%;
}
.review-table th:nth-child(4), .review-table td:nth-child(4) {
	width: 12%;
}
.review-table th:nth-child(5), .review-table td:nth-child(5) {
	width: 10%;
	font-size: 13px;
}
.review-table th:nth-child(6), .review-table td:nth-child(6) {
	width: 10%;
	font-size: 13px;
}
.thumb-buttons .btn {
	margin: 0 3px;
}
.review-write-btn {
	padding: 10px 24px;
	font-size: 16px;
	display: inline-block;
}
.review-button-container {
	text-align: right;
	margin-top: 30px;
}
.review-form {
	display: none;
	margin-top: 20px;
	max-width: 900px;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
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
.form-buttons-container {
	text-align: right;
	margin-top: 10px;
}
.form-buttons-container button {
	padding: 8px 20px;
	font-size: 14px;
	margin-left: 6px;
}
/* 별점 */
.star-rating {
	display: flex;
	flex-direction: row;
	width: 160px;
	margin: 0 auto;
}
.star-container {
	position: relative;
	width: 24px;
	height: 24px;
	display: inline-block;
}
.star-base, .star-overlay {
	font-size: 24px;
	line-height: 1;
	position: absolute;
	top: 0;
	left: 0;
}
.star-base {
	color: lightgray;
}
.star-overlay {
	color: gold;
	overflow: hidden;
	width: 0;
}
.star-container[data-value] {
	cursor: pointer;
}
/* 토스트 메시지 */
#toast {
	visibility: hidden;
	min-width: 250px;
	background-color: #333;
	color: #fff;
	text-align: center;
	border-radius: 8px;
	padding: 12px 20px;
	position: fixed;
	z-index: 9999;
	left: 50%;
	bottom: 30px;
	transform: translateX(-50%);
	font-size: 16px;
	opacity: 0;
	transition: opacity 0.5s ease-in-out, visibility 0s linear 0.5s;
}
#toast.show {
	visibility: visible;
	opacity: 1;
	transition: opacity 0.5s ease-in-out;
}
</style>
</head>
<body>
<%
	String success = request.getParameter("success");
	if ("1".equals(success)) {
%>
<script>
	document.addEventListener("DOMContentLoaded", function () {
		showToast("후기 등록이 완료되었습니다.");
	});
</script>
<%
	}
%>

<%
String pageParam = request.getParameter("page");
String order = request.getParameter("order");
if (order == null || order.equals("")) order = "추천순";

int currentPage = (pageParam == null || pageParam.equals("")) ? 1 : Integer.parseInt(pageParam);
int perPage = 12;
int start = (currentPage - 1) * perPage;

String hg_id = request.getParameter("hg_id");
GpaDao dao = new GpaDao();
double avgStars = dao.getAverageStarsByHgId(hg_id);
int totalCount = dao.getCountByHgId(hg_id);
String hgName = dao.getHgName(hg_id);
List<GpaDto> list = dao.getReviewsByHgIdPaging(hg_id, start, perPage, order);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

String userid = (String) session.getAttribute("userId");

%>

<div class="custom-content-wrapper">
	<div class="summary">
		<div>
			<strong><%= hgName %> 평균 평점</strong> <span class="star">★</span> <strong><%=String.format("%.1f", avgStars)%></strong>
			<small>(5점만점)</small> <br>
			<strong><%=totalCount%>개의 평점</strong>
		</div>
		<div>
			<button class="order-btn" onclick="toggleOrder()">
				<i class="bi bi-arrow-down-up"></i> <span id="orderText"><%=order%></span>
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
			<% for (GpaDto dto : list) { %>
			<tr>
				<td><%=dto.getStars()%></td>
				<td><%=dto.getUserid() == null ? "null" : dto.getUserid()%></td>
				<td><%=dto.getContent()%></td>
				<td><%=sdf.format(dto.getWriteday())%></td>
				<td><%=dto.getGood() %></td>
				<td class="thumb-buttons">
					<a href="<%=request.getContextPath()%>/gpa/goodUpdate.jsp?num=<%=dto.getNum()%>&type=up&hg_id=<%=hg_id%>&order=<%=order%>" class="btn btn-sm btn-outline-success">
						<i class="bi bi-hand-thumbs-up"></i>
					</a>
					<a href="<%=request.getContextPath()%>/gpa/goodUpdate.jsp?num=<%=dto.getNum()%>&type=down&hg_id=<%=hg_id%>&order=<%=order%>" class="btn btn-sm btn-outline-danger">
						<i class="bi bi-hand-thumbs-down"></i>
					</a>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>

	<form action="<%=request.getContextPath()%>/gpa/gpaAction.jsp" method="post">
		<input type="hidden" name="userid" value="<%= userid %>">
		<input type="hidden" name="hg_id" value="<%= hg_id %>">
		<input type="hidden" name="order" value="<%= order %>"><!-- ✅ 정렬 상태 유지 -->
		<div class="review-form" id="reviewForm">
			<table>
				<colgroup>
					<col style="width: 20%;">
					<col style="width: 15%;">					
					<col style="width: 65%;">
				</colgroup>
				<tbody>
					<tr style="height: 50px;">
						<td style="text-align: center; vertical-align: middle;">
							<div class="star-rating">
								<input type="hidden" name="stars" id="ratingValue">
								<% for (int i = 0; i < 5; i++) { %>
								<div class="star-container" data-value="<%=i + 1%>">
									<i class="bi bi-star-fill star-base"></i>
									<i class="bi bi-star-fill star-overlay"></i>
									<div class="half-hover" style="position: absolute; top: 0; left: 0; width: 50%; height: 100%; z-index: 2;"></div>
									<div class="full-hover" style="position: absolute; top: 0; left: 50%; width: 50%; height: 100%; z-index: 2;"></div>
								</div>
								<% } %>
							</div>
						</td>
						<td>아이디</td>
						
						<td><textarea name="content" class="form-control" placeholder="후기를 입력해주세요..." required></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="form-buttons-container">
				<button class="btn btn-sm btn-primary" type="submit">✅ 작성완료</button>
				<button class="btn btn-sm btn-secondary" type="button" onclick="toggleReviewForm()">❌ 취소</button>
			</div>
		</div>
		<div class="review-button-container">
			<button id="reviewWriteBtn" class="btn btn-primary review-write-btn" type="button" onclick="toggleReviewForm()">✍️ 후기 작성</button>
		</div>
	</form>
</div>

<div id="toast"></div>

<script>
let orderModes = ["추천순", "추천낮은순", "최신순"];
let currentOrderIndex = orderModes.indexOf("<%=order%>");
if (currentOrderIndex < 0) currentOrderIndex = 0;

function toggleOrder() {
	currentOrderIndex = (currentOrderIndex + 1) % orderModes.length;
	const selectedOrder = orderModes[currentOrderIndex];
	const urlParams = new URLSearchParams(window.location.search);
	urlParams.set("order", selectedOrder);
	urlParams.set("page", "1");
	location.href = "<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=" + "<%=hg_id%>" + "&" + urlParams.toString();
}

function toggleReviewForm() {
	const form = document.getElementById("reviewForm");
	const writeBtn = document.getElementById("reviewWriteBtn");
	form.style.display = (form.style.display === "none") ? "block" : "none";
	writeBtn.style.display = (form.style.display === "none") ? "inline-block" : "none";
}

function showToast(message) {
	const toast = document.getElementById("toast");
	toast.textContent = message;
	toast.classList.add("show");
	setTimeout(() => { toast.classList.remove("show"); }, 3000);
}

document.addEventListener("DOMContentLoaded", function () {
	const stars = document.querySelectorAll(".star-container");
	const input = document.getElementById("ratingValue");
	stars.forEach((star, idx) => {
		const half = star.querySelector(".half-hover");
		const full = star.querySelector(".full-hover");
		half.addEventListener("mouseenter", () => updateStars(idx + 0.5));
		full.addEventListener("mouseenter", () => updateStars(idx + 1));
		half.addEventListener("click", () => selectStars(idx + 0.5));
		full.addEventListener("click", () => selectStars(idx + 1));
	});
	let selected = 0;
	function updateStars(value) {
		const containers = document.querySelectorAll(".star-container");
		containers.forEach((c, i) => {
			const overlay = c.querySelector(".star-overlay");
			overlay.style.width = "0";
			if (value >= i + 1) {
				overlay.style.width = "100%";
			} else if (value > i) {
				overlay.style.width = "50%";
			}
		});
	}
	function selectStars(value) {
		selected = value;
		input.value = value;
		updateStars(value);
	}
	updateStars(0);
});
</script>

<%
int totalPage = (int)Math.ceil(totalCount / (double)perPage);
%>
<nav aria-label="Page navigation">
  <ul class="pagination justify-content-center mt-4">
    <% for (int i = 1; i <= totalPage; i++) { %>
      <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
        <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%=hg_id%>&page=<%=i%>&order=<%=order%>"><%=i%></a>
      </li>
    <% } %>
  </ul>
</nav>
</body>
</html>
