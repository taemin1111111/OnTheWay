<%@page import="GpaData.GpaDao"%>
<%@page import="hg.HgDataDto"%>
<%@page import="hg.HgDataDao"%>
<%@page import="java.util.List"%>
<%@page import="hgDao.hgRestDao"%>
<%@page import="hgDto.hgRestDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap"
	rel="stylesheet"> <!-- 다양한 Google Fonts 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"> <!-- Bootstrap CSS 링크 -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script> <!-- jQuery 라이브러리 링크 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"> <!-- Bootstrap Icons 링크 -->
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44&libraries=services,clusterer"></script> <!-- 카카오 맵 SDK 링크 -->
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	// 휴게소 번호를 클릭하면 해당 상세 페이지로 이동
	$("a.hg_num").click(function(){
		var hg_num=$(this).attr("id"); // 클릭한 링크의 ID를 가져옴
		location.href="<%=request.getContextPath()%>/index.jsp?main=details/info.jsp?hg_id="+hg_num; // 상세 페이지로 이동
	})
})
</script>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif; /* 기본 폰트 설정 */
	background-color: #f9fafb; /* 배경색 설정 */
	color: #212529; /* 기본 글자 색상 설정 */
	margin: 0; /* 기본 여백 제거 */
	padding: 0; /* 기본 패딩 제거 */
}
.container {
	max-width: 1200px; /* 최대 너비 설정 */
	margin: 100px auto 50px auto; /* 상단 및 하단 여백 설정 */
	padding: 0 20px; /* 패딩 설정 */
	background: #fff; /* 배경색 흰색 */
	border-radius: 12px; /* 모서리 둥글게 설정 */
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}
h3 {
	font-weight: 700; /* 글자 두께 설정 */
	font-size: 2.2rem; /* 글자 크기 설정 */
	margin-bottom: 25px; /* 하단 여백 설정 */
	color: #2c7a2c; /* 제목 색상 설정 */
	text-align: center; /* 중앙 정렬 */
	padding-top: 50px;
}
form {
	display: flex; /* 플렉스 박스 사용 */
	flex-direction: column; /* 세로 정렬 */
	align-items: center; /* 중앙 정렬 */
	gap: 15px; /* 요소 간 간격 설정 */
	margin-bottom: 30px; /* 하단 여백 설정 */
	max-width: 500px; /* 최대 너비 설정 */
	margin-left: auto; /* 왼쪽 여백 자동 */
	margin-right: auto; /* 오른쪽 여백 자동 */
}
form input[type="text"] {
	width: 100%; /* 너비 100% 설정 */
	padding: 12px 20px; /* 패딩 설정 */
	border: 2px solid #28a745; /* 테두리 색상 설정 */
	border-radius: 40px; /* 모서리 둥글게 설정 */
	font-size: 1rem; /* 글자 크기 설정 */
	transition: border-color 0.3s ease, box-shadow 0.3s ease; /* 전환 효과 설정 */
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 효과 */
}
form input[type="text"]:focus {
	outline: none; /* 포커스 시 외곽선 제거 */
	border-color: #1b4d1b; /* 포커스 시 테두리 색상 변경 */
	box-shadow: 0 0 8px rgba(40, 167, 69, 0.6); /* 포커스 시 그림자 효과 */
}
form button {
	width: 100%; /* 너비 100% 설정 */
	max-width: 200px; /* 최대 너비 설정 */
	background-color: #28a745; /* 배경색 설정 */
	border: none; /* 테두리 제거 */
	color: white; /* 글자 색상 흰색 */
	padding: 12px 0; /* 패딩 설정 */
	font-weight: 600; /* 글자 두께 설정 */
	border-radius: 40px; /* 모서리 둥글게 설정 */
	font-size: 1rem; /* 글자 크기 설정 */
	cursor: pointer; /* 커서 포인터로 변경 */
	box-shadow: 0 4px 10px rgba(40, 167, 69, 0.5); /* 그림자 효과 */
	transition: background-color 0.3s ease, box-shadow 0.3s ease; /* 전환 효과 설정 */
}
form button:hover {
	background-color: #1b4d1b; /* 호버 시 배경색 변경 */
	box-shadow: 0 6px 14px rgba(27, 77, 27, 0.7); /* 호버 시 그림자 효과 */
}
/* 체크박스 그룹 전체 세로 정렬 */
.checkbox-group {
	display: flex; /* 플렉스 박스 사용 */
	flex-direction: column; /* 세로 정렬 */
	gap: 10px; /* 요소 간 간격 설정 */
	width: 100%; /* 너비 100% 설정 */
}
/* 각 체크박스 + 라벨 묶음 (라벨 위 텍스트) */
.checkbox-wrapper {
	display: flex; /* 플렉스 박스 사용 */
	flex-direction: column; /* 세로 정렬 */
	align-items: flex-start; /* 왼쪽 정렬 */
	font-weight: 600; /* 글자 두께 설정 */
	font-size: 1rem; /* 글자 크기 설정 */
	color: #333; /* 글자 색상 설정 */
	cursor: pointer; /* 커서 포인터로 변경 */
	user-select: none; /* 텍스트 선택 방지 */
}
.checkbox-wrapper input[type="checkbox"] {
	accent-color: #28a745; /* 체크박스 색상 설정 */
	width: 18px; /* 체크박스 너비 설정 */
	height: 18px; /* 체크박스 높이 설정 */
	margin-top: 4px; /* 상단 여백 설정 */
	cursor: pointer; /* 커서 포인터로 변경 */
}
.checkbox-group-horizontal {
	display: flex; /* 플렉스 박스 사용 */
	gap: 20px; /* 체크박스 간 간격 설정 */
	align-items: center; /* 세로 가운데 정렬 */
	margin-top: 10px; /* 상단 여백 설정 */
}
#map {
	width: 100%; /* 너비 100% 설정 */
	max-width: 100%; /* 최대 너비 설정 */
	height: 450px; /* 높이 설정 */
	border-radius: 12px; /* 모서리 둥글게 설정 */
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15); /* 그림자 효과 */
	margin-bottom: 40px; /* 하단 여백 설정 */
}
.table {
	width: 100%; /* 너비 100% 설정 */
	border-radius: 12px; /* 모서리 둥글게 설정 */
	overflow: hidden; /* 내용 넘침 방지 */
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	border-collapse: separate !important; /* 테두리 분리 */
	border-spacing: 0 10px; /* 테이블 셀 간 간격 설정 */
	background: white; /* 배경색 흰색 */
}
.table thead tr {
	background-color: #28a745; /* 헤더 배경색 설정 */
	color: white; /* 헤더 글자 색상 흰색 */
	font-weight: 700; /* 헤더 글자 두께 설정 */
	font-size: 1.1rem; /* 헤더 글자 크기 설정 */
	border-radius: 12px; /* 모서리 둥글게 설정 */
}
.table thead th {
	padding: 15px 20px; /* 패딩 설정 */
	border: none !important; /* 테두리 제거 */
}
.table tbody tr {
	background: #f8f9fa; /* 본문 배경색 설정 */
	transition: background-color 0.3s ease; /* 전환 효과 설정 */
	cursor: default; /* 기본 커서로 설정 */
	border-radius: 12px; /* 모서리 둥글게 설정 */
}
.table tbody tr:hover {
	background-color: #d4edda; /* 호버 시 배경색 변경 */
}
.table tbody td {
	padding: 15px 20px; /* 패딩 설정 */
	vertical-align: middle; /* 수직 정렬 설정 */
	border: none !important; /* 테두리 제거 */
	font-size: 1rem; /* 글자 크기 설정 */
	color: #333; /* 글자 색상 설정 */
}
a.hg_num {
	color: #2c7a2c; /* 링크 색상 설정 */
	font-weight: 600; /* 글자 두께 설정 */
	text-decoration: none; /* 밑줄 제거 */
	transition: color 0.3s ease; /* 전환 효과 설정 */
}
a.hg_num:hover {
	color: #1b4d1b; /* 호버 시 색상 변경 */
	text-decoration: underline; /* 호버 시 밑줄 추가 */
}
@media (max-width: 768px) {
	form {
		width: 100%; /* 너비 100% 설정 */
		max-width: 500px; /* 최대 너비 설정 */
	}
	form button {
		width: 100%; /* 버튼 너비 100% 설정 */
	}
	.checkbox-group {
		max-width: 100%; /* 체크박스 그룹 최대 너비 설정 */
	}
	
	
}
</style>
</head>
<%
request.setCharacterEncoding("utf-8"); // 요청 인코딩 설정
String searchName = request.getParameter("searchName"); // 검색어 가져오기
hgRestDao dao = new hgRestDao(); // DAO 객체 생성
String lpg = request.getParameter("lpg"); // LPG 체크박스 상태 가져오기
String ev = request.getParameter("ev"); // 전기차 체크박스 상태 가져오기
String pharm = request.getParameter("pharm"); // 약국 체크박스 상태 가져오기
List<hgRestDto> list; // 휴게소 리스트 선언
if (searchName != null && !searchName.trim().equals("")) {
	list = dao.getData(searchName, lpg, ev, pharm); // 검색어가 있을 때 데이터 가져오기
} else {
	list = dao.getLpgList(lpg, ev, pharm); // 전체 조회
}
%>
<body>

	<div style="margin: 100px auto;" class="container mt-3" > <!-- 컨테이너 설정 -->
		<h3>고속도로 휴게소</h3> <!-- 제목 -->
		<br>
		<form method="get" action="<%=request.getContextPath()%>/index.jsp" id="ckbox">
			<br>
			<input type="hidden" name="main" value="hg/hgRestInfo.jsp"> <!-- 숨겨진 필드: 메인 페이지 설정 -->
			<input type="text" name="searchName" placeholder="검색할 휴게소 이름을 입력하세요."
				style="width: 500px;" id="sName"
				value="<%=(searchName == null || searchName.trim().equals("")) ? "" : searchName%>"> <!-- 검색어 입력 필드 -->
				<div class="checkbox-group-horizontal"> <!-- 체크박스 그룹 -->
				<label><input type="checkbox" name="lpg" value="Y"
					<%="Y".equals(lpg) ? "checked" : ""%> class="a"> LPG충전소</label> <!-- LPG 체크박스 -->
				<label><input type="checkbox" name="ev" value="Y"
					<%="Y".equals(ev) ? "checked" : ""%> class="a"> 전기차충전소</label> <!-- 전기차 체크박스 -->
				<label><input type="checkbox" name="pharm" value="Y"
					<%="Y".equals(pharm) ? "checked" : ""%> class="a"> 약국</label> <!-- 약국 체크박스 -->
			</div>
			<button type="submit" class="btn btn-success" id="search">검색</button> <!-- 검색 버튼 -->
		</form>
		<br>
		<div id="map"></div> <!-- 지도 표시 영역 -->
		<br>
		<br>
		<div style="overflow-y: auto; max-height: 400px; width: 1180px;" > <!-- 테이블 영역 -->
			<table class="table table-bordered" style="width: 1200px;"> <!-- 테이블 설정 -->
				<tr class="table-success" align="center"> <!-- 테이블 헤더 -->
					<th style="width: 50; align: center;">번호</th>
					<th style="width: 100; align: center;">이름</th>
					<th style="width: 150; align: center;">전화번호</th>
					<th style="width: 100; align: center;">평점</th>
					<th style="width: 200; align: center;">주소</th>
				</tr>
				<%
				int n = 1; // 번호 카운터
				int i = 0; // 인덱스 카운터
				for (hgRestDto dto : list) { // 리스트를 순회
					System.out.println("==== dto 디버깅 ===="+i);
				    System.out.println("ID: " + dto.getId2());
				    System.out.println("이름: " + dto.getName());
				    System.out.println("평점: " + dao.getReview(dto.getAvg_star())+ dto.getAvg_star());
				    System.out.println("위도: " + dto.getLatitude());
				    System.out.println("경도: " + dto.getLongitude());

				
				%>
				<tr>
					<td style="text-align: center"><%=n++%></td> <!-- 번호 출력 -->
					<td><a class="hg_num"
						href="<%=request.getContextPath()%>/index.jsp?main=details/info.jsp?hg_id=<%=dto.getId2()%>"><%=dto.getName()%></a></td> <!-- 이름 링크 -->
					<td><%=dto.getTel_no()%></td> <!-- 전화번호 출력 -->
					<td class="stars" style="color:#F1F24B;">
                    <% for(int a=1; a<=5; a++) { %>
                        <i class="bi <%= (dto.getAvg_star() >= a) ? "bi-star-fill" : (dto.getAvg_star() >= a - 0.5 ? "bi-star-half" : "bi-star") %>"></i>
                    <% } %>
                    </td>
                    <%-- <td><%=dao.getReview(dto.getAvg_star())%>(<%=Math.round(dto.getAvg_star()*100.0)/100.0%>)</td> --%>
					<td><%=dto.getAddress() %></td>
				</tr>
				<%
				i++; // 인덱스 증가
				}
				%>
			</table>
		</div>
		<br>
		<script>
		
		 document.querySelectorAll(".a").forEach(cb => {
		       cb.addEventListener('change', () => {
		           document.querySelector('#ckbox').submit();
		       });
		   });   
		
		
		
		// 지도 먼저 로딩
		 const map = new kakao.maps.Map(document.getElementById('map'), {
		   center: new kakao.maps.LatLng(36.5, 127.5),
		   level: 12
		 });

		 // 클러스터러도 초기화만 함
		 const clusterer = new kakao.maps.MarkerClusterer({
		   map: map,
		   averageCenter: true,
		   minLevel: 12
		 });

		 // 데이터는 미리 준비해둠
		 const lats = [<%= String.join(",", list.stream().map(dto -> String.valueOf(dto.getLatitude())).toArray(String[]::new)) %>];
		const lngs = [<%= String.join(",", list.stream().map(dto -> String.valueOf(dto.getLongitude())).toArray(String[]::new)) %>];
		const names = [<%= String.join(",", list.stream().map(dto -> "\"" + dto.getName().replace("\"", "\\\"") + "\"").toArray(String[]::new)) %>];
		const ids = [<%= String.join(",", list.stream().map(dto -> "\"" + dto.getId2() + "\"").toArray(String[]::new)) %>];

		 // 마커와 오버레이는 일정 시간 뒤 로딩
		 setTimeout(() => {
		   const markers = [];
		   const bounds = new kakao.maps.LatLngBounds();

		   for (let i = 0; i < lats.length; i++) {
		     const lat = parseFloat(lats[i]);
		     const lng = parseFloat(lngs[i]);
		     if (isNaN(lat) || isNaN(lng)) continue;

		     const coords = new kakao.maps.LatLng(lat, lng);
		     bounds.extend(coords);

		     const marker = new kakao.maps.Marker({ position: coords });
		     marker.setMap(null);

		     kakao.maps.event.addListener(marker, 'click', () => {
		       location.href = '<%=request.getContextPath()%>/index.jsp?main=details/info.jsp&hg_id=' + ids[i];
		     });

		     markers.push(marker);
		   }

		   clusterer.addMarkers(markers);
		   map.setBounds(bounds);

		 }, 10); // 1초 후 마커 로딩
		 </script>

	</div>
	
</body>
</html>
  