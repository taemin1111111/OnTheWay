<%@page import="java.util.Properties"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드코트 메뉴 현황</title>

<%-- Google Fonts: Noto Sans KR --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

<%-- Bootstrap 5 & Icons --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style>
/* --- 🎨 2024-2025 통합 디자인 시스템 (확장) --- */
:root {
    --primary-color: #007aff; /* iOS 스타일 블루 */
    --accent-color: #ff9500; /* 오렌지 (Best 메뉴 등 강조) */
    --background-color: #f7f9fc; /* 전체 배경 */
    --card-background-color: #ffffff; /* 카드 배경 */
    --text-primary: #212529;
    --text-secondary: #5a6573;
    --text-muted: #8a95a3;
    --border-color: #e0e4e8; /* 테두리 색상 좀 더 부드럽게 */
    --success-color: #34c759;
    --danger-color: #ff3b30;
    --button-primary-bg: #007aff;
    --button-primary-hover-bg: #005bb5;
    --button-danger-bg: #ff3b30;
    --button-danger-hover-bg: #cc2929;
    --button-success-bg: #34c759;
    --button-success-hover-bg: #28a745;

    --font-family-main: 'Noto Sans KR', sans-serif;
    --border-radius-sm: 8px;
    --border-radius-md: 12px;
    --border-radius-lg: 16px;
    --shadow-soft: 0 4px 12px rgba(0, 0, 0, 0.05); /* 그림자 좀 더 은은하게 */
    --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.08); /* 그림자 좀 더 은은하게 */
}

/* body */
body {
  font-family: var(--font-family-main);
  background-color: var(--background-color);
  color: var(--text-primary);
  padding: 0; /* 전체 패딩 추가 */
  
}

/* 타이틀 */
h2 {
  font-size: 2.2rem; /* 조금 더 크게 */
  font-weight: 700; /* 더 굵게 */
  margin-top: 2rem; /* 상단 여백 조정 */
  margin-bottom: 2rem; /* 하단 여백 조정 */
  color: var(--text-primary);
  text-align: center;
}

/* label */
label {
  font-weight: 500;
  font-size: 1rem;
  color: var(--text-secondary);
}

/* 검색/선택 컨테이너 */
.search-select-container {
    padding: 1.5rem;
    background-color: var(--card-background-color);
    border-radius: var(--border-radius-md);
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 1.5rem; /* 요소 간 간격 */
}

/* 자동완성 리스트 */
#autocompleteList {
  margin-top: 0.25rem;
  display: none;
  position: absolute;
  z-index: 1050;
  width: 100%;
  max-width: 280px; /* 검색창 너비에 맞춤 */
  border-radius: var(--border-radius-sm);
  overflow: hidden;
  box-shadow: var(--shadow-medium);
}

/* 자동완성 아이템 */
#autocompleteList .list-group-item {
  cursor: pointer;
  background-color: var(--card-background-color);
  border-color: var(--border-color);
  transition: background-color 0.2s, color 0.2s;
}
#autocompleteList .list-group-item:hover {
  background-color: var(--primary-color);
  color: white;
}

/* 휴게소 선택 셀렉트 */
#restSelect {
  font-size: 1rem;
  padding: 0.5rem 1rem;
  border-radius: var(--border-radius-sm);
  border-color: var(--border-color);
  max-width: 400px;
}
#restSelect:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 0.25rem rgba(0, 122, 255, 0.25);
}

/* 구분선 */
hr {
  border-top: 1px solid var(--border-color);
  margin-top: 2rem;
  margin-bottom: 2rem;
}

/* 메인 컨텐츠 영역 */
.main-content-area {
    display: flex;
    justify-content: space-between;
    gap: 2rem; /* 패널 간 간격 */
    flex-wrap: wrap; /* 반응형을 위해 추가 */
}

/* 메뉴 리스트: 그리드 */
#menuPanel {
    flex-grow: 1;
    flex-basis: 60%; /* 기본 너비 */
    max-height: 600px;
    overflow-y: auto;
    background-color: var(--card-background-color);
    border-radius: var(--border-radius-md);
    box-shadow: var(--shadow-soft);
    padding: 1.5rem;
}
#menuList {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1rem;
}

