package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class ClinicDao {
	
	public static List<Clinic> getAllClinics() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM clinic";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet result = ps.executeQuery();
		List<Clinic> clinics = new ArrayList<Clinic>();
		while(result.next()) {
			Clinic clinic = new Clinic();
			
			clinic.setClinicId(result.getInt("clinic_id"));
			clinic.setClinicName(result.getString("clinic_name"));
			clinic.setDoctorName(result.getString("doctor_clinic_name"));
			clinic.setSpecialty(result.getString("specialty"));
			clinic.setPhone(result.getString("phone"));
			clinic.setAddress(result.getString("address"));
			clinic.setGoogle_maps_url(result.getString("google_maps_url"));
			clinic.setLat(result.getFloat("lat"));
			clinic.setLang(result.getFloat("lang"));
			clinic.setAdminId(result.getInt("admin_id"));
			clinic.setReview(result.getFloat("review"));
			clinic.setIntro(result.getString("intro"));
			clinic.setSpecialty(result.getString("specialty"));
			clinic.setWebsite(result.getString("website"));
			clinic.setNumOfSessions(result.getInt("number_of_sessions"));
			clinic.setFees(result.getString("fees"));
			
			clinics.add(clinic);
		}
		con.close();
		return clinics;
	}

	public static Clinic getClinicById(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM clinic WHERE admin_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		Clinic clinic= new Clinic();
		clinic.setClinicId(result.getInt("clinic_id"));
		clinic.setClinicName(result.getString("clinic_name"));
		clinic.setDoctorName(result.getString("doctor_clinic_name"));
		clinic.setSpecialty(result.getString("specialty"));
		clinic.setPhone(result.getString("phone"));
		clinic.setAddress(result.getString("address"));
		clinic.setGoogle_maps_url(result.getString("google_maps_url"));
		clinic.setLat(result.getFloat("lat"));
		clinic.setLang(result.getFloat("lang"));
		clinic.setAdminId(result.getInt("admin_id"));
		clinic.setReview(result.getFloat("review"));
		clinic.setIntro(result.getString("intro"));
		clinic.setSpecialty(result.getString("specialty"));
		clinic.setWebsite(result.getString("website"));
		clinic.setDoctorName(result.getString("doctor_clinic_name"));
		clinic.setSpecialty(result.getString("specialty"));
		clinic.setWebsite(result.getString("website"));
		clinic.setNumOfSessions(result.getInt("number_of_sessions"));
		clinic.setFees(result.getString("fees"));
		con.close();
		return clinic;
	}
	
	public static void insertClinic(Clinic clinic)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO clinic "
				+ "(clinic_name, admin_id, lat, lang, phone, website, address, intro, google_maps_url, doctor_clinic_name, specialty, fees) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, clinic.getClinicName());
		ps.setInt(2, clinic.getAdminId());
		ps.setFloat(3, clinic.getLat());
		ps.setFloat(4, clinic.getLang());
		ps.setString(5,clinic.getPhone());
		ps.setString(6, clinic.getWebsite());
		ps.setString(7,clinic.getAddress());
		ps.setString(8, clinic.getIntro());
		ps.setString(9, clinic.getGoogle_maps_url());
		ps.setString(10, clinic.getDoctorName());
		ps.setString(11, clinic.getSpecialty());
		ps.setString(12, clinic.getFees());		
		
		ps.executeUpdate();
		con.close();
	}

	public static void deleteSomthing(String table, String column, int value) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="DELETE FROM " + table + " WHERE " + column + " = " + value;
		PreparedStatement ps = con.prepareStatement(sql);
		ps.executeUpdate();
		con.close();
	}

	public static void updateClinic(Clinic clinic)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE clinic "
				+ "SET clinic_name=?, admin_id=?, lat=?, lang=?, phone=?, website=?, address=?, intro=?, google_maps_url=?,doctor_clinic_name=?,specialty=? ,fees=? "
				+ "WHERE clinic_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, clinic.getClinicName());
		ps.setInt(2, clinic.getAdminId());
		ps.setFloat(3, clinic.getLat());
		ps.setFloat(4, clinic.getLang());
		ps.setString(5, clinic.getPhone());
		ps.setString(6, clinic.getWebsite());
		ps.setString(7, clinic.getAddress());
		ps.setString(8, clinic.getIntro());
		ps.setString(9, clinic.getGoogle_maps_url());
		ps.setString(10, clinic.getDoctorName());
		ps.setString(11, clinic.getSpecialty());
		ps.setInt(12, clinic.getClinicId());
		ps.setString(13, clinic.getFees());
		
		ps.executeUpdate();
		con.close();
	}

	public static HashMap<String,Appointment> getAppointmentOfClinic(int clinicId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
	
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM appointment where clinic_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clinicId);
		ResultSet result = ps.executeQuery();
		
		HashMap<String,Appointment> apps = new HashMap<String,Appointment>();
		
		while(result.next()) {
			Appointment app = new Appointment();
			app.setAppointmenId(result.getInt("appointment_id"));
			app.setDay(result.getString("app_day"));
			app.setDayDate(result.getDate("day_date"));
			app.setAppFrom(result.getTime("app_from"));
			app.setAppTo(result.getTime("app_to"));
			app.setClinicId(result.getInt("clinic_id"));
			app.setAvailable(result.getInt("available"));
			app.setBookedSessions(result.getInt("booked_sessions"));
			
			apps.put(result.getString("app_day"),app);
		}
		con.close();
		return apps;
	}
	
	public static boolean checkUserReviewOfClinic(int userId, int clinicId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM review WHERE clinic_id=? AND user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clinicId);
		ps.setInt(2, userId);
		ResultSet result = ps.executeQuery();
		result.next();
		boolean exists = result.getRow()>0;		
		con.close();
		
		return exists;		
	}

	public static void updateUserClinicReview(int userId, int clinicId, int review) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql2 ="UPDATE review SET review=? WHERE clinic_id=? AND user_id=?";
		PreparedStatement ps2 = con.prepareStatement(sql2);
		ps2.setInt(1, review);
		ps2.setFloat(2, clinicId);
		ps2.setInt(3, userId);
		ps2.executeUpdate();
		
		con.close();	
		
	}

	public static void setClinicReview(int userId, int clinicId, int review) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO review (user_id, clinic_id, review) VALUES(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ps.setInt(2, clinicId);
		ps.setInt(3, review);
		ps.executeUpdate();
		con.close();
		
	}

	public static void updateClinicReview(int clinicId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE clinic SET review = (SELECT AVG(review) FROM review WHERE clinic_id=? AND review != 0) WHERE clinic_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clinicId);
		ps.setInt(2, clinicId);
		ps.executeUpdate();
		con.close();
		
	}

	public static void insertComment(int userId, int clinicId, String comment) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO review (user_id, clinic_id, comment) VALUES(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ps.setInt(2, clinicId);
		ps.setString(3, comment);
		ps.executeUpdate();
		con.close();
		
	}
	
	public static List<Review> get5Comments(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		List<Review> reviews = new ArrayList<Review>();
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM review JOIN person ON person.user_id  = review.user_id"
				+ " WHERE clinic_id=? AND show_comment = 1 AND comment IS NOT NULL"
				+ " ORDER BY review_id DESC LIMIT 5";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
				
		while(result.next()) {
			Review review = new Review();
			review.setUserFirstName(result.getString("firstname"));
			review.setUserLastName(result.getString("lastname"));
			review.setComment(result.getString("comment"));
			reviews.add(review);
		}
		return reviews;
	}

	public static boolean isTheUserAuthorized(String username, int clinicId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		
		String sql = "SELECT * FROM clinic JOIN user ON clinic.admin_id = user.user_id"
					+ " WHERE username=? AND clinic_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, username);
		ps.setInt(2, clinicId);
		
		ResultSet result = ps.executeQuery();
		
		result.next();
		
		return result.getInt("admin_id") == result.getInt("user_id");	
	}
	
	public static List<Review> getClinicReviews(int clinicId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM review JOIN person ON person.user_id  = review.user_id" + 
				" WHERE clinic_id=? AND comment IS NOT NULL";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clinicId);
		ResultSet result = ps.executeQuery();
		
		List<Review> reviews =new ArrayList <Review>();
		while(result.next()) {
			Review review =new Review();
			review.setReviewId(result.getInt("review_id"));
			review.setReview(result.getFloat("review"));
			review.setUserId(result.getInt("user_id"));
			review.setComment(result.getString("comment"));
			review.setUserFirstName(result.getString("firstname"));
			review.setUserLastName(result.getString("lastname"));
			review.setClinicId(result.getInt("clinic_id"));
			review.setServiceId(result.getInt("service_id"));
			review.setShowComment(result.getInt("show_comment"));
			review.setTime(result.getDate("time_of_comment"));
			reviews.add(review);
		}
		return reviews;	
	}


	public static Booking getBookingOfClinicById(int bookingId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking" + " JOIN clinic ON booking.clinic_id=clinic.clinic_id"
				+ " WHERE booking.booking_id=? LIMIT 1";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);

		ResultSet result = ps.executeQuery();
		result.next();

		Booking B = new Booking();
		B.setBookingId(result.getInt("booking_id"));
		B.setUserId(result.getInt("user_id"));
		B.setFirstName(result.getString("firstname"));
		B.setLastName(result.getString("lastname"));
		B.setAge(result.getInt("age"));
		B.setDateFrom(result.getDate("date_from"));
		B.setDateTo(result.getDate("date_to"));
		B.setTimeFrom(result.getTime("time_from"));
		B.setDayOfBooking(result.getDate("day_of_time"));
		B.setStatus(result.getInt("status"));
		B.setTimeOfBooking(result.getDate("time_of_booking"));
		B.setBookingPhone(result.getString("booking_phone"));
		B.setAdminId(result.getInt("admin_id"));

		con.close();
		return B;
	}

}
