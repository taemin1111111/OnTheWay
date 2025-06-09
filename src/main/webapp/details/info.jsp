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

    <%-- Google Fonts: Noto Sans KR --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        /* --- 🎨 2024-2025 통합 디자인 시스템 --- */
        :root {
            --primary-color: #007aff; /* iOS 스타일 블루 */
            --background-color: #f7f9fc;
            --card-background-color: rgba(255, 255, 255, 0.9); /* 약간의 투명도 추가 */
            --text-primary: #212529;
            --text-secondary: #5a6573;
            --text-muted: #8a95a3;
            --border-color: #e0e4e8; /* 테두리 색상 좀 더 부드럽게 */
            --star-color: #ffcc00;
            --success-color: #34c759;
            --danger-color: #ff3b30;

            --font-family-main: 'Noto Sans KR', sans-serif;
            --border-radius-md: 12px;
            --border-radius-lg: 16px;
            --shadow-soft: 0 4px 12px rgba(0, 0, 0, 0.05); /* 그림자 좀 더 은은하게 */
            --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.08); /* 그림자 좀 더 은은하게 */
        }

        body {
            font-family: var(--font-family-main);
            background-color: var(--background-color);
            color: var(--text-primary);
        }

        /* --- 페이지 헤더 (Hero) --- */
        .page-hero {
            /* 기존 패딩은 삭제하고 아래 패딩을 사용 */
            text-align: center;
            max-width: 1200px;
            margin: 0 auto 3rem auto; /* 중앙 정렬 및 하단 여백 */

            /* 새로 추가되거나 수정된 스타일 */
            background-color: var(--card-background-color); /* 카드 배경색 적용 */
            border-radius: var(--border-radius-lg); /* info-card와 동일하게 둥근 모서리 적용 */
            box-shadow: var(--shadow-soft); /* 부드러운 그림자 적용 */
            padding: 2.5rem 1.5rem; /* 카드 내부 패딩 조정 */
            backdrop-filter: blur(8px); /* Glassmorphism 효과 */
            -webkit-backdrop-filter: blur(8px); /* Safari 지원 */
        }
        .page-hero h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            /* 기존 padding-left: 130px; 삭제 */
        }
        .page-hero .route-info {
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
        }
        .page-hero .rating-summary-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: var(--text-primary);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            background-color: var(--card-background-color);
            box-shadow: var(--shadow-soft);
            transition: transform 0.2s, box-shadow 0.2s;
            backdrop-filter: blur(5px); /* Glassmorphism 효과 */
            -webkit-backdrop-filter: blur(5px); /* Safari 지원 */
        }
        .page-hero .rating-summary-link:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }
        .page-hero .stars .bi { color: var(--star-color); }
        .page-hero .rating-score { font-weight: 700; font-size: 1.1rem; }
        .page-hero .review-count { font-size: 1rem; color: var(--text-secondary); }

        /* --- 공통 카드 스타일 --- */
        .info-card {
            background-color: var(--card-background-color);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-soft);
            margin-bottom: 2rem;
            overflow: hidden; /* For header radius */
            backdrop-filter: blur(8px); /* Glassmorphism 효과 추가 */
            -webkit-backdrop-filter: blur(8px); /* Safari 지원 */
        }
        .info-card-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.5rem;
            font-size: 1.2rem;
            font-weight: 700;
            border-bottom: 1px solid var(--border-color);
        }
        .info-card-header .bi { color: var(--primary-color); }
        .info-card-body { padding: 1.5rem; }
        .info-card .list-group-item {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            transition: background-color 0.2s ease-in-out; /* 호버 효과 추가 */
        }
        .info-card .list-group-item:last-child { border-bottom: none; }
        .info-card .list-group-item:hover {
            background-color: #f0f4f7; /* 호버 시 약간 밝아지는 효과 */
            cursor: pointer; /* 클릭 가능함을 시각적으로 나타냄 */
        }

        /* --- 정보 항목 스타일 --- */
        .info-entry {
            display: flex;
            align-items: flex-start; /* 아이콘이 위쪽으로 정렬되도록 */
            gap: 1rem;
            margin-bottom: 1.2rem;
            font-size: 0.95rem;
        }
        .info-entry:last-child { margin-bottom: 0; }
        .info-entry .bi {
            font-size: 1.5rem;
            color: var(--primary-color);
            min-width: 24px;
            height: 24px; /* 아이콘 높이 고정 */
            display: flex;
            align-items: center;
            justify-content: center; /* 아이콘 중앙 정렬 */
        }
        .info-entry strong { color: var(--text-primary); margin-right: 0.5rem; }
        .info-entry span { color: var(--text-secondary); }

        /* --- 시설 유무 표시 스타일 --- */
        .facility-status {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .facility-status .icon-box {
            font-size: 1.5rem;
            min-width: 24px;
            height: 24px; /* 아이콘 높이 고정 */
            display: flex;
            align-items: center;
            justify-content: center; /* 아이콘 중앙 정렬 */
        }
        .facility-status .is-available { color: var(--success-color); }
        .facility-status .is-unavailable { color: var(--text-muted); }
        .facility-status span { font-weight: 500; }

        /* --- 브랜드, 리뷰 등 특정 섹션 스타일 --- */
        .brand-logo-wrapper {
            background-color: #f8f9fa;
            border-radius: var(--border-radius-md);
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .brand-logo-wrapper:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-soft);
        }
        .brand-logo { max-height: 40px; margin-bottom: 0.5rem; }
        
        .review-item {
            border-bottom: 1px solid var(--border-color);
            padding: 1.25rem 0;
        }
        .review-item:first-child { padding-top: 0; }
        .review-item:last-child { border-bottom: none; padding-bottom: 0;}
        .review-item .user-info { font-weight: 700; }
        .review-item .date-info { font-size: 0.85rem; color: var(--text-muted); }
        .review-item .stars .bi { color: var(--star-color); }
        .review-item .content { color: var(--text-secondary); margin: 0.5rem 0; }
        .review-item .recommend { font-size: 0.9rem; color: var(--primary-color); }

        #map {
            width: 100%;
            height: 450px;
            border-radius: 0 0 var(--border-radius-lg) var(--border-radius-lg);
        }
        
        .header-action-link {
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--primary-color);
        }

        /* 버튼 스타일 강화 (예: 후기 작성하기 버튼) */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* 기본 Bootstrap hover 색상보다 조금 더 어둡게 */
            border-color: #0056b3;
            transform: translateY(-2px); /* 살짝 위로 올라오는 효과 */
            box-shadow: var(--shadow-soft);
        }
        .btn-primary:active {
            transform: translateY(0); /* 클릭 시 원상 복귀 */
            box-shadow: none;
        }

        /* 모바일 환경 고려 (page-hero h1 padding 조정) */
        @media (max-width: 768px) {
            .page-hero h1 {
                font-size: 2rem; /* 모바일에서 글자 크기 조정 */
            }
            .page-hero {
                padding: 2rem 1rem; /* 모바일에서 패딩 약간 줄임 */
            }
        }
    </style>
