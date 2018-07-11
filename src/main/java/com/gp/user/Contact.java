package com.gp.user;

public class Contact {
	
	private int contactId;
	
	private String name, email, msg;
	
	public Contact(String name, String email, String msg) {
		super();
		this.name = name;
		this.email = email;
		this.msg = msg;
	}

	public Contact() {
		super();
	}

	public int getContactId() {
		return contactId;
	}

	public void setContactId(int contactId) {
		this.contactId = contactId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
