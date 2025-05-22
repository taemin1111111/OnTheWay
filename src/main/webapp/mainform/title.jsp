<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light px-4">
	<div
		class="container-fluid d-flex align-items-center justify-content-between">
		<div class="d-flex align-items-center">
			<a class="navbar-brand" href=""> <img
				src="<%=root%>/image/rogo1.png" style="max-height: 60px;">
			</a>
			<ul class="navbar-nav d-flex flex-row ms-5">
				<!-- 휴게소 소개 -->
				<li class="nav-item dropdown me-3 dropdown-hover"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 휴게소 소개 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">개요</a></li>
						<li><a class="dropdown-item" href="#">설립 목적</a></li>
						<li><a class="dropdown-item" href="#">위치 안내</a></li>
						<li><a class="dropdown-item" href="#">운영 시간</a></li>
					</ul></li>

				<!-- 나머지 메뉴들도 동일하게 dropdown-hover 클래스 추가 -->
				<li class="nav-item dropdown me-3 dropdown-hover"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">편의시설</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">주차장</a></li>
						<li><a class="dropdown-item" href="#">화장실</a></li>
						<li><a class="dropdown-item" href="#">흡연실</a></li>
						<li><a class="dropdown-item" href="#">ATM</a></li>
					</ul></li>
				<li class="nav-item dropdown me-3 dropdown-hover"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">먹거리</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">한식</a></li>
						<li><a class="dropdown-item" href="#">분식</a></li>
						<li><a class="dropdown-item" href="#">카페</a></li>
						<li><a class="dropdown-item" href="#">간식코너</a></li>
					</ul></li>
				<li class="nav-item dropdown me-3 dropdown-hover"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">오시는길</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">자가용</a></li>
						<li><a class="dropdown-item" href="#">버스</a></li>
						<li><a class="dropdown-item" href="#">기차</a></li>
						<li><a class="dropdown-item" href="#">네비게이션</a></li>
					</ul></li>
				<li class="nav-item dropdown me-3 dropdown-hover"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">고객센터</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">공지사항</a></li>
						<li><a class="dropdown-item" href="#">문의사항</a></li>
						<li><a class="dropdown-item" href="#">불편접수</a></li>
						<li><a class="dropdown-item" href="#">칭찬게시판</a></li>
					</ul></li>
			</ul>
		</div>
		<div class="d-flex align-items-center">
			<i class="bi bi-person-circle me-2" style="font-size: 1.8rem;"></i> <a
				href="" class="me-3 login-font">로그인</a>
		</div>
	</div>
</nav>

<style>
/* 드롭다운 메뉴 글자 크기 및 패딩 조절 */
.navbar-nav .dropdown-menu .dropdown-item {
	font-size: 20px; /* 원하는 크기로 조절 */
	padding: 10px 20px; /* 여백도 조절 가능 */
}

/* 네비게이션 기본 스타일 */
.navbar-nav .nav-link {
	transition: background 0.4s ease, color 0.4s ease;
}

/* 드롭다운 메뉴 배경 부드러운 그라데이션 변화 + 텍스트 색상 */
.navbar-nav .dropdown-menu .dropdown-item:hover, .navbar-nav .dropdown-menu .dropdown-item:focus
	{
	background: linear-gradient(90deg, #f5f5f5, #e0e0e0);
	color: #333 !important;
	border: none;
	box-shadow: none;
}

/* 드롭다운 토글 마우스 오버 배경변화 (선택사항) */
.navbar-nav .nav-link.dropdown-toggle:hover, .navbar-nav .nav-link.dropdown-toggle:focus,
	.navbar-nav .nav-link.dropdown-toggle:active {
	background: linear-gradient(90deg, #f5f5f5, #e0e0e0);
	color: #333 !important;
	border-radius: 6px;
	outline: none !important;
	box-shadow: none !important;
	border: none !important;
}

/* 로고와 메뉴 사이 띄우기 */
.d-flex.align-items-center>ul.navbar-nav {
	margin-left: 200px !important;
}
</style>

<script>
  // 마우스 오버시 드롭다운 열기
  document.querySelectorAll('.dropdown-hover').forEach(function(dropdown){
    dropdown.addEventListener('mouseenter', function() {
      let toggle = this.querySelector('.dropdown-toggle');
      let dropdownInstance = bootstrap.Dropdown.getOrCreateInstance(toggle);
      dropdownInstance.show();
    });
    dropdown.addEventListener('mouseleave', function() {
      let toggle = this.querySelector('.dropdown-toggle');
      let dropdownInstance = bootstrap.Dropdown.getOrCreateInstance(toggle);
      dropdownInstance.hide();
    });
  });
</script>
