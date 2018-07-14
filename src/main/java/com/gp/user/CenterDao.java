package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class CenterDao {
	
	public static Center getCenterById(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM center WHERE admin_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		Center center= new Center();
		center.setCenterId(result.getInt("center_id"));
		center.setCenterName(result.getString("center_name"));
		center.setAdminId(result.getInt("admin_id"));
		center.setLat(result.getFloat("lat"));
		center.setLang(result.getFloat("lang"));
		center.setPhone(result.getString("phone"));
		center.setWebsite(result.getString("website"));
		center.setReview(result.getFloat("center_review"));
		center.setAddress(result.getString("address"));
		center.setIntro(result.getString("intro"));
		center.setGoogleMapsUrl(result.getString("google_maps_url"));
		center.setDimmed(result.getInt("dimmed"));
		
		return center;
	}
	

	public static List<Center> getAllCenters()
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM center";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet result = ps.executeQuery();
		List<Center> centers = new ArrayList<Center>();
		while(result.next()) {
			Center center = new Center();
			center.setCenterId(result.getInt("center_id"));
			center.setCenterName(result.getString("center_name"));
			center.setAdminId(result.getInt("admin_id"));
			center.setLat(result.getFloat("lat"));
			center.setLang(result.getFloat("lang"));
			center.setPhone(result.getString("phone"));
			center.setWebsite(result.getString("website"));
			center.setReview(result.getFloat("center_review"));
			center.setAddress(result.getString("address"));
			center.setIntro(result.getString("intro"));
			center.setGoogleMapsUrl(result.getString("google_maps_url"));
			center.setDimmed(result.getInt("dimmed"));
			centers.add(center);
		}
		return centers;
	
	}
	
	public static void updateCenter(Center center)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE center "
				+ "SET center_name=?, admin_id=?, lat=?, lang=?, phone=?, website=?, address=?, intro=?, google_maps_url=? "
				+ "WHERE center_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1,center.getCenterName());
		ps.setInt(2, center.getAdminId());
		ps.setFloat(3, center.getLat());
		ps.setFloat(4, center.getLang());
		ps.setString(5, center.getPhone());
		ps.setString(6, center.getWebsite());
		ps.setString(7, center.getAddress());
		ps.setString(8, center.getIntro());
		ps.setString(9,center.getGoogleMapsUrl());
		ps.setInt(10,center.getCenterId());
		
		ps.executeUpdate();
		
	}
	
	public static void insertCenter(Center center)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO center "
				+ "(center_name, admin_id, lat, lang, phone, website, address, intro, google_maps_url) "
				+ "VALUES(?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, center.getCenterName());
		ps.setInt(2, center.getAdminId());
		ps.setFloat(3, center.getLat());
		ps.setFloat(4, center.getLang());
		ps.setString(5, center.getPhone());
		ps.setString(6, center.getWebsite());
		ps.setString(7,center.getAddress());
		ps.setString(8, center.getIntro());
		ps.setString(9, center.getGoogleMapsUrl());
		
		ps.executeUpdate();
		
	}
	public static void inserDimmedtCenter(Center center)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO center "
				+ "(center_name, admin_id, lat, lang, phone, website, address, intro, google_maps_url,dimmed) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, center.getCenterName());
		ps.setInt(2, center.getAdminId());
		ps.setFloat(3, center.getLat());
		ps.setFloat(4, center.getLang());
		ps.setString(5, center.getPhone());
		ps.setString(6, center.getWebsite());
		ps.setString(7,center.getAddress());
		ps.setString(8, center.getIntro());
		ps.setString(9, center.getGoogleMapsUrl());
		ps.setInt(10, center.getDimmed());
		
		ps.executeUpdate();
		
	}
	
	public static List<String> getServices(){
		
		List<String> services = new ArrayList<String>();
		services.add("MRI");
		services.add("ICU");
		services.add("CT");
		
		return services;
	}

	public static void insertService(String service, int centerId)
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO `service`( `name`,`dept_id`) VALUES(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, centerId);
		ps.setString(2, service);
		
		ps.executeUpdate();
	}

	public static int countCenters() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();		
		String sql = "SELECT COUNT(center_id) AS NumOfUsers FROM center";
		PreparedStatement ps = con.prepareStatement(sql);		
		ResultSet result = ps.executeQuery();	
		result.next();
		
		int numOfUsers = result.getInt("NumOfUsers");
		
		con.close();
		
		return numOfUsers;
		
	}
	
}

	

