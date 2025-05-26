<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String root = request.getContextPath();
%>
<!-- 슬라이더 이미지 -->
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
  <!-- 점점점 인디케이터 -->
  <div class="carousel-indicators custom-indicator">
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2"></button>
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="3"></button>
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="4"></button>
    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="5"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active"><img src="<%=root%>/image2/pt1.jpg" class="d-block w-100" alt="..."></div>
    <div class="carousel-item"><img src="<%=root%>/image2/pt2.jpg" class="d-block w-100" alt="..."></div>
    <div class="carousel-item"><img src="<%=root%>/image2/pt3.jpg" class="d-block w-100" alt="..."></div>
    <div class="carousel-item"><img src="<%=root%>/image2/pt4.jpg" class="d-block w-100" alt="..."></div>
    <div class="carousel-item"><img src="<%=root%>/image2/pt5.jpg" class="d-block w-100" alt="..."></div>
    <div class="carousel-item"><img src="<%=root%>/image2/pt6.jpg" class="d-block w-100" alt="..."></div>
  </div>
</div>

<!-- 좌우 클릭 영역 -->
<div class="position-relative" style="margin-top: -400px; height: 400px;">
  <div id="leftArea" style="position: absolute; top: 0; left: 0; width: 50%; height: 100%; z-index: 10;"></div>
  <div id="rightArea" style="position: absolute; top: 0; right: 0; width: 50%; height: 100%; z-index: 10;"></div>
</div>

<style>
/* 점점점(인디케이터) 디자인 커스텀 */
.carousel-indicators.custom-indicator button {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  margin: 0 5px;
  border: none;
  background-color: #ddd;   /* 연한 회색 */
  opacity: 0.5;
  transition: background 0.2s;
}
.carousel-indicators.custom-indicator button.active {
  background-color: #444;   /* 어두운 그레이 */
}
</style>

<script>
  // Bootstrap Carousel 연동
  const carousel = new bootstrap.Carousel('#mainCarousel', {
    interval: 3000,
    ride: 'carousel'
  });

  document.getElementById("leftArea").addEventListener("click", () => {
    carousel.prev();
  });

  document.getElementById("rightArea").addEventListener("click", () => {
    carousel.next();
  });
</script>
