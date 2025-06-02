<%@ page import="java.io.InputStream, java.util.Properties, java.sql.*" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        InputStream input = application.getResourceAsStream("/WEB-INF/classes/config.properties");
        if (input == null) throw new Exception("config.properties 파일을 찾을 수 없습니다.");

        Properties prop = new Properties();
        prop.load(input);

        String url = prop.getProperty("db.url");
        String dbUser = prop.getProperty("db.user");
        String dbPassword = prop.getProperty("db.password");

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // ✔ userId 기준으로 로그인 시도
        String sql = "SELECT * FROM user WHERE userId = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("userId", rs.getString("userId"));
            session.setAttribute("userName", rs.getString("userName"));

            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
%>
            <script>
                alert("아이디 또는 비밀번호가 올바르지 않습니다.");
                history.back();
            </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("로그인 중 오류 발생: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
