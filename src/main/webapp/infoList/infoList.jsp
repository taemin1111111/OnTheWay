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
    background-color: #f8f9fa;
    color: #343a40;
    margin: 0;
    padding: 2rem 0;
  }

  h3 {
    font-weight: 700;
    font-size: 2.2rem;
    color: #212529;
    margin-bottom: 2rem;
  }

  #infoTable {
    width: 80%;
    max-width: 1200px;
    margin: 0 auto;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0,0,0,0.1);
  }

  #infoTable thead tr {
    background-color: #007bff; /* 부트스트랩 기본 파랑 */
    color: #fff;
    font-weight: 600;
    font-size: 1.1rem;
  }

  #infoTable tbody tr:hover {
    background-color: #e9f2ff;
    cursor: pointer;
  }

  #infoTable tbody td {
    vertical-align: middle;
    font-size: 1rem;
    color: #495057;
  }

  #infoTable a {
    color: #007bff;
    font-weight: 600;
    text-decoration: none;
  }

  #infoTable a:hover {
    text-decoration: underline;
  }

  /* 검색창 스타일 */
  #searchrest {
    width: 220px;
    height: 36px;
    padding: 0 12px;
    border: 1.8px solid #007bff;
    border-radius: 8px;
    font-size: 1rem;
    color: #495057;
    outline: none;
    transition: 0.3s ease all;
    float: right;
  }

  #searchrest::placeholder {
    color: #adb5bd;
  }

  #searchrest:focus {
    border-color: #0056b3;
    box-shadow: 0 0 6px rgba(0, 123, 255, 0.5);
  }

  /* 버튼 컨테이너 */
  .btn-group {
    display: flex;
    gap: 8px;
    justify-content: center;
  }

  /* 공통 버튼 스타일 */
  .btn {
    font-size: 0.9rem;
    padding: 6px 12px;
    border-radius: 6px;
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  }

  /* 삭제 버튼 */
  .btn-danger {
    background-color: #dc3545;
    border: none;
    color: #fff;
  }
  .btn-danger:hover {
    background-color: #b02a37;
    box-shadow: 0 4px 10px rgba(220, 53, 69, 0.6);
  }

  /* 수정 버튼 */
  .btn-warning {
    background-color: #ffc107;
    border: none;
    color: #212529;
  }
  .btn-warning:hover {
    background-color: #e0a800;
    box-shadow: 0 4px 10px rgba(255, 193, 7, 0.6);
  }

  /* 글쓰기 버튼 */
  #writeBtn button {
    background-color: #28a745;
    border: none;
    color: #fff;
    padding: 10px 18px;
    font-weight: 600;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.5);
    transition: background-color 0.3s ease;
  }

  #writeBtn button:hover {
    background-color: #1e7e34;
    box-shadow: 0 6px 18px rgba(30, 126, 52, 0.7);
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
				<%if("admin".equals(userId)){
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
						<%if("admin".equals(userId)){
						%>
							<td>
							  <div class="btn-group">
							    <button class="btn btn-danger btn-sm" 
							            onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='infoList/delete.jsp?id=<%=dto.getId() %>';">
							      삭제
							    </button>
							    <button class="btn btn-warning btn-sm" 
							            onclick="location.href='infoList/updateform.jsp?id=<%=dto.getId() %>'">
							      수정
							    </button>
							  </div>
							</td>
							
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
    
     </div>

<% if ("admin".equals(userId)) { %>
  <div style="width: 80%; max-width: 1200px; margin: 10px auto 30px auto; text-align: right;">
    <button class="btn btn-success" onclick="location.href='infoList/addform.jsp'">글쓰기</button>
  </div>
<% } %>
    
     
     
     
    
     
     
     
     
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