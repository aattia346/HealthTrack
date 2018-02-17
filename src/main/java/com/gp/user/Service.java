package com.gp.user;

import java.util.Date;

public class Service {
	
	int id;
	String name;
	int centerId;
	int deptId;
	String fees;
	Date bookedTill = new Date();
	Date lastUpdate = new Date();
	
	public Service(int id, String name, int centerId, int deptId, String fees, Date bookedTill, Date lastUpdate) {
		super();
		this.id = id;
		this.name = name;
		this.centerId = centerId;
		this.deptId = deptId;
		this.fees = fees;
		this.bookedTill = bookedTill;
		this.lastUpdate = lastUpdate;
	}

	public Service() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCenterId() {
		return centerId;
	}

	public void setCenterId(int centerId) {
		this.centerId = centerId;
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	public String getFees() {
		return fees;
	}

	public void setFees(String fees) {
		this.fees = fees;
	}

	public Date getBookedTill() {
		return bookedTill;
	}

	public void setBookedTill(Date bookedTill) {
		this.bookedTill = bookedTill;
	}

	public Date getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	
	
}
