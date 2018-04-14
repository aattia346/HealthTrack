package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
			
			clinics.add(clinic);
		}
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
		
		ps.executeUpdate();
		
	}
public static List<String> getServices(){
		
		List<String> services = new ArrayList<String>();
		services.add("MRI");
		services.add("ICU");
		services.add("CT");
		
		return services;
	}
public static void deleteSomthing(String table, String column, int value) 
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
	Connection con = DBConnection.getConnection();
	String sql="DELETE FROM " + table + " WHERE " + column + " = " + value;
	PreparedStatement ps = con.prepareStatement(sql);
	ps.executeUpdate();
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
	
	ps.executeUpdate();
	
}



	
}
