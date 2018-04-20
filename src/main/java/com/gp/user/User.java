package com.gp.user;

public class User {
	
	int id, verificationCode, ban;
	String username, password, type;
	
	public User() {
		super();
	}
	
	public int getBan() {
		return ban;
	}

	public void setBan(int ban) {
		this.ban = ban;
	}

	public User(int id, String username, String type) {
		super();
		this.id = id;
		this.username = username;
		this.type = type;
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
