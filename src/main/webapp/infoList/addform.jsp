<%@page import="hgDao.infoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.util.Map" %>
<%@ page import="hg.HgDataDao" %>

<%
	HgDataDao dao = new HgDataDao();
	List<Map<String, String>> restList = dao.getAllRestStops();
    
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>공지사항 추가 폼</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f7fa;
    padding-top: 60px;
  }
  .form-wrapper {
    max-width: 700px;
    margin: 40px auto;
    background: #fff;
    padding: 40px 50px;
    border-radius: 14px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
  }
  .form-wrapper h2 {
    color: #2c7a2c;
    font-weight: 700;
    margin-bottom: 35px;
    border-left: 6px solid #2c7a2c;
    padding-left: 15px;
  }
  label {
    font-weight: 600;
    color: #3a3a3a;
    margin-bottom: 6px;
  }
  input[type="text"],
  input[type="date"],
  select,
  input[type="file"],
  textarea {
    border: 1.8px solid #d1d9de;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 1rem;
    color: #2e2e2e;
    width: 100%;
    transition: border-color 0.3s ease;
  }
  input:focus,
  select:focus,
  textarea:focus {
    outline: none;
    border-color: #2c7a2c;
    box-shadow: 0 0 8px rgba(44, 122, 44, 0.3);
  }
  textarea {
    resize: vertical;
    min-height: 120px;
  }
  .file-note {
    font-size: 0.85rem;
    color: #777;
    margin-top: 4px;
  }
</style>
</head>
<body>

<div class="form-wrapper">
  <h2>공지사항 등록</h2>

  <form id="eventForm" action="addaction.jsp" method="post" enctype="multipart/form-data">
    <!-- 이벤트명 -->
    <div class="mb-4">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required />
    </div>

    <!-- 휴게소 선택 -->
    <div class="mb-4">
      <label for="hgId">등록할 휴게소</label>
      <select name="hgId" id="hgId" required>
        <option value="">휴게소를 선택하세요.</option>
        <% for (Map<String, String> rest : restList) { %>
          <option value="<%= rest.get("id") %>"><%= rest.get("rest_name") %></option>
        <% } %>
      </select>
    </div>

 

    <!-- 이벤트 이미지 -->
    <div class="mb-4">
      <label for="fileInput">이미지</label>
      <input type="file" id="fileInput" name="photo" accept="image/*" />
      <input type="hidden" id="photoFilename" name="photoFilename" />
      <div class="file-note">※ 이미지 파일만 업로드 가능합니다.</div>
    </div>

    <!-- 이벤트 내용 -->
    <div class="mb-4">
      <label for="content">내용</label>
      <textarea id="content" name="content" placeholder="내용을 입력하세요" required></textarea>
    </div>

    <!-- 버튼 (세로 정렬) -->
    <div class="text-center" style="float:right">
      <button type="submit" id="submitBtn" class="btn btn-success">등록</button>      
	  <button type="button" id="backBtn" class="btn btn-secondary" >이전</button>
    </div>
  </form>
</div>

<script>
  $(document).ready(function () {
    // 파일명 표시용 이벤트만 유지
    $('#fileInput').on('change', function () {
      const file = this.files[0];
      if (file) {
        $('#photoFilename').val(file.name);
      } else {
        $('#photoFilename').val('');
      }
    });

    // 뒤로가기 버튼 이벤트만 남기기
    $('#backBtn').on('click', function () {
      $('#eventForm')[0].reset();
      history.back();
    });
  });
</script>

</body>
</html>
