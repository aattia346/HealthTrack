package com.gp.user;

import java.util.Date;

public class Service extends Department {
	
	int serviceId;
	String serviceName;
	int centerId;
	int deptId;
	Date lastUpdated;
	String fees;
	float serviceReview;
	Date available_from;
	Date available_to;
	String centerName;
	int slotType;         // 1 means day && 2 means time

	public String getCenterName() {
		return centerName;
	}

	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}


	public int getSlotType() {
		return slotType;
	}

	public void setSlotType(int slotType) {
		this.slotType = slotType;
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
	
	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	
	public int getServiceId() {
		return serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
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
	public Date getAvailable_from() {
		return available_from;
	}

	public void setAvailable_from(Date available_from) {
		this.available_from = available_from;
	}
	
	public Date getAvailable_to() {
		return available_from;
	}

	public void setAvailable_to(Date available_to) {
		this.available_to = available_to;
	}


}
