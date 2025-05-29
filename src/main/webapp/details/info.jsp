<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Import necessary DAOs, DTOs, and utility classes --%>
<%@ page import="hg.HgDao, hg.HgDto" %>
<%@ page import="conv.ConvDao, conv.ConvDto" %>
<%@ page import="brand.BrandDao, brand.BrandDto" %>
<%@ page import="java.util.List, java.util.ArrayList" %> <%-- Using List now, but Vector is also fine --%>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 상세 정보</title>
<style>
    body { font-family: sans-serif; margin: 20px; }
    .container { border: 1px solid #ccc; padding: 20px; max-width: 800px; margin: auto; }
    h1 { text-align: center; color: #333; }
    h2 { color: #555; border-bottom: 1px solid #eee; padding-bottom: 5px; }
    ul { list-style-type: none; padding-left: 0; }
    li { background-color: #f9f9f9; border: 1px solid #eee; padding: 8px; margin-bottom: 5px; border-radius: 4px; }
    .error { color: red; font-weight: bold; }
    .info { margin-bottom: 10px; }
    .info p { margin: 5px 0; }
</style>
</head>
<body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4883e0847e98b2ab0137a4ad0f7669d&libraries=services"></script>


<div class="container">
    <%
        String hgIdFromUrl = request.getParameter("hg_id");
    	if (hgIdFromUrl==null){
    		hgIdFromUrl="A00001";
    	}

        HgDto hgDetails = null;
        List<ConvDto> convFacilitiesList = new ArrayList<>();
        List<BrandDto> brandStoresList = new ArrayList<>();
        String errorMessage = null;
        boolean hgFound = false;

        if (hgIdFromUrl == null || hgIdFromUrl.trim().isEmpty()) {
            errorMessage = "휴게소 ID가 제공되지 않았습니다.";
        }

        if (errorMessage == null) {
            HgDao hgDao = new HgDao();
            ConvDao convDao = new ConvDao();
            BrandDao brandDao = new BrandDao();

            try {
                hgDetails = hgDao.getHgByID(hgIdFromUrl);

                if (hgDetails != null) {
                    hgFound = true;
                    String restStopName = hgDetails.getName();

                    if (restStopName != null && !restStopName.trim().isEmpty()) {
                        convFacilitiesList.addAll(convDao.getConvsByName(restStopName));
                        brandStoresList.addAll(brandDao.getBrandsByName(restStopName));
                    } else {   
                        errorMessage = "휴게소 이름 정보를 가져올 수 없습니다.";
                    }
                } else {
                    errorMessage = "ID '" + hgIdFromUrl + "'에 해당하는 휴게소 정보를 찾을 수 없습니다.";
                }

            } catch (SQLException e) {
                errorMessage = "데이터베이스 오류가 발생했습니다: " + e.getMessage();
                System.err.println("SQL Error fetching details for hg_id " + hgIdFromUrl + ":");
                e.printStackTrace(new java.io.PrintWriter(out));
                e.printStackTrace();
            } catch (Exception e) {
                errorMessage = "처리 중 알 수 없는 오류가 발생했습니다: " + e.getMessage();
                System.err.println("General Error fetching details for hg_id " + hgIdFromUrl + ":");
                e.printStackTrace(new java.io.PrintWriter(out));
                e.printStackTrace();
            }
        }
    %>

    <% if (errorMessage != null) { %>
        <h1>오류</h1>
        <p class="error"><%= errorMessage %></p>
    <% } else if (hgFound && hgDetails != null) { %>
        <h1>휴게소 정보: <%= hgDetails.getName() %></h1>

        <div id="map" style="width:100%;height:400px; margin-bottom:20px;"></div>

        <div class="info">
            <% if (hgDetails.getTel_no() != null && !hgDetails.getTel_no().isEmpty()) { %>
                <p><strong>전화번호:</strong> <%= hgDetails.getTel_no() %></p>
            <% } else { %>
                <p><strong>전화번호:</strong> 정보 없음</p>
            <% } %>
            <% if (hgDetails.getAddr() != null && !hgDetails.getAddr().isEmpty()) { %>
                <p><strong>주소:</strong> <%= hgDetails.getAddr() %></p>
            <% } else { %>
                <p><strong>주소:</strong> 정보 없음</p>
            <% } %>
            <p><strong>화물 휴게소:</strong> <%= hgDetails.isTruck() ? "O" : "X" %></p>
            <p><strong>경정비 가능:</strong> <%= hgDetails.isMaintenance() ? "가능" : "불가능" %></p>
        </div>

        <h2>편의시설</h2>
        <% if (convFacilitiesList == null || convFacilitiesList.isEmpty()) { %>
            <p>등록된 편의시설 정보가 없습니다.</p>
        <% } else { %>
            <ul>
                <% for (ConvDto facility : convFacilitiesList) { %>
                    <li><%= facility.getConv_name() %> <%-- ConvDto has getConv_name() --%>
                        <% if (facility.getConv_desc() != null && !facility.getConv_desc().isEmpty()) { %>
                            (<%= facility.getConv_desc() %>)
                        <% } %>
                    </li>
                <% } %>
            </ul>
        <% } %>

		<h2>브랜드 매장</h2>
		<% if (brandStoresList == null || brandStoresList.isEmpty()) { %>
		<p>등록된 브랜드 매장 정보가 없습니다.</p>
		<% } else { %>
		<div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap; justify-content: flex-start;">
		<% for (BrandDto store : brandStoresList) { %>
		<img src="../BrandLogoImage/<%= store.getBrand_name() %>.png" alt="<%= store.getBrand_name() %>" 
		     style="max-width: 120px; height: auto; flex-shrink: 0;">
		<% } %>
		</div>
		<% } %>

    <% } else { %>
        <h1>정보 없음</h1>
        <p>요청하신 휴게소 정보를 표시할 수 없습니다. ID를 확인해주세요.</p>
    <% } %>
    
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('<%= hgDetails.getAddr() %>', function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>

</div>
</body>
</html>