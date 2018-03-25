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
		Hospital hospital = new Hospital(result.getInt(1), id, result.getString(2), result.getString(6),
										result.getString(7), result.getString(9), result.getString(10),
										result.getString(10),result.getFloat(4), result.getFloat(5), result.getFloat(8));
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
		//result.next();
		while(result.next()) {
			Department d = new Department(result.getInt("department_id"), result.getInt("hospital_id"), result.getString("name"));
			list.add(d);
		}
		return list;
	}
	
	public static List<Service> getServicesByDeptID(int deptId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service WHERE dept_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, deptId);
		ResultSet result = ps.executeQuery();
		List<Service> list = new ArrayList<Service>();
		while(result.next()) {
			Service s = new Service(result.getInt(1), result.getString(2), result.getInt(3), result.getInt(4), 
					result.getDate(5), result.getString(7), result.getFloat(8));
			list.add(s);
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
					hospital.setHospitalId(result.getInt("id"));
					hospital.setAdminId(result.getInt("admin_id"));
					hospital.setHospitalName(result.getString("name"));
					hospital.setLat(result.getFloat("lat"));
					hospital.setLang(result.getFloat("lang"));
					hospital.setPhone(result.getString("phone"));
					hospital.setWebsite(result.getString("website"));
					hospital.setReview(result.getFloat("review"));
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
		String sql="SELECT * FROM department JOIN hospital on Department.hospital_id = hospital.id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		List<Department> list = new ArrayList<Department>();
		while(result.next()) {
			Department d = new Department(result.getInt("department_id"), result.getInt("hospital_id"), result.getString("name"));
			d.setHospitalName(result.getString(5));
			d.setAdminId(result.getInt("admin_id"));
			list.add(d);
		}
		return list;
	}
}
