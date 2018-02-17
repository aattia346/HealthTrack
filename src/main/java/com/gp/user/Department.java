package com.gp.user;

public class Department {
	
	int id, hospitalId;
	String Name;
	public Department(int id, int hospitalId, String name) {
		super();
		this.id = id;
		this.hospitalId = hospitalId;
		Name = name;
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
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	
	

}
