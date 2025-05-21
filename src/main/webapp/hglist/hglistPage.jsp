<%@page import="java.util.ResourceBundle"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    ResourceBundle cfg = ResourceBundle.getBundle("config");
    String apiKey = cfg.getString("api.key");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style type="text/css">
	*{
		 font-family: 'Nanum Myeongjo';
	}
	tr {
	text-align: center;
	}
	.box {
		width: 40px; height: 40px;
		border-radius: 100px;
		box-shadow: 5px 5px 5px gray;
	}
</style>

</head>
<body>
  <h1>노선별 휴게시설 현황</h1>
<table id="table" class="table table-striped table-bordered table-hover">
  <thead></thead>
  <tbody></tbody>
</table>

  <script>
    const API_KEY = '<%= apiKey %>';
    const API_URL = 'https://data.ex.co.kr/openapi/business/serviceAreaRoute' 
                  + '?key=9384470378&type=json&numOfRows=300'; // API 키
        
	let items;  // 콘솔 디버깅을 위해 global 변수 선언          
    
    
                  
	async function fetchAndRender() { // 비동기처리 (api의 response가 오지 않더라도 페이지 로드)
		try {
		const resp = await fetch(API_URL); // API 리퀘스트 요청
		const data = await resp.json(); // 받은 response (json형식)를 data에 저장
		items = data.list;  // 받은 json을 리스트로 변환        
		/*
		console.log(items) 를 콘솔창에 입력하면 items 리스트를 콘솔에서 확인 가능
		console.log(items[0])을 하면 items의 첫번째 원소 확인 가능
		console.log(items[0].key]) 로 첫번쨰 원소의 key값에 들어있는 값에 접근 가능 (이 페이지에서 key 값 예시:brand)
		*/
         
		const headers = Object.keys(items[0]); // keys를 첫번쨰 행에 출력하기 위해 item 리스트의 첫번째 값의 속성값을 가져옴
         
		const table = document.querySelector('#table thead'); // id가 table인 요소(<table>) 선택
		const headerRow = document.createElement('tr'); // tr 생성
		headerRow.classList.add('table-info'); // tr에 부트스트랩 클래스 추가

		headers.forEach(col => { // headers(위에 key를 모아둔 리스트)의 각 원소를 차례대로
           const th = document.createElement('th');  // th 생성
           th.textContent = col; // th의 내용을 col(headers의 각각의 요소)로 변경
           headerRow.append(th); // 
         });
		table.appendChild(headerRow);

    	const tbody = document.querySelector('#table tbody');

    	items.forEach(obj => {
		const tr = document.createElement('tr');
		headers.forEach(field => {
			const td = document.createElement('td');
			td.textContent = obj[field] ?? ''; // 값이 null일 경우 ''를 출력 (널 병합 연산자)
			tr.appendChild(td);
		});
		tbody.appendChild(tr);
		/*	     
		모든 요소가 아닌 필요한 속성만 출력하고 싶다면:
			const picks = [0,4,7,3,5,9];  // 필요한 속성값의 인덱스(해당 예제처럼 순서도 바꿀 수 있음)
		picks.forEach(ind => {
		  const th = document.createElement('th');
		  th.textContent = headers[ind] ?? '';
		  headerRow.appendChild(th);
		});
		table.appendChild(headerRow);
		const tbody = document.querySelector('#table tbody');

    	items.forEach(obj => {
		const tr = document.createElement('tr');
		picks.forEach(ind => {
			const td = document.createElement('td');
			td.textContent = obj[headers[ind]] ?? ''; // 값이 null일 경우 ''를 출력 (널 병합 연산자)
			tr.appendChild(td);
		});
		tbody.appendChild(tr);
		*/
	});
	} catch (err) {
	console.error('API 호출 오류:', err); // 예외 처리
	}
}
    fetchAndRender(); // 함수 실행
    </script>
</body>
</html>