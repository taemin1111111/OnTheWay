<%@page import="java.util.List"%>
<%@page import="hgDto.hgRestDao"%>
<%@page import="hgDao.hgRestDto"%>
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
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44"></script>  
<title>Insert title here</title>
<script type="text/javascript">
	
	
	
	
	
	
	
	
	

</script>


<style>
    #map {
      width: 700px;
      height: 400px;
    }
  </style>  


</head>
<%
request.setCharacterEncoding("utf-8");

String searchName=request.getParameter("searchName");

System.out.println(searchName);



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
    
    <form method="get" action="hgRestInfo.jsp">
	    <input type="text" name="searchName" placeholder="검색할 휴게소 이름을 입력하세요." style="width:500px;">&nbsp;&nbsp;&nbsp;
	    
	    <button type="submit" class="btn btn-success" id="search">검색</button>
	</form>
    <br>
    <br>
    <br>

	<div style="overflow-y: auto;  max-height: 400px;">
	<table class="table table-bordered">
		<tr class="table-success" align="center">
			<th style="width:50; align:center;">번호</th>
			<th style="width:100; align:center;">이름</th>
			<th style="width:150; align:center;">전화번호</th>
			<th style="width:150; align:center;">편의시설</th>
			<th style="width:100; align:center;">평점</th>
			<th style="width:350; align:center;">주소</th>
			
		
		
		
		</tr>	
		<%int n=1;
		for(hgRestDto dto:list)
		{
		%>
			<tr>
				<td><%=n++ %></td>
				<td><%=dto.getName() %></td>
				<td><%=dto.getTel_no() %></td>
				<td></td>
				<td><%=dao.getReview() %></td>
				<td><%=dto.getAddr() %></td>
				
				
				
			</tr>
			
			
		<%}
		
		
		
		
		
		%>
	
	
	
	
	</table>
</div>
<br>


 <div id="map"></div>

 <script>
window.onload = function() {
    const container = document.getElementById('map');
    const options = {
        center: new kakao.maps.LatLng(37.459939, 127.042514),
        level: 3
    };
    const map = new kakao.maps.Map(container, options);
};


	
	
		









</script>


</div>



</body>
</html>