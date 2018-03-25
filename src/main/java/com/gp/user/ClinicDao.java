package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

public class ClinicDao {
	
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
			clinic.setAdress(result.getString("address"));
			clinic.setGoogle_maps_url(result.getString("google_maps_url"));
			clinic.setLat(result.getFloat("lat"));
			clinic.setLang(result.getFloat("lang"));
			clinic.setAdminId(result.getInt("admin_id"));
			clinic.setReview(result.getFloat("review"));
			
			clinics.add(clinic);
		}
		return clinics;
	}
	
}
