<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="hg.HgDataDao, hg.HgDataDto" %>
<%@ page import="brand.BrandDao, brand.BrandDto" %>
<%@ page import="GpaData.GpaDao, GpaData.GpaDto" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>휴게소 상세 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body { background-color: #f8f9fa; }
        .card-header { font-weight: bold; }
        .facility-icon { font-size: 1.2rem; margin-right: 8px; }
        .brand-logo { max-height: 60px; object-fit: contain; }
        .info-item { display: flex; align-items: center; margin-bottom: 0.5rem; }
        .info-item .bi { min-width: 25px; }
        .custom-card-header {
			    background-color: #ffc107;
			    color: #212529;
			    display: flex;
			    justify-content: space-between;
			    align-items: center;
			}
			
		.custom-card-header .header-action a {
			    color: #212529; 
			    text-decoration: none;
		}
			
		.custom-card-header .header-action a:hover {
			    text-decoration: underline; 
		}
        .review-stars .bi-star-fill, .review-stars .bi-star-half, .review-stars .bi-star {
            color: #ffc107; 
        }
    </style>
</head>
<body>
<%
    // ... (Properties and Kakao map key scriptlet - REMAINS THE SAME) ...
    Properties prop = new Properties();
    InputStream input = application.getResourceAsStream("/WEB-INF/classes/config.properties");
    prop.load(input);

    String mapKey = prop.getProperty("kakao.api");
%>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=mapKey%>&libraries=services">
    </script>
    
<%
    // ... (Data fetching scriptlet - REMAINS THE SAME) ...
    String hgIdFromUrl = request.getParameter("hg_id");
    if (hgIdFromUrl == null || hgIdFromUrl.trim().isEmpty()) {
        hgIdFromUrl = "1"; 
    }

    HgDataDto hgDetails = null;
    List<BrandDto> brandStoresList = new ArrayList<>();
    String errorMessage = null;
    double latitude = 37.566826; 
    double longitude = 126.9786567;

    List<GpaDto> topReviewsList = new ArrayList<>();
    double averageStars = 0;
    int reviewCount = 0;
    String hgNameForUrl = "";

    try {
        HgDataDao hgDao = new HgDataDao();
        BrandDao brandDao = new BrandDao();
        GpaDao gpaDao = new GpaDao();

        hgDetails = hgDao.getHgDataById(hgIdFromUrl); 

        if (hgDetails != null) {
            latitude = hgDetails.getLatitude();
            longitude = hgDetails.getLongitude();
            brandStoresList = brandDao.getBrandsByName(hgDetails.getRest_name());
            
            if (hgDetails.getRest_name() != null) {
                 hgNameForUrl = URLEncoder.encode(hgDetails.getRest_name(), "UTF-8");
            }

            try {
                topReviewsList = gpaDao.getReviewsByHgIdPaging(hgIdFromUrl, 0, 3, "good DESC"); 
                averageStars = gpaDao.getAverageStarsByHgId(hgIdFromUrl);
                reviewCount = gpaDao.getCountByHgId(hgIdFromUrl);
            } catch (Exception re) {
                System.err.println("Error fetching reviews for hg_id " + hgIdFromUrl + ": " + re.getMessage());
            }

        } else {
            errorMessage = "ID '" + hgIdFromUrl + "'에 해당하는 휴게소 정보를 찾을 수 없습니다.";
        }
    } catch (NumberFormatException e) {
        errorMessage = "유효하지 않은 휴게소 ID 형식입니다: '" + hgIdFromUrl + "'. 숫자 형식이어야 합니다.";
    } catch (SQLException e) {
        errorMessage = "데이터베이스 오류 발생: " + e.getMessage();
        e.printStackTrace(); 
    } catch (Exception e) {
        errorMessage = "알 수 없는 오류 발생: " + e.getMessage();
        e.printStackTrace();
    }
%>

<div class="container py-4">
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger text-center mt-4">
            <h4 class="alert-heading"><i class="bi bi-exclamation-triangle-fill"></i> 오류 발생</h4>
            <p><%= errorMessage %></p>
            <hr>
            <p class="mb-0">문제가 지속되면 관리자에게 문의해주세요.</p>
        </div>
    <% } else if (hgDetails != null) { %>
        <div class="text-center mb-4 pt-3">
            <h1 class="display-5 fw-bold"><%= hgDetails.getRest_name() %></h1>
            <% if (reviewCount > 0) { %>
    <p class="mb-2">
        <a href="<%=request.getContextPath()%>/index.jsp?main=/gpa/gpa.jsp&hg_id=<%= hgIdFromUrl %>" class="text-decoration-none text-dark">
            <span class="review-stars" style="font-size: 1.4rem; vertical-align: middle;">
                <%
                double avgDisplayStars = averageStars;
                for(int starIter = 1; starIter <= 5; starIter++) {
                    if (avgDisplayStars >= starIter) {
                %>
                    <i class="bi bi-star-fill"></i>
                <%
                    } else if (avgDisplayStars >= (starIter - 0.5)) {
                %>
                    <i class="bi bi-star-half"></i>
                <%
                    } else {
                %>
                    <i class="bi bi-star"></i>
                <%
                    }
                }
                %>
            </span>
            <span class="ms-2 fw-bold" style="font-size: 1.2rem; vertical-align: middle;">
                <%= String.format("%.1f", averageStars) %>
            </span>
        </a>
    </p>
<% } else { %>
    <p class="mb-2 text-muted" style="font-size: 1rem;">
        <i class="bi bi-chat-square-dots"></i> 아직 등록된 후기가 없습니다.
    </p>
<% } %>
            <%-- END: Average Stars and Review Count Display --%>

            <p class="lead text-muted">
                <%= hgDetails.getRoute_name() %> (<%= hgDetails.getRoad_type() %>) - <%= hgDetails.getRoute_direction() %> 방면
            </p>
        </div>

        <div class="row g-4">
            <!-- Left Column: Information -->
            <div class="col-lg-5">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <i class="bi bi-info-circle-fill facility-icon"></i> 기본 정보
                    </div>
                    <div class="card-body">
                        <p class="info-item"><i class="bi bi-telephone-fill text-primary"></i> <strong>전화번호:</strong> <%= hgDetails.getPhone_number() != null && !hgDetails.getPhone_number().isEmpty() ? hgDetails.getPhone_number() : "정보 없음" %></p>
                        <p class="info-item"><i class="bi bi-clock-fill text-primary"></i> <strong>운영시간:</strong> <%= hgDetails.getOpen_time() != null && !hgDetails.getOpen_time().isEmpty() ? hgDetails.getOpen_time() : "정보 없음" %> - <%= hgDetails.getClose_time() != null && !hgDetails.getClose_time().isEmpty() ? hgDetails.getClose_time() : "정보 없음" %></p>
                        <p class="info-item"><i class="bi bi-p-circle-fill text-primary"></i> <strong>주차 가능 대수:</strong> <%= hgDetails.getParking_count() > 0 ? hgDetails.getParking_count() + "대" : "정보 없음" %></p>
                        <p class="info-item"><i class="bi bi-building text-primary"></i> <strong>휴게소 유형:</strong> <%= hgDetails.getRest_type() != null && !hgDetails.getRest_type().isEmpty() ? hgDetails.getRest_type() : "정보 없음" %></p>
                        <% if (hgDetails.getRoad_area() > 0) { %>
                             <p class="info-item"><i class="bi bi-rulers text-primary"></i> <strong>부지 면적:</strong> <%= String.format("%,d", hgDetails.getRoad_area()) %> ㎡</p>
                        <% } %>
                    </div>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-info text-dark">
                        <i class="bi bi-tools facility-icon"></i> 차량 서비스
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item info-item">
                            <i class="bi bi-fuel-pump-fill <%= "Y".equals(hgDetails.getHas_gas_station()) ? "text-success" : "text-muted" %>"></i> 주유소: <%= "Y".equals(hgDetails.getHas_gas_station()) ? "있음" : "없음" %>
                        </li>
                        <li class="list-group-item info-item">
                            <i class="bi bi-fuel-pump-diesel-fill <%= "Y".equals(hgDetails.getHas_lpg_station()) ? "text-success" : "text-muted" %>"></i> LPG 충전소: <%= "Y".equals(hgDetails.getHas_lpg_station()) ? "있음" : "없음" %>
                        </li>
                        <li class="list-group-item info-item">
                            <i class="bi bi-ev-station-fill <%= "Y".equals(hgDetails.getHas_ev_station()) ? "text-success" : "text-muted" %>"></i> 전기차 충전소: <%= "Y".equals(hgDetails.getHas_ev_station()) ? "있음" : "없음" %>
                        </li>
                        <li class="list-group-item info-item">
                            <i class="bi bi-wrench-adjustable-circle-fill <%= "Y".equals(hgDetails.getRepair_available()) ? "text-success" : "text-muted" %>"></i> 경정비 가능: <%= "Y".equals(hgDetails.getRepair_available()) ? "가능" : "불가능" %>
                        </li>
                    </ul>
                </div>
                
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-secondary text-white">
                       <i class="bi bi-people-fill facility-icon"></i> 편의 시설
                    </div>
                     <ul class="list-group list-group-flush">
                        <li class="list-group-item info-item"><i class="bi bi-person-standing-dress <%= "Y".equals(hgDetails.getHas_toilet()) ? "text-success" : "text-muted" %>"></i> 화장실: <%= "Y".equals(hgDetails.getHas_toilet()) ? "있음" : "정보 없음" %></li>
                        <li class="list-group-item info-item"><i class="bi bi-capsule-pill <%= "Y".equals(hgDetails.getHas_pharmacy()) ? "text-success" : "text-muted" %>"></i> 약국: <%= "Y".equals(hgDetails.getHas_pharmacy()) ? "있음" : "없음" %></li>
                        <li class="list-group-item info-item"><i class="bi bi-person-arms-up <%= "Y".equals(hgDetails.getHas_nursing_room()) ? "text-success" : "text-muted" %>"></i> 수유실: <%= "Y".equals(hgDetails.getHas_nursing_room()) ? "있음" : "없음" %></li>
                        <li class="list-group-item info-item"><i class="bi bi-shop <%= "Y".equals(hgDetails.getHas_store()) ? "text-success" : "text-muted" %>"></i> 편의점/매점: <%= "Y".equals(hgDetails.getHas_store()) ? "있음" : "없음" %></li>
                        <li class="list-group-item info-item"><i class="bi bi-egg-fried <%= "Y".equals(hgDetails.getHas_restaurant()) ? "text-success" : "text-muted" %>"></i> 식당: <%= "Y".equals(hgDetails.getHas_restaurant()) ? "있음" : "없음" %></li>
                        <li class="list-group-item info-item"><i class="bi bi-bus-front-fill <%= "Y".equals(hgDetails.getBus_transfer_available()) ? "text-success" : "text-muted" %>"></i> 버스 환승: <%= "Y".equals(hgDetails.getBus_transfer_available()) ? "가능" : "불가능" %></li>
                    </ul>
                </div>

                <% if (hgDetails.getSignature_menu() != null && !hgDetails.getSignature_menu().trim().isEmpty()) { %>
                <div class="card shadow-sm mb-4">
                    <div class="card-header custom-card-header">
					    <div class="header-title">
					        <i class="bi bi-star-fill facility-icon"></i> 대표 메뉴
					    </div>
					    <div class="header-action">
					        <a href="<%=request.getContextPath()%>/index.jsp?main=restFoodMenu.jsp?search=<%= hgDetails.getRest_name() %>휴게소">모든 메뉴 보기</a>
					    </div>
					</div>
                    <div class="card-body">
                        <p class="mb-0"><%= hgDetails.getSignature_menu() %></p>
                    </div>
                </div>
                <% } %>

                <% if (hgDetails.getExtra_facilities() != null && !hgDetails.getExtra_facilities().trim().isEmpty()) { %>
                <div class="card shadow-sm"> <%-- Removed mb-4 as it's the last item in this column now --%>
                    <div class="card-header" style="background-color: #6f42c1; color: white;">
                        <i class="bi bi-plus-circle-fill facility-icon"></i> 추가 시설 정보
                    </div>
                    <div class="card-body">
                        <p class="mb-0"><%= hgDetails.getExtra_facilities().replace("\n", "<br>") %></p>
                    </div>
                </div>
                <% } %>

                <%-- REVIEW SECTION HAS BEEN MOVED FROM HERE --%>

            </div>

            <!-- Right Column: Map and Brands -->
            <div class="col-lg-7">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <i class="bi bi-geo-alt-fill facility-icon"></i> 지도 위치
                    </div>
                    <div class="card-body p-0">
                        <div id="map" style="width:100%; height:450px;"></div>
                    </div>
                </div>

                <div class="card shadow-sm mb-4"> <%-- Added mb-4 to the Brands card for spacing before reviews --%>
                    <div class="card-header bg-dark text-white">
                        <i class="bi bi-tags-fill facility-icon"></i> 입점 브랜드
                    </div>
                    <div class="card-body">
                        <% if (brandStoresList.isEmpty()) { %>
                            <p class="text-muted text-center">등록된 브랜드 매장이 없습니다.</p>
                        <% } else { %>
                            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-3 justify-content-center">
                                <% for (BrandDto store : brandStoresList) { %>
                                    <div class="col text-center">
                                        <div class="p-2 border rounded bg-light h-100 d-flex flex-column justify-content-center align-items-center">
                                            <img src="<%=request.getContextPath()%>/BrandLogoImage/<%= store.getBrand_name() %>.png"
                                                 alt="<%= store.getBrand_name() %> 로고"
                                                 class="img-fluid brand-logo mb-2"
                                                 onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='block'; this.nextElementSibling.nextElementSibling.style.display='block';">
                                            <span class="small fw-bold d-block"><%= store.getBrand_name() %></span>
                                            <small class="text-muted d-none">이미지 없음</small> 
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>

                <%-- START: Reviews Section (MOVED HERE) --%>
<div class="card shadow-sm mb-4">
                    <div class="card-header custom-card-header" style="background-color: #17a2b8; color: white;"> 
                        <div class="header-title">
                            <i class="bi bi-chat-left-text-fill facility-icon"></i> 방문자 후기
                            <% if (reviewCount > 0) { %>
                                <small style="font-weight: normal;">(총 <%= reviewCount %>개 | 평균 <%= String.format("%.1f", averageStars) %> <i class="bi bi-star-fill" style="color: #ffc107;"></i>)</small>
                            <% } %>
                        </div>
                        <div class="header-action">
                            <a href="<%=request.getContextPath()%>/index.jsp?main=/gpa/gpa.jsp?hg_id=<%= hgIdFromUrl %>" style="color: white;">모든 후기 보기</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <% if (topReviewsList.isEmpty()) { %>
                            <p class="text-muted text-center">아직 등록된 후기가 없습니다.</p>
                        <% } else { %>
                            <ul class="list-group list-group-flush">
                                <% 
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
                                    for (GpaDto review : topReviewsList) { 
                                        String userId = review.getUserid();
                                        String maskedUserId = userId.length() > 3 ? userId.substring(0, 3) + "***" : userId + "***";
                                        String formattedDate = review.getWriteday() != null ? sdf.format(review.getWriteday()) : "날짜 없음";
                                %>
                                    <li class="list-group-item px-0">
                                        <div class="d-flex w-100 justify-content-between align-items-baseline">
                                            <h6 class="mb-1"><%= maskedUserId %></h6>
                                            <small class="text-muted"><%= formattedDate %></small>
                                        </div>
                                        <div class="mb-1 review-stars">
                                            <% for(int i = 1; i <= 5; i++) { %>
                                                <% if (i <= review.getStars()) { %>
                                                    <i class="bi bi-star-fill"></i>
                                                <% } else if (i - 0.5 == review.getStars()) { %>
                                                    <i class="bi bi-star-half"></i>
                                                <% } else { %>
                                                    <i class="bi bi-star"></i>
                                                <% } %>
                                            <% } %>
                                            <span class="ms-1 text-muted">(<%= String.format("%.1f", review.getStars()) %>)</span>
                                            <small class="text-muted"><i class="bi bi-hand-thumbs-up-fill text-primary"></i> <%= review.getGood() %>명이 추천</small>
                                        </div>
                                        <p class="mb-1"><%= review.getContent() %></p>
                                    </li>
                                <% } %>
                            </ul>
                        <% } %>
                        <div class="text-center mt-3">
                            <a href="<%=request.getContextPath()%>/index.jsp?main=/gpa/gpa.jsp?hg_id=<%= hgIdFromUrl %>" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil-square"></i> 후기 작성하기
                            </a>
                        </div>
                    </div>
                </div>
                <%-- END: Reviews Section --%>
            </div>
        </div>
    <% } else if (errorMessage == null) { 
    %>
        <div class="alert alert-warning text-center mt-4">
            <p>휴게소 정보를 불러올 수 없습니다. ID를 확인해주세요 (<%= hgIdFromUrl %>).</p>
        </div>
    <% } %>

    <footer class="text-center text-muted py-4 mt-4">
        <p>© <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> 휴게소 정보 서비스. All rights reserved.</p>
    </footer>
</div>

<script>
    // ... (JavaScript for Kakao Map - REMAINS THE SAME) ...
    document.addEventListener("DOMContentLoaded", function() {
        const mapContainer = document.getElementById('map');
        
        <% if (hgDetails != null) { %>
            if (mapContainer) {
                const lat = <%= latitude %>;
                const lng = <%= longitude %>;
                const restName = "<%= hgDetails.getRest_name() != null ? hgDetails.getRest_name().replace("\\", "\\\\").replace("\"", "\\\"") : "휴게소 정보" %>";

                const mapOption = {
                    center: new kakao.maps.LatLng(lat, lng),
                    level: 5 
                };

                const map = new kakao.maps.Map(mapContainer, mapOption);
                map.setDraggable(true);
                map.setZoomable(true);

                const markerPosition  = new kakao.maps.LatLng(lat, lng);
                const marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                marker.setMap(map);

                const iwContent = '<div style="padding:5px; text-align:center; min-width:150px;">' + restName + '<br><a href="https://map.kakao.com/link/map/' + encodeURIComponent(restName) + ',' + lat + ',' + lng + '" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/' + encodeURIComponent(restName) + ',' + lat + ',' + lng + '" style="color:blue" target="_blank">길찾기</a></div>';
                const iwPosition = new kakao.maps.LatLng(lat, lng);
                const infowindow = new kakao.maps.InfoWindow({
                    position : iwPosition,
                    content : iwContent,
                    disableAutoPan: true 
                });
                 kakao.maps.event.addListener(marker, 'click', function() {
                      infowindow.open(map, marker);
                 });

            } else {
                console.error("Map container not found.");
            }
        <% } else { %>
            if (mapContainer) {
                 const defaultLat = 36.5; 
                 const defaultLng = 127.5;
                 const mapOption = {
                    center: new kakao.maps.LatLng(defaultLat, defaultLng),
                    level: 10
                };
                const map = new kakao.maps.Map(mapContainer, mapOption);
                mapContainer.innerHTML = '<div class="d-flex justify-content-center align-items-center h-100 text-muted">지도 정보를 불러올 수 없습니다.</div>';
            }
        <% } %>
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>