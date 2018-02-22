package com.gp.user;

public class Department extends Hospital{
	
	int id, hospitalId;
	String deptName;
	
	public Department(int id, int hospitalId, String name) {
		super();
		this.id = id;
		this.hospitalId = hospitalId;
		deptName = name;
	}
	public Department() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHospitalId() {
		return hospitalId;
	}
	public void setHospitalId(int hospitalId) {
		this.hospitalId = hospitalId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	
}
