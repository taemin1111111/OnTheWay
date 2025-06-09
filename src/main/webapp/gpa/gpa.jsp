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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 후기 페이지</title>
<%-- Google Fonts: Noto Sans KR --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

<%-- Bootstrap 5 & Icons --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
:root {
    --primary-color: #4A90E2; /* 부드러운 블루 */
    --primary-hover-color: #357ABD;
    --text-color-primary: #333;
    --text-color-secondary: #767676;
    --background-color: #f8f9fa;
    --card-background-color: #ffffff;
    --border-color: #e9ecef;
    --star-color: #FFD700; /* 골드 */
    --star-inactive-color: #e0e0e0;
    --success-color: #28a745;
    --danger-color: #dc3545;
    
    --font-family-main: 'Noto Sans KR', sans-serif;
    --border-radius-sm: 8px;
    --border-radius-md: 12px;
    --shadow-soft: 0 4px 12px rgba(0, 0, 0, 0.08);
    --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.1);
}

body {
    font-family: var(--font-family-main);
    background-color: var(--background-color);
    color: var(--text-color-primary);
    padding: 2rem 0;
    padding-top: 0px;
}

.review-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 0 1rem;
}

/* --- 상단 요약 섹션 --- */
.review-summary {
    background-color: var(--card-background-color);
    padding: 2rem;
    border-radius: var(--border-radius-md);
    box-shadow: var(--shadow-soft);
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.summary-rating .rating-value {
    font-size: 2.5rem;
    font-weight: 700;
    color: var(--primary-color);
}

.summary-rating .rating-value i {
    font-size: 2rem;
    color: var(--star-color);
    margin-right: 0.5rem;
}

.summary-rating .total-reviews {
    font-size: 1rem;
    color: var(--text-color-secondary);
    font-weight: 500;
}

.sort-and-write {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.sort-btn {
    font-family: var(--font-family-main);
    background-color: transparent;
    border: 1px solid var(--border-color);
    color: var(--text-color-secondary);
    border-radius: var(--border-radius-sm);
    padding: 0.6rem 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s, color 0.2s;
}
.sort-btn:hover {
    background-color: var(--background-color);
    color: var(--text-color-primary);
}

.review-write-btn {
    background-color: var(--primary-color);
    color: white;
    font-weight: 700;
    padding: 0.6rem 1.5rem;
    border-radius: var(--border-radius-sm);
    border: none;
    transition: background-color 0.2s;
}
.review-write-btn:hover {
    background-color: var(--primary-hover-color);
    color: white;
}

/* --- 🌟 리뷰 카드 (테이블 대체) --- */
.review-list {
    display: grid;
    gap: 1.5rem;
}

.review-card {
    background-color: var(--card-background-color);
    border: 1px solid var(--border-color);
    border-radius: var(--border-radius-md);
    padding: 1.5rem;
    box-shadow: var(--shadow-soft);
    position: relative;
    transition: transform 0.2s, box-shadow 0.2s;
}
.review-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-medium);
}

.review-card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 0.75rem;
}

.review-author .author-id {
    font-weight: 700;
    font-size: 1.1rem;
}
.review-author .write-date {
    font-size: 0.85rem;
    color: var(--text-color-secondary);
    margin-top: 2px;
}

.card-star-rating { color: var(--star-inactive-color); }
.card-star-rating .bi-star-fill { color: var(--star-color); }

.review-card-body p {
    line-height: 1.7;
    margin: 0;
}

.review-card-footer {
    margin-top: 1.5rem;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 0.75rem;
}

.thumb-btn {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    background-color: transparent;
    border: 1px solid var(--border-color);
    padding: 0.4rem 0.8rem;
    border-radius: 20px; /* pill shape */
    font-size: 0.9rem;
    color: var(--text-color-secondary);
    cursor: pointer;
    transition: all 0.2s;
}
.thumb-btn:hover {
    color: var(--text-color-primary);
    background-color: #f1f1f1;
}
.thumb-btn .count { font-weight: 700; }
.thumb-btn.up:hover { border-color: var(--success-color); }
.thumb-btn.down:hover { border-color: var(--danger-color); }


