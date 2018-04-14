package com.gp.user;

public class Person extends User{
	
	private int userId;
	private String username;
	private String password;
	private String type;
	private int verificationCode;
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
	
	public int getVerificationCode() {
		return verificationCode;
	}

	public void setVerificationCode(int verificationCode) {
		this.verificationCode = verificationCode;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public int getVerified() {
		return verified;
	}


	public void setVerified(int verified) {
		this.verified = verified;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
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
