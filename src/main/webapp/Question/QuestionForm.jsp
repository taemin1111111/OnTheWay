<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FAQ</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: linear-gradient(to bottom, #e3f2fd, #ffffff);
      color: #333;
    }

    .faq-header-image {
      text-align: center;
      margin-bottom: 40px;
    }

    .faq-header-image img {
      max-width: 600px;
      width: 100%;
      height: auto;
      border-radius: 20px;
    }

    .faq-category {
      background-color: white;
      border-radius: 12px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    .faq-header {
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 16px;
      color: #1565c0;
    }

    .accordion-button {
      font-weight: bold;
      background-color: #fff;
      color: #333;
    }

    .accordion-button:not(.collapsed) {
      background-color: #e3f2fd;
      color: #0d47a1;
    }

    .accordion-body {
      background-color: #fafafa;
      border-top: 1px solid #ddd;
    }
  </style>
</head>
<body>

<% 
String root = request.getContextPath(); 
%>

<!-- 상단 대표 이미지 -->
<div class="faq-header-image">
  <img src="<%=root%>/image2/Question.png" alt="FAQ 대표 이미지">
</div>

<!-- 후기 관련 질문 -->
<div class="faq-category">
  <div class="faq-header">후기 관련 질문</div>
  <div class="accordion" id="faqAccordionReview">
    <div class="accordion-item">
      <h2 class="accordion-header" id="review-q1">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#review-a1">Q. 회원가입을 꼭 해야 하나요?</button>
      </h2>
      <div id="review-a1" class="accordion-collapse collapse" data-bs-parent="#faqAccordionReview">
        <div class="accordion-body">후기 작성 및 평점 등록은 회원가입 후 이용하실 수 있습니다. 로그인 없이도 다른 이용자의 후기와 평점은 자유롭게 열람 가능합니다.</div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="review-q2">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#review-a2">Q. 후기 작성 후 수정이 불가능한 이유는 뭔가요?</button>
      </h2>
      <div id="review-a2" class="accordion-collapse collapse" data-bs-parent="#faqAccordionReview">
        <div class="accordion-body">후기를 수정 가능하게 할 경우, 추천수를 받은 뒤 내용을 광고, 욕설, 음란물 등으로 바꾸는 악용 사례를 방지하기 위해 수정 기능은 제공하지 않습니다.</div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="review-q3">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#review-a3">Q. 후기를 삭제하고 싶어요.</button>
      </h2>
      <div id="review-a3" class="accordion-collapse collapse" data-bs-parent="#faqAccordionReview">
        <div class="accordion-body">본인이 작성한 후기만 삭제할 수 있으며, 로그인 후 삭제 버튼을 눌러 진행 가능합니다.</div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="review-q4">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#review-a4">Q. 후기 작성은 한 명당 몇 번 가능한가요?</button>
      </h2>
      <div id="review-a4" class="accordion-collapse collapse" data-bs-parent="#faqAccordionReview">
        <div class="accordion-body">한 명당 휴게소별로 1개의 후기만 작성할 수 있습니다. 중복 등록은 제한됩니다.</div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="review-q5">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#review-a5">Q. 후기 정렬 방식은 어떻게 되나요?</button>
      </h2>
      <div id="review-a5" class="accordion-collapse collapse" data-bs-parent="#faqAccordionReview">
        <div class="accordion-body">최신순, 추천순, 평점 높은순, 평점 낮은순 총 4가지 정렬 방식을 제공하며, 버튼을 눌러 원하는 방식으로 전환할 수 있습니다.</div>
      </div>
    </div>
  </div>
</div>

<!-- 푸드코트 관련 질문 -->
<div class="faq-category">
  <div class="faq-header">푸드코트 관련 질문</div>
  <div class="accordion" id="faqAccordionFood">
    <div class="accordion-item">
      <h2 class="accordion-header" id="food-q1">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#food-a1">Q. 푸드코트 메뉴는 어떻게 확인하나요?</button>
      </h2>
      <div id="food-a1" class="accordion-collapse collapse" data-bs-parent="#faqAccordionFood">
        <div class="accordion-body">상단 바에서 "푸드코트"를 선택한 뒤, 원하는 휴게소를 클릭하면 해당 휴게소의 메뉴 및 브랜드 매장을 확인할 수 있습니다.</div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="food-q2">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#food-a2">Q. 음식은 미리 주문하고 결제도 가능한가요?</button>
      </h2>
      <div id="food-a2" class="accordion-collapse collapse" data-bs-parent="#faqAccordionFood">
        <div class="accordion-body">네. 원하는 메뉴를 장바구니에 담고, 결제를 진행하면 해당 푸드코트에서 미리 준비됩니다.</div>
      </div>
    </div>
  </div>
</div>

<!-- 교통 정보 관련 질문 -->
<div class="faq-category">
  <div class="faq-header">교통 정보 관련 질문</div>
  <div class="accordion" id="faqAccordionTraffic">
    <div class="accordion-item">
      <h2 class="accordion-header" id="traffic-q1">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#traffic-a1">Q. 교통 정보는 어디서 확인할 수 있나요?</button>
      </h2>
      <div id="traffic-a1" class="accordion-collapse collapse" data-bs-parent="#faqAccordionTraffic">
        <div class="accordion-body">상단 바의 "교통정보"를 클릭하시면 한국도로공사 교통정보로 연결되어 실시간 교통상황을 확인하실 수 있습니다.</div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
