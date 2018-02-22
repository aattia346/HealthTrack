package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gp.database.DBConnection;

public class ServiceDao {

	public static Service getServiceById(int id) throws
	InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service JOIN department ON dept_id=department_id JOIN hospital ON hospital_id=id"
				+ " WHERE service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		
		Service service = new Service();
		
		service.setServiceName(result.getString(2));
		service.setCenterId(result.getInt(3));
		service.setDeptId(result.getInt(4));
		service.setDeptName(result.getString(11));
		service.setHospitalName(result.getString(13));
		service.setBookedTill(result.getDate(5));
		service.setLastUpdated(result.getDate(6));
		service.setFees(result.getString(7));
		service.setAdminId(result.getInt(14));
		service.setGoogleMapsUrl(result.getString(22));
		service.setAddress(result.getString(20));
		service.setServiceReview(result.getFloat(8));
		return service;
	}
}
