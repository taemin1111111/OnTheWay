<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<%
    response.setContentType("application/json; charset=UTF-8");

    String stdRestNm = request.getParameter("stdRestNm");
    if (stdRestNm == null || stdRestNm.trim().isEmpty()) {
        response.setStatus(400);
        out.print("[]");
        return;
    }

    JSONParser parser = new JSONParser();
    JSONArray totalList = new JSONArray();

    try {
        String filePath = application.getRealPath("/data/restFoodCourtData.json");
        JSONArray allData = (JSONArray) parser.parse(new FileReader(filePath));

        for (Object obj : allData) {
            JSONObject item = (JSONObject) obj;
            if (stdRestNm.equals(item.get("stdRestNm"))) {
                totalList.add(item);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500);
        out.print("[]");
        return;
    }

    out.print(totalList.toJSONString());
%>
