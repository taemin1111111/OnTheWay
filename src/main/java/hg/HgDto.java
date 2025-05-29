package hg;

public class HgDto {
    private String id;
    private String name; 
    private String tel_no; 
    private String addr; 
    private boolean truck; 
    private boolean maintenance; 

    // Getters and Setters
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getTel_no() {
        return tel_no;
    }
    public void setTel_no(String tel_no) {
        this.tel_no = tel_no;
    }
    public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }
    public boolean isTruck() { // Use "is" for boolean getters
        return truck;
    }
    public void setTruck(boolean truck) {
        this.truck = truck;
    }
    public boolean isMaintenance() { // Use "is" for boolean getters
        return maintenance;
    }
    public void setMaintenance(boolean maintenance) {
        this.maintenance = maintenance;
    }
}