package com.gp.user;

public class Person extends User{
	
	public int userId;
	public String username;
	public String password;
	public String type;
	public int verificationCode;
	public String firstName;
	public String lastName;
	public String email;
	public String phone;
	public int verified;
	
	
	public Person(int userId, String firstName, String lastName, String email, String phone, int verified) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.verified = verified;
	}

	public Person(int userId, String username, String password, String type, int verificationCode, String firstName,
			String lastName, String email, String phone, int verified) {
		super();
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.type = type;
		this.verificationCode = verificationCode;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.verified = verified;
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
