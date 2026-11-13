package com.spring.greenStudyS.vo;

//@Data
public class UserVO {
	private int idx;
	private String mid;
	private String name;
	private int age;
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
	
	@Override
	public String toString() {
		return "UserVO [idx=" + idx + ", mid=" + mid + ", name=" + name + ", age=" + age + ", address=" + address
				+ ", fieldName=" + fieldName + ", orderName=" + orderName + "]";
	}
}
