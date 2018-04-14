package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class HospitalDao {
	
	public static Hospital getHospitalById(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM hospital WHERE admin_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
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

	public static void deleteSomthing(String table, String column, int value) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="DELETE FROM " + table + " WHERE " + column + " = " + value;
		PreparedStatement ps = con.prepareStatement(sql);
		ps.executeUpdate();
	}

	public static void insertHospital(Hospital hospital)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
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
	
	public static List<String> getDepts(){
		
		List<String> depts = new ArrayList<String>();
		depts.add("Radiology");
		depts.add("ICU");
		depts.add("Neonatal intensive care");
		
		return depts;
	}

	public static void insertDepartment(String dept, int hospitalId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO department "
				+ "(hospital_id, dept_name) "
				+ "VALUES(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, hospitalId);
		ps.setString(2, dept);
		
		ps.executeUpdate();
	}
	
	public static boolean checkIfTheDepartmentExists(String deptName, int hospitalId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		boolean exist=false;
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM department WHERE dept_name=? AND hospital_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, deptName);
		ps.setInt(2, hospitalId);
		
		ResultSet result = ps.executeQuery();
		result.next();
		if(result.getRow()>0) {
			exist = true;
		}
		
		return exist;
	}

	
	public static void updateHospital(Hospital hospital)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE hospital "
				+ "SET hospital_name=?, admin_id=?, lat=?, lang=?, phone=?, website=?, address=?, intro=?, google_maps_url=? "
				+ "WHERE hospital_id=?";
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
		ps.setInt(10, hospital.getHospitalId());
		
		ps.executeUpdate();
		
	}
	
}
