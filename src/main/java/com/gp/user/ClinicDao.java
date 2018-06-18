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
			//clinic.setFees(result.getFloat("fees"));
			
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
		//clinic.setFees(result.getFloat("fees"));
		con.close();
		return clinic;
	}
	
	public static void insertClinic(Clinic clinic)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO clinic "
				+ "(clinic_name, admin_id, lat, lang, phone, website, address, intro, google_maps_url,doctor_clinic_name,specialty) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
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
		//ps.setFloat(11, clinic.getFees());		
		
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
				+ "SET clinic_name=?, admin_id=?, lat=?, lang=?, phone=?, website=?, address=?, intro=?, google_maps_url=?,doctor_clinic_name=?,specialty=? "
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
		//ps.setFloat(13, clinic.getFees());
		
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
		String sql="UPDATE clinic SET review = (SELECT AVG(review) FROM review WHERE clinic_id=?) WHERE clinic_id=?";
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
	
}