.delete-btn {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: none;
    border: none;
    color: var(--text-color-secondary);
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.2s;
    padding: 0.5rem;
}
.review-card:hover .delete-btn { opacity: 1; }
.delete-btn:hover { color: var(--danger-color); }


/* --- ✨ 후기 작성 모달 --- */
#reviewModal .modal-content {
    background-color: var(--card-background-color);
    border-radius: var(--border-radius-md);
    border: none;
    box-shadow: var(--shadow-medium);
    padding: 1.5rem;
    text-align: center;
}

#reviewModal .modal-header {
    border-bottom: none;
    text-align: center;
    justify-content: center;
    padding-top: 0;
}
#reviewModal .modal-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--text-color-primary);
}
#reviewModal .modal-title i {
    color: var(--primary-color);
}
#reviewModal .btn-close {
    position: absolute;
    top: 1.5rem;
    right: 1.5rem;
}

#reviewModal .modal-body { padding: 1rem 1.5rem; }

.rating-prompt {
    font-size: 1rem;
    color: var(--text-color-secondary);
    margin-bottom: 1rem;
    font-weight: 500;
}

/* 인터랙티브 별점 시스템 */
.interactive-star-rating {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
}

.interactive-star-rating .bi {
    font-size: 2.5rem;
    color: var(--star-inactive-color);
    cursor: pointer;
    transform-origin: center;
    transition: color 0.2s ease, transform 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}
.interactive-star-rating:hover .bi { color: var(--star-color); }
.interactive-star-rating .bi:hover ~ .bi { color: var(--star-inactive-color); }
.interactive-star-rating .bi.selected { color: var(--star-color); }
.interactive-star-rating .bi:hover { transform: scale(1.2); }

.rating-feedback {
    min-height: 24px;
    font-weight: 700;
    color: var(--primary-color);
    transition: opacity 0.3s;
    margin-bottom: 1.5rem;
}

#reviewModal textarea.form-control {
    min-height: 150px;
    border-radius: var(--border-radius-md);
    border: 1px solid var(--border-color);
    resize: none;
    padding: 1rem;
}
#reviewModal textarea.form-control:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
}

#reviewModal .modal-footer {
    border-top: none;
    display: flex;
    justify-content: center;
    gap: 1rem;
    padding-bottom: 0;
}
#reviewModal .modal-footer .btn {
    min-width: 120px;
    padding: 0.75rem 1.5rem;
    font-weight: 700;
    border-radius: var(--border-radius-sm);
    border: none;
}
#reviewModal .btn-submit {
    background-color: var(--primary-color);
    color: white;
}
#reviewModal .btn-submit:hover { background-color: var(--primary-hover-color); }
#reviewModal .btn-cancel {
    background-color: var(--border-color);
    color: var(--text-color-secondary);
}
#reviewModal .btn-cancel:hover { background-color: #dcdfe2; }


/* --- 토스트 알림 --- */
#toast {
   visibility: hidden;
   min-width: 250px;
   background-color: #333;
   color: #fff;
   text-align: center;
   border-radius: var(--border-radius-sm);
   padding: 1rem;
   position: fixed;
   z-index: 9999;
   top: 20px;
   left: 50%;
   transform: translateX(-50%);
   font-size: 1rem;
   font-weight: 500;
   box-shadow: var(--shadow-medium);
   opacity: 0;
   transition: opacity 0.5s, top 0.5s;
}

#toast.show {
   visibility: visible;
   opacity: 1;
   top: 40px;
}
#toast.error { background-color: var(--danger-color); }

</style>
</head>

<body>

<%
// --- 기존 Java 로직은 그대로 유지 ---
String already = request.getParameter("already");
if ("1".equals(already)) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () { showToast("추천/비추천은 1번만 가능합니다.", "error"); });
</script>
<% } %>

<%
String success = request.getParameter("success");
if ("1".equals(success)) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () { showToast("후기 등록이 완료되었습니다."); });
</script>
<% } %>

<%
String duplicate = request.getParameter("duplicate");
if ("1".equals(duplicate)) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () { showToast("이미 평점을 등록하셨습니다.", "error"); });
</script>
<% } %>

<%
String pageParam = request.getParameter("page");
String order = request.getParameter("order");
if (order == null || order.isEmpty()) order = "추천순";

