<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GpaData.GpaDto"%>
<%@page import="java.util.List"%>
<%@page import="GpaData.GpaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 평점 테이블</title>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
   rel="stylesheet">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<style>
body {
   font-family: 'Nanum Myeongjo', serif;
   padding: 20px;
}

.custom-content-wrapper {
   max-width: 1400px;
   margin: 0 auto;
   padding: 0 16px;
}

.summary {
   margin-top: 20px;
   display: flex;
   justify-content: space-between;
   align-items: center;
}

.star {
   color: #FFD700;
   font-size: 24px;
   margin: 0 5px;
}

.order-btn {
   background-color: transparent;
   border: none;
   font-weight: bold;
   font-size: 18px;
   cursor: pointer;
   display: flex;
   align-items: center;
   gap: 5px;
   margin-right: 105px;
}

table.review-table {
   width: 100%;
   margin-top: 20px;
   border-collapse: collapse;
}

table.review-table th, table.review-table td {
   border: 1px solid #000;
   padding: 12px;
   text-align: center;
   vertical-align: middle;
}

.review-table th {
   background-color: #f8f9fa;
   font-weight: bold;
}

.review-table th:nth-child(1), .review-table td:nth-child(1) {
   width: 12%;
}

.review-table th:nth-child(2), .review-table td:nth-child(2) {
   width: 16%;
}

.review-table th:nth-child(3), .review-table td:nth-child(3) {
   width: 40%;
}

.review-table th:nth-child(4), .review-table td:nth-child(4) {
   width: 12%;
}

.review-table th:nth-child(5), .review-table td:nth-child(5) {
   width: 10%;
   font-size: 13px;
}

.review-table th:nth-child(6), .review-table td:nth-child(6) {
   width: 10%;
   font-size: 13px;
}

.thumb-buttons .btn {
   margin: 0 3px;
}
/* 별점 */
.star-rating {
   display: flex;
   flex-direction: row;
}

.star-container {
   position: relative;
   width: 24px;
   height: 24px;
   display: inline-block;
}

.star-base, .star-overlay {
   font-size: 24px;
   line-height: 1;
   position: absolute;
   top: 0;
   left: 0;
}

.star-base {
   color: lightgray;
}

.star-overlay {
   color: gold;
   overflow: hidden;
   width: 0;
}

.star-container[data-value] {
   cursor: pointer;
}
/* 토스트 */
#toast {
   visibility: hidden;
   min-width: 250px;
   background-color: #333;
   color: #fff;
   text-align: center;
   border-radius: 8px;
   padding: 12px 20px;
   position: fixed;
   z-index: 9999;
   top: 20px; /* ✅ 상단에 고정 */
   left: 50%;
   transform: translateX(-50%); /* ✅ 가로만 중앙 정렬 */
   font-size: 16px;
   opacity: 0;
   transition: opacity 0.5s ease-in-out, visibility 0s linear 0.5s;
}


#toast.show {
   visibility: visible;
   opacity: 1;
   transition: opacity 0.5s ease-in-out;
}

#toast.error {
   background-color: #dc3545;
}



<!--
버튼-->.my-button-group {
   display: flex;
   justify-content: center;
   margin-top: 24px;
}

.my-button {
   appearance: none; /* 브라우저 기본 버튼 제거 */
   background: none; /* 배경 초기화 */
   border: none; /* 테두리 제거 */
   outline: none;
   padding: 0;
   margin: 0;
   width: 100px;
   height: 42px;
   font-size: 16px;
   font-weight: bold;
   color: white;
   border-radius: 8px;
   cursor: pointer;
   transition: background-color 0.2s ease-in-out;
}

.my-button.write {
   background-color: #28a745;
   appearance: none; /* 브라우저 기본 버튼 제거 */
   border: none; /* 테두리 제거 */
   outline: none;
   padding: 0;
   margin: 0;
   width: 100px;
   height: 42px;
   font-size: 16px;
   font-weight: bold;
   color: white;
   border-radius: 8px;
   cursor: pointer;
   transition: background-color 0.2s ease-in-out;
}

.my-button.write:hover {
   background-color: #218838;
}

/* 취소 버튼 */
.my-button.cancel {
   background-color: #dc3545;
   appearance: none; /* 브라우저 기본 버튼 제거 */
   border: none; /* 테두리 제거 */
   outline: none;
   padding: 0;
   margin: 0;
   width: 100px;
   height: 42px;
   font-size: 16px;
   font-weight: bold;
   color: white;
   border-radius: 8px;
   cursor: pointer;
   transition: background-color 0.2s ease-in-out;
}

.my-button.cancel:hover {
   background-color: #c82333;
}
</style>
</head>



