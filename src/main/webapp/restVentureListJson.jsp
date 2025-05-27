<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<%
    response.setContentType("application/json; charset=UTF-8");

    String stdRestCd = request.getParameter("stdRestCd");
    if (stdRestCd == null || stdRestCd.trim().isEmpty()) {
        response.setStatus(400);
        out.print("[]");
        return;
    }

    JSONParser parser = new JSONParser();
    JSONArray totalList = new JSONArray();

    try {
        String filePath = application.getRealPath("/data/restVentureData.json");
        JSONArray allData = (JSONArray) parser.parse(new FileReader(filePath));

        for (Object obj : allData) {
            JSONObject item = (JSONObject) obj;
            if (stdRestCd.equals(item.get("stdRestCd"))) {
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
