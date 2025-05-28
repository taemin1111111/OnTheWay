<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.*, java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<%
    int itemsPerPage = 15;
    int currentPage = 1;
    String searchKeyword = request.getParameter("searchKeyword");

    if (request.getParameter("currentPage") != null) {
        try {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    String dataPath = application.getRealPath("/data/restThemeData.json");
    JSONParser parser = new JSONParser();
    JSONArray allData = new JSONArray();

    try {
        allData = (JSONArray) parser.parse(new FileReader(dataPath));
    } catch (Exception e) {
        e.printStackTrace();
    }

    List<JSONObject> filteredList = new ArrayList<>();
    for (Object obj : allData) {
        JSONObject item = (JSONObject) obj;
        if (searchKeyword == null || searchKeyword.trim().isEmpty() ||
            ((String) item.get("itemNm")).contains(searchKeyword)) {
            filteredList.add(item);
        }
    }

    int totalItems = filteredList.size();
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
    int start = (currentPage - 1) * itemsPerPage;
    int end = Math.min(start + itemsPerPage, totalItems);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테마 휴게소 안내</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f9fafb; padding: 40px; color: #212529; }
        h2 { font-size: 28px; font-weight: 600; margin-bottom: 30px; color: #1a1a1a; text-align: center; }
        .theme-item {
            background: white; border: 1px solid #ccc; border-radius: 10px;
            padding: 20px; margin: 0 auto 20px; width: 800px; max-width: 100%;
        }
        .theme-item h5 { color: #333; font-weight: 600; margin-bottom: 20px; }
        .theme-item p { margin: 5px 0; color: #555; }
        .pagination { justify-content: center; margin-top: 30px; }
        .page-link { color: #000; }
        .page-item.active .page-link { background-color: #000; border-color: #000; color: #fff; }
        #searchBox {
		    text-align: center;
		    margin-bottom: 30px;
		    position: relative;
		}
		#searchInput:focus {
		    outline: none;
		    box-shadow: none;
		    border-color: #ccc; /* 기존 테두리 색상 유지 */
		}
		/* 자동완성 리스트가 input 아래 잘 붙게 조정 */
		#autocompleteList {
		    position: absolute;
		    top: 100%;
		    left: 50%;
		    transform: translateX(-50%);
		    width: 300px;
		    z-index: 1000;
		    background: #fff;
		    border: 1px solid #ccc;
		    max-height: 300px;
		    overflow-y: auto;
		    display: none;
		}
		#autocompleteList div {
		    padding: 8px;
		    cursor: pointer;
		}
		#autocompleteList div:hover {
		    background-color: #f0f0f0;
		}
    </style>
</head>
<body>
    <div class="container">
        <h2>테마 휴게소 안내</h2>

        <div id="searchBox">
	    <form method="get" class="d-flex justify-content-center">
	        <div class="position-relative" style="width: 300px;">
	            <div class="input-group">
	                <input type="text" id="searchInput" name="searchKeyword" class="form-control"
	                       placeholder="테마명을 입력하세요"
	                       value="<%= searchKeyword != null ? searchKeyword : "" %>" autocomplete="off">
	                <button type="submit" class="btn btn-dark">
	                    <i class="bi bi-search"></i>
	                </button>
	            </div>
	            <!-- 🔽 자동완성은 input-group 안이 아닌 position-relative div 내부에 위치 -->
	            <div id="autocompleteList" class="list-group"></div>
	        </div>
	    </form>
	</div>

        <% for (int i = start; i < end; i++) {
            JSONObject item = filteredList.get(i);
        %>
            <div class="theme-item">
                <h5><%= item.get("itemNm") %></h5>
                <p><strong>휴게소명:</strong> <%= item.get("stdRestNm") %></p>
                <p><strong>주소:</strong> <%= item.get("svarAddr") %></p>
                <p><strong>노선:</strong> <%= item.get("routeNm") %></p>
                <p style="margin-top: 10px;"><strong>테마 설명</strong></p>
                <p style="margin-top: 6px;"><%= item.get("detail").toString().replaceAll("\\r?\\n", "<br>") %></p>
            </div>
        <% } %>

        <nav>
            <ul class="pagination">
                <% if (currentPage > 1) { %>
                    <li class="page-item">
                        <a class="page-link" href="?currentPage=<%= currentPage - 1 %>&searchKeyword=<%= searchKeyword != null ? searchKeyword : "" %>">이전</a>
                    </li>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                        <a class="page-link" href="?currentPage=<%= i %>&searchKeyword=<%= searchKeyword != null ? searchKeyword : "" %>"><%= i %></a>
                    </li>
                <% } %>

                <% if (currentPage < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="?currentPage=<%= currentPage + 1 %>&searchKeyword=<%= searchKeyword != null ? searchKeyword : "" %>">다음</a>
                    </li>
                <% } %>
            </ul>
        </nav>
    </div>

    <script>
        const input = document.getElementById("searchInput");
        const list = document.getElementById("autocompleteList");

        const keywords = [
            <% for (Object obj : allData) {
                JSONObject item = (JSONObject) obj;
                String name = (String) item.get("itemNm");
                if (name != null) { %>
                    "<%= name.replaceAll("\"", "\\\\\"") %>",
            <% } } %>
        ];

        input.addEventListener("input", function () {
            const value = this.value.trim().toLowerCase();
            list.innerHTML = '';
            if (value.length < 1) {
                list.style.display = "none";
                return;
            }

            const matched = keywords.filter(k => k.toLowerCase().includes(value));
            matched.forEach(k => {
                const div = document.createElement("div");
                div.textContent = k;
                div.onclick = () => {
                    input.value = k;
                    list.innerHTML = '';
                    list.style.display = "none";
                };
                list.appendChild(div);
            });
            list.style.display = "block";
        });

        document.addEventListener("click", (e) => {
            if (!input.contains(e.target) && !list.contains(e.target)) {
                list.style.display = "none";
            }
        });
    </script>
</body>
</html>
