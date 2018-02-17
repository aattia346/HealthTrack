package com.gp.user;

public class Hospital extends User{

	int id, adminId;
	String name, phone, website, address, intro;
	float lat, lang, review;

	public Hospital() {
		super();
	}

	
	
	public Hospital(int id, int adminId, String name, String phone, String website, String address, String intro,
			float lat, float lang, float review) {
		super();
		this.id = id;
		this.adminId = adminId;
		this.name = name;
		this.phone = phone;
		this.website = website;
		this.address = address;
		this.intro = intro;
		this.lat = lat;
		this.lang = lang;
		this.review = review;
	}

	public String getIntro() {
		return intro;
	}



	public void setIntro(String intro) {
		this.intro = intro;
	}



	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public float getLat() {
		return lat;
	}

	public void setLat(float lat) {
		this.lat = lat;
	}

	public float getLang() {
		return lang;
	}

	public void setLang(float lang) {
		this.lang = lang;
	}

	public float getReview() {
		return review;
	}

	public void setReview(float review) {
		this.review = review;
	}
	
	
	
}
