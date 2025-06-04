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
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Cute+Font&family=Gamja+Flower&family=Jua&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Noto+Serif+KR:wght@200..900&family=Poor+Story&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44&libraries=services"></script>
<title>Insert title here</title>
<script type="text/javascript">




$(function(){
	$("a.hg_num").click(function(){
		
		var hg_num=$(this).attr("id");
		
		location.href="<%=request.getContextPath()%>/index.jsp?main=details/info.jsp?hg_id="+hg_num;
	})
})

</script>
<style>
    #map {
      width: 700px;
      height: 400px;
    }
    
    a.hg_num{
    text-decoration: none;
    color: black;
    }
    
    a.hg_num:hover{
    
    color:blue;
    text-decoration: underline;    
    }
  </style>  
</head>
<%
request.setCharacterEncoding("utf-8");
String searchName=request.getParameter("searchName");
hgRestDao dao=new hgRestDao();


List<hgRestDto> list;

	if (searchName != null && !searchName.trim().equals("")) {
    	list = dao.getData(searchName); // 검색어가 있을 때
	} else {
    	list = dao.getRestList(); // 전체 조회
	}
%>

<body>


<div style="margin: 100px 100px;" class="container mt-3" >

<h3>고속도로 휴게소</h3>
    <br> 
    
    <form method="get" action="<%=request.getContextPath()%>/index.jsp">
    <input type="hidden" name="main" value="hg/hgRestInfo.jsp">
    <input type="text" name="searchName" placeholder="검색할 휴게소 이름을 입력하세요." style="width:500px;" id="sName">
    <button type="submit" class="btn btn-success" id="search">검색</button>
</form>
    <br>
	<div id="map"></div>
	<br><br>    
	<div style="overflow-y: auto;  max-height: 400px; width:1220px;">	
	<table class="table table-bordered" style="width:1200px;">
		<tr class="table-success" align="center">			
			<th style="width:50; align:center;">번호</th>
			<th style="width:100; align:center;">이름</th>
			<th style="width:150; align:center;">전화번호</th>			
			<th style="width:100; align:center;">평점</th>
			<th style="width:200; align:center;">주소</th>
		</tr>	
		
		<%int n=1;
		 int i = 0;
		for(hgRestDto dto:list)
		{
			%>
			<tr >
				<td ><%=n++ %></td>
				<td><a class="hg_num" href="<%=request.getContextPath()%>/index.jsp?main=details/info.jsp?hg_id=<%= dto.getId2() %>"><%= dto.getName() %></a></td>
				<td><%=dto.getTel_no() %></td>				
				<td><%=dao.getReview() %></td>
				<td class="addr-cell" data-index="<%= i %>"></td>
			</tr>
		<% i++; }
		%>
	</table>
</div>
<br>


 <script>

 var searchName = "<%= searchName != null ? searchName.trim() : "" %>";
 var map = new kakao.maps.Map(document.getElementById('map'), {
	    center: new kakao.maps.LatLng(36.5, 127.5),
	    level: 12
	});

	var geocoder = new kakao.maps.services.Geocoder();

	// JSP에서 값 전달
	var lats = [<%= String.join(",", list.stream().map(dto -> String.valueOf(dto.getLatitude())).toArray(String[]::new)) %>];
	var lngs = [<%= String.join(",", list.stream().map(dto -> String.valueOf(dto.getLongitude())).toArray(String[]::new)) %>];
	var names = [<%= String.join(",", list.stream().map(dto -> "\"" + dto.getName().replace("\"", "\\\"") + "\"").toArray(String[]::new)) %>];
	var ids = [<%= String.join(",", list.stream().map(dto -> "\"" + dto.getId2() + "\"").toArray(String[]::new)) %>];

	for (let i = 0; i < lats.length; i++) {
	    let lat = parseFloat(lats[i]);
	    let lng = parseFloat(lngs[i]);
	    let name = names[i];
	    let id = ids[i];

	    if (isNaN(lat) || isNaN(lng)) {
	        console.warn(`잘못된 좌표: index ${i}, lat=${lat}, lng=${lng}`);
	        continue;
	    }

	    let coords = new kakao.maps.LatLng(lat, lng);

	    let marker = new kakao.maps.Marker({
	        map: map,
	        position: coords
	    });

	    kakao.maps.event.addListener(marker, 'click', function() {
	        window.location.href = '<%=request.getContextPath()%>/index.jsp?main=details/info.jsp?hg_id=' + id;
	    });

	    // 주소 변환 후 테이블 채우기
	    (function(index, marker, name, coords) {
	        geocoder.coord2Address(coords.getLng(), coords.getLat(), function(result, status) {
	            if (status === kakao.maps.services.Status.OK) {
	                let roadAddr = result[0].address.address_name;
	                
	                if (searchName.trim() !== "") {
	                let infowindow = new kakao.maps.InfoWindow({
	                    content: '<div style="padding:0px; font-size:5px;">' + name + '</div>'
	                }); 
	                infowindow.open(map, marker);
	                }
	                
	                let cell = document.querySelector('td.addr-cell[data-index="' + index + '"]');
	                if (cell) {
	                    cell.textContent = roadAddr;
	                } else {
	                    console.warn('주소 셀을 찾을 수 없음: index=' + index);
	                }
	            } else {
	                console.warn("주소 변환 실패:", coords);
	            }
	        });
	    })(i, marker, name, coords);
	}


</script>


</div>

</body>
</html>