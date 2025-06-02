<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Set" %> <%-- Add this import --%>
<%
    String mapKey = null;
    String errorMessage = null;
    Properties prop = new Properties();
    InputStream input = null;

    try {
        String path1 = "/WEB-INF/classes/config.properties";
        input = application.getResourceAsStream(path1);

        if (input == null) {
            errorMessage = "ERROR: Could not find resource at " + path1 + " using ServletContext.";
            System.out.println(errorMessage);
            // ... (your fallback logic if you have one) ...
        } else {
            System.out.println("SUCCESS: Found resource " + path1 + " using ServletContext.");
            prop.load(input);

            // --- DEBUG: Print all loaded properties ---
            System.out.println("--- All Loaded Properties ---");
            Set<String> propertyNames = prop.stringPropertyNames();
            if (propertyNames.isEmpty()) {
                System.out.println("No properties were loaded from the file!");
            } else {
                for (String key : propertyNames) {
                    System.out.println("Loaded Key: '" + key + "', Value: '" + prop.getProperty(key) + "'");
                }
            }
            System.out.println("-----------------------------");
            // --- END DEBUG ---

            mapKey = prop.getProperty("kakao.api"); // The key we are interested in
            if (mapKey == null) {
                String keyNotFoundMsg = "WARN: 'kakao.api' key not found in properties file, though file was loaded.";
                System.out.println(keyNotFoundMsg);
                if (errorMessage != null && !errorMessage.isEmpty()) {
                    errorMessage += "\n" + keyNotFoundMsg;
                } else {
                    errorMessage = keyNotFoundMsg;
                }
            } else {
                System.out.println("SUCCESS: Loaded mapKey: " + mapKey);
            }
        }
    } catch (IOException e) {
        // ... (your error handling) ...
        errorMessage = "IOException: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (input != null) {
            try {
                input.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!-- For displaying in the browser -->
<p>Map Key: <%= (mapKey != null ? mapKey : "Not found or error loading") %></p>
<% if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <p style="color:red;">Error: <%= errorMessage.replace("\n", "<br>") %></p>
<% } %>