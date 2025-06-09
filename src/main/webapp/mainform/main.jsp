<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hgDto.infoDto"%>
<%@page import="hgDao.infoDao"%>
<%@page import="hg.HgDataDao"%>
<%@page import="event.EventDao"%>
<%@page import="java.util.List"%>
<%@page import="event.EventDto"%>
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
	href="https://fonts.googleapis.com/css2?family=Krona+One&family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<style>
/* --- 🎨 2024-2025 통합 디자인 시스템 (확장) --- */
:root {
    --primary-color: #28a745; /* 고속도로 관련: 녹색 계열 */
    --accent-color: #ffc107; /* 강조 (노란색) */
    --background-color: #f7f9fc; /* 전체 배경 */
    --card-background-color: #ffffff; /* 카드 배경 */
    --text-primary: #212529;
    --text-secondary: #5a6573;
    --text-muted: #8a95a3;
    --border-color: #e0e4e8; /* 테두리 색상 좀 더 부드럽게 */
    --success-color: #28a745;
    --danger-color: #dc3545;
    --button-primary-bg: #28a745;
    --button-primary-hover-bg: #218838;
    --button-danger-bg: #dc3545;
    --button-danger-hover-bg: #c82333;

    --font-family-main: 'Noto Sans KR', sans-serif;
    --font-family-logo: 'Krona One', sans-serif;
    --border-radius-sm: 8px;
    --border-radius-md: 12px;
    --border-radius-lg: 16px;
    --shadow-soft: 0 4px 12px rgba(0, 0, 0, 0.05); /* 그림자 좀 더 은은하게 */
    --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.08); /* 그림자 좀 더 은은하게 */

    --gap-sm: 1rem;
    --gap-md: 1.5rem;
    --gap-lg: 2rem;
}

body {
	font-family: var(--font-family-main);
	background: var(--background-color);
	margin: 0;
	padding-top: 0px;
	position: relative;
	color: var(--text-primary);
}

.container {
	width: 90%; /* 조금 더 넓게 */
	max-width: 1200px; /* 최대 너비 설정 */
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
	color: var(--text-primary);
	text-shadow: -1px -1px 0 #000;
}

.main-title p {
	font-size: 16px;
	color: var(--text-secondary);
}

.event-section, .notice-section {
	background: var(--card-background-color);
	border-radius: var(--border-radius-md);
	box-shadow: var(--shadow-soft);
	padding: var(--gap-md);
	margin-bottom: var(--gap-lg);
	margin-top: 100px; /* 기존과 동일하게 유지 */
}

.notice-section {
    margin: var(--gap-lg) 0 30px; /* 좌우 마진 0으로 설정, 상단 마진은 var(--gap-lg) */
}

.section-title {
	font-size: 24px;
	font-weight: 700;
	color: var(--text-primary);
	margin-bottom: 20px;
	text-align: center;
}

.event-list {
	display: flex;
	flex-wrap: wrap;
	gap: 2%; /* 카드 사이 간격 */
	justify-content: flex-start; /* 카드들을 시작점부터 정렬 */
}

.event-card {
	width: 32%; /* 3개씩 한 줄에 오도록 100% / 3 = 33.33% - 간격 */
	border: 1px solid var(--border-color);
	border-radius: var(--border-radius-md);
	overflow: hidden;
	text-align: center;
	transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
	display: flex; /* 내부 요소 정렬을 위해 flex 추가 */
	flex-direction: column; /* 세로 방향으로 정렬 */
	justify-content: space-between; /* 내용과 더보기 버튼 사이 공간 확보 */
	margin-bottom: 20px; /* 각 카드 하단 여백 추가 */
    text-decoration: none; /* 링크 밑줄 제거 */
    color: inherit; /* 링크 색상 상속 */
}

.event-card:hover {
	transform: translateY(-5px);
    box-shadow: var(--shadow-medium);
}

