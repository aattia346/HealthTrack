package com.gp.user;

public class Center extends User{
	
	int centerId, adminId;
	String CenterName, phone, website, address, intro, googleMapsUrl;
	float lat, lang, review;
	public int getCenterId() {
		return centerId;
	}
	public void setCenterId(int centerId) {
		this.centerId = centerId;
	}
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public String getCenterName() {
		return CenterName;
	}
	public void setCenterName(String centerName) {
		CenterName = centerName;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getGoogleMapsUrl() {
		return googleMapsUrl;
	}
	public void setGoogleMapsUrl(String googleMapsUrl) {
		this.googleMapsUrl = googleMapsUrl;
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
	public Center(int centerId, int adminId, String centerName, String phone, String website, String address,
			String intro, String googleMapsUrl, float lat, float lang, float review) {
		super();
		this.centerId = centerId;
		this.adminId = adminId;
		CenterName = centerName;
		this.phone = phone;
		this.website = website;
		this.address = address;
		this.intro = intro;
		this.googleMapsUrl = googleMapsUrl;
		this.lat = lat;
		this.lang = lang;
		this.review = review;
	}
	public Center() {
		super();
	}
	
}
