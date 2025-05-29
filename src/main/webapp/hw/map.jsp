<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kakao 지도</title>
	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44"></script>  
	
	<style>
    #map {
      width: 500px;
      height: 400px;
    }
  </style>
</head>
<body>
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
</body>
</html>