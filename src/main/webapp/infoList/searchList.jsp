<%@page import="hgDao.infoDao"%>
<%@page import="hgDto.infoDto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
String searchRest = request.getParameter("searchRest");
if(searchRest == null) searchRest = "";

infoDao dao = new infoDao();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

// DB에서 searchRest 포함된 데이터만 가져오는 메서드 필요
List<infoDto> list = dao.searchByRestName(searchRest);

int currentPage = 1;
int perPage = 10;
int totalCount = list.size(); //필터된 전체 글갯수
int no = totalCount;

hg.HgDataDao hgDao = new hg.HgDataDao();

for(int i=0; i<list.size(); i++){
    infoDto dto = list.get(i);
    String restName = "";
    try {
        restName = hgDao.getRestNameById(Integer.parseInt(dto.getHgId()));
    } catch (Exception e) {
        restName = "알 수 없음";
    }
%>
<tr>
  <td><%= i + 1 %></td>
  <td><a href="<%=request.getContextPath()%>/index.jsp?main=infoList/detail.jsp&id=<%=dto.getId()%>"><%=dto.getTitle() %> [<%=restName%>]</a></td>
  <td><%= sdf.format(dto.getWriteday()) %></td>
  <td><%= dto.getReadcount() %></td>
</tr>
<%
}
%>