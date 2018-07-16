package com.gp.user;

public class Person extends User{
	
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private int verified;
	private int bookingsPerDay;
	
	
	public int getBookingsPerDay() {
		return bookingsPerDay;
	}

	public void setBookingsPerDay(int bookingsPerDay) {
		this.bookingsPerDay = bookingsPerDay;
	}

	public Person() {
		super();
	}
	
	public int getVerified() {
		return verified;
	}


	public void setVerified(int verified) {
		this.verified = verified;
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


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
