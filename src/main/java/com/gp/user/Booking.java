package com.gp.user;

import java.sql.Time;
import java.util.Date;

public class Booking extends Service{

	int bookingId, serviceId, userId;
	String firstName, lastName, bookingPhone, msg, sex;
	int age, clinicId;
	Date dateFrom, dateTo, dayOfBooking, timeOfBooking;
	Time timeFrom;
	int status;
	
	
	public int getClinicId() {
		return clinicId;
	}
	public void setClinicId(int clinicId) {
		this.clinicId = clinicId;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBookingPhone() {
		return bookingPhone;
	}
	public void setBookingPhone(String bookingPhone) {
		this.bookingPhone = bookingPhone;
	}
	public int getStatus() {
		return status;
	}
	public Date getTimeOfBooking() {
		return timeOfBooking;
	}
	public void setTimeOfBooking(Date timeOfBooking) {
		this.timeOfBooking = timeOfBooking;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Booking() {
		super();
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public int getServiceId() {
		return serviceId;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public Date getDateFrom() {
		return dateFrom;
	}
	public void setDateFrom(Date dateFrom) {
		this.dateFrom = dateFrom;
	}
	public Date getDateTo() {
		return dateTo;
	}
	public void setDateTo(Date dateTo) {
		this.dateTo = dateTo;
	}

	public Date getDayOfBooking() {
		return dayOfBooking;
	}
	public void setDayOfBooking(Date dayOfBooking) {
		this.dayOfBooking = dayOfBooking;
	}
	public Time getTimeFrom() {
		return timeFrom;
	}
	public void setTimeFrom(Time timeFrom) {
		this.timeFrom = timeFrom;
	}
}
