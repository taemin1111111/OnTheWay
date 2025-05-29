<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="hg.HgDao, hg.HgDto" %>
<%@ page import="conv.ConvDao, conv.ConvDto" %>
<%@ page import="brand.BrandDao, brand.BrandDto" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>휴게소 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4883e0847e98b2ab0137a4ad0f7669d&libraries=services"></script>
</head>
<body>
<%
    String hgIdFromUrl = request.getParameter("hg_id");
    if (hgIdFromUrl == null) hgIdFromUrl = "A00001";

    HgDto hgDetails = null;
    List<ConvDto> convFacilitiesList = new ArrayList<>();
    List<BrandDto> brandStoresList = new ArrayList<>();
    String errorMessage = null;

    try {
        HgDao hgDao = new HgDao();
        ConvDao convDao = new ConvDao();
        BrandDao brandDao = new BrandDao();

        hgDetails = hgDao.getHgByID(hgIdFromUrl);
        if (hgDetails != null) {
            String restStopName = hgDetails.getName();
            convFacilitiesList = convDao.getConvsByName(restStopName);
            brandStoresList = brandDao.getBrandsByName(restStopName);
        } else {
            errorMessage = "휴게소 정보를 찾을 수 없습니다.";
        }
    } catch (Exception e) {
        errorMessage = "오류 발생: " + e.getMessage();
    }
%>

<div class="container py-5">
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger text-center">
            <h4 class="alert-heading">오류</h4>
            <p><%= errorMessage %></p>
        </div>
    <% } else if (hgDetails != null) { %>
        <div class="row g-4">
            <!-- Left Side: Basic Info -->
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><a href="index.jsp?main=gpa/gpa.jsp?hg_id=<%= hgDetails.getId() %>"><%= hgDetails.getName() %></a></h5>
                        
                    </div>
                    <div class="card-body">
                        <p><strong>전화번호:</strong> <%= hgDetails.getTel_no() != null ? hgDetails.getTel_no() : "정보 없음" %></p>
                        <p><strong>주소:</strong> <%= hgDetails.getAddr() != null ? hgDetails.getAddr() : "정보 없음" %></p>
                        <p><strong>화물 휴게소:</strong> <%= hgDetails.isTruck() ? "O" : "X" %></p>
                        <p><strong>경정비 가능:</strong> <%= hgDetails.isMaintenance() ? "가능" : "불가능" %></p>
                    </div>
                </div>

                <div class="card mt-4 shadow-sm">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="mb-0">편의시설</h6>
                    </div>
                    <div class="card-body">
                        <% if (convFacilitiesList.isEmpty()) { %>
                            <p class="text-muted">등록된 편의시설 정보가 없습니다.</p>
                        <% } else { %>
                            <ul class="list-group list-group-flush">
                                <% for (ConvDto facility : convFacilitiesList) { %>
                                    <li class="list-group-item">
                                        <%= facility.getConv_name() %>
                                        <% if (facility.getConv_desc() != null && !facility.getConv_desc().isEmpty()) { %>
                                            <span class="text-muted small">(<%= facility.getConv_desc() %>)</span>
                                        <% } %>
                                    </li>
                                <% } %>
                            </ul>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Right Side: Map and Brand Info -->
            <div class="col-lg-8">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <h6 class="mb-0">지도 위치</h6>
                    </div>
                    <div class="card-body p-0">
                        <div id="map" style="width: 100%; height: 400px;"></div>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white">
                        <h6 class="mb-0">브랜드 매장</h6>
                    </div>
                    <div class="card-body">
                        <% if (brandStoresList.isEmpty()) { %>
                            <p class="text-muted">등록된 브랜드 매장이 없습니다.</p>
                        <% } else { %>
                            <div class="row g-3">
                                <% for (BrandDto store : brandStoresList) { %>
                                    <div class="col-6 col-md-4 col-lg-3 text-center">
                                        <img src="../BrandLogoImage/<%= store.getBrand_name() %>.png"
                                             alt="<%= store.getBrand_name() %>"
                                             class="img-fluid rounded border p-2 bg-light">
                                        <p class="mt-2 small"><%= store.getBrand_name() %></p>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<script>
    const mapContainer = document.getElementById('map');
    const mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };
    const map = new kakao.maps.Map(mapContainer, mapOption);
    const geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch('<%= hgDetails != null ? hgDetails.getAddr() : "" %>', function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            const marker = new kakao.maps.Marker({ map: map, position: coords });
            map.setCenter(coords);
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