int currentPage = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
int perPage = 10; // 페이지당 카드 개수 조정
int start = (currentPage - 1) * perPage;

String hg_id = request.getParameter("hg_id");
GpaDao dao = new GpaDao();
double avgStars = dao.getAverageStarsByHgId(hg_id);
int totalCount = dao.getCountByHgId(hg_id);
String hgName = dao.getHgName(hg_id);
List<GpaDto> list = dao.getReviewsByHgIdPaging(hg_id, start, perPage, order);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

String userid = (String) session.getAttribute("userId");
%>

<div class="review-container">
    <header class="review-summary">
        <div class="summary-rating">
            <span class="rating-value"><i class="bi bi-star-fill"></i><%=String.format("%.1f", avgStars)%></span>
            <div class="total-reviews"><%=hgName%>에 대한 <%=totalCount%>개의 소중한 후기</div>
        </div>
        <div class="sort-and-write">
            <button class="sort-btn" onclick="toggleOrder()">
                <i class="bi bi-arrow-down-up"></i>
                <span id="orderText"><%=order%></span>
            </button>
            <button class="btn review-write-btn"
                <%if (userid == null) {%>
                onclick="alert('로그인 후 후기를 작성할 수 있습니다.');"
                <%} else {%>
                data-bs-toggle="modal" data-bs-target="#reviewModal"
                <%}%>>
                <i class="bi bi-pencil-square"></i> 후기 작성
            </button>
        </div>
    </header>

    <main class="review-list">
        <% for (GpaDto dto : list) { %>
        <article class="review-card">
            <div class="review-card-header">
                <div class="review-author">
                    <div class="author-id"><%=dto.getUserid()%></div>
                    <div class="write-date"><%=sdf.format(dto.getWriteday())%></div>
                </div>
                <div class="card-star-rating">
                    <% for(int i=1; i<=5; i++){ %>
                        <i class="bi <%= (dto.getStars() >= i) ? "bi-star-fill" : "bi-star" %>"></i>
                    <% } %>
                </div>
            </div>
            <div class="review-card-body">
                <p><%=dto.getContent()%></p>
            </div>
            <div class="review-card-footer">
                <% if (userid != null && userid.equals(dto.getUserid())) { %>
                    <button class="delete-btn" onclick="confirmDelete('<%=dto.getNum()%>', '<%=hg_id%>', '<%=order%>')">
                        <i class="bi bi-trash3"></i>
                    </button>
                <% } %>
                <a href="<%= (userid == null) ? "javascript:alert('로그인 후 이용 가능합니다.');" : request.getContextPath()+"/gpa/goodUpdate.jsp?num="+dto.getNum()+"&type=up&hg_id="+hg_id+"&order="+order %>" class="thumb-btn up">
                    <i class="bi bi-hand-thumbs-up"></i>
                    <span class="count"><%=dto.getGood()%></span>
                </a>
                 <a href="<%= (userid == null) ? "javascript:alert('로그인 후 이용 가능합니다.');" : request.getContextPath()+"/gpa/goodUpdate.jsp?num="+dto.getNum()+"&type=down&hg_id="+hg_id+"&order="+order %>" class="thumb-btn down">
                    <i class="bi bi-hand-thumbs-down"></i>
                </a>
            </div>
        </article>
        <% } %>
    </main>

    <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/gpa/gpaAction.jsp" method="post">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="hg_id" value="<%=hg_id%>">
                    <input type="hidden" name="order" value="<%=order%>">
                    <input type="hidden" name="stars" id="modalRatingValue" value="0">

                    <div class="modal-header">
                        <h5 class="modal-title" id="reviewModalLabel"><i class="bi bi-chat-quote-fill"></i> 소중한 후기를 들려주세요</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <p class="rating-prompt">이 장소에 대한 경험은 어떠셨나요?</p>
                        <div class="interactive-star-rating" id="modalStarRating">
                            <i class="bi bi-star" data-value="1"></i>
                            <i class="bi bi-star" data-value="2"></i>
                            <i class="bi bi-star" data-value="3"></i>
                            <i class="bi bi-star" data-value="4"></i>
                            <i class="bi bi-star" data-value="5"></i>
                        </div>
                        <p class="rating-feedback" id="ratingFeedbackText">&nbsp;</p>

                        <textarea name="content" class="form-control" placeholder="자세한 후기를 작성해주시면 다른 사용자에게 큰 도움이 됩니다." required></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-submit">등록하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="toast"></div>

    <%
    int totalPage = (int) Math.ceil(totalCount / (double) perPage);
    if(totalPage > 1) {
    %>
    <nav aria-label="Page navigation" class="mt-5">
      <ul class="pagination justify-content-center">
         <% for (int i = 1; i <= totalPage; i++) { %>
         <li class="page-item <%=(i == currentPage) ? "active" : ""%>">
            <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%=hg_id%>&page=<%=i%>&order=<%=order%>"><%=i%></a>
         </li>
         <% } %>
      </ul>
   </nav>
   <% } %>

