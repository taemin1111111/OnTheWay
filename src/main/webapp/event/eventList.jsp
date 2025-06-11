<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="event.EventDao" %>
<%@ page import="event.EventDto" %>
<%@ page import="hg.HgDataDao" %>

<%
    EventDao dao = new EventDao();
    List<EventDto> list = dao.getAllEvents();

    HgDataDao hgDao = new HgDataDao();
    
    Integer role = (Integer) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            padding: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        h2 {
            font-weight: 800;
            margin-top: 50px;
            margin-bottom: 50px;
            text-align: center;
        }
        .event-card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 15px 15px;
            margin-bottom: 30px;
            text-align: center;
            transition: box-shadow 0.2s;
            height: 100%;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }
        .event-card:hover {
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }
        .event-photo {
		    width: 100%;
		    height: 200px;
		    object-fit: cover;       /* 비율 유지하며 채우고 넘치는 건 잘림 */
		    object-position: top;    /* 이미지의 윗부분이 보이도록 */
		    border-radius: 6px;
		    margin-bottom: 15px;
		}
        .event-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #2c7a2c;
            margin-bottom: 10px;
        }
        .event-info {
            font-size: 0.95rem;
            color: #333;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>

    <h2>이벤트 / 혜택 &nbsp;<i class="bi bi-calendar-event"></i></h2>
	<hr>
	<% if (role != null && role == 1) { %>
	    <div class="container mb-3 text-end">
	        <a href="index.jsp?main=event/eventAddForm.jsp" class="btn btn-success">
	            <i class="bi bi-plus-circle"></i> 이벤트 작성하기
	        </a>
	    </div>
	<% } %>
	
    <div class="container mt-4">
        <div class="row">
            <%
                for (EventDto dto : list) {
                    String restName = "";
                    try {
                        restName = hgDao.getRestNameById(Integer.parseInt(dto.getHgId()));
                    } catch (Exception e) {
                        restName = "알 수 없음";
                    }
            %>
                <div class="col-md-4 d-flex mb-4">
                    <a href="index.jsp?main=event/eventDetail.jsp?id=<%= dto.getId() %>" class="event-card w-100">
                        <% if (dto.getPhoto() != null && !dto.getPhoto().isEmpty()) { %>
                            <img src="eventImage/<%= dto.getPhoto() %>" class="event-photo" alt="이벤트 이미지">
                        <% } %>
                        <div class="event-title"><%= dto.getTitle() %></div>
                        <div class="event-info">휴게소: <strong><%= restName %></strong></div>
                        <div class="event-info">기간: <%= dto.getStartday() %> ~ <%= dto.getEndday() %></div>
                    </a>
                </div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>