package com.gp.user;

public class Location {

	float lat, lang;
	String name, type, url, pinColor;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public Location(float lat, float lang, String name, String type, String url, String pinColor) {
		super();
		this.lat = lat;
		this.lang = lang;
		this.name = name;
		this.type = type;
		this.url = url;
		this.pinColor = pinColor;
	}
	public String getPinColor() {
		return pinColor;
	}
	public void setPinColor(String pinColor) {
		this.pinColor = pinColor;
	}
	public Location() {
		super();
	}
	
	
}