</div> <%-- /.review-container --%>

<script>
// --- 최신 트렌드가 적용된 스크립트 ---

// 모달 인터랙티브 별점 시스템
document.addEventListener("DOMContentLoaded", function () {
    const stars = document.querySelectorAll("#modalStarRating .bi");
    const ratingInput = document.getElementById("modalRatingValue");
    const feedbackText = document.getElementById("ratingFeedbackText");
    const ratingFeedbacks = {
        0: "&nbsp;",
        1: "별로예요",
        2: "조금 아쉬워요",
        3: "괜찮아요",
        4: "좋아요",
        5: "아주 좋아요!"
    };

    stars.forEach(star => {
        star.addEventListener("mouseover", handleMouseOver);
        star.addEventListener("click", handleClick);
    });

    document.getElementById('modalStarRating').addEventListener('mouseleave', handleMouseLeave);

    function handleMouseOver(e) {
        const hoverValue = e.target.dataset.value;
        stars.forEach(star => {
            star.classList.toggle("bi-star-fill", star.dataset.value <= hoverValue);
            star.classList.toggle("bi-star", star.dataset.value > hoverValue);
        });
    }

    function handleClick(e) {
        const selectedValue = e.target.dataset.value;
        ratingInput.value = selectedValue;
        feedbackText.textContent = ratingFeedbacks[selectedValue];
        
        stars.forEach(star => {
            star.classList.remove("selected");
            if (star.dataset.value <= selectedValue) {
                star.classList.add("selected");
            }
        });
    }

    function handleMouseLeave() {
        const selectedValue = ratingInput.value;
        stars.forEach(star => {
            star.classList.toggle("bi-star-fill", star.dataset.value <= selectedValue && star.classList.contains("selected"));
            star.classList.toggle("bi-star", !(star.dataset.value <= selectedValue && star.classList.contains("selected")));
        });
    }
    
    // 모달이 닫힐 때 별점 초기화
    const reviewModal = document.getElementById('reviewModal');
    reviewModal.addEventListener('hidden.bs.modal', function () {
        ratingInput.value = 0;
        feedbackText.innerHTML = ratingFeedbacks[0];
        stars.forEach(star => {
            star.className = 'bi bi-star'; // 클래스 전체 초기화
        });
    });
});


// 토스트 알림
function showToast(message, type = "success") {
   const toast = document.getElementById("toast");
   toast.textContent = message;
   toast.className = "show";
   if (type === 'error') {
       toast.classList.add('error');
   }
   setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 3000);
}

// 정렬 순서 변경
function toggleOrder() {
   let orderModes = ["최신순", "추천순", "평점 높은순", "평점 낮은순"];
   let currentOrderIndex = orderModes.indexOf("<%=order%>");
   currentOrderIndex = (currentOrderIndex + 1) % orderModes.length;
   const selectedOrder = orderModes[currentOrderIndex];
   location.href = "<%=request.getContextPath()%>/index.jsp?main=gpa/gpa.jsp&hg_id=<%=hg_id%>&order=" + selectedOrder + "&page=1";
}

// 삭제 확인
function confirmDelete(num, hg_id, order) {
    if (confirm("이 후기를 정말 삭제하시겠습니까?")) {
        const encodedOrder = encodeURIComponent(order);
        location.href = "<%=request.getContextPath()%>/gpa/deleteGpa.jsp?num=" + num + "&hg_id=" + hg_id + "&order=" + encodedOrder;
    }
}
</script>
</body>
</html>