package com.gp.user;

public class Pharmacy {
	
	int pharmacyId, adminId;
	String pharmacyName, phone, adress, google_maps_url;
	float lat, lang, review;
	
	public Pharmacy() {
		super();
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

	public String getAdress() {
		return adress;
	}

	public void setAdress(String adress) {
		this.adress = adress;
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
	
}