/* 주문 패널 */
#orderPanel {
  flex-basis: 35%; /* 기본 너비 */
  min-width: 300px;
  max-height: 600px;
  overflow-y: auto;
  background-color: var(--card-background-color);
  border-radius: var(--border-radius-md);
  box-shadow: var(--shadow-medium); /* 주문 패널은 그림자 좀 더 강하게 */
  padding: 1.5rem;
}

/* 주문 타이틀 */
#orderPanel h5 {
  font-size: 1.4rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
#orderPanel h5 .bi {
    color: var(--primary-color);
}


/* 메뉴 아이템 */
.menu-item {
  position: relative;
  background-color: var(--background-color); /* 메뉴 아이템 배경은 약간 어둡게 */
  border: 1px solid var(--border-color);
  padding: 1rem;
  border-radius: var(--border-radius-md);
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out, background-color 0.3s;
  overflow: hidden; /* 버튼이 넘치지 않도록 */
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.menu-item:hover {
  transform: translateY(-5px); /* 살짝 떠오르는 효과 */
  box-shadow: var(--shadow-soft);
  background-color: #eef2f7; /* 호버 시 약간 밝아짐 */
}

/* 담기 버튼 */
.menu-item .add-btn {
  position: absolute;
  bottom: 1rem; /* 하단에서 1rem */
  right: 1rem; /* 우측에서 1rem */
  display: none; /* 기본 숨김 */
  z-index: 10;
  background-color: var(--primary-color);
  color: #fff;
  border: none;
  padding: 0.5rem 0.8rem;
  border-radius: var(--border-radius-sm);
  font-size: 0.875rem;
  font-weight: 600;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  transition: background-color 0.2s, transform 0.2s, opacity 0.2s;
  opacity: 0; /* 초기 투명도 0 */
  transform: translateY(10px); /* 초기 위치 (아래로 숨겨져 있음) */
}

.menu-item:hover .add-btn {
  display: block; /* 호버 시 보이게 */
  opacity: 1; /* 투명도 1 */
  transform: translateY(0); /* 원래 위치로 */
}
.menu-item .add-btn:hover {
    background-color: var(--button-primary-hover-bg);
    transform: translateY(-2px); /* 약간 위로 이동 */
}


.menu-item h5 {
  font-size: 1.15rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 0.5rem;
}

.menu-item p {
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin: 0.25rem 0;
}

/* Best 아이콘 */
.best-badge {
  color: var(--accent-color); /* 주황색 */
  font-weight: 700;
  margin-right: 0.4rem;
  font-size: 1rem;
}

/* 메뉴 없을 때 메시지 */
.no-data {
  text-align: center;
  font-size: 1.25rem;
  color: var(--text-muted);
  margin-top: 2rem;
  padding: 100px 0; /* 중앙 정렬 위한 패딩 */
  grid-column: 1 / -1; /* 전체 열 차지 */
}

/* 주문 목록 아이템 */
#orderList .list-group-item {
    background-color: var(--background-color);
    border-color: var(--border-color);
    border-radius: var(--border-radius-sm);
    margin-bottom: 0.5rem; /* 아이템 간 간격 */
    padding: 0.8rem 1rem;
    transition: background-color 0.2s;
    display: flex; /* flexbox 사용 */
    justify-content: space-between; /* 요소들을 양 끝으로 분산 */
    align-items: center; /* 세로 중앙 정렬 */
}
#orderList .list-group-item:last-child {
    margin-bottom: 0;
}
#orderList .list-group-item:hover {
    background-color: #eef2f7;
}

#orderList .list-group-item strong {
    color: var(--text-primary);
    display: block; /* 메뉴 이름을 한 줄에 표시 */
    white-space: nowrap; /* 메뉴 이름이 넘치지 않도록 */
    overflow: hidden; /* 넘치는 부분 숨김 */
    text-overflow: ellipsis; /* 넘치는 부분은 ...으로 표시 */
}

#orderList .list-group-item .item-details {
    flex-grow: 1; /* 메뉴 이름, 가격, 수량이 공간을 최대한 차지하도록 */
    margin-right: 10px; /* 상세 정보와 버튼 사이 간격 */
    min-width: 0; /* flex 아이템이 내용물에 따라 줄어들도록 허용 */
}