.event-card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.event-card .event-title {
    font-size: 1.1em;
    font-weight: 700;
    color: var(--text-primary);
    padding: 10px 15px 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.event-card .event-info {
	padding: 0px 15px 15px; /* 상단 패딩 제거, 하단 유지 */
	font-size: 0.9em;
	color: var(--text-secondary);
}

.event-card .event-info strong {
	color: var(--primary-color);
}


/* "더 보기" 버튼 스타일 통일 및 개선 */
.more-btn {
	display: flex; /* flexbox 사용 */
	justify-content: flex-end; /* 우측 정렬 */
	margin-top: 20px;
	padding-right: 10px; /* 우측 패딩 추가 */
}

.more-btn a {
	display: inline-flex;
	align-items: center;
	gap: 5px;
	font-size: 16px;
	color: var(--primary-color); /* 테마 색상으로 변경 */
	text-decoration: none;
	font-weight: 600; /* 글씨 굵게 */
	transition: color 0.2s, text-decoration 0.2s;
}

.more-btn a:hover {
	color: var(--button-primary-hover-bg); /* 호버 색상 */
	text-decoration: underline;
}

.notice-table {
	width: 100%;
	border-collapse: collapse;
}

.notice-table th, .notice-table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid var(--border-color);
}

.notice-table th {
	font-size: 14px;
	font-weight: 700;
	color: var(--text-secondary);
	background-color: #f8f9fa; /* 헤더 배경색 */
}

.notice-table td {
	font-size: 14px;
	color: var(--text-primary);
}

.notice-table td a {
	color: var(--text-primary);
	text-decoration: none;
	transition: color 0.2s;
}

.notice-table td a:hover {
	color: var(--primary-color);
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
	width: 100%; /* 너비를 100%로 설정하여 화면 전체 차지 */
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
	font-family: var(--font-family-logo);
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
  background: var(--card-background-color);
  padding: 10px 0;
  box-shadow: var(--shadow-soft);
  z-index: 1000;
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative; /* z-index 적용을 위해 필요 */
}

.search-input {
  width: 400px;
  max-width: 90vw;
  font-size: 16px;
  border-radius: 30px;
  padding-left: 20px;
  border: 1px solid var(--border-color); /* 테두리 추가 */
  transition: box-shadow 0.3s ease, border-color 0.3s ease;
}

.search-input:focus {
  box-shadow: 0 0 8px rgba(40, 167, 69, 0.6);
  border-color: var(--primary-color);
  outline: none;

}

.btn-success {
  border-radius: 30px;
  padding: 8px 20px;
  font-weight: 600;
  background-color: var(--button-primary-bg);
  border-color: var(--button-primary-bg);
  transition: background-color 0.2s, border-color 0.2s;
}

.btn-success:hover {
  background-color: var(--button-primary-hover-bg);
  border-color: var(--button-primary-hover-bg);
}

