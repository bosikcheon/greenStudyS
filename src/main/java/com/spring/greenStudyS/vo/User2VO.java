package com.spring.greenStudyS.vo;

//@Data
public class User2VO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private int age;
	private String gender;
	private String address;
	
	private String fieldName;
	private String orderName;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	@Override
	public String toString() {
		return "User2VO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", name=" + name + ", age=" + age + ", gender="
				+ gender + ", address=" + address + ", fieldName=" + fieldName + ", orderName=" + orderName + "]";
	}
}