#orderList .list-group-item .item-details .text-muted {
    font-size: 0.9rem;
    display: inline-block; /* 가격과 수량이 한 줄에 표시되도록 */
    margin-right: 0.8rem; /* 가격과 수량 사이 간격 */
}

/* 수량 표시를 위한 새로운 스타일 */
#orderList .list-group-item .quantity-display {
    font-size: 0.9rem; /* 수량 글꼴 크기 */
    font-weight: 700;
    color: var(--primary-color); /* 강조 색상 */
}

/* 주문 목록 내 버튼들 (-, +, 삭제) */
#orderList .btn-sm {
    width: 30px; /* 버튼의 고정 너비 */
    height: 30px; /* 버튼의 고정 높이 */
    padding: 0; /* 패딩 제거 */
    font-size: 0.8rem; /* 아이콘 크기 조절 */
    border-radius: 0.3rem; /* 버튼 모서리 둥글게 */
    display: flex; /* 아이콘 중앙 정렬을 위해 flex 사용 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    flex-shrink: 0; /* 공간이 부족해도 줄어들지 않도록 */
}

#orderList .list-group-item .d-flex.align-items-center.gap-2 {
    gap: 0.4rem !important; /* 버튼 그룹 간격 조정 */
    flex-shrink: 0; /* 이 버튼 그룹도 공간이 부족해도 줄어들지 않도록 */
}

/* 주문 총 금액 */
#orderSummary {
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--text-primary);
    border-top: 1px dashed var(--border-color); /* 점선 구분선 */
    padding-top: 1rem;
    margin-top: 1.5rem;
}

/* 결제/삭제 버튼 */
.btn-group-bottom .btn {
    font-size: 1.1rem; /* 약간 크게 */
    padding: 0.75rem 1.5rem;
    border-radius: var(--border-radius-md); /* 둥글게 */
    font-weight: 600;
    transition: transform 0.2s, box-shadow 0.2s;
}
.btn-group-bottom .btn:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-soft);
}
.btn-group-bottom .btn-success {
    background-color: var(--button-success-bg);
    border-color: var(--button-success-bg);
}
.btn-group-bottom .btn-success:hover {
    background-color: var(--button-success-hover-bg);
    border-color: var(--button-success-hover-bg);
}
.btn-group-bottom .btn-danger {
    background-color: var(--button-danger-bg);
    border-color: var(--button-danger-bg);
}
.btn-group-bottom .btn-danger:hover {
    background-color: var(--button-danger-hover-bg);
    border-color: var(--button-danger-hover-bg);
}


