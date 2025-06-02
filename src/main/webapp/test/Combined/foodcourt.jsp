<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>휴게소 음식 정보</title>
  <style>
    /* === foodcourt.css 내용 === */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #ffffff;
      padding: 10px 30px;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }

    header img {
      height: 60px;
    }

    .main-nav ul {
      list-style: none;
      display: flex;
      gap: 30px;
      padding: 0;
      margin: 0;
    }

    .main-nav ul li a {
      text-decoration: none;
      font-size: 18px;
      color: #333;
      font-weight: bold;
    }

    .main-nav ul li a:hover {
      color: #007bff;
    }

    .search-container {
      background-color: #ffffffaa;
      padding: 20px;
      display: none;
      justify-content: center;
      gap: 40px;
      position: sticky;
      top: 0;
      z-index: 1000;
    }

    .search-container.visible {
      display: flex;
    }

    .search-item {
      display: flex;
      flex-direction: column;
    }

    .search-item label {
      font-weight: bold;
      margin-bottom: 5px;
    }

    .search-item select {
      padding: 6px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }

    .food-list {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      padding: 30px;
      justify-content: center;
      background-color: #fff;
    }

    .food-item {
      width: 220px;
      background-color: #f9f9f9;
      border-radius: 10px;
      padding: 20px;
      text-align: center;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .img-box {
      width: 100%;
      height: 140px;
      background-color: #ddd;
      border-radius: 10px;
      margin-bottom: 10px;
    }

    .title {
      font-size: 18px;
      font-weight: bold;
    }

    .tag {
      color: #d9534f;
    }

    .price {
      font-size: 16px;
      color: #777;
    }
  </style>
</head>
<body>

<header>
  <a href="#" id="logo">
    <img src="../imgway/way.png" alt="로고">
  </a>
  <nav class="main-nav">
    <ul>
      <li><a href="#">교통정보</a></li>
      <li><a href="#">휴게소 찾기</a></li>
      <li><a href="#">휴게소 소개</a></li>
      <li><a href="foodcourt.jsp">푸드코트 정보</a></li>
      <li><a href="#">고객센터</a></li>
    </ul>
  </nav>
</header>

<!-- 마우스 오버 시 내려오는 검색창 -->
<div class="search-container" id="searchBar">
  <div class="search-bar">
    <div class="search-item">
      <label for="rest-stop-search">휴게소 검색</label>
      <select id="rest-stop-search">
        <option>안성(서울)휴게소</option>
      </select>
    </div>
    <div class="search-item">
      <label for="rest-stop-select">휴게소 선택</label>
      <select id="rest-stop-select">
        <option>안성(서울)휴게소</option>
      </select>
    </div>
  </div>
</div>

<!-- 음식 리스트 -->
<main class="food-list">
  <div class="food-item">
    <div class="img-box"></div>
    <p class="title"><span class="tag">BEST - </span>자연맞춤한우국밥</p>
    <p class="price">가격 : 12,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title"><span class="tag">BEST - </span>자연맞춤한우곰탕</p>
    <p class="price">가격 : 12,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">등심돈까스</p>
    <p class="price">가격 : 11,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">유부우동</p>
    <p class="price">가격 : 6,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">어묵우동</p>
    <p class="price">가격 : 6,500 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">떡 만두 라면</p>
    <p class="price">가격 : 6,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">김치 제육 덮밥</p>
    <p class="price">가격 : 8,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">카레 돈카츠</p>
    <p class="price">가격 : 11,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">황태 해장국</p>
    <p class="price">가격 : 9,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">한우 소머리 국밥</p>
    <p class="price">가격 : 9,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">불고기 비빔밥</p>
    <p class="price">가격 : 10,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">돼지고기 김치찌개</p>
    <p class="price">가격 : 9,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">얼큰 칼국수</p>
    <p class="price">가격 : 8,000 원</p>
  </div>

  <div class="food-item">
    <div class="img-box"></div>
    <p class="title">얼큰 수제비</p>
    <p class="price">가격 : 8,000 원</p>
  </div>
</main>

<!-- === foodcourt.js 내용 === -->
<script>
  const searchBar = document.getElementById('searchBar');

  document.addEventListener('mousemove', (e) => {
    if (e.clientY < 100) {
      searchBar.classList.add('visible');
    } else {
      searchBar.classList.remove('visible');
    }
  });
</script>

</body>
</html>