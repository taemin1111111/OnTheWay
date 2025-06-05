<%@page import="hg.HgDataDao"%>
<%@page import="hg.HgDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="hgDao.infoDao"%>
<%@page import="hgDto.infoDto"%>
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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">  
  <!-- Bootstrap Icons CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.css" rel="stylesheet">
  
  <!-- Google Fonts (Optional, 모던폰트) -->
  <link href="https://fonts.googleapis.com/css2?family=Segoe+UI&display=swap" rel="stylesheet">

<title>Insert title here</title>

<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
    padding: 3rem 1rem;
  }

  h3 {
    font-weight: 700;
    font-size: 2.5rem;
    color: #212529;
    text-align: center;
    margin-bottom: 2.5rem;
    letter-spacing: 0.05em;
  }

  table {
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 24px rgb(0 0 0 / 0.1);
    overflow: hidden;
    transition: box-shadow 0.3s ease;
  }

  table:hover {
    box-shadow: 0 12px 36px rgb(0 0 0 / 0.15);
  }

  thead tr {
    background-color: #4a90e2;
    color: white;
    font-weight: 600;
    font-size: 1.05rem;
  }

  tbody tr {
    transition: background-color 0.25s ease;
    cursor: pointer;
  }

  tbody tr:hover {
    background-color: #f0f4ff;
  }

  tbody tr td {
    vertical-align: middle;
    font-size: 1rem;
    color: #495057;
  }

  a {
    color: #4a90e2;
    text-decoration: none;
    font-weight: 600;
  }

  a:hover {
    text-decoration: underline;
  }

  /* 번호 컬럼 */
  th:first-child, td:first-child {
    width: 60px;
    text-align: center;
  }

  /* 작성일 */
  td:nth-child(3), th:nth-child(3) {
    width: 140px;
    text-align: center;
    color: #6c757d;
    font-size: 0.9rem;
  }

  /* 조회수 */
  td:nth-child(4), th:nth-child(4) {
    width: 80px;
    text-align: center;
    color: #6c757d;
    font-size: 0.9rem;
  }
</style>
</head>
<%
request.setCharacterEncoding("utf-8");
infoDao dao=new infoDao();
List <infoDto> list=dao.getBoardList();
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

HgDataDao hgDao = new HgDataDao();


%>


<body>
	<div style="text-align: center; margin-top: 3rem;">
		<h3>공지사항</h3>
		<br><br>
		<table class="table table-bordered" style="width: 80%; max-width: 1200px; margin: 0 auto;">
			<caption align="top"><b>총<%=list.size() %>개의 게시글이 있습니다</b></caption>
			<tr>
				<th>번호</th>
				
				<th>제목</th>
				
						
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			
			<%
			if(list.size()==0)
			{%>
				<tr>
					<td colspan="3" align="center">
						<b>등록된 게시글이 없습니다.</b>
					</td>
				</tr>
			<%}
			else{
			
				for(int i=0;i<list.size();i++){
					infoDto dto = list.get(i);
					
					String restName = "";
                    try {
                        restName = hgDao.getRestNameById(Integer.parseInt(dto.getHgId()));
                    } catch (Exception e) {
                        restName = "알 수 없음";
                        java.io.StringWriter sw = new java.io.StringWriter();
                        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                        e.printStackTrace(pw);
                        out.println("예외 발생: " + sw.toString());
                    }
					
					
					
					%>
					
					<tr>
						<td><%= i+1%></td>
						
						<td><a href="detail.jsp?id=<%=dto.getId()%>"><%=dto.getTitle() %>[<%=restName %>]</a></td>
												
						
						<td><%=sdf.format(dto.getWriteday()) %></td>
						<td><%=dto.getReadcount() %></td>
					</tr>
					
					
					
					
					
				<%}
			}
			
			
			
			%>
			
		</table>
	
	</div>
	
	<!-- <div class="write" style="width:1000px;">
	   <button type="button" class="btn btn-outline-info"
	   onclick="" style="float: right">새글쓰기</button>&nbsp;&nbsp;
	   <button type="button" class="btn btn-outline-danger"
	   onclick="" style="float: right; margin-right:10px">선택삭제</button>
	</div> -->






</body>
</html>