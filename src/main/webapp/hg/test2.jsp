<%@ page import="hgDao.hgRestDao" %>
<%@ page import="hgDto.hgRestDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 검색</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5ac2ea2e11f7b380cdf52afbcc384b44&libraries=services"></script>

<style>
  #map { width: 700px; height: 400px; }
  a.hg_num { text-decoration:none; color:black; }
  a.hg_num:hover { color:blue; text-decoration:underline; }
  #result-table { max-height:400px; overflow-y:auto; }
</style>

<script>



$(function() {
  // 검색 또는 체크박스 변경 시 Ajax 호출
  function loadData() {
    let searchName = $('#sName').val();
    let lpg = $("input[name='lpg']").is(":checked") ? "Y" : "";
    let ev = $("input[name='ev']").is(":checked") ? "Y" : "";
    let pharm = $("input[name='pharm']").is(":checked") ? "Y" : "";

    $.ajax({
    	url: '<%=request.getContextPath()%>/hg/test.jsp',
      method: 'GET',
      data: { searchName, lpg, ev, pharm },
      dataType: 'json',
      success: function(data) {
    	  console.log(data);  // data가 배열로 잘 들어오는지 확인
    	  renderTable(data);
    	  let searchName = $('#sName').val().trim();
    	  renderMap(data, searchName !== "");
    	},
      error: function(xhr, status, error) {
    	  console.error('데이터 로딩 실패:', status, error);
    	  console.error('응답 텍스트:', xhr.responseText);
    	  alert('데이터 로딩 실패');
    	}
    });
  }

  // 테이블 렌더링
  function renderTable(data) {
    let html = `<table class="table table-bordered" style="width:1200px;">
      <tr class="table-success" align="center">      
        <th style="width:50;">번호</th>
        <th style="width:100;">이름</th>
        <th style="width:150;">전화번호</th>      
        <th style="width:100;">평점</th>
        <th style="width:200;">주소</th>
      </tr>`;

    for(let i=0; i<data.length; i++) {
      let d = data[i];
      html += `<tr>
        <td>${i+1}</td>
        <td><a href="index.jsp?main=details/info.jsp?hg_id=${d.id}" class="hg_num">${d.name}</a></td>
        <td>${d.tel_no}</td>
        <td>${d.review}</td>
        <td class="addr-cell" data-lat="${d.latitude}" data-lng="${d.longitude}"></td>
      </tr>`;
    }
    html += '</table>';
    $('#result-table').html(html);
    fillAddresses(); // 주소 채우기 호출
  }

  // 주소 변환해서 테이블 채우기
  function fillAddresses() {
    var geocoder = new kakao.maps.services.Geocoder();

    $('td.addr-cell').each(function() {
      let cell = $(this);
      let lat = parseFloat(cell.data('lat'));
      let lng = parseFloat(cell.data('lng'));

      geocoder.coord2Address(lng, lat, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
          let addr = result[0].address.address_name;
          cell.text(addr);
        } else {
          cell.text("주소 없음");
        }
      });
    });
  }

  // 카카오맵 마커 표시
  var map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(36.5, 127.5),
    level: 12
  });
  var markers = [];
  var customOverlays = [];
  
  function renderMap(data, isSearch) {
	  // 기존 마커, 오버레이 제거
	  markers.forEach(m => m.setMap(null));
	  markers = [];
	  
	  customOverlays.forEach(co => co.setMap(null));
	  customOverlays = [];
	  
	  for(let i=0; i<data.length; i++) {
	    let d = data[i];
	    let lat = parseFloat(d.latitude);
	    let lng = parseFloat(d.longitude);
	    if(isNaN(lat) || isNaN(lng)) continue;

	    let pos = new kakao.maps.LatLng(lat, lng);
	    let marker = new kakao.maps.Marker({ map: map, position: pos });
	    markers.push(marker);

	    kakao.maps.event.addListener(marker, 'click', function() {
	      window.location.href = 'index.jsp?main=details/info.jsp?hg_id=' + d.id;
	    });

	    // 검색어가 있을 때만 이름 박스 표시
	    if(isSearch) {
	      let overlayDiv = document.createElement('div');
	      overlayDiv.style.background = 'white';
	      overlayDiv.style.border = '1px solid #666';
	      overlayDiv.style.padding = '4px 8px';
	      overlayDiv.style.fontSize = '13px';
	      overlayDiv.style.whiteSpace = 'nowrap';
	      overlayDiv.style.borderRadius = '4px';
	      overlayDiv.style.boxShadow = '2px 2px 6px rgba(0,0,0,0.3)';
	      overlayDiv.style.color = 'black';
	      overlayDiv.textContent = d.name;

	      let customOverlay = new kakao.maps.CustomOverlay({
	        content: overlayDiv,
	        map: map,
	        position: pos,
	        yAnchor: 1.5
	      });

	      overlayDiv.addEventListener('click', function() {
	        window.location.href = 'index.jsp?main=details/info.jsp?hg_id=' + d.id;
	      });

	      customOverlays.push(customOverlay);
	    }
	  }
	}

  // 검색 버튼 클릭 시
  $('#search').click(function(e) {
    e.preventDefault();
    loadData();
  });

  // 체크박스 변경 시
  $('input.a').change(function() {
    loadData();
  });

  // 페이지 최초 로드 시 데이터 불러오기
  loadData();
});
</script>

</head>
<body>

<div style="margin: 100px 100px;" class="container mt-3">

<h3>고속도로 휴게소</h3>
<br>

<form id="searchForm" method="get" action="#">
  <input type="text" name="searchName" placeholder="검색할 휴게소 이름을 입력하세요." style="width:500px;" id="sName">
  <button id="search" class="btn btn-success">검색</button>
  <br>
  <label><input type="checkbox" name="lpg" value="Y" class="a"> LPG충전소</label>
  <label><input type="checkbox" name="ev" value="Y" class="a"> 전기차충전소</label>
  <label><input type="checkbox" name="pharm" value="Y" class="a"> 약국</label>
</form>

<br>

<div id="map"></div>
<br>

<div id="result-table"></div>

</div>

</body>
</html>