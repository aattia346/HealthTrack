package com.gp.user;

public class Pharmacy {
	
	int pharmacyId, adminId;
	String pharmacyName, phone, address, google_maps_url,website,intro;
	float lat, lang, review;
	
	public Pharmacy() {
		super();
	}
	public Pharmacy(int pharmacyId,int adminId,String pharmacyName,String phone,String address,String google_maps_url,String website,
			String intro,float lat ,float lang ,float review) {
		super();
		this.pharmacyId=pharmacyId;
		this.adminId=adminId;
		this.pharmacyName=pharmacyName;
		this.phone=phone;
		this.address=address;
		this.google_maps_url=google_maps_url;
		this.website=website;
		this.lat=lat;
		this.lang=lang;
		this.review=review;
		this.intro=intro;
	}

	public int getPharmacyId() {
		return pharmacyId;
	}

	public void setPharmacyId(int pharmacyId) {
		this.pharmacyId = pharmacyId;
	}

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public String getPharmacyName() {
		return pharmacyName;
	}

	public void setPharmacyName(String pharmacyName) {
		this.pharmacyName = pharmacyName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGoogle_maps_url() {
		return google_maps_url;
	}

	public void setGoogle_maps_url(String google_maps_url) {
		this.google_maps_url = google_maps_url;
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
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	

	
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}

	
}
