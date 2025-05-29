<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
%>
<div class="swiper mySwiper">
  <div class="swiper-wrapper">
    <div class="swiper-slide">
      <img src="<%=root%>/image2/pt1.jpg" alt="slide1">
    </div>
    <div class="swiper-slide">
      <img src="<%=root%>/image2/pt2.jpg" alt="slide2">
    </div>
    <div class="swiper-slide">
      <img src="<%=root%>/image2/pt3.jpg" alt="slide3">
    </div>
    <div class="swiper-slide">
      <img src="<%=root%>/image2/pt4.jpg" alt="slide4">
    </div>
  </div>

  <!-- 슬라이드 번호 표시 -->
  <div class="swiper-pagination"></div>

  <!-- 좌우 화살표 -->
  <div class="swiper-button-prev"></div>
  <div class="swiper-button-next"></div>

  <!-- 멈춤/재생 버튼 -->
  <div class="swiper-control">
    <button id="togglePlay" onclick="toggleAutoplay()">
      <i id="playIcon" class="bi bi-pause-fill"></i>
    </button>
  </div>
</div>

<style>
.swiper {
  width: 100%;
  padding: 30px 0;
  position: relative;
}
.swiper-slide {
  width: 48%;
  height: 300px;
  border-radius: 20px; /* 사진 둥글게 */
  overflow: hidden;
  background: #fff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}
.swiper-slide img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.swiper-pagination {
  text-align: center;
  font-size: 16px;
  font-weight: bold;
  margin-top: 10px;
}
.swiper-control {
  position: absolute;
  bottom: -40px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10;
}
.swiper-control button {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
}
</style>

<script>
let swiper = new Swiper(".mySwiper", {
  slidesPerView: 2,
  spaceBetween: 30,
  loop: true,
  autoplay: {
    delay: 3000,
    disableOnInteraction: false
  },
  pagination: {
    el: ".swiper-pagination",
    type: "fraction"
  },
  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev"
  }
});

function toggleAutoplay() {
  const playIcon = document.getElementById("playIcon");
  if (swiper.autoplay.running) {
    swiper.autoplay.stop();
    playIcon.classList.remove("bi-pause-fill");
    playIcon.classList.add("bi-play-fill");
  } else {
    swiper.autoplay.start();
    playIcon.classList.remove("bi-play-fill");
    playIcon.classList.add("bi-pause-fill");
  }
}
</script>
