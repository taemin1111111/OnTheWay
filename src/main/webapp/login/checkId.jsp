<%@ page import="user.UserDao" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");
    UserDao dao = new UserDao();
    boolean exists = dao.isUserIdExists(userId);

    out.print("{\"exists\":" + exists + "}");
%>
