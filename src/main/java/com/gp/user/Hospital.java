package com.gp.user;

public class Hospital extends User{

	int hospitalId, adminId;
	String hospitalName, phone, website, address, intro, googleMapsUrl;
	float lat, lang, review;

	public Hospital() {
		super();
	}
	
	

	public Hospital(int hospitalId, int adminId, String hospitalName, String phone, String website, String address,
			String intro, String googleMapsUrl, float lat, float lang, float review) {
		super();
		this.hospitalId = hospitalId;
		this.adminId = adminId;
		this.hospitalName = hospitalName;
		this.phone = phone;
		this.website = website;
		this.address = address;
		this.intro = intro;
		this.googleMapsUrl = googleMapsUrl;
		this.lat = lat;
		this.lang = lang;
		this.review = review;
	}



	public String getIntro() {
		return intro;
	}

	public String getGoogleMapsUrl() {
		return googleMapsUrl;
	}

	public void setGoogleMapsUrl(String googleMapsUrl) {
		this.googleMapsUrl = googleMapsUrl;
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


	

	public int getHospitalId() {
		return hospitalId;
	}



	public void setHospitalId(int hospitalId) {
		this.hospitalId = hospitalId;
	}



	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	
	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
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
