package hg;

public class HgDataDto {

    private int id;
    private String rest_name;
    private String road_type;
    private String route_number;
    private String route_name;
    private String route_direction;
    private double latitude;
    private double longitude;
    private String rest_type;
    private String open_time;
    private String close_time;
    private int road_area;
    private int parking_count;
    private String repair_available; // char(1) -> 'Y' or 'N'
    private String has_gas_station;  // char(1)
    private String has_lpg_station;  // char(1)
    private String has_ev_station;   // char(1)
    private String bus_transfer_available; // char(1)
    private String has_rest_area;    // char(1)
    private String has_toilet;       // char(1)
    private String has_pharmacy;     // char(1)
    private String has_nursing_room; // char(1)
    private String has_store;        // char(1)
    private String has_restaurant;   // char(1)
    private String extra_facilities;
    private String signature_menu;
    private String phone_number;

    // Default Constructor
    public HgDataDto() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRest_name() {
        return rest_name;
    }

    public void setRest_name(String rest_name) {
        this.rest_name = rest_name;
    }

    public String getRoad_type() {
        return road_type;
    }

    public void setRoad_type(String road_type) {
        this.road_type = road_type;
    }

    public String getRoute_number() {
        return route_number;
    }

    public void setRoute_number(String route_number) {
        this.route_number = route_number;
    }

    public String getRoute_name() {
        return route_name;
    }

    public void setRoute_name(String route_name) {
        this.route_name = route_name;
    }

    public String getRoute_direction() {
        return route_direction;
    }

    public void setRoute_direction(String route_direction) {
        this.route_direction = route_direction;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getRest_type() {
        return rest_type;
    }

    public void setRest_type(String rest_type) {
        this.rest_type = rest_type;
    }

    public String getOpen_time() {
        return open_time;
    }

    public void setOpen_time(String open_time) {
        this.open_time = open_time;
    }

    public String getClose_time() {
        return close_time;
    }

    public void setClose_time(String close_time) {
        this.close_time = close_time;
    }

    public int getRoad_area() {
        return road_area;
    }

    public void setRoad_area(int road_area) {
        this.road_area = road_area;
    }

    public int getParking_count() {
        return parking_count;
    }

    public void setParking_count(int parking_count) {
        this.parking_count = parking_count;
    }

    public String getRepair_available() {
        return repair_available;
    }

    public void setRepair_available(String repair_available) {
        this.repair_available = repair_available;
    }

    public String getHas_gas_station() {
        return has_gas_station;
    }

    public void setHas_gas_station(String has_gas_station) {
        this.has_gas_station = has_gas_station;
    }

    public String getHas_lpg_station() {
        return has_lpg_station;
    }

    public void setHas_lpg_station(String has_lpg_station) {
        this.has_lpg_station = has_lpg_station;
    }

    public String getHas_ev_station() {
        return has_ev_station;
    }

    public void setHas_ev_station(String has_ev_station) {
        this.has_ev_station = has_ev_station;
    }

    public String getBus_transfer_available() {
        return bus_transfer_available;
    }

    public void setBus_transfer_available(String bus_transfer_available) {
        this.bus_transfer_available = bus_transfer_available;
    }

    public String getHas_rest_area() {
        return has_rest_area;
    }

    public void setHas_rest_area(String has_rest_area) {
        this.has_rest_area = has_rest_area;
    }

    public String getHas_toilet() {
        return has_toilet;
    }

    public void setHas_toilet(String has_toilet) {
        this.has_toilet = has_toilet;
    }

    public String getHas_pharmacy() {
        return has_pharmacy;
    }

    public void setHas_pharmacy(String has_pharmacy) {
        this.has_pharmacy = has_pharmacy;
    }

    public String getHas_nursing_room() {
        return has_nursing_room;
    }

    public void setHas_nursing_room(String has_nursing_room) {
        this.has_nursing_room = has_nursing_room;
    }

    public String getHas_store() {
        return has_store;
    }

    public void setHas_store(String has_store) {
        this.has_store = has_store;
    }

    public String getHas_restaurant() {
        return has_restaurant;
    }

    public void setHas_restaurant(String has_restaurant) {
        this.has_restaurant = has_restaurant;
    }

    public String getExtra_facilities() {
        return extra_facilities;
    }

    public void setExtra_facilities(String extra_facilities) {
        this.extra_facilities = extra_facilities;
    }

    public String getSignature_menu() {
        return signature_menu;
    }

    public void setSignature_menu(String signature_menu) {
        this.signature_menu = signature_menu;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    // (Optional) toString() method for debugging
    @Override
    public String toString() {
        return "HgDataDto{" +
               "id=" + id +
               ", rest_name='" + rest_name + '\'' +
               // Add other fields if needed for quick debugging
               '}';
    }
}