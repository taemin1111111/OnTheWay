package hg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mysql.db.DbConnect;

public class HgDataDao {

    DbConnect db = new DbConnect();

    /**
     * Fetches a single HgDataDto object from the hg_data table by its ID.
     *
     * @param hgIdParam The ID of the rest stop (as a String, will be parsed to int).
     * @return HgDataDto object if found, null otherwise.
     * @throws SQLException if a database access error occurs.
     * @throws NumberFormatException if hgIdParam cannot be parsed to an integer.
     */
    public HgDataDto getHgDataById(String hgIdParam) throws SQLException, NumberFormatException {
        HgDataDto hgData = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Validate and parse the ID
        int hgId;
        try {
            hgId = Integer.parseInt(hgIdParam);
        } catch (NumberFormatException e) {
            System.err.println("Invalid ID format for hg_data: " + hgIdParam);
            throw e; // Re-throw to be handled by the caller (JSP)
        }

        String sql = "SELECT * FROM hg_data WHERE id = ?"; // Use your actual table name

        try {
            conn = db.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, hgId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                hgData = new HgDataDto();
                hgData.setId(rs.getInt("id"));
                hgData.setRest_name(rs.getString("rest_name"));
                hgData.setRoad_type(rs.getString("road_type"));
                hgData.setRoute_number(rs.getString("route_number"));
                hgData.setRoute_name(rs.getString("route_name"));
                hgData.setRoute_direction(rs.getString("route_direction"));
                hgData.setLatitude(rs.getDouble("latitude"));
                hgData.setLongitude(rs.getDouble("longitude"));
                hgData.setRest_type(rs.getString("rest_type"));
                hgData.setOpen_time(rs.getString("open_time"));
                hgData.setClose_time(rs.getString("close_time"));
                hgData.setRoad_area(rs.getInt("road_area"));
                hgData.setParking_count(rs.getInt("parking_count"));
                hgData.setRepair_available(rs.getString("repair_available"));
                hgData.setHas_gas_station(rs.getString("has_gas_station"));
                hgData.setHas_lpg_station(rs.getString("has_lpg_station"));
                hgData.setHas_ev_station(rs.getString("has_ev_station"));
                hgData.setBus_transfer_available(rs.getString("bus_transfer_available"));
                hgData.setHas_rest_area(rs.getString("has_rest_area"));
                hgData.setHas_toilet(rs.getString("has_toilet"));
                hgData.setHas_pharmacy(rs.getString("has_pharmacy"));
                hgData.setHas_nursing_room(rs.getString("has_nursing_room"));
                hgData.setHas_store(rs.getString("has_store"));
                hgData.setHas_restaurant(rs.getString("has_restaurant"));
                hgData.setExtra_facilities(rs.getString("extra_facilities"));
                hgData.setSignature_menu(rs.getString("signature_menu"));
                hgData.setPhone_number(rs.getString("tel_no"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching hg_data by ID '" + hgId + "': " + e.getMessage());
            e.printStackTrace(); // Good for server logs
            throw e; // Re-throw to be handled by the caller (JSP)
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return hgData;
    }
}