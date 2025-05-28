package mysql.db;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import java.nio.file.*;
import java.sql.*;
import java.util.*;

public class ApiDb {
    private final DbConnect db;

    public ApiDb() {
        this.db = new DbConnect();
    }

    public void general(String jsonFilePath) throws Exception {
        byte[] data = Files.readAllBytes(Path.of(jsonFilePath));
        List<Map<String,String>> list = new ObjectMapper()
            .readValue(data, new TypeReference<List<Map<String,String>>>() {});

        String sql = """
            INSERT INTO hg
              (id, name, tel_no, addr, truck, maintenance)
            VALUES (?,?,?,?,?,?)
            """;

        DbConnect db = new DbConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (Map<String,String> obj : list) {
                String idStr = obj.get("serviceAreaCode");  
                // <-- if there's no "id" in this JSON record, skip it
                if (idStr == null || idStr.isBlank()) {
                    System.out.println("Skipping record without id: " + obj);
                    continue;
                }
                
                String idName = obj.get("serviceAreaName");  
                // <-- if there's no "id" in this JSON record, skip it
                if (idName == null || idStr.isBlank()) {
                    System.out.println("Skipping record without id: " + obj);
                    continue;
                }

                // now bind id + the other five values
                ps.setString   (1, idStr);
                ps.setString(2, idName);
                ps.setString(3, obj.get("telNo"));
                ps.setString(4, obj.get("svarAddr"));
                ps.setInt   (5, "O".equals(obj.get("truckSaYn")) ? 1 : 0);
                ps.setInt   (6, "O".equals(obj.get("maintenanceYn")) ? 1 : 0);
                ps.addBatch();
            }

            ps.executeBatch();
            System.out.println("✅ Import complete");
        }
    }

    public void brand(String jsonFilePath) throws Exception {
        byte[] data = Files.readAllBytes(Path.of(jsonFilePath));
        List<Map<String,String>> list = new ObjectMapper()
            .readValue(data, new TypeReference<List<Map<String,String>>>() {});

        String sql = """
        	    INSERT INTO hg_brand
        	      (hg_name, brand_name, brand_id)
        	    VALUES (?,?,?)
        	    """;

        DbConnect db = new DbConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (Map<String,String> obj : list) {
                String brandName = obj.get("brdName");  
                if (brandName == null || brandName.isBlank()) {
                    System.out.println("Skipping record without name: " + obj);
                    continue;
                }

                // now bind id + the other five values
                ps.setString(1, obj.get("stdRestNm"));
                ps.setString(2, brandName);
                ps.setString(3, obj.get("brdCode"));
                ps.addBatch();
            }

            ps.executeBatch();
            System.out.println("✅ Import complete");
        }
    }
    
    public void conv(String jsonFilePath) throws Exception {
        byte[] data = Files.readAllBytes(Path.of(jsonFilePath));
        List<Map<String,String>> list = new ObjectMapper()
            .readValue(data, new TypeReference<List<Map<String,String>>>() {});

        String sql = """
        	    INSERT INTO hg_conv
        	      (hg_name, conv_name, conv_desc)
        	    VALUES (?,?,?)
        	    """;

        DbConnect db = new DbConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (Map<String,String> obj : list) {
                String convName = obj.get("psName");  
                if (convName == null || convName.isBlank()) {
                    System.out.println("Skipping record without name: " + obj);
                    continue;
                }

                // now bind id + the other five values
                ps.setString(1, obj.get("stdRestNm"));
                ps.setString(2, convName);
                ps.setString(3, obj.get("psDesc"));
                ps.addBatch();
            }

            ps.executeBatch();
            System.out.println("✅ Import complete");
        }
    }
    
    
    
    public static void main(String[] args) throws Exception {
        String genPath = args.length > 0
            ? args[0]
            : System.getProperty("user.dir") + "/src/main/webapp/data/restGeneral.json";
        String brandPath = args.length > 0
                ? args[0]
                : System.getProperty("user.dir") + "/src/main/webapp/data/restBrandStoreData.json";
        String convPath = args.length > 0
                ? args[0]
                : System.getProperty("user.dir") + "/src/main/webapp/data/restConv.json";
        	
        System.out.println("Loading from: " + genPath);
        //new ApiDb().general(genPath);
        new ApiDb().brand(brandPath);
        //new ApiDb().conv(convPath);

    }
}

