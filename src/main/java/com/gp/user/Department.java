package com.gp.user;

public class Department extends Hospital{
	
	int deptId, hospitalId;
	String deptName;

	
	public Department(int deptId, int hospitalId, String deptName) {
		super();
		this.deptId = deptId;
		this.hospitalId = hospitalId;
		this.deptName = deptName;
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	public Department() {
		super();
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
