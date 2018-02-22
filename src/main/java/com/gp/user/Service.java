package com.gp.user;

import java.util.Date;

public class Service extends Department{
	
	int id;
	String serviceName;
	int centerId;
	int deptId;
	Date bookedTill;
	Date lastUpdated;
	String fees;
	float serviceReview;

	public Service(int id, String name, int centerId, int deptId, Date bookedTill, Date lastUpdated) {
		super();
		this.id = id;
		this.serviceName = name;
		this.centerId = centerId;
		this.deptId = deptId;
		this.bookedTill = bookedTill;
		this.lastUpdated = lastUpdated;
	}

	public Service() {
		super();
	}

	public float getServiceReview() {
		return serviceReview;
	}

	public void setServiceReview(float serviceReview) {
		this.serviceReview = serviceReview;
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

	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
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

}
