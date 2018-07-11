package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class PharmacyDao {
	
public static List<Pharmacy> getAllPharmacies() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM pharmacy";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet result = ps.executeQuery();
		List<Pharmacy> pharmacies = new ArrayList<Pharmacy>();
		while(result.next()) {
			Pharmacy pharmacy = new Pharmacy();
			
			pharmacy.setPharmacyId(result.getInt("pharmacy_id"));
			pharmacy.setPharmacyName(result.getString("pharmacy_name"));
			pharmacy.setPhone(result.getString("phone"));
			pharmacy.setAddress(result.getString("address"));
			pharmacy.setGoogle_maps_url(result.getString("google_maps_url"));
			pharmacy.setLat(result.getFloat("lat"));
			pharmacy.setLang(result.getFloat("lang"));
			pharmacy.setAdminId(result.getInt("admin_id"));
			pharmacy.setWebsite(result.getString("website"));


			pharmacies.add(pharmacy);
		}
		return pharmacies;
	}
public static Pharmacy getPharmacyById(int id) throws InstantiationException,
IllegalAccessException, ClassNotFoundException, SQLException {
	
	Connection con = DBConnection.getConnection();
	String sql="SELECT * FROM pharmacy WHERE admin_id=?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setInt(1, id);
	ResultSet result = ps.executeQuery();
	result.next();
	Pharmacy pharmacy= new Pharmacy();

	pharmacy.setPharmacyId(result.getInt("pharmacy_id"));
	pharmacy.setPharmacyName(result.getString("pharmacy_name"));
	pharmacy.setPhone(result.getString("phone"));
	pharmacy.setAddress(result.getString("address"));
	pharmacy.setGoogle_maps_url(result.getString("google_maps_url"));
	pharmacy.setLat(result.getFloat("lat"));
	pharmacy.setLang(result.getFloat("lang"));

	pharmacy.setAdminId(result.getInt("admin_id"));
	pharmacy.setIntro(result.getString("intro"));

	pharmacy.setWebsite(result.getString("website"));

	return pharmacy;
}

public static void updatePharmacy(Pharmacy pharmacy)
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
	Connection con = DBConnection.getConnection();
	String sql=
	"UPDATE `pharmacy` SET `pharmacy_name`=? ,`phone`=? ,`address`=? ,`google_maps_url`=? ,`lat`=? ,`lang`=? ,`admin_id`=? ,`website`=? ,`intro`=?  WHERE `pharmacy_id`=? ";
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1,pharmacy.getPharmacyName());
	ps.setString(2, pharmacy.getPhone());
	ps.setString(3, pharmacy.getAddress());
	ps.setString(4,pharmacy.getGoogle_maps_url());
	ps.setFloat(5, pharmacy.getLat());
	ps.setFloat(6, pharmacy.getLang());
	ps.setInt(7,pharmacy.getAdminId());	
	ps.setString(8, pharmacy.getWebsite());
	ps.setString(9, pharmacy.getIntro());
	ps.setInt(10,pharmacy.getPharmacyId());
	
	
	ps.executeUpdate();
	
}
	public static void insertPharmacy(Pharmacy pharmacy)
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
	Connection con = DBConnection.getConnection();
	String sql="INSERT INTO pharmacy "
			+ "(pharmacy_name, lat, lang, phone, address, google_maps_url,admin_id,website,intro) "
			+ "VALUES(?,?,?,?,?,?,?,?,?)";
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, pharmacy.getPharmacyName());
	ps.setFloat(2, pharmacy.getLat());
	ps.setFloat(3, pharmacy.getLang());
	ps.setString(4, pharmacy.getPhone());
	ps.setString(5,pharmacy.getAddress());
	ps.setString(6, pharmacy.getGoogle_maps_url());
	ps.setInt(7, pharmacy.getAdminId());
	ps.setString(8, pharmacy.getWebsite());
	ps.setString(9, pharmacy.getIntro());
	
	ps.executeUpdate();
	
}

	public static int countPharmacies() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
	Connection con = DBConnection.getConnection();		
	String sql = "SELECT COUNT(pharmacy_id) AS NumOfUsers FROM pharmacy";
	PreparedStatement ps = con.prepareStatement(sql);		
	ResultSet result = ps.executeQuery();	
	result.next();
	
	int numOfUsers = result.getInt("NumOfUsers");
	
	con.close();
	
	return numOfUsers;
	
	}

}
