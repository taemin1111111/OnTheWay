<%@ page import="event.EventDao" %>
<%
	request.setCharacterEncoding("utf-8");
    
	String id = request.getParameter("id");
    EventDao dao = new EventDao();
    dao.deleteEventById(id);  // deleteEventById 메서드는 DAO에 구현되어 있어야 함

 	// 리다이렉트
  	response.sendRedirect("../index.jsp?main=event/eventList.jsp");
%>