<body>
<%
String already = request.getParameter("already");
if ("1".equals(already)) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () {
   showToast("추천/비추천은 1번만 가능합니다.", "error");
});
</script>
<%
}
%>
   <%
   String success = request.getParameter("success");
   if ("1".equals(success)) {
   %>
   <script>
   document.addEventListener("DOMContentLoaded", function () {
      showToast("후기 등록이 완료되었습니다.");
   });
</script>
   <%
   }
   %>

   <%
   //아이디1개당 1번 평점 등록
   String duplicate = request.getParameter("duplicate");
   if ("1".equals(duplicate)) {
   %>
   <script>
   document.addEventListener("DOMContentLoaded", function () {
      showToast("이미 평점을 등록하셨습니다.", "error");
   });
   </script>
   <%
   }
   ////
   String pageParam = request.getParameter("page");
   String order = request.getParameter("order");
   if (order == null || order.equals(""))
   order = "추천순";

   int currentPage = (pageParam == null || pageParam.equals("")) ? 1 : Integer.parseInt(pageParam);
   int perPage = 12;
   int start = (currentPage - 1) * perPage;

   String hg_id = request.getParameter("hg_id");
   GpaDao dao = new GpaDao();
   double avgStars = dao.getAverageStarsByHgId(hg_id);
   int totalCount = dao.getCountByHgId(hg_id);
   String hgName = dao.getHgName(hg_id);
   List<GpaDto> list = dao.getReviewsByHgIdPaging(hg_id, start, perPage, order);
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   String userid = (String) session.getAttribute("userId");
   %>

   <div class="custom-content-wrapper">
      <div class="summary">
         <div>
            <strong><%=hgName%> 평균 평점</strong> <span class="star">★</span> <strong><%=String.format("%.1f", avgStars)%></strong>
            <small>(5점만점)</small> <br> <strong><%=totalCount%>개의
               평점</strong>
         </div>
         <div>
            <button class="order-btn" onclick="toggleOrder()">
               <i class="bi bi-arrow-down-up"></i> <span id="orderText"><%=order%></span>
            </button>
         </div>
      </div>

      <!-- 후기 테이블 -->
      <table class="review-table">
         <thead>
            <tr>
               <th>평점</th>
               <th>아이디</th>
               <th>방문객 후기</th>
               <th>후기 작성일</th>
               <th>후기 추천수</th>
               <th>평점 추천</th>
            </tr>
         </thead>
         <tbody>
            <%
            for (GpaDto dto : list) {
            %>
            <tr style="position: relative;">
   <td><%=dto.getStars()%></td>
   <td><%=dto.getUserid()%></td>
   <td><%=dto.getContent()%></td>
   <td><%=sdf.format(dto.getWriteday())%></td>
   <td><%=dto.getGood()%></td>
   <td class="thumb-buttons">
   <% if (userid == null) { %>
      <button class="btn btn-sm btn-outline-success" onclick="alert('로그인 후 이용 가능합니다.'); return false;">
         <i class="bi bi-hand-thumbs-up"></i>
      </button>
      <button class="btn btn-sm btn-outline-danger" onclick="alert('로그인 후 이용 가능합니다.'); return false;">
         <i class="bi bi-hand-thumbs-down"></i>
      </button>
   <% } else { %>
      <a href="<%=request.getContextPath()%>/gpa/goodUpdate.jsp?num=<%=dto.getNum()%>&type=up&hg_id=<%=hg_id%>&order=<%=order%>"
         class="btn btn-sm btn-outline-success me-1">
         <i class="bi bi-hand-thumbs-up"></i>
      </a>
      <a href="<%=request.getContextPath()%>/gpa/goodUpdate.jsp?num=<%=dto.getNum()%>&type=down&hg_id=<%=hg_id%>&order=<%=order%>"
         class="btn btn-sm btn-outline-danger">
         <i class="bi bi-hand-thumbs-down"></i>
      </a>
   <% } %>

   <%-- ✅ 삭제 버튼을 td 밖에, 오른쪽 띄워서 배치 (작성자일 경우만, confirm 포함) --%>
   <% if (userid != null && userid.equals(dto.getUserid())) { %>
   <span style="position: absolute; top: 50%; left: 100%; transform: translate(10px, -50%);">
      <button onclick="confirmDelete('<%=dto.getNum()%>', '<%=hg_id%>', '<%=order%>')"
         style="background-color: #dc3545; color: white; border: none;
               padding: 4px 12px; border-radius: 5px; font-weight: bold; cursor: pointer; white-space: nowrap;">
         삭제
      </button>
   </span>
<% } %>

</td>

</tr>

            <%
            }
            %>
         </tbody>
      </table>
      <!-- 후기 작성 버튼 -->
      <div class="review-button-container text-end mt-4">
         <button class="btn btn-primary review-write-btn"
            <%if (userid == null) {%>
            onclick="alert('로그인을 하십시오.'); return false;" <%} else {%>
            data-bs-toggle="modal" data-bs-target="#reviewModal" <%}%>>✍️
            후기 작성</button>


      </div>
   </div>

   <!-- 후기 작성 모달 -->
   <div class="modal fade" id="reviewModal" tabindex="-1"
      aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content p-4">
            <form action="<%=request.getContextPath()%>/gpa/gpaAction.jsp"
               method="post">
               <input type="hidden" name="userid" value="<%=userid%>"> <input
                  type="hidden" name="hg_id" value="<%=hg_id%>"> <input
                  type="hidden" name="order" value="<%=order%>"> <input
                  type="hidden" name="stars" id="modalRatingValue">

               <!-- 상단: 평점 + 별 / 아이디 -->
               <div
                  class="d-flex justify-content-between align-items-center mb-3 px-1">
                  <div class="d-flex align-items-center">
                     <span class="me-2">평점</span>
                     <div class="star-rating">
                        <%
                        for (int i = 0; i < 5; i++) {
                        %>
                        <div class="star-container modal-star" data-value="<%=i + 1%>">
                           <i class="bi bi-star-fill star-base"></i> <i
                              class="bi bi-star-fill star-overlay"></i>
                           <div class="half-hover"
                              style="position: absolute; top: 0; left: 0; width: 50%; height: 100%; z-index: 2;"></div>
                           <div class="full-hover"
                              style="position: absolute; top: 0; left: 50%; width: 50%; height: 100%; z-index: 2;"></div>
                        </div>
                        <%
                        }
                        %>
                     </div>
                  </div>
                  <div>
                     <strong>아이디:</strong>
                     <%=userid%></div>
               </div>

               <!-- 텍스트 입력 -->
               <div class="mb-3">
                  <textarea name="content" class="form-control"
                     style="height: 200px; border: 2px solid #666; border-radius: 10px; resize: none;"
                     placeholder="평점을 입력해주세요..." required></textarea>
               </div>


               <div class="my-button-group">
                  <button type="submit" class="my-button write">
                     <i class="bi bi-check-lg"></i>
                  </button>
                  <button type="button" class="my-button cancel"
                     data-bs-dismiss="modal">
                     <i class="bi bi-x-lg"></i>
                  </button>
               </div>





            </form>
         </div>
      </div>
   </div>

   <div id="toast"></div>

   <!-- 별점 JS -->
   <script>
