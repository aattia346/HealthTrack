package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
		
		service.setServiceId(result.getInt(1));
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

	public static List<Booking> getBookingsByServiceId(int serviceId) 
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		List<Booking> bookedDates = new ArrayList<Booking>();
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking where service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
		//result.next();
		
		while(result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt(1));
			B.setServiceId(result.getInt(2));
			B.setUserId(result.getInt(3));
			B.setFirstName(result.getString(4));
			B.setLastName(result.getString(5));
			B.setAge(result.getInt(6));
			B.setDateFrom(result.getDate(7));
			B.setDateTo(result.getDate(8));
			B.setTimeFrom(result.getDate(9));
			B.setTimeTo(result.getDate(10));
			B.setStatus(result.getInt(11));
			bookedDates.add(B);
		}
		
		return bookedDates;
	}

	public static void insertBookingDays(int serviceId, int userId, String firstName, String lastName, int age, Date bookFromAsDate, Date bookToAsDate)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		java.sql.Date sqlDateFrom = new java.sql.Date(bookFromAsDate.getTime());
		java.sql.Date sqlDateTo = new java.sql.Date(bookToAsDate.getTime());
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO booking(service_id, user_id, firstname, lastname, age, date_from, date_to, status) VALUES(?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setInt(2, userId);
		ps.setString(3, firstName);
		ps.setString(4, lastName);
		ps.setInt(5, age);
		ps.setDate(6, sqlDateFrom);
		ps.setDate(7, sqlDateTo);
		ps.setInt(8, 0);
		ps.executeUpdate();
		
	}

	public static Booking getBookingById(int bookingId)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking"
				+ " JOIN service ON booking.service_id=service.service_id"
				+ " JOIN department ON service.dept_id=department.department_id"
				+ " JOIN hospital ON department.hospital_id=hospital.id"
				+ " WHERE booking.id=? LIMIT 1";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);

		ResultSet result = ps.executeQuery();
		result.next();
		
		Booking B = new Booking();
		B.setBookingId(result.getInt(1));
		B.setServiceId(result.getInt(2));
		B.setUserId(result.getInt(3));
		B.setFirstName(result.getString(4));
		B.setLastName(result.getString(5));
		B.setAge(result.getInt(6));
		B.setDateFrom(result.getDate(7));
		B.setDateTo(result.getDate(8));
		B.setTimeFrom(result.getDate(9));
		B.setTimeTo(result.getDate(10));
		B.setStatus(result.getInt(11));
		B.setAdminId(result.getInt("admin_id"));
		return B;
	}

	public static void verifyBooking(int bookingId)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE booking SET status=1 WHERE id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}

	public static void unverifyBooking(int bookingId)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE booking SET status=0 WHERE id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}

	public static void deleteBooking(int bookingId)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="DELETE FROM booking WHERE id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}
	
	
}
