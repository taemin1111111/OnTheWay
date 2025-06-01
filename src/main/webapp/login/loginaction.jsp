<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("id");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // config.properties 로드
        InputStream input = application.getResourceAsStream("/WEB-INF/classes/config.properties");
        if (input == null) {
            throw new Exception("config.properties 파일을 찾을 수 없습니다.");
        }

        Properties prop = new Properties();
        prop.load(input);

        String url = prop.getProperty("db.url");
        String dbUser = prop.getProperty("db.user");
        String dbPassword = prop.getProperty("db.password");

        // DB 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 사용자 인증 쿼리
        String sql = "SELECT * FROM user WHERE userId = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 세션에 로그인 정보 저장
            session.setAttribute("userId", rs.getString("userId"));
            session.setAttribute("userName", rs.getString("userName"));
            session.setAttribute("email", rs.getString("email"));
            session.setAttribute("role", rs.getInt("role"));

            // 메인 페이지로 이동
            response.sendRedirect("../index.jsp");
        } else {
%>
            <script>
                alert("아이디 또는 비밀번호가 올바르지 않습니다.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
%>
        <script>
            alert("오류 발생: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>