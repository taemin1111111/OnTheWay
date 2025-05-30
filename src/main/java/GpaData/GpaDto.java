package GpaData;

import java.sql.Timestamp;

import mysql.db.DbConnect;

public class GpaDto {
private String num;
private String userid;
private String hg_id;
private double stars;
private String content;
private int good;


public int getGood() {
	return good;
}
public void setGood(int good) {
	this.good = good;
}
private Timestamp writeday;
public String getNum() {
	return num;
}
public void setNum(String num) {
	this.num = num;
}
public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}

public String getHg_id() {
	return hg_id;
}
public void setHg_id(String hg_id) {
	this.hg_id = hg_id;
}
public double getStars() {
	return stars;
}
public void setStars(double stars) {
	this.stars = stars;
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
