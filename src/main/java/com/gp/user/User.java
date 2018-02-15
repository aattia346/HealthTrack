package com.gp.user;

public class User {
	
	public int id;
	public String username;
	public String password;
	public String type;
	public int verificationCode;
	
	public User() {
		super();
	}

	public User(String username, String password, String type, int verificationCode) {
		super();
		this.username = username;
		this.password = password;
		this.type = type;
		this.verificationCode = verificationCode;
	}

	public User(int id, String username, String password, String type, int verificationCode) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.type = type;
		this.verificationCode = verificationCode;
	}

	public User(int id, String username, String password, String type) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.type = type;
	}

	public int getVerificationCode() {
		return verificationCode;
	}

	public void setVerificationCode(int verificationCode) {
		this.verificationCode = verificationCode;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	
	
}
