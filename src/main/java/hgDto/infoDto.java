package hgDto;

import java.sql.Timestamp;

public class infoDto {
	
	
	private int id;
	private String name;
	private String title;
	private String content;
	private String photoName;
	private Timestamp writeday;
	private int readcount;
	private String hgId;
	
	
	
	
	public String getHgId() {
		return hgId;
	}
	public void setHgId(String hgId) {
		this.hgId = hgId;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	
	
	
	
	
	
	
	
	

}
