<%@page import="hg.HgDataDao"%>
<%@page import="hg.HgDao"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="event.EventDao" %>
<%@ page import="event.EventDto" %>

<%
    EventDto event = new EventDao().getEventById(request.getParameter("id"));
    String restName = new HgDataDao().getRestNameById(Integer.parseInt(event.getHgId()));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이벤트 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
	<style>
		body {
			font-family: 'Noto Sans KR', sans-serif;
			padding: 50px 30px;
			background-color: #f8f9fa;
		}
		
		h2 {
			font-weight: 700;
			margin-top: 35px;
			margin-bottom: 25px;
		}
		
		.event-image {
			width: 100%;
			height: auto;
			border-radius: 12px;
			margin-bottom: 25px;
		}
		
		.event-detail {
			background-color: #ffffff;
			border-radius: 12px;
			padding: 25px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
		}
		
		.event-detail h3 {
			font-weight: 700;
			margin-bottom: 20px;
			color: #2c7a2c;
			font-size: 1.5rem;
		}
		
		.event-info-item {
			margin-bottom: 12px;
			font-size: 1.05rem;
		}
		
		.event-info-item strong {
			color: #444;
			width: 100px;
			display: inline-block;
		}
		
		.event-content-box {
			margin-top: 20px;
			padding: 15px 20px;
			background-color: #f9f9f9;
			border-left: 4px solid #198754;
			border-radius: 8px;
			line-height: 1.6;
			white-space: pre-line;
		}
		
		.btn-group {
			margin-top: 50px;
		}
	</style>
</head>
<body>

<div class="container">
    <h2>이벤트 / 혜택 &nbsp;<i class="bi bi-calendar-event"></i></h2>
    <hr />

    <%
    if (event != null) {
    %>
        <%
        if (event.getPhoto() != null && !event.getPhoto().equals("")) {
        %>
            <img src="eventImage/<%=event.getPhoto()%>" alt="이벤트 이미지" class="event-image">
        <%
        }
        %>

        <div class="event-detail">
		    <h3><%= event.getTitle() %></h3>
		
		    <div class="event-info-item">
		        <strong>휴게소 정보:</strong> <%= restName %>
		    </div>
		    <div class="event-info-item">
		        <strong>이벤트 기간:</strong> <%= event.getStartday() %> ~ <%= event.getEndday() %>
		    </div>
		
		    <div class="event-content-box"><%= event.getContent() %></div>
		</div>

        <div class="text-center">
		    <div class="btn-group">
		        <a href="index.jsp?main=event/eventList.jsp" class="btn btn-secondary me-2">목록으로</a>
	            <a href="index.jsp?main=details/info.jsp?hg_id=<%= event.getHgId() %>" class="btn btn-success">
	                <i class="bi bi-signpost-2"></i> 휴게소 정보 보기
	            </a>
		    </div>
		</div>
    <% } else { %>
        <div class="alert alert-warning">존재하지 않는 이벤트입니다.</div>
        <a href="index.jsp?main=event/eventList.jsp" class="btn btn-secondary mt-3">목록으로</a>
    <% } %>
</div>

</body>
</html>
