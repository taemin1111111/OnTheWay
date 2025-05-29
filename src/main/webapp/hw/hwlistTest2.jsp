<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h1>jQuery 테스트</h1>
<button id="btn">클릭</button>
<script>
$(document).ready(function(){
  $("#btn").click(function(){
    alert("버튼 클릭됨!");
  });
});
</script>
</body>
</html>