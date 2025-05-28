<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드코트 메뉴 현황</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style>
    /* 스타일은 기존 유지 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f9fafb;
        padding: 40px;
        color: #212529;
    }
    h2 { font-size: 28px; font-weight: 600; margin-bottom: 30px; color: #1a1a1a; text-align: center; }
    label { font-weight: 500; font-size: 16px; }
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
    #restSelect { font-size: 16px; padding: 8px 12px; width: 100%; max-width: 400px; }
    #menuList {
        margin-top: 30px;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
    .menu-item {
        background-color: #ffffff;
        border: 1px solid #d6d6d6;
        padding: 16px;
        border-radius: 10px;
    }
    .menu-item h5 { font-size: 18px; font-weight: 600; color: #333; margin-bottom: 8px; }
    .menu-item p { font-size: 15px; color: #555; margin: 4px 0; }
    .best { color: #d9230f; font-weight: bold; margin-left: 6px; }
    .no-data { text-align: center; font-size: 18px; color: #888; margin-top: 40px; }
    @media (max-width: 576px) {
        body { padding: 20px; }
        #menuList { grid-template-columns: 1fr; }
    }
</style>

</head>
<body>
<%
    String dataPath = application.getRealPath("/data/restFoodCourtData.json");
    Map<String, String> restMap = new LinkedHashMap<>();

    try {
        JSONParser parser = new JSONParser();
        JSONArray list = (JSONArray) parser.parse(new FileReader(dataPath));

        for (Object obj : list) {
            JSONObject item = (JSONObject) obj;
            String code = (String) item.get("stdRestCd");
            String name = (String) item.get("stdRestNm");

            if (!restMap.containsKey(code)) {
                restMap.put(code, name);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<h2>푸드코트 메뉴 현황</h2>
<div class="mb-3 text-center">
    <label for="restSearch" class="form-label">휴게소 검색:&nbsp;</label>

    <!-- 🔧 감싸는 div 추가: 입력창과 자동완성 박스를 같이 묶고 position-relative 설정 -->
    <div class="d-inline-block position-relative" style="width: 300px;">
        <input type="text" id="restSearch" class="form-control" placeholder="휴게소명을 입력하세요">
        <div id="autocompleteList" class="list-group position-absolute w-100" style="z-index:1000;"></div>
    </div>

    &nbsp;&nbsp;&nbsp;

    <label for="restSelect" class="form-label">휴게소 선택:&nbsp;</label>
    <select id="restSelect" class="form-select d-inline-block w-auto">
        <option value="">휴게소를 선택하세요</option>
        <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
            <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
        <% } %>
    </select>
</div>
<div id="menuList"></div>

<!-- 자바스크립트 영역 -->
<script>
    const select = document.getElementById('restSelect');
    const container = document.getElementById('menuList');
    const restInput = document.getElementById('restSearch');
    const listDiv = document.getElementById('autocompleteList');

    const restAreaMap = {
        <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
            "<%= entry.getValue() %>": "<%= entry.getKey() %>",
        <% } %>
    };

    function loadMenu(code) {
        container.innerHTML = '';
        if (!code) return;

        fetch('restFoodMenuJson.jsp?stdRestCd=' + encodeURIComponent(code))
            .then(res => {
                if (!res.ok) throw new Error('네트워크 오류');
                return res.json();
            })
            .then(data => {
                if (!data || data.length === 0) {
                    container.innerHTML = '<p class="no-data">메뉴 정보가 없습니다.</p>';
                    return;
                }

                const best = data.filter(i => i.bestfoodyn === 'Y');
                const normal = data.filter(i => i.bestfoodyn !== 'Y');
                const sorted = [...best, ...normal];

                sorted.forEach(i => {
                    const div = document.createElement('div');
                    div.className = 'menu-item';

                    const h5 = document.createElement('h5');
                    if (i.bestfoodyn === 'Y') {
                        const starSpan = document.createElement('span');
                        starSpan.className = 'best';
                        starSpan.textContent = '★ Best ';
                        h5.appendChild(starSpan);
                    }
                    h5.appendChild(document.createTextNode(i.foodNm));
                    div.appendChild(h5);

                    const priceP = document.createElement('p');
                    const priceFormatted = Number(i.foodCost).toLocaleString();
                    priceP.textContent = '가격: ' + priceFormatted + '원';
                    priceP.style.marginBottom = '10px';
                    div.appendChild(priceP);

                    if (i.etc) {
                        const descP = document.createElement('p');
                        descP.textContent = i.etc;
                        div.appendChild(descP);
                    }

                    container.appendChild(div);
                });
            })
            .catch(err => {
                container.innerHTML = '<p class="no-data">메뉴 정보를 가져오는 중 오류가 발생했습니다.</p>';
                console.error(err);
            });
    }

    // 셀렉트박스 변경 시
    select.addEventListener('change', () => {
        const code = select.value;
        if (!code) {
            restInput.value = "";
            container.innerHTML = "";
            history.replaceState(null, "", "restFoodMenu.jsp");
            return;
        }

        const name = Object.keys(restAreaMap).find(key => restAreaMap[key] === code);
        if (name) restInput.value = name;

        loadMenu(code);
        history.pushState(null, "", "restFoodMenu.jsp?stdRestCd=" + encodeURIComponent(code));
    });

    // 자동완성 검색 기능
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
                    loadMenu(code);
                    history.pushState(null, "", "restFoodMenu.jsp?stdRestCd=" + encodeURIComponent(code));
                }
            });
            listDiv.appendChild(item);
        });

        listDiv.style.display = 'block';
    });

    document.addEventListener('click', function(e) {
        if (!restInput.contains(e.target) && !listDiv.contains(e.target)) {
            listDiv.style.display = 'none';
        }
    });

    // ✅ 페이지 로드시 URL 파라미터 처리
    window.addEventListener('DOMContentLoaded', () => {
        const params = new URLSearchParams(location.search);
        const code = params.get('stdRestCd');
        if (code) {
            const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
            if (name) {
                restInput.value = name;
                select.value = code;
                loadMenu(code);
            }
        }
    });

    // ✅ 브라우저 뒤로/앞으로 이동 대응
    window.addEventListener('popstate', () => {
        const params = new URLSearchParams(location.search);
        const code = params.get('stdRestCd');
        if (code) {
            const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
            if (name) {
                restInput.value = name;
                select.value = code;
                loadMenu(code);
            }
        } else {
            select.value = '';
            restInput.value = '';
            container.innerHTML = '';
        }
    });
</script>
</body>
</html>