document.addEventListener("DOMContentLoaded", function () {
  const modalStars = document.querySelectorAll(".modal-star");
  const input = document.getElementById("modalRatingValue");

  modalStars.forEach((star, idx) => {
    const half = star.querySelector(".half-hover");
    const full = star.querySelector(".full-hover");
    half.addEventListener("mouseenter", () => updateStars(idx + 0.5));
    full.addEventListener("mouseenter", () => updateStars(idx + 1));
    half.addEventListener("click", () => selectStars(idx + 0.5));
    full.addEventListener("click", () => selectStars(idx + 1));
  });

  function updateStars(value) {
    modalStars.forEach((c, i) => {
      const overlay = c.querySelector(".star-overlay");
      overlay.style.width = "0";
      if (value >= i + 1) {
        overlay.style.width = "100%";
      } else if (value > i) {
        overlay.style.width = "50%";
      }
    });
  }

  function selectStars(value) {
    input.value = value;
    updateStars(value);
  }

  updateStars(0); // 초기 상태
});

function showToast(message, type = "success") {
   const toast = document.getElementById("toast");
   toast.textContent = message;

   // 기존 클래스 초기화
   toast.className = "";
   toast.classList.add("show", type); // type: success 또는 error

   setTimeout(() => {
      toast.classList.remove("show");
   }, 3000);
}

//원하는 툴로 나열
function toggleOrder() {
   let orderModes = ["최신순", "추천순", "평점 높은순", "평점 낮은순"];
   let currentOrderIndex = orderModes.indexOf("<%=order%>");
   currentOrderIndex = (currentOrderIndex + 1) % orderModes.length;
   const selectedOrder = orderModes[currentOrderIndex];
   const urlParams = new URLSearchParams(window.location.search);
   urlParams.set("order", selectedOrder);
   urlParams.set("page", "1");
   location.href = "<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=" + "<%=hg_id%>" + "&" + urlParams.toString();
}

function confirmDelete(num, hg_id, order) {
    const context = "<%=request.getContextPath()%>";
    if (confirm("삭제하시겠습니까?")) {
        const encodedOrder = encodeURIComponent(order);
        location.href = `${context}/gpa/deleteGpa.jsp?num=${num}&hg_id=${hg_id}&order=${encodedOrder}`;
    }
}


</script>

   <!-- 페이징 -->
   <%
   int totalPage = (int) Math.ceil(totalCount / (double) perPage);
   %>
   <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center mt-4">
         <%
         for (int i = 1; i <= totalPage; i++) {
         %>
         <li class="page-item <%=(i == currentPage) ? "active" : ""%>"><a
            class="page-link"
            href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%=hg_id%>&page=<%=i%>&order=<%=order%>"><%=i%></a>
         </li>
         <%
         }
         %>
      </ul>
   </nav>

</body>
</html>
