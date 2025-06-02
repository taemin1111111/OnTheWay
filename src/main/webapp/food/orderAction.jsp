<%@ page import="order.OrderDto, order.OrderDao"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String merchant_uid = request.getParameter("merchant_uid");
	String imp_uid = request.getParameter("imp_uid");
	String userName = request.getParameter("userName");
	String email = request.getParameter("email");
	String orderName = request.getParameter("orderName");
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	
	String userId = (String) session.getAttribute("userId");
	
	OrderDto dto = new OrderDto();
	dto.setMerchant_uid(merchant_uid);
	dto.setImp_uid(imp_uid);
	dto.setUserId(userId);
	dto.setUserName(userName);
	dto.setEmail(email);
	dto.setOrderName(orderName);
	dto.setOrderPrice(orderPrice);
	
	OrderDao dao = new OrderDao();
	dao.insertOrder(dto);
%>
