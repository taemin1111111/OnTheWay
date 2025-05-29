package conv;

public class ConvDto {
	private int id;
	private String hg_name;
	private String conv_name;
	private String conv_desc;
	
	
	public int getId() {
		return id;
	}
	public String getHg_name() {
		return hg_name;
	}
	public String getConv_name() {
		return conv_name;
	}
	public String getConv_desc() {
		return conv_desc;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setHg_name(String hg_name) {
		this.hg_name = hg_name;
	}
	public void setConv_name(String conv_name) {
		this.conv_name = conv_name;
	}
	public void setConv_desc(String conv_desc) {
		this.conv_desc = conv_desc;
	}
	
}
