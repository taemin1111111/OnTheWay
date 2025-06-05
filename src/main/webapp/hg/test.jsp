<%@ page import="hgDao.hgRestDao" %>
<%@ page import="hgDto.hgRestDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String searchName = request.getParameter("searchName");
  String lpg = request.getParameter("lpg");
  String ev = request.getParameter("ev");
  String pharm = request.getParameter("pharm");

  hgRestDao dao = new hgRestDao();
  List<hgRestDto> list;

  if (searchName != null && !searchName.trim().equals("")) {
    list = dao.getData(searchName, lpg, ev, pharm);
  } else {
    list = dao.getLpgList(lpg, ev, pharm);
  }

  StringBuilder json = new StringBuilder();
  json.append("[");

  for(int i=0; i<list.size(); i++) {
    hgRestDto dto = list.get(i);
    json.append("{");
    json.append("\"id\":").append(dto.getId2()).append(",");
    json.append("\"name\":\"").append(dto.getName().replace("\"", "\\\"")).append("\",");
    json.append("\"tel_no\":\"").append(dto.getTel_no()).append("\",");
    json.append("\"latitude\":").append(dto.getLatitude()).append(",");
    json.append("\"longitude\":").append(dto.getLongitude()).append(",");
    json.append("\"review\":\"").append(dao.getReview().replace("\"", "\\\"")).append("\"");
    json.append("}");

    if(i != list.size()-1) {
      json.append(",");
    }
  }
  json.append("]");

  out.print(json.toString());
%>