/* 모바일 대응 */
@media (max-width: 768px) {
  .main-content-area {
    flex-direction: column; /* 세로로 정렬 */
  }
  #menuPanel, #orderPanel {
    flex-basis: 100%; /* 전체 너비 차지 */
    max-height: none; /* 높이 제한 해제 */
    overflow-y: visible; /* 스크롤바 해제 */
  }
  .search-select-container {
      flex-direction: column;
      align-items: center;
  }
  .search-select-container label {
      margin-left: 0 !important; /* ms-3 제거 */
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

		if (!restMap.containsKey(name)) { // 코드 대신 이름으로 중복 체크
	        restMap.put(name, code); // 이름이 key, 코드가 value
		}
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>
<%
    Properties prop = new Properties();
    InputStream input = application.getResourceAsStream("/WEB-INF/classes/config.properties");
    prop.load(input);

    String channelKey = prop.getProperty("portone.channelKey");
%>
<div class="container my-5">
    <h2>푸드코트 메뉴 현황</h2>
    <div class="search-select-container">
      <label for="restSearch" class="form-label mb-0">휴게소 검색:</label>
      <div class="position-relative" style="width: 300px;">
        <input type="text" id="restSearch" class="form-control" placeholder="휴게소명을 입력하세요" autocomplete="off">
        <div id="autocompleteList" class="list-group"></div>
      </div>

      <label for="restSelect" class="form-label mb-0">휴게소 선택:</label>
      <select id="restSelect" class="form-select">
        <option value="">휴게소를 선택하세요</option>
        <% for (Map.Entry<String, String> entry : restMap.entrySet()) { %>
          <option value="<%= entry.getKey() %>"><%= entry.getKey() %></option>
        <% } %>
      </select>
    </div>

    <hr>

    <div class="main-content-area">
      <div id="menuPanel">
        <div id="menuList"></div>
      </div>

      <div id="orderPanel">
        <h5 class="mt-1 mb-3"><i class="bi bi-basket-fill"></i> 주문 메뉴</h5>
        <ul id="orderList" class="list-group"></ul>
        <div id="orderSummary" class="text-end mb-3 mt-4"></div>
        <div class="text-center btn-group-bottom">
          <button class="btn btn-success" onclick="orderBtn()"><i class="bi bi-wallet-fill"></i> 결제하기</button>
          &nbsp;
          <button class="btn btn-danger" onclick="clearOrder()"><i class="bi bi-trash-fill"></i> 전체삭제</button>
        </div>
      </div>
    </div>
</div>

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
            "<%= entry.getKey() %>": "<%= entry.getValue() %>",
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
            isOrderNotEmpty = false;
            const emptyItem = document.createElement('li');
            // 텍스트와 아이콘을 중앙에 정렬하기 위해 flexbox 사용
            emptyItem.className = 'list-group-item text-center text-muted d-flex flex-column justify-content-center align-items-center'; 
            emptyItem.innerHTML = '<i class="bi bi-cart-x fs-4 mb-2"></i><br>주문 메뉴를 담아주세요.'; 
            emptyItem.style.padding = '100px 0'; // 주문 목록 비어있을 때 높이 유지
            orderList.appendChild(emptyItem);
            summaryArea.textContent = '';
            return;
        }

        isOrderNotEmpty = true;

        entries.forEach(([name, info]) => {
            total += info.price * info.quantity;

            const item = document.createElement('li');
            item.className = 'list-group-item d-flex justify-content-between align-items-center';

            // 왼쪽 (메뉴 이름, 가격, 수량)
            const itemDetails = document.createElement('div');
            itemDetails.className = 'item-details';
            itemDetails.innerHTML = "<strong>" + name + "</strong><br>" +
                                    "<span class='text-muted'>" + info.price.toLocaleString() + "원</span>" +
                                    "<span class='quantity-display ms-2'>" + info.quantity + "개</span>"; // 수량 위치 변경

            // 오른쪽 (버튼 그룹)
            const right = document.createElement('div');
            right.className = 'd-flex align-items-center gap-2'; // 버튼 간격

            // 수량 감소 버튼
            const minusBtn = document.createElement('button');
            minusBtn.className = 'btn btn-sm btn-outline-secondary';
            minusBtn.innerHTML = '<i class="bi bi-dash-lg"></i>'; // 아이콘으로 변경
            minusBtn.onclick = () => {
                if (info.quantity > 1) {
                    info.quantity -= 1;
                } else {
                    delete orderMap[name];
                }
                renderOrderList();
            };

            // 수량 증가 버튼
            const plusBtn = document.createElement('button');
            plusBtn.className = 'btn btn-sm btn-outline-secondary';
            plusBtn.innerHTML = '<i class="bi bi-plus-lg"></i>'; // 아이콘으로 변경
            plusBtn.onclick = () => {
                info.quantity += 1;
                renderOrderList();
            };

            // 삭제 버튼
            const delBtn = document.createElement('button');
            delBtn.className = 'btn btn-sm btn-outline-danger';
            delBtn.innerHTML = '<i class="bi bi-trash-fill"></i>'; // 휴지통 아이콘
            delBtn.onclick = () => {
                delete orderMap[name];
                renderOrderList();
            };

            right.append(minusBtn, plusBtn, delBtn); // 수량 제외
            item.append(itemDetails, right); // itemDetails로 묶어서 추가
            orderList.appendChild(item);
        });

        // 총 금액 표시
        summaryArea.textContent = "총 금액: " + total.toLocaleString() + "원";
    }

    // 메뉴 목록 로딩 함수
    function loadMenu(name) {
        container.innerHTML = '';
        
        if (!name) {
            container.innerHTML = '<div class="no-data"><i class="bi bi-search fs-3 mb-2"></i><br>휴게소를 선택 또는 검색해주세요.</div>';
            return;
        }

        fetch('restFoodMenuJson.jsp?stdRestNm=' + encodeURIComponent(name))
            .then(res => {
                if (!res.ok) throw new Error('네트워크 오류');
                return res.json();
            })
            .then(data => {
                if (!data || data.length === 0) {
                    container.innerHTML = '<div class="no-data"><i class="bi bi-box-seam-fill fs-3 mb-2"></i><br>선택된 휴게소의 메뉴 정보가 없습니다.</div>';
                    return;
                }

                // Best 메뉴를 상단으로 정렬
                const sorted = [...data.filter(i => i.bestfoodyn === 'Y'), ...data.filter(i => i.bestfoodyn !== 'Y')];

                sorted.forEach(i => {
                    const div = document.createElement('div');
                    div.className = 'menu-item';

                    // 메뉴명
                    const h5 = document.createElement('h5');
                    if (i.bestfoodyn === 'Y') {
                        const star = document.createElement('span');
                        star.className = 'best-badge';
                        star.innerHTML = '<i class="bi bi-award-fill"></i> Best ';
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
                    if (i.etc && i.etc.trim() !== '') { // 빈 문자열 체크
                        const desc = document.createElement('p');
                        desc.textContent = i.etc;
                        div.appendChild(desc);
                    }

                    // 담기 버튼
                    const addBtn = document.createElement('button');
                    addBtn.className = 'add-btn';
                    addBtn.innerHTML = '<i class="bi bi-cart-plus-fill"></i> 담기';
                    addBtn.onclick = () => addToOrder(i.foodNm, i.foodCost);
                    div.appendChild(addBtn);

                    container.appendChild(div);
                });
            })
            .catch(err => {
                container.innerHTML = '<div class="no-data"><i class="bi bi-exclamation-triangle-fill fs-3 mb-2"></i><br>메뉴 정보를 가져오는 중 오류가 발생했습니다.</div>';
                console.error(err);
            });
    }

    // 휴게소 선택(select) 변경 이벤트
    select.addEventListener('change', () => {
        const selectedName = select.value; // 선택된 휴게소 '이름'
        
        if (isOrderNotEmpty) {
            const proceed = confirm("주문 목록이 초기화됩니다. 계속하시겠습니까?");
            if (!proceed) {
                // 이전 선택값으로 되돌리기 (뒤로가기 방지)
                const currentParams = new URLSearchParams(location.search);
                const currentName = currentParams.get('stdRestNm') || '';
                select.value = currentName;
                return;
            }
            clearOrder();
        }
        
        restInput.value = selectedName; // 검색 입력창에도 반영
        loadMenu(selectedName); // 메뉴 로딩
        
        // URL 업데이트 (뒤로가기/새로고침 시 상태 유지)
        if (selectedName) {
            history.pushState(null, "", "index.jsp?main=restFoodMenu.jsp&stdRestNm=" + encodeURIComponent(selectedName));
        } else {
            history.replaceState(null, "", "index.jsp?main=restFoodMenu.jsp"); // 휴게소 미선택 시 파라미터 제거
        }
    });

    // 자동완성 검색 기능
    restInput.addEventListener('input', () => {
        const keyword = restInput.value.trim();
        listDiv.innerHTML = '';
        listDiv.style.display = 'none';

        if (keyword.length < 1) return;

        // 휴게소 이름(Key)을 기준으로 검색
        const matches = Object.keys(restAreaMap).filter(name => name.includes(keyword));
        if (matches.length === 0) return;

        matches.forEach(name => {
            const item = document.createElement('div');
            item.className = 'list-group-item list-group-item-action';
            item.textContent = name;
            item.onclick = () => {
                if (isOrderNotEmpty) {
                    const proceed = confirm("주문 목록이 초기화됩니다. 계속하시겠습니까?");
                    if (!proceed) return;
                    clearOrder();
                }

                restInput.value = name;
                select.value = name; // select 박스도 해당 휴게소명으로 선택
                loadMenu(name);
                history.pushState(null, "", "index.jsp?main=restFoodMenu.jsp&stdRestNm=" + encodeURIComponent(name));
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
	    const name = params.get('stdRestNm'); // URL에서 휴게소명 가져오기
	
	    if (name) {
	        restInput.value = name;     // 자동완성 입력창에 휴게소명 넣기
	        select.value = name;        // select 박스는 휴게소명으로 선택
	        loadMenu(name);             // 메뉴 로딩도 휴게소명 기준
	    } else {
	        restInput.value = '';
	        select.value = '';
	        loadMenu(); // 휴게소 미선택 시 기본 메시지 표시
	    }
	
	    renderOrderList(); // 주문 목록 초기 렌더링
	});

    // 브라우저 뒤로/앞으로 이동 대응 (history.popstate)
    window.addEventListener('popstate', () => {
	    if (isOrderNotEmpty) {
	        const proceed = confirm("주문 목록이 초기화될 수 있습니다. 계속하시겠습니까?");
	        if (!proceed) {
	            // 사용자가 취소하면 뒤로가기 동작을 막고 현재 페이지 유지
	            history.forward();
	            return;
	        }
	        clearOrder();
	    }
	
	    const params = new URLSearchParams(location.search);
	    const name = params.get('stdRestNm');
	
	    restInput.value = name || '';
	    select.value = name || ''; // select 박스도 이름으로 선택
	    loadMenu(name);
	    renderOrderList(); // 주문 목록 상태도 다시 렌더링
	});
</script>

<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script>
	function orderBtn() {
	    // 로그인 체크 (JSP 코드로 세션 검사)
	    <% if (session.getAttribute("userId") == null) { %>
	        alert("로그인이 필요합니다.");
	        return;
	    <% } %>
	
	    // 주문 비어있을 때
	    if (Object.keys(orderMap).length === 0) {
	        alert("주문할 메뉴가 없습니다.");
	        return;
	    }
	
	    const IMP = window.IMP;
	    IMP.init("imp37255548"); // 식별코드 (가맹점 고유 식별 코드)
	
	    // 주문 데이터 구성
	    const now = new Date();
	    const channel_key = "<%= channelKey %>";	// PortOne 채널키
	    const merchantUid = "order_" + now.getTime();	// 고유한 주문번호
	    
	    // 실제 결제 금액
	    const totalAmount = Object.values(orderMap).reduce((sum, item) => sum + item.price * item.quantity, 0); 
	    
	    // --- 테스트용: 실제 결제 시 주석 해제 및 위 totalAmount 사용 ---
	    // const totalAmount = Math.round(
		//     Object.values(orderMap).reduce((sum, item) => sum + item.price * item.quantity, 0) / 100
		// );
	    // --- 테스트용 끝 ---
	    
	    const menuNames = Object.keys(orderMap);
	    const restName = document.getElementById('restSearch').value || "선택된 휴게소";
	
	    let orderName = restName;
	    if (menuNames.length > 0) {
	        orderName += " - " + menuNames[0];
	        if (menuNames.length > 1) {
	            orderName += " 외 " + (menuNames.length - 1) + "개";
	        }
	    }
	
	    // 결제 요청
	    IMP.request_pay({
	        channelKey: channel_key,
	        pg: "html5_inicis", // PG사 선택 (예: 이니시스)
	        pay_method: "card",
	        merchant_uid: merchantUid,
	        name: orderName,
	        amount: totalAmount,
	        buyer_name: "<%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "비회원" %>",
	        buyer_email: "<%= session.getAttribute("email") != null ? session.getAttribute("email") : "guest@example.com" %>"
	    }, function (rsp) {
	        console.log("결제 응답", rsp); 
	
	        if (rsp.success) {
	        	// 결제 성공 시 서버로 주문 정보 전송
	        	$.ajax({
	                url: "food/orderAction.jsp",
	                type: "POST",
	                data: {
	                    merchant_uid: rsp.merchant_uid,
	                    imp_uid: rsp.imp_uid,
	                    userName: rsp.buyer_name,
	                    email: rsp.buyer_email,
	                    orderName: rsp.name,
	                    orderPrice: rsp.paid_amount
	                },
	                success: function() {
	                	alert("결제가 완료되었습니다!");
	                    clearOrder(); // 주문 목록 전체 초기화
	                    // 필요하다면 페이지 새로고침 또는 메뉴 리스트 다시 로드
	                    // loadMenu(document.getElementById('restSelect').value);
	                },
	                error: function(xhr, status, error) {
	                    alert("주문 정보 저장에 실패했습니다. 관리자에게 문의하세요.");
	                    console.error("Order save error:", error);
	                }
	            });
	        	
	        } else {
	            alert("결제 실패: " + rsp.error_msg);
	        }
	    });
	}
</script>

</body>
</html>