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

#menuList {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
}

#orderPanel {
	max-height: 600px;
	overflow-y: auto;
}

#orderPanel h5 {
	font-size: 20px;
	font-weight: 500;
	color: #333;
	margin-bottom: 8px;
}

.menu-item {
	position: relative;
	background-color: #fff;
	border: 1px solid #d6d6d6;
	padding: 16px;
	border-radius: 10px;
	transition: background-color 0.3s;
}

.menu-item:hover {
	background-color: rgba(0, 0, 0, 0.1);
}

/* 담기 버튼 초기 상태 숨김 */
.menu-item .add-btn {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	z-index: 10;
	background-color: #212529;
	color: #fff;
	border: none;
	padding: 10px 14px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

/* 마우스 호버 시 버튼 표시 */
.menu-item:hover .add-btn {
	display: block;
}

.menu-item h5 {
	font-size: 18px;
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
}

.menu-item p {
	font-size: 15px;
	color: #555;
	margin: 4px 0;
}

.best {
	color: #d9230f;
	font-weight: bold;
	margin-left: 6px;
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
	#menuList {
		grid-template-columns: 1fr;
	}
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

<hr style="margin-top: 50px">

<div class="d-flex justify-content-between gap-4" style="margin-top: 30px">
    <!-- 왼쪽: 메뉴 리스트 -->
    <div id="menuPanel" class="flex-grow-1" style="flex-basis: 60%; max-height: 600px; overflow-y: auto;">
	    <div id="menuList"></div>
	</div>

	<!-- 오른쪽: 주문 목록 -->
	<div id="orderPanel" class="bg-white border rounded p-3" style="width: 35%; min-width: 300px;">
	    <h5 class="mt-1 mb-2"><i class="bi bi-fork-knife"></i> 주문 메뉴</h5>
	    <ul id="orderList" class="list-group my-3"></ul>
	    <div id="orderSummary" class="text-end mb-3 fw-bold text-dark"></div>
	    <div class="text-center">
	    	<button class="btn btn-sm btn-success" style="font-size: 16px; " onclick="orderBtn()">결제하기</button>
	    	&nbsp;
	        <button class="btn btn-sm btn-danger" style="font-size: 16px; " onclick="clearOrder()">전체삭제</button>
	    </div>
	</div>
</div>

<!-- 자바스크립트 영역 -->
<script>
    // 주문 목록이 비어있는지 여부를 추적하는 변수
    let isOrderNotEmpty = false;

    // DOM 요소 참조
    const select = document.getElementById('restSelect');
    const container = document.getElementById('menuList');
    const restInput = document.getElementById('restSearch');
    const listDiv = document.getElementById('autocompleteList');
    const orderList = document.getElementById('orderList');
    const summaryArea = document.getElementById('orderSummary');

    // Java에서 전달된 휴게소 이름 → 코드 매핑 객체
    const restAreaMap = {
        <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
            "<%= entry.getValue() %>": "<%= entry.getKey() %>",
        <% } %>
    };

    // 주문 항목 저장 객체 (메뉴명 → { price, quantity })
    const orderMap = {};

    // 주문 항목 추가 함수
    function addToOrder(name, price) {
        if (orderMap[name]) {
            orderMap[name].quantity += 1;
        } else {
            orderMap[name] = { price: Number(price), quantity: 1 };
        }
        isOrderNotEmpty = true;
        renderOrderList();
    }

    // 주문 목록 전체 삭제 함수
    function clearOrder() {
        Object.keys(orderMap).forEach(k => delete orderMap[k]);
        isOrderNotEmpty = false;
        renderOrderList();
    }

    // 주문 목록 UI 렌더링 함수
    function renderOrderList() {
        orderList.innerHTML = '';
        let total = 0;
        const entries = Object.entries(orderMap);

        if (entries.length === 0) {
            // 메뉴가 없을 때 메시지 표시
            isOrderNotEmpty = false;
            const emptyItem = document.createElement('li');
            emptyItem.className = 'list-group-item text-center text-muted';
            emptyItem.textContent = '메뉴가 비어있습니다.';
            emptyItem.style.padding = '220px';
            orderList.appendChild(emptyItem);
            summaryArea.textContent = '';
            return;
        }

        isOrderNotEmpty = true;

        entries.forEach(([name, info]) => {
            total += info.price * info.quantity;

            const item = document.createElement('li');
            item.className = 'list-group-item d-flex justify-content-between align-items-center';

            const left = document.createElement('div');
            left.innerHTML = "<strong>" + name + "</strong><br><span class='text-muted'>" + info.price.toLocaleString() + "원</span>";

            const right = document.createElement('div');
            right.className = 'd-flex align-items-center gap-1';

            // 수량 감소 버튼
            const minusBtn = document.createElement('button');
            minusBtn.className = 'btn btn-sm btn-outline-secondary';
            minusBtn.textContent = '-';
            minusBtn.onclick = () => {
                if (info.quantity > 1) {
                    info.quantity -= 1;
                } else {
                    delete orderMap[name];
                }
                renderOrderList();
            };

            // 수량 표시
            const qtySpan = document.createElement('span');
            qtySpan.textContent = info.quantity;
            qtySpan.className = 'mx-2 fw-bold';

            // 수량 증가 버튼
            const plusBtn = document.createElement('button');
            plusBtn.className = 'btn btn-sm btn-outline-secondary';
            plusBtn.textContent = '+';
            plusBtn.onclick = () => {
                info.quantity += 1;
                renderOrderList();
            };

            // 삭제 버튼
            const delBtn = document.createElement('button');
            delBtn.className = 'btn btn-sm btn-outline-danger';
            delBtn.textContent = '삭제';
            delBtn.onclick = () => {
                delete orderMap[name];
                renderOrderList();
            };

            right.append(minusBtn, qtySpan, plusBtn, delBtn);
            item.append(left, right);
            orderList.appendChild(item);
        });

        // 총 금액 표시
        summaryArea.textContent = "총 금액: " + total.toLocaleString() + "원";
    }

    // 메뉴 목록 로딩 함수
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

                const sorted = [...data.filter(i => i.bestfoodyn === 'Y'), ...data.filter(i => i.bestfoodyn !== 'Y')];

                sorted.forEach(i => {
                    const div = document.createElement('div');
                    div.className = 'menu-item';

                    // 메뉴명
                    const h5 = document.createElement('h5');
                    if (i.bestfoodyn === 'Y') {
                        const star = document.createElement('span');
                        star.className = 'best';
                        star.textContent = '★ Best ';
                        h5.appendChild(star);
                    }
                    h5.appendChild(document.createTextNode(i.foodNm));
                    div.appendChild(h5);

                    // 가격
                    const priceP = document.createElement('p');
                    priceP.textContent = '가격: ' + Number(i.foodCost).toLocaleString() + '원';
                    priceP.style.marginBottom = '10px';
                    div.appendChild(priceP);

                    // 설명
                    if (i.etc) {
                        const desc = document.createElement('p');
                        desc.textContent = i.etc;
                        div.appendChild(desc);
                    }

                    // 담기 버튼
                    const addBtn = document.createElement('button');
                    addBtn.className = 'add-btn';
                    addBtn.textContent = '담기';
                    addBtn.onclick = () => addToOrder(i.foodNm, i.foodCost);
                    div.appendChild(addBtn);

                    container.appendChild(div);
                });
            })
            .catch(err => {
                container.innerHTML = '<p class="no-data">메뉴 정보를 가져오는 중 오류가 발생했습니다.</p>';
                console.error(err);
            });
    }

    // 셀렉트 박스 변경 이벤트
    select.addEventListener('change', () => {
        const code = select.value;

        if (isOrderNotEmpty) {
            const proceed = confirm("주문 목록이 초기화됩니다. 계속하시겠습니까?");
            if (!proceed) {
                select.value = '';
                return;
            }
            clearOrder();
        }

        if (!code) {
            restInput.value = "";
            container.innerHTML = "";
            history.replaceState(null, "", "restFoodMenu.jsp");
            return;
        }

        const name = Object.keys(restAreaMap).find(k => restAreaMap[k] === code);
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
            item.onclick = () => {
                const code = restAreaMap[name];
                if (!code) return;

                if (isOrderNotEmpty) {
                    const proceed = confirm("주문 목록이 초기화됩니다. 계속하시겠습니까?");
                    if (!proceed) return;
                    clearOrder();
                }

                restInput.value = name;
                select.value = code;
                loadMenu(code);
                history.pushState(null, "", "restFoodMenu.jsp?stdRestCd=" + encodeURIComponent(code));
                listDiv.style.display = 'none';
            };
            listDiv.appendChild(item);
        });

        listDiv.style.display = 'block';
    });

    // 외부 클릭 시 자동완성 닫기
    document.addEventListener('click', e => {
        if (!restInput.contains(e.target) && !listDiv.contains(e.target)) {
            listDiv.style.display = 'none';
        }
    });

    // 페이지 로드시 URL 파라미터 처리
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
        renderOrderList();
    });

    // 브라우저 뒤로/앞으로 이동 대응
    window.addEventListener('popstate', () => {
        if (isOrderNotEmpty) {
            const proceed = confirm("주문 목록이 초기화됩니다. 계속하시겠습니까?");
            if (!proceed) {
                history.forward();
                return;
            }
            clearOrder();
        }

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
