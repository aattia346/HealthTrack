package com.gp.user;

public class Clinic {
	
	int clinicId, adminId;
	String clinicName, doctorName, specialty, phone, address, google_maps_url,intro,website;
	float lat, lang, review;
	
	public Clinic() {
		super();
	}
	
	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public float getReview() {
		return review;
	}

	public void setReview(float review) {
		this.review = review;
	}

	public int getClinicId() {
		return clinicId;
	}

	public void setClinicId(int clinicId) {
		this.clinicId = clinicId;
	}

	public String getClinicName() {
		return clinicName;
	}

	public void setClinicName(String clinicName) {
		this.clinicName = clinicName;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}


	public String getSpecialty() {
		return specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
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

	public void setAddress(String adress) {
		this.address = adress;
	}
	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
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
		
}
