<%@page import="hg.HgDataDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hgDto.infoDto"%>
<%@page import="hgDao.infoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.css" rel="stylesheet">
<title>Insert title here</title>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
    padding: 3rem 1rem;
  }

  .boardcontent {
    max-width: 900px;
    margin: 50px auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 12px 36px rgb(0 0 0 / 0.12);
    padding: 2rem 3rem;
  }

  .boardcontent h3 {
    font-weight: 700;
    font-size: 2.2rem;
    color: #212529;
    margin-bottom: 1.8rem;
    text-align: center;
    letter-spacing: 0.05em;
  }

  .post-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: #343a40;
    margin-bottom: 0.3rem;
  }

  .post-meta {
    display: flex;
    justify-content: space-between;
    color: #6c757d;
    font-size: 0.9rem;
    margin-bottom: 1.8rem;
  }

  .post-meta span {
    display: inline-block;
  }

  .post-content {
    font-size: 1.1rem;
    line-height: 1.7;
    color: #495057;
    white-space: pre-wrap; /* 줄바꿈 유지 */
  }

  .post-image {
    max-width: 100%;
    border-radius: 12px;
    margin-bottom: 1.5rem;
    box-shadow: 0 4px 15px rgb(0 0 0 / 0.1);
  }

  .btn-list {
    max-width: 900px;
    margin: 30px auto 70px;
    text-align: right;
  }

  .btn-list .btn {
    min-width: 100px;
  }
</style>
</head>
<%
  String id=request.getParameter("id");

  infoDao dao=new infoDao();
  dao.updateReadCount(id);
  infoDto dto=dao.getData(id);
  HgDataDao hgDao = new HgDataDao();
  //조회수 증가
 
  
  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
  String restName=hgDao.getRestNameById(Integer.parseInt(dto.getHgId()));
%>

<body>
  <div class="boardcontent">
    <h3>공지사항</h3>
    <div class="post-title"><%= dto.getTitle() %></div>
    <div class="post-meta">
      <span><i class="bi bi-building"></i> <%= restName %></span>
      <span><i class="bi bi-calendar-event"></i> <%= dto.getWriteday() == null ? "" : sdf.format(dto.getWriteday()) %></span>
      <span><i class="bi bi-eye"></i> 조회수: <%= dto.getReadcount() %></span>
    </div>
    <% if(dto.getPhotoName() != null && !dto.getPhotoName().isEmpty()) { %>
      <img class="post-image" alt="게시글 이미지" src="../infoimage/<%= dto.getPhotoName() %>">
    <% } %>
    <div class="post-content">
      <%= dto.getContent() %>
    </div>
  </div>

  <div class="btn-list">
    <button type="button" class="btn btn-outline-primary" onclick="location.href='infoList.jsp'">
      <i class="bi bi-list"></i> 목록
    </button>
  </div>
</body>
</html>