package com.gp.user;

import java.sql.Time;

public class Appointment extends Service{
	
	int appointmenId, available, bookedSessions, clinicId;
	String day;
	Time appFrom, appTo;
	
	public int getAppointmenId() {
		return appointmenId;
	}
	public void setAppointmenId(int appointmenId) {
		this.appointmenId = appointmenId;
	}
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	public int getBookedSessions() {
		return bookedSessions;
	}
	public void setBookedSessions(int bookedSessions) {
		this.bookedSessions = bookedSessions;
	}
	public int getClinicId() {
		return clinicId;
	}
	public void setClinicId(int clinicId) {
		this.clinicId = clinicId;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Time getAppFrom() {
		return appFrom;
	}
	public void setAppFrom(Time appFrom) {
		this.appFrom = appFrom;
	}
	public Time getAppTo() {
		return appTo;
	}
	public void setAppTo(Time appTo) {
		this.appTo = appTo;
	}

}