package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

public class HospitalDao {
	
	public static Hospital getHospitalById(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM hospital WHERE admin_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		Hospital hospital = new Hospital(result.getInt("hospital_id"), id, result.getString("hospital_name"), result.getString("phone"),
										result.getString("website"), result.getString("address"), result.getString("intro"),
										result.getString("google_maps_url"),result.getFloat("lat"), result.getFloat("lang"), result.getFloat("hospital_review"));
		return hospital;
	}
	
	public static List<Department> getDeptsByHospitalID(int hospitalId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM department WHERE hospital_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, hospitalId);
		ResultSet result = ps.executeQuery();
		List<Department> list = new ArrayList<Department>();
		while(result.next()) {
			Department d = new Department(result.getInt("department_id"), result.getInt("hospital_id"), result.getString("dept_name"));
			list.add(d);
		}
		return list;
	}

	public static List<Hospital> getAllHospitals()
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM hospital";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet result = ps.executeQuery();
		List<Hospital> hospitals = new ArrayList<Hospital>();
		while(result.next()) {
			Hospital hospital = new Hospital();
			hospital.setHospitalId(result.getInt("hospital_id"));
			hospital.setAdminId(result.getInt("admin_id"));
			hospital.setHospitalName(result.getString("hospital_name"));
			hospital.setLat(result.getFloat("lat"));
			hospital.setLang(result.getFloat("lang"));
			hospital.setPhone(result.getString("phone"));
			hospital.setWebsite(result.getString("website"));
			hospital.setReview(result.getFloat("hospital_review"));
			hospital.setAddress(result.getString("address"));
			hospital.setIntro(result.getString("intro"));
			hospital.setGoogleMapsUrl(result.getString("google_maps_url"));
			hospitals.add(hospital);
			}
		return hospitals;
			
			}

	public static List<Department> getAllDepts() 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM department JOIN hospital on Department.hospital_id = hospital.hospital_id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		List<Department> list = new ArrayList<Department>();
		while(result.next()) {
			Department d = new Department(result.getInt("department_id"), result.getInt("hospital_id"), result.getString("dept_name"));
			d.setHospitalName(result.getString("hospital_name"));
			d.setAdminId(result.getInt("admin_id"));
			list.add(d);
		}
		return list;
	}

	
	public static void insertHospital(Hospital hospital)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		
		System.out.println("insert");
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO hospital "
				+ "(hospital_name, admin_id, lat, lang, phone, website, address, intro, google_maps_url) "
				+ "VALUES(?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, hospital.getHospitalName());
		ps.setInt(2, hospital.getAdminId());
		ps.setFloat(3, hospital.getLat());
		ps.setFloat(4, hospital.getLang());
		ps.setString(5, hospital.getPhone());
		ps.setString(6, hospital.getWebsite());
		ps.setString(7, hospital.getAddress());
		ps.setString(8, hospital.getIntro());
		ps.setString(9, hospital.getGoogleMapsUrl());
		
		ps.executeUpdate();
		
	}
}
