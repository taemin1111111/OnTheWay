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
		
		var hg_num=$(this).attr("hgId");
		
		location.href="../details/info.jsp?hg_id="+hg_num;
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
    
    <form method="get" action="map.jsp">
	    <input type="text" name="searchName" placeholder="검색할 휴게소 이름을 입력하세요." style="width:500px;" id="sName">&nbsp;&nbsp;&nbsp;
	    
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
		for(hgRestDto dto:list)
		{
			%>
			<tr >
				<td ><%=n++ %></td>
				<td><a class="hg_num" hgId=<%=dto.getId() %> style="cursor: pointer;"><%=dto.getName() %></a></td>
				<td><%=dto.getTel_no() %></td>				
				<td><%=dao.getReview() %></td>
				<td><%=dto.getAddr() %></td>
			</tr>
		<%}
		%>
	</table>
</div>
<br>


 

 <script>

	
	
    
  
	
 	var searchName = "<%= (searchName == null) ? "" : searchName.trim() %>";
	var map = new kakao.maps.Map(document.getElementById('map'), {
        center: new kakao.maps.LatLng(36.5, 127.5),
        level: 12
    });

    var geocoder = new kakao.maps.services.Geocoder();

    var addresses = [
    	<%
    	    for (int i = 0; i < list.size(); i++) {
    	        String addr = list.get(i).getAddr(); 
    	        out.print("\"" + addr.replace("\"", "\\\"") + "\"");
    	        if (i < list.size() - 1) out.print(", ");
    	    }
    	%>
    	];
    
    var names = [
        <% for (int i = 0; i < list.size(); i++) {
            String name = list.get(i).getName();
            out.print("\"" + name.replace("\"", "\\\"") + "\"");
            if (i < list.size() - 1) out.print(", ");
        } %>
    ];
    
     var ids = [
        <% for (int i = 0; i < list.size(); i++) {
        	out.print("\"" + list.get(i).getId() + "\"");
            if (i < list.size() - 1) out.print(", ");
        } %>
    ]; 
    
    
   

    addresses.forEach(function(address,index) {
    	const name = names[index];
        const id = ids[index];
    	
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
                
                 kakao.maps.event.addListener(marker, 'click', function() {
                    window.location.href = '../details/info.jsp?hg_id=' + id;
                }); 
                
               
                
                if(searchName && searchName.length > 0){
                 var infowindow = new kakao.maps.InfoWindow({
                	 content: '<div style="padding:2px; font-size:8px; font-weight:bold; white-space:nowrap;" id=>' + name + '</div>' 
                });
                infowindow.open(map, marker);  
               } 
                
                
            } else {
                console.warn("주소 변환 실패: " + address);
            }
            
            
        });
    });



</script>


</div>

</body>
</html>