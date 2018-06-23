package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public static List<WaitingRequest> getAllUnrespondedRequests() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM waiting_request WHERE response = 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		
		List<WaitingRequest> requests = new ArrayList<WaitingRequest>();
		
		while(result.next()) {
			
			WaitingRequest WR = new WaitingRequest(result.getString("name") , result.getString("phone"), result.getString("service"));
			requests.add(WR);
		}
		
		return requests;
	}
}
