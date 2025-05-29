<%@page import="hgDao.hgRestDto"%>
<%@page import="java.util.List"%>
<%@page import="hgDto.hgRestDao"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    hgRestDao dao = new hgRestDao();
    List<hgRestDto> list = dao.getRestList();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 표시</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44&libraries=services"></script>
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>

<script>
    var map = new kakao.maps.Map(document.getElementById('map'), {
        center: new kakao.maps.LatLng(36.5, 127.5),
        level: 20
    });

    var geocoder = new kakao.maps.services.Geocoder();

    var addresses = [
    <%
        for (int i = 0; i < list.size(); i=i+1) {
            String addr = list.get(i).getAddr();
            out.print("\"" + addr.replace("\"", "\\\"") + "\"");
            if (i < list.size() - 1) out.print(", ");
        }
    %>
    ];
    
   

    addresses.forEach(function(address) {
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:5px;font-size:10px;">' + address + '</div>'
                });
                infowindow.open(map, marker);
            } else {
                console.warn("주소 변환 실패: " + address);
            }
        });
    });
</script>
</body>
</html>