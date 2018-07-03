package com.gp.user;

import java.util.Date;

public class Review {
	private int reviewId;
	private int userId ;
	private int serviceId ;
	private String comment, userFirstName, userLastName ;
	private float review ;
	private int clinicId;
	private int showComment;
	private Date time;
	
	
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getUserFirstName() {
		return userFirstName;
	}
	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}
	public String getUserLastName() {
		return userLastName;
	}
	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getServiceId() {
		return serviceId;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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
	public int getShowComment() {
		return showComment;
	}
	public void setShowComment(int showComment) {
		this.showComment = showComment;
	}
	

}

