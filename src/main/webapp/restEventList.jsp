<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<%
    String dataPath = application.getRealPath("/data/restEventListData.json");
    Map<String, String> restMap = new LinkedHashMap<>();

    try {
        JSONParser parser = new JSONParser();
        JSONArray list = (JSONArray) parser.parse(new FileReader(dataPath));
        for (Object obj : list) {
            JSONObject item = (JSONObject) obj;
            String code = (String) item.get("stdRestCd");
            String name = (String) item.get("stdRestNm");
            if (code != null && name != null && !restMap.containsKey(code)) {
                restMap.put(code, name);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 안내</title>

<!-- 스타일 및 외부 리소스는 동일하게 유지 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f9fafb;
	padding: 40px;
	color: #212529;
}

h2 {
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 30px;
	color: #1a1a1a;
	text-align: center;
}

label {
	font-weight: 500;
	font-size: 16px;
}

#autocompleteList {
	margin-top: 2px;
	display: none;
	position: absolute;
	z-index: 1000;
	width: 100%;
	max-width: 300px;
}

#autocompleteList .list-group-item {
	cursor: pointer;
}

#restSelect {
	font-size: 16px;
	padding: 8px 12px;
	width: 100%;
	max-width: 400px;
}

#eventList {
	margin-top: 30px;
}
/* 이벤트 항목 박스 */
.event-item {
	background-color: #ffffff;
	border: 1px solid #d6d6d6;
	border-radius: 10px;
	padding: 20px;
	margin: 0 auto 20px; /* 가운데 정렬 + 하단 여백 */
	max-width: 800px; /* 너비 제한 */
	width: 100%; /* 반응형 대응 */
}

.event-item h5 {
	font-size: 18px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

.event-item p {
	font-size: 15px;
	color: #555;
	margin: 6px 0;
}

.no-data {
	text-align: center;
	font-size: 18px;
	color: #888;
	margin-top: 40px;
}

@media ( max-width : 576px) {
	body {
		padding: 20px;
	}
}
</style>

</head>
<body>
<div class="container">
    <h2>이벤트 안내</h2>
    <div class="mb-4 text-center">
        <label for="restSearch">휴게소 검색:&nbsp;</label>
        <div class="d-inline-block position-relative" style="width: 300px;">
            <input type="text" id="restSearch" class="form-control" placeholder="휴게소명 입력">
            <div id="autocompleteList" class="list-group position-absolute"></div>
        </div>
        &nbsp;&nbsp;
        <label for="restSelect">휴게소 선택:&nbsp;</label>
        <select id="restSelect" class="form-select d-inline-block w-auto">
            <option value="">휴게소를 선택하세요</option>
            <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
                <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% } %>
        </select>
    </div>

    <div id="eventList"></div>
</div>

<script>
    const select = document.getElementById('restSelect');
    const restInput = document.getElementById('restSearch');
    const listDiv = document.getElementById('autocompleteList');
    const container = document.getElementById('eventList');

    const restAreaMap = {
        <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
            "<%= entry.getValue() %>": "<%= entry.getKey() %>",
        <% } %>
    };

    function loadEvent(code) {
        container.innerHTML = '';
        if (!code) return;

        fetch('restEventListJson.jsp?stdRestCd=' + encodeURIComponent(code))
            .then(res => res.json())
            .then(data => {
                if (!data || data.length === 0) {
                    container.innerHTML = '<p class="no-data">이벤트 정보가 없습니다.</p>';
                    return;
                }
                data.forEach(i => {
                    const div = document.createElement('div');
                    div.className = 'event-item';

                    const h5 = document.createElement('h5');
                    h5.textContent = i.eventNm || '이벤트명 없음';
                    h5.style.fontWeight = 'bold';
                    div.appendChild(h5);

                    const date = document.createElement('p');
                    date.textContent = '기간: ' + i.stime + ' ~ ' + i.etime;
                    div.appendChild(date);

                    const desc = document.createElement('p');
                    desc.innerHTML = (i.eventDetail || '').replaceAll("\r\n", "<br>");
                    div.appendChild(desc);

                    container.appendChild(div);
                });
            });
    }

    // 휴게소 선택 시
    select.addEventListener('change', () => {
        const code = select.value;
        if (!code) {
            restInput.value = "";
            container.innerHTML = "";
            history.replaceState(null, '', 'restEventList.jsp');
            return;
        }
        const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
        if (name) restInput.value = name;

        loadEvent(code);
        history.pushState(null, '', 'restEventList.jsp?stdRestCd=' + encodeURIComponent(code));
    });

    // 자동완성 검색
    restInput.addEventListener('input', () => {
        const keyword = restInput.value.trim();
        listDiv.innerHTML = '';
        listDiv.style.display = 'none';
        if (keyword.length < 1) return;

        const matches = Object.keys(restAreaMap).filter(name => name.includes(keyword));
        if (matches.length === 0) return;

        matches.forEach(name => {
            const item = document.createElement('div');
            item.className = 'list-group-item list-group-item-action';
            item.textContent = name;
            item.addEventListener('click', () => {
                restInput.value = name;
                listDiv.style.display = 'none';

                const code = restAreaMap[name];
                if (code) {
                    select.value = code;
                    loadEvent(code);
                    history.pushState(null, '', 'restEventList.jsp?stdRestCd=' + encodeURIComponent(code));
                }
            });
            listDiv.appendChild(item);
        });

        listDiv.style.display = 'block';
    });

    // 외부 클릭 시 자동완성 닫기
    document.addEventListener('click', (e) => {
        if (!restInput.contains(e.target) && !listDiv.contains(e.target)) {
            listDiv.style.display = 'none';
        }
    });

    // 페이지 최초 로드시 stdRestCd 파라미터 처리
    window.addEventListener('DOMContentLoaded', () => {
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('stdRestCd');

        if (code) {
            select.value = code;
            const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
            if (name) restInput.value = name;
            loadEvent(code);
        }
    });

    // 뒤로가기/앞으로가기 대응
    window.addEventListener('popstate', () => {
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('stdRestCd');

        if (code) {
            select.value = code;
            const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
            if (name) restInput.value = name;
            loadEvent(code);
        } else {
            select.value = "";
            restInput.value = "";
            container.innerHTML = "";
        }
    });
</script>
</body>
</html>