</head>
<body>

<%
    // --- 기존 Java 로직은 그대로 유지 ---
    Properties prop = new Properties();
    try (InputStream input = application.getResourceAsStream("/WEB-INF/classes/config.properties")) {
        if (input != null) {
            prop.load(input);
        }
    }
    String mapKey = prop.getProperty("kakao.api");

    String hgIdFromUrl = request.getParameter("hg_id");
    if (hgIdFromUrl == null || hgIdFromUrl.trim().isEmpty()) hgIdFromUrl = "1";

    HgDataDto hgDetails = null;
    List<BrandDto> brandStoresList = new ArrayList<>();
    List<GpaDto> topReviewsList = new ArrayList<>();
    String errorMessage = null;
    double latitude = 37.566826, longitude = 126.9786567;
    double averageStars = 0;
    int reviewCount = 0;

    try {
        HgDataDao hgDao = new HgDataDao();
        hgDetails = hgDao.getHgDataById(hgIdFromUrl);

        if (hgDetails != null) {
            latitude = hgDetails.getLatitude();
            longitude = hgDetails.getLongitude();

            BrandDao brandDao = new BrandDao();
            brandStoresList = brandDao.getBrandsByName(hgDetails.getRest_name());

            GpaDao gpaDao = new GpaDao();
            topReviewsList = gpaDao.getReviewsByHgIdPaging(hgIdFromUrl, 0, 3, "추천순"); 
            averageStars = gpaDao.getAverageStarsByHgId(hgIdFromUrl);
            reviewCount = gpaDao.getCountByHgId(hgIdFromUrl);
        } else {
            errorMessage = "ID '" + hgIdFromUrl + "'에 해당하는 휴게소 정보를 찾을 수 없습니다.";
        }
    } catch (Exception e) {
        errorMessage = "데이터를 불러오는 중 오류가 발생했습니다: " + e.getMessage();
        e.printStackTrace();
    }
%>

<div class="container my-4 my-lg-5">
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger text-center mt-4">
            <h4 class="alert-heading"><i class="bi bi-exclamation-triangle-fill"></i> 오류 발생</h4>
            <p><%= errorMessage %></p>
        </div>
    <% } else if (hgDetails != null) { %>
    
        <header class="page-hero">
            <h1><%= hgDetails.getRest_name() %></h1>
            <p class="route-info"><%= hgDetails.getRoute_name() %> (<%= hgDetails.getRoad_type() %>) - <%= hgDetails.getRoute_direction() %> 방면</p>
            
            <% if (reviewCount > 0) { %>
                <a href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%= hgIdFromUrl %>" class="rating-summary-link">
                    <span class="stars">
                    <% for(int i=1; i<=5; i++) { %>
                        <i class="bi <%= (averageStars >= i) ? "bi-star-fill" : (averageStars >= i - 0.5 ? "bi-star-half" : "bi-star") %>"></i>
                    <% } %>
                    </span>
                    <span class="rating-score"><%= String.format("%.1f", averageStars) %></span>
                    <span class="review-count">(<%= reviewCount %>개 후기)</span>
                </a>
            <% } else { %>
                <p class="text-muted"><i class="bi bi-chat-square-dots"></i> 아직 등록된 후기가 없습니다.</p>
            <% } %>
        </header>

        <div class="row g-4">
            <div class="col-lg-5">
                <section class="info-card">
                    <h2 class="info-card-header"><i class="bi bi-info-circle-fill"></i> 기본 정보</h2>
                    <div class="info-card-body">
                        <div class="info-entry">
                            <i class="bi bi-telephone-fill"></i>
                            <div><strong>전화번호:</strong> <span><%= hgDetails.getPhone_number() != null && !hgDetails.getPhone_number().isEmpty() ? hgDetails.getPhone_number() : "정보 없음" %></span></div>
                        </div>
                        <div class="info-entry">
                            <i class="bi bi-clock-fill"></i>
                            <div><strong>운영시간:</strong> <span><%= hgDetails.getOpen_time() != null && !hgDetails.getOpen_time().isEmpty() ? hgDetails.getOpen_time() : "정보 없음" %></span></div>
                        </div>
                        <div class="info-entry">
                            <i class="bi bi-p-circle-fill"></i>
                            <div><strong>주차:</strong> <span><%= hgDetails.getParking_count() > 0 ? hgDetails.getParking_count() + "대 가능" : "정보 없음" %></span></div>
                        </div>
                    </div>
                </section>

                <section class="info-card">
                    <h2 class="info-card-header"><i class="bi bi-tools"></i> 차량 서비스</h2>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item facility-status">
                            <i class="icon-box bi bi-fuel-pump-fill <%= "Y".equals(hgDetails.getHas_gas_station()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>주유소</span>
                        </li>
                        <li class="list-group-item facility-status">
                            <i class="icon-box bi bi-fuel-pump-diesel-fill <%= "Y".equals(hgDetails.getHas_lpg_station()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>LPG 충전소</span>
                        </li>
                        <li class="list-group-item facility-status">
                             <i class="icon-box bi bi-ev-station-fill <%= "Y".equals(hgDetails.getHas_ev_station()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>전기차 충전소</span>
                        </li>
                    </ul>
                </section>
                
                <section class="info-card">
                    <h2 class="info-card-header"><i class="bi bi-people-fill"></i> 편의 시설</h2>
                    <ul class="list-group list-group-flush">
                         <li class="list-group-item facility-status">
                            <i class="icon-box bi bi-shop <%= "Y".equals(hgDetails.getHas_store()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>편의점/매점</span>
                        </li>
                        <li class="list-group-item facility-status">
                             <i class="icon-box bi bi-egg-fried <%= "Y".equals(hgDetails.getHas_restaurant()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>식당</span>
                        </li>
                         <li class="list-group-item facility-status">
                            <i class="icon-box bi bi-person-arms-up <%= "Y".equals(hgDetails.getHas_nursing_room()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>수유실</span>
                        </li>
                        <li class="list-group-item facility-status">
                            <i class="icon-box bi bi-capsule-pill <%= "Y".equals(hgDetails.getHas_pharmacy()) ? "is-available" : "is-unavailable" %>"></i>
                            <span>약국</span>
                        </li>
                    </ul>
                </section>

                <% if (hgDetails.getSignature_menu() != null && !hgDetails.getSignature_menu().trim().isEmpty()) { %>
                <section class="info-card">
                    <h2 class="info-card-header">
                        <i class="bi bi-star-fill" style="color:var(--star-color)"></i> 대표 메뉴
                    </h2>
                    <div class="info-card-body">
                        <p class="fs-5 fw-bold mb-0"><%= hgDetails.getSignature_menu() %></p>
                        <a href="<%=request.getContextPath()%>/index.jsp?main=restFoodMenu.jsp&stdRestNm=<%= URLEncoder.encode(hgDetails.getRest_name(), "UTF-8") %>휴게소" class="header-action-link">모든 메뉴 보기 <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                </section>
                <% } %>
            </div>

            <div class="col-lg-7">
                <section class="info-card">
                    <h2 class="info-card-header"><i class="bi bi-geo-alt-fill"></i> 지도 위치</h2>
                    <div class="card-body p-0">
                        <div id="map"></div>
                    </div>
                </section>
                
                <% if (!brandStoresList.isEmpty()) { %>
                <section class="info-card">
                    <h2 class="info-card-header"><i class="bi bi-tags-fill"></i> 입점 브랜드</h2>
                    <div class="info-card-body">
                        <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 g-3">
                            <% for (BrandDto store : brandStoresList) { %>
                                <div class="col">
                                    <div class="brand-logo-wrapper">
                                        <img src="<%=request.getContextPath()%>/BrandLogoImage/<%= store.getBrand_name() %>.png"
                                             alt="<%= store.getBrand_name() %> 로고" class="brand-logo"
                                             onerror="this.style.display='none'; this.nextElementSibling.classList.remove('d-none');">
                                        <span class="small fw-bold d-none"><%= store.getBrand_name() %></span>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </section>
                <% } %>
                
                <section class="info-card">
                    <div class="info-card-header d-flex justify-content-between align-items-center">
                        <h2 class="mb-0 fs-5 fw-bold"><i class="bi bi-chat-left-text-fill"></i> 방문자 후기</h2>
                        <a href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%= hgIdFromUrl %>" class="header-action-link">모두 보기</a>
                    </div>
                    <div class="info-card-body">
                         <% if (topReviewsList.isEmpty()) { %>
                            <p class="text-center text-muted py-3">아직 등록된 후기가 없습니다.<br>첫 후기를 작성해주세요!</p>
                        <% } else { %>
                            <% 
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
                                for (GpaDto review : topReviewsList) { 
                                    String userId = review.getUserid();
                                    String maskedUserId = userId.length() > 3 ? userId.substring(0, 3) + "***" : userId + "***";
                            %>
                            <div class="review-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="user-info"><%= maskedUserId %></span>
                                    <span class="date-info"><%= sdf.format(review.getWriteday()) %></span>
                                </div>
                                <div class="stars my-1">
                                    <% for(int i=1; i<=5; i++) { %>
                                        <i class="bi <%= (review.getStars() >= i) ? "bi-star-fill" : "bi-star" %>"></i>
                                    <% } %>
                                </div>
                                <p class="content"><%= review.getContent() %></p>
                                <div class="recommend fw-bold">
                                    <i class="bi bi-hand-thumbs-up-fill"></i> <%= review.getGood() %>
                                </div>
                            </div>
                            <% } %>
                        <% } %>
                        <div class="text-center mt-4">
                            <a href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%= hgIdFromUrl %>" class="btn btn-primary rounded-pill px-4">
                                <i class="bi bi-pencil-square"></i> 후기 작성하기
                            </a>
                        </div>
                    </div>
                </section>
            </div>
        </div>

    <% } else { %>
        <div class="alert alert-warning text-center mt-4">
            <p>휴게소 정보를 불러올 수 없습니다. ID(<%= hgIdFromUrl %>)를 확인해주세요.</p>
        </div>
    <% } %>

    <footer class="text-center text-muted py-4 mt-4 border-top">
        <p class="mb-0">© <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> 휴게소 정보 서비스. All rights reserved.</p>
    </footer>
</div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=mapKey%>&libraries=services"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        <% if (hgDetails != null) { %>
            const mapContainer = document.getElementById('map');
            if (mapContainer) {
                const lat = <%= latitude %>;
                const lng = <%= longitude %>;
                const restName = "<%= hgDetails.getRest_name().replace("\"", "\\\"") %>";
                const map = new kakao.maps.Map(mapContainer, {
                    center: new kakao.maps.LatLng(lat, lng),
                    level: 5
                });
                const marker = new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lng) });
                marker.setMap(map);
                const infowindow = new kakao.maps.InfoWindow({
                    content: `<div style="padding:5px;font-size:14px;text-align:center;">${restName}<br><a href="https://map.kakao.com/link/to/${restName},${lat},${lng}" style="color:blue" target="_blank">길찾기</a></div>`,
                    disableAutoPan: true
                });
                kakao.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map, marker);
                });
            }
        <% } %>
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>