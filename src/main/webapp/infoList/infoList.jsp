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
<title>Insert title here</title>


</head>
<%
request.setCharacterEncoding("utf-8");
infoDao dao=new infoDao();
List <infoDto> list=dao.getBoardList();
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");


%>


<body>
	<div>
		<h3>공지사항</h3>
		<br><br>
		<table class="table table-bordered" style="width:1000px;">
			<caption align="top"><b>총<%=list.size() %>개의 게시글이 있습니다</b></caption>
			<tr>
				<th><input type="checkbox">번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>아이디</th>
				<th>작성일</th>
			</tr>
			
			<%
			if(list.size()==0)
			{%>
				<tr>
					<td colspan="5" align="center">
						<b>등록된 게시글이 없습니다.</b>
					</td>
				</tr>
			<%}
			else{
			
				for(int i=0;i<list.size();i++){
					
					infoDto dto=list.get(i);
					%>
					
					<tr>
						<td>i+1</td>
						<td><a href=""><%=dto.getTitle() %></a><td>
						<td><%= dto.getContent()%></td>
						<td><%=dto.getName() %></td>
						<td><%=sdf.format(dto.getWriteday()) %></td>
						
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