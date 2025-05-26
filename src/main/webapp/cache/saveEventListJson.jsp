<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.net.*, java.io.*, org.json.simple.*, org.json.simple.parser.*, java.io.File" %>
<%
    String apiKey = "7961459716"; // 실제 API 키로 교체
    int maxPage = 8; // 실제 페이지 수에 따라 조절
    JSONParser parser = new JSONParser();
    JSONArray allData = new JSONArray();

    String jsonFilePath = application.getRealPath("/data/restEventListData.json");
    File jsonFile = new File(jsonFilePath);

    long now = System.currentTimeMillis();
    long refreshInterval = 3L * 60 * 60 * 1000; // 3시간
    boolean shouldRefresh = false;

    if (!jsonFile.exists()) {
        shouldRefresh = true;
    } else {
        long lastModified = jsonFile.lastModified();
        if (now - lastModified > refreshInterval) {
            shouldRefresh = true;
        }
    }

    if (!shouldRefresh) {
        out.println("<h3>최근 데이터가 이미 존재합니다 (3시간 이내)</h3>");
        out.println("<p>파일 위치: " + jsonFilePath + "</p>");
        return;
    }

    try {
        for (int pageNo = 1; pageNo <= maxPage; pageNo++) {
            String apiUrl = "https://data.ex.co.kr/openapi/restinfo/restEventList"
                          + "?key=" + apiKey
                          + "&type=json"
                          + "&numOfRows=99"
                          + "&pageNo=" + pageNo;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();

            JSONObject respJson = (JSONObject) parser.parse(sb.toString());
            if (!"SUCCESS".equals(respJson.get("code"))) break;

            JSONArray list = (JSONArray) respJson.get("list");
            if (list != null) {
                allData.addAll(list);
            }
        }

        // JSON 파일로 저장
        try (FileWriter fw = new FileWriter(jsonFilePath, false)) {
            fw.write(allData.toJSONString());
        }

        out.println("<h3>휴게소 이벤트 데이터 저장 성공!</h3>");
        out.println("<p>총 이벤트 항목 수: " + allData.size() + "</p>");
        out.println("<p>저장된 파일 위치: " + jsonFilePath + "</p>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>데이터 저장 중 오류 발생</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
    }
%>