/* 모바일 대응 */
@media (max-width: 768px) {
    .container {
        width: 95%; /* 모바일에서 컨테이너 너비 확대 */
        padding: 15px 0;
    }
    .event-section, .notice-section {
        padding: var(--gap-sm);
        margin-top: 50px; /* 모바일에서 마진 조정 */
    }
    .event-list {
        flex-direction: column; /* 이벤트 카드 세로 정렬 */
        align-items: center; /* 가운데 정렬 */
        gap: var(--gap-md); /* 세로 간격 조정 */
    }
    .event-card {
        width: 95%; /* 모바일에서 폭 꽉 채우기 */
        margin-bottom: 0; /* 개별 카드 하단 여백 제거 (gap으로 대체) */
    }
    .notice-section {
        width: 100%; /* 모바일에서 전체 너비 차지 (컨테이너 패딩 적용) */
        padding: var(--gap-sm);
    }
    .notice-table th, .notice-table td {
        padding: 10px;
        font-size: 13px; /* 글꼴 크기 약간 줄임 */
    }
    .hero-text h1 {
        font-size: 36px; /* 모바일에서 제목 크기 조정 */
    }
    .hero-text p {
        font-size: 16px; /* 모바일에서 부제목 크기 조정 */
    }
    .search-input {
        max-width: 80vw; /* 모바일에서 검색창 너비 조정 */
        width: 100%;
    }
    .search-bar-container .d-flex {
        flex-direction: column; /* 검색창과 버튼 세로 정렬 */
        gap: 10px; /* 세로 간격 */
        align-items: center;
    }
}
</style>
</head>
<body>
	<div class="hero-section">
		<img src="<%=root%>/imgway/wayway.jpg" alt="고속도로 이미지">
		<div class="hero-text">
			<h1>OnTheWay</h1>
			<p>전국 고속도로 정보.</p>
		</div>
	</div>
	
	<div class="search-bar-container">
	  <form action="<%=root%>/searchResults.jsp" method="get" class="d-flex justify-content-center align-items-center">
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

	<div class="container"> <%-- 이 `div` 태그가 이제 메인 컨텐츠를 감싸줍니다. --%>
		<div class="event-section">
			<div class="section-title">이벤트</div>
			<div class="event-list">
				<%
				EventDao dao = new EventDao();
				List<EventDto> list = dao.getAllEvents();
				HgDataDao hgDao = new HgDataDao();
	
				int count = Math.min(3, list.size()); //3개 띄우기
				for (int i = 0; i < count; i++) {
					EventDto dto = list.get(i);
					String restName = "";
					try {
						restName = hgDao.getRestNameById(Integer.parseInt(dto.getHgId()));
					} catch (Exception e) {
						restName = "알 수 없음";
					}
				%>
				<%-- col-md-4 d-flex mb-4 제거, event-card에 flex 속성 적용 --%>
				<a href="index.jsp?main=event/eventDetail.jsp?id=<%=dto.getId()%>"
					class="event-card"> 
					<%
					if (dto.getPhoto() != null && !dto.getPhoto().isEmpty()) {
					%>
						<img src="eventImage/<%=dto.getPhoto()%>" class="event-photo"
						alt="이벤트 이미지"> 
					<%
					}
					%>
					<div class="event-title"><%=dto.getTitle()%></div>
					<div class="event-info">
						휴게소: <strong><%=restName%></strong>
					</div>
					<div class="event-info">
						기간:
						<%=dto.getStartday()%>
						~
						<%=dto.getEndday()%></div>
				</a>
				<%
				}
				%>
			</div>
			<%-- "더 보기" 버튼을 .more-btn div로 감싸도록 변경 --%>
			<div class="more-btn">
				<a href="<%=root%>/index.jsp?main=event/eventList.jsp">
					<i class="bi bi-arrow-right-circle"></i> 더 보기
				</a>
			</div>
		</div>
	
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
					<%
						// 공지사항 Dao 불러오기
						infoDao inDao=new infoDao();
						List<infoDto> iList = inDao.getBoardList(); // 전체 불러오기
						String  restName = "";//일단 list랑 맞춰서 만들었는데 제목에는 실제로 실행 해보니 필요없을거 같아서 그냥 만들어만 두었음.
						int nCount = Math.min(3, iList.size()); // 최대 3개만 출력
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						for (int i = 0; i < nCount; i++) {
							infoDto iDto= iList.get(i);
							// restName = hgDao.getRestNameById(Integer.parseInt(iDto.getHgId())); // 공지사항에 휴게소명 필요 없으므로 주석 처리
					%>
					<tr>
						<td>
							<a href="index.jsp?main=infoList/detail.jsp?id=<%=iDto.getId()%>">
								<%=iDto.getTitle()%>
							</a>
						</td>
						<td><%=sdf.format(iDto.getWriteday())%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class="more-btn">
				<a href="<%=root%>/index.jsp?main=infoList/infoList.jsp">
					<i class="bi bi-plus-circle"></i> 더 보기
				</a>
			</div>
		</div>
	</div>
</body>
</html>