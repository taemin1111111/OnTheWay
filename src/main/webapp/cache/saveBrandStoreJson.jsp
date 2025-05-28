<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.net.*, java.io.*, org.json.simple.*, org.json.simple.parser.*, java.util.Properties" %>
<%
	InputStream in = application.getResourceAsStream("/WEB-INF/classes/config.properties");
	if (in == null) {
	    throw new RuntimeException("config.properties 파일을 찾을 수 없습니다.");
	}
	Properties props = new Properties();
	props.load(in);
	in.close();
	
	// 2) API 키 꺼내오기
	String apiKey = props.getProperty("api.key");
	if (apiKey == null || apiKey.isBlank()) {
	    throw new RuntimeException("api.key 값이 설정되지 않았습니다.");
	}

    int maxPage = 7;
    JSONParser parser = new JSONParser();
    JSONArray allData = new JSONArray();

    String jsonFilePath = application.getRealPath("/data/restBrandStoreData.json");
    File jsonFile = new File(jsonFilePath);

    // ✅ 3시간 갱신 주기 설정
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
            String apiUrl = "https://data.ex.co.kr/openapi/restinfo/restBrandList"
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

        out.println("<h3>브랜드 매장 현황 데이터 저장 성공!</h3>");
        out.println("<p>총 항목 수: " + allData.size() + "</p>");
        out.println("<p>저장된 파일 위치: " + jsonFilePath + "</p>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>데이터 저장 중 오류 발생</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
    }
%>
