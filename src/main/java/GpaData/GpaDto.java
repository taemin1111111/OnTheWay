package GpaData;

import java.sql.Timestamp;

import mysql.db.DbConnect;

public class GpaDto {
private String num;
private String userid;
private String hgName;
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
public String getHgName() {
	return hgName;
}
public void setHgName(String hgName) {
	this.hgName = hgName;
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
