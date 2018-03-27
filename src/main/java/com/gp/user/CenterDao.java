package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

public class CenterDao {

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
			centers.add(center);
		}
		return centers;
	
	}
	
}
