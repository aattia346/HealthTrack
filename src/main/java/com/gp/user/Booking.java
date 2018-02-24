package com.gp.user;

import java.util.Date;

public class Booking extends Service{

	int bookingId, serviceId, userId;
	String firstName, lastName, bookingPhone;
	int age;
	Date dateFrom, dateTo, timeFrom, timeTo, timeOfBooking;
	int status;
	
	public Booking(int bookingId, int serviceId, int userId, String firstName, String lastName, int age, Date dateFrom,
			Date dateTo, Date timeFrom, Date timeTo, int status, Date timeOfBooking, String bookingPhone) {
		super();
		this.bookingId = bookingId;
		this.serviceId = serviceId;
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.age = age;
		this.dateFrom = dateFrom;
		this.timeOfBooking = timeOfBooking;
		this.dateTo = dateTo;
		this.timeFrom = timeFrom;
		this.timeTo = timeTo;
		this.status = status;
		this.bookingPhone = bookingPhone;
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
	public Date getTimeFrom() {
		return timeFrom;
	}
	public void setTimeFrom(Date timeFrom) {
		this.timeFrom = timeFrom;
	}
	public Date getTimeTo() {
		return timeTo;
	}
	public void setTimeTo(Date timeTo) {
		this.timeTo = timeTo;
	}
	
}
