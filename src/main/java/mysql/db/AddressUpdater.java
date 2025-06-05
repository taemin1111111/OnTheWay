package mysql.db;

import java.sql.*;
import java.util.*;
import org.json.*;
import java.net.*;
import java.io.*;

public class AddressUpdater {
    private static final String API_KEY = "KakaoAK ";

    public static String getAddress(double longitude, double latitude) {
        String apiUrl = String.format(
            "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=%f&y=%f", longitude, latitude);
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", API_KEY);
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.out.println("❌ API failed: " + responseCode);
                return null;
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) sb.append(line);
            in.close();

            JSONObject json = new JSONObject(sb.toString());
            JSONArray documents = json.getJSONArray("documents");

            if (documents.length() > 0) {
                JSONObject addressObj = documents.getJSONObject(0).getJSONObject("address");
                return addressObj.getString("address_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void updateAddresses() {
        String sqlSelect = "SELECT id, latitude, longitude FROM hg_data WHERE address IS NULL";
        String sqlUpdate = "UPDATE hg_data SET address = ? WHERE id = ?";

        try (Connection conn = new DbConnect().getConnection();
             PreparedStatement psSelect = conn.prepareStatement(sqlSelect);
             PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
             ResultSet rs = psSelect.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                double lat = rs.getDouble("latitude");
                double lon = rs.getDouble("longitude");

                String addr = getAddress(lon, lat);
                if (addr != null) {
                    psUpdate.setString(1, addr);
                    psUpdate.setInt(2, id);
                    psUpdate.executeUpdate();
                    System.out.println("✅ Updated id " + id + " with address: " + addr);
                } else {
                    System.out.println("⚠️ Failed to get address for id " + id);
                }

                Thread.sleep(200); // Respect API rate limits
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        updateAddresses();
    }
}
