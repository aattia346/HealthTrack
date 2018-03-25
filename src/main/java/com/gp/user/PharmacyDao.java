package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

public class PharmacyDao {
	
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
			pharmacy.setAdress(result.getString("address"));
			pharmacy.setGoogle_maps_url(result.getString("google_maps_url"));
			pharmacy.setLat(result.getFloat("lat"));
			pharmacy.setLang(result.getFloat("lang"));
			pharmacy.setAdminId(result.getInt("admin_id"));
			pharmacy.setReview(result.getFloat("review"));
			
			pharmacies.add(pharmacy);
		}
		return pharmacies;
	}
}
