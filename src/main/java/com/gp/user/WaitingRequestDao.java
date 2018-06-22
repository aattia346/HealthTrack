package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gp.database.DBConnection;

public abstract class WaitingRequestDao {

	public static void insertRequest(WaitingRequest waitingRequest) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO waiting_request (name, phone, service, request_date) VALUES(?,?,?,now())";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, waitingRequest.getName());
		ps.setString(2, waitingRequest.getPhone());
		ps.setString(3, waitingRequest.getService());
		ps.executeUpdate();
		con.close();
	}
}
