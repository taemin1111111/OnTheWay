<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
%>
<!-- 슬라이더 이미지 -->
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
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
