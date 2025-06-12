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
#searchrest {
  width: 180px;
  height: 36px;
  padding: 0 12px;
  border: 2px solid #4a90e2; /* 테이블 헤더 색과 맞춤 */
  border-radius: 8px;
  font-size: 1rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: #495057;
  box-shadow: 0 2px 6px rgba(74, 144, 226, 0.25);
  transition: border-color 0.3s ease, box-shadow 0.3s ease;
  float: right;
  outline: none;
}

#searchrest::placeholder {
  color: #adb5bd; /* 연한 회색 */
}

#searchrest:focus {
  border-color: #2c6ed5;
  box-shadow: 0 0 8px rgba(44, 110, 213, 0.6);
}
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
    padding: 0;
    margin: 0; 
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

<script type="text/javascript"></script>




</script>
</head>
<%
request.setCharacterEncoding("utf-8");
infoDao dao=new infoDao();



SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

HgDataDao hgDao = new HgDataDao();

//페이징처리
//전체갯수
int totalCount=dao.getTotalCount();
int perPage=10; //한페이지에 보여질 글의 갯수
int perBlock=5; //한블럭당 보여질 페이지의 갯수
int startNum; //db에서 가져올 글의 시작번호(mysql:0 오라클:1번)
int startPage; //각블럭당 보여질 시작페이지
int endPage;//각블럭당 보여질 끝페이지
int currentPage; //현재페이지
int totalPage; //총페이지

int no; //각페이지당 출력할 시작번호

//현재페이지 읽기,단 null일경우는 1페이지로 준다
if(request.getParameter("currentPage")==null)
	  currentPage=1;
else
	  currentPage=Integer.parseInt(request.getParameter("currentPage"));


//총페이지수를 구한다
//총글의 갯수/한페이지당 보여질개수로 나눔(7/5=1)
//나머지가 1이라도 있으면 무저건 1페이지추가(1+1=2페이지가 필요)
totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);

//각블럭당 보여질 시작페이지
//perBlock=5일경우 현재페이지가 1~5 시작1,끝5
//만약 현재페이지가 13일경우는 시작11,끝15
startPage=(currentPage-1)/perBlock*perBlock+1;
endPage=startPage+perBlock-1;

//총페이지가 23개일경우 마지막 블럭은 끝 25가 아니라 23이다
if(endPage>totalPage)
	  endPage=totalPage;

//각페이지에서 보여질 시작번호
//예: 1페이지-->0  2페이지-->5 3페이지-->10...
startNum=(currentPage-1)*perPage;

//각페이지당 출력할 시작번호
//예를들어 총글갯수가 23   1페이지: 23  2페이지:18  3페이지: 13.....
no=totalCount-(currentPage-1)*perPage;



List<infoDto> list=dao.getList(startNum, perPage);

String userId=(String)session.getAttribute("userId");



%>


<body>
	<div style="text-align: center; margin-top: 3rem;" >
		<h3>공지사항</h3>
		<br>
		
		<table id="infoTable" class="table table-bordered" style="width: 80%; max-width: 1200px; margin: 0 auto;">
			<caption align="top"><b>
			총<%=dao.getTotalCount() %>개의 게시글이 있습니다
			
			<input type="text" name="searchrest" id="searchrest" style="width:200px; height:30px; float:right;" placeholder="검색할 휴게소 입력">
			
			</b></caption>
			
			
			
			<tr>
				<th>번호</th>			
				<th>제목</th>					
				<th>작성일</th>
				<th>조회수</th>
				<%if(userId.equals("admin")){
				%>
					<th>작성글관리</th>	
					
				<%}%>
				
			</tr>
			<tbody id="infoBody">
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
						<td><%= (currentPage - 1) * perPage + i + 1 %></td>
						
						<td><a href="<%=request.getContextPath()%>/index.jsp?main=infoList/detail.jsp&id=<%=dto.getId()%>"><%=dto.getTitle() %>[<%=restName %>]</a></td>
												
						
						<td><%=sdf.format(dto.getWriteday()) %></td>
						<td><%=dto.getReadcount() %></td>
						<%if(userId.equals("admin")){
						%>
							<th>
								<button class="btn btn-danger" style="width:70px; float:center;">삭제</button>
								<button class="btn btn-success" style="width:70px; float:center;">수정</button>
							
							</th>	
							
						<%}%>
						
						
					</tr>
					
					
					
					
					
				<%}
			}
			
			
			
			%>
			</tbody>	
		</table>
	
	</div>
	
	<!--페이지 번호 출력  -->
     <div class="d-flex justify-content-center mt-4">
    <ul class="pagination">
       <%
          //이전
          if(startPage>1)
          {%>
        	  <li class="page-item">
        	    <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=infoList/infoList.jsp&currentPage=<%=startPage-1%>"
        	    style="color: black;">
        	      이전
        	    </a>
        	  </li>
          <%}
          
       		for(int pp=startPage;pp<=endPage;pp++)
       		{
       			if(pp==currentPage)
       			{%>
       				<li class="page-item active">
       				  <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=infoList/infoList.jsp&currentPage=<%=pp%>"><%=pp %></a>
       				</li>
       			<%}else{%>
       				<li class="page-item">
       				  <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=infoList/infoList.jsp&currentPage=<%=pp%>"><%=pp %></a>
       				</li>
       			<%}
       		}
       		
       		//다음
       		if(endPage<totalPage)
       		{%>
       			<li class="page-item">
        	    <a class="page-link" href="<%=request.getContextPath()%>/index.jsp?main=infoList/infoList.jsp&currentPage=<%=endPage+1%>"
        	    style="color: black;">
        	      다음
        	    </a>
        	  </li>
       		<%}
       			
       %>
     </ul>
     
    
     
     </div>
     
     
     
     
<script type="text/javascript">

$(document).ready(function() {
    $('#searchrest').on('input', function() {
      let searchVal = $(this).val();

      $.ajax({
        url: 'infoList/searchList.jsp',
        type: 'GET',
        data: { searchRest: searchVal },
        success: function(data) {
          // data는 <tr>... 형태의 html
          $('#infoBody').html(data);
        },
        error: function() {
          alert('검색 중 오류가 발생했습니다.');
        }
      });
    });
  });













</script>

	






</body>
</html>