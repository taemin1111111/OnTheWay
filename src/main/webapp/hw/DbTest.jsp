<%@ page import="java.io.FileReader" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="org.json.simple.parser.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // JSON 파일 경로 (웹 프로젝트 기준)
    String jsonFilePath = application.getRealPath("/data/hgRestLocation.json");

    JSONParser parser = new JSONParser();

    try (FileReader reader = new FileReader(jsonFilePath)) {
        // JSON 파일 전체를 JSONArray로 읽음
       	JSONObject jsonObject = (JSONObject) parser.parse(reader);
		JSONArray jsonArray = (JSONArray) jsonObject.get("fields");

        for (Object obj : jsonArray) {
            JSONObject jsonObj = (JSONObject) obj;

            String 휴게소명 = (String) jsonObj.get("휴게소명");
            String 도로종류 = (String) jsonObj.get("도로종류");
            String 도로노선번호 = (String) jsonObj.get("도로노선번호");
            String 도로노선명 = (String) jsonObj.get("도로노선명");
            String 도로노선방향 = (String) jsonObj.get("도로노선방향");

            // 위도, 경도는 숫자형으로 처리
            Double 위도 = null;
            Double 경도 = null;
            try {
                Object latObj = jsonObj.get("위도");
                Object lonObj = jsonObj.get("경도");

                if (latObj != null) {
                    if (latObj instanceof Number) {
                        위도 = ((Number) latObj).doubleValue();
                    } else {
                        위도 = Double.parseDouble(latObj.toString());
                    }
                }

                if (lonObj != null) {
                    if (lonObj instanceof Number) {
                        경도 = ((Number) lonObj).doubleValue();
                    } else {
                        경도 = Double.parseDouble(lonObj.toString());
                    }
                }
            } catch (Exception e) {
                // 숫자 변환 실패 시 0.0으로 기본값 설정
                위도 = 0.0;
                경도 = 0.0;
            }

            // 원하는 열만 출력
            out.println("휴게소명: " + 휴게소명 + "<br>");
            out.println("도로종류: " + 도로종류 + "<br>");
            out.println("도로노선번호: " + 도로노선번호 + "<br>");
            out.println("도로노선명: " + 도로노선명 + "<br>");
            out.println("도로노선방향: " + 도로노선방향 + "<br>");
            out.println("위도: " + 위도 + "<br>");
            out.println("경도: " + 경도 + "<hr>");
        }

    } catch (Exception e) {
        out.println("파일 읽기 또는 JSON 파싱 오류: " + e.getMessage());
    }
%>