<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnTheWay</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

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
    max-width: 1920px;     /* 여기 수정해!! → 최대 너비 조절 */
    margin: 0 auto;
    padding: 0 0;       /* 여기 수정해!! → 좌우 여백 조절 */
}

/* ----------- main.jsp 스타일 ----------- */
.info-box {
    width: 48%; /* 기본값 (두 개 나란히 배치될 때) */
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    margin-bottom: 30px; /* 섹션 간 간격 추가 */
}

.info-box.full-width { /* 이벤트 섹션처럼 전체 너비를 사용할 때 */
    width: 100%;
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

.modal-header {
	max-width: 100%;
	height: auto;
}
</style>
</head>
<%
   String mainPage="mainform/main.jsp";

  if(request.getParameter("main")!=null)
  {
	  mainPage=request.getParameter("main");
  }
%>
<body>

    <jsp:include page="mainform/title.jsp" />

    <div class="centered-content">
        <jsp:include page="<%=mainPage %>"/>
    </div>

    <jsp:include page="mainform/footer.jsp" />

</body>
	<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #003366;">
        <h5 class="modal-title text-white" id="eventModalLabel">📢 이벤트 안내</h5>
        <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <img src="image2/top_01.jpg" alt="이벤트 배너" style="max-width: 100%; height: auto;">
        <div class="form-check mt-3 d-flex justify-content-center">
            <input class="form-check-input" type="checkbox" value="" id="dismissForWeekCheckbox">
            <label class="form-check-label ms-2" for="dismissForWeekCheckbox">
                일주일 동안 다시 보지 않기
            </label>
        </div>
      </div>
      <div class="modal-footer d-flex justify-content-end"> <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const modalElement = document.getElementById('eventModal');
    const modal = new bootstrap.Modal(modalElement);
    const dismissForWeekCheckbox = document.getElementById('dismissForWeekCheckbox');

    // 날짜 계산 (오늘 + 7일)
    function getExpiryDate(days) {
      const date = new Date();
      date.setDate(date.getDate() + days);
      return date.getTime();
    }

    // 모달 표시 조건
    const modalDismissedUntil = localStorage.getItem('eventModalDismissedUntil');
    const now = new Date().getTime();

    if (!modalDismissedUntil || now > parseInt(modalDismissedUntil)) {
      modal.show();
    }

    // 모달이 닫히기 직전(hide.bs.modal)에 체크박스 상태 확인
    modalElement.addEventListener('hide.bs.modal', function () {
        if (dismissForWeekCheckbox.checked) {
            const expiry = getExpiryDate(7);
            localStorage.setItem('eventModalDismissedUntil', expiry);
        }
    });
});
</script>
</html>