package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class BookingDao {

	public static List<Booking> getBookingsByServiceId(int serviceId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		List<Booking> bookedDates = new ArrayList<Booking>();
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking where service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
				
		while(result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getDate("time_from"));
			B.setTimeTo(result.getDate("time_to"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
				
		return bookedDates;
		}
	
	public static List<Booking> getVerifiedBookingsByServiceId(int serviceId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		List<Booking> bookedDates = new ArrayList<Booking>();
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking where service_id=? AND status=1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
				
		while(result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getDate("time_from"));
			B.setTimeTo(result.getDate("time_to"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
		return bookedDates;
	}
	
	public static void insertBookingDays(Booking b) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
				
		java.sql.Date sqlDateFrom = new java.sql.Date(b.getDateFrom().getTime());
		java.sql.Date sqlDateTo = new java.sql.Date(b.getDateTo().getTime());
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO booking(service_id, user_id, firstname, lastname, age, date_from, date_to, status, time_of_booking, booking_phone, day_or_time)"
				+ " VALUES(?,?,?,?,?,?,?,?,now(),?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, b.getServiceId());
		ps.setInt(2, b.getUserId());
		ps.setString(3, b.getFirstName());
		ps.setString(4, b.getLastName());
		ps.setInt(5, b.getAge());
		ps.setDate(6, sqlDateFrom);
		ps.setDate(7, sqlDateTo);
		ps.setInt(8, 0);
		ps.setString(9, b.getPhone());
		ps.setInt(10, 1);
		ps.executeUpdate();
		}
	
	public static Booking getBookingById(int bookingId)
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking"
				+ " JOIN service ON booking.service_id=service.service_id"
				+ " JOIN department ON service.dept_id=department.department_id"
				+ " JOIN hospital ON department.hospital_id=hospital.id"
				+ " WHERE booking.booking_id=? LIMIT 1";
				
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, bookingId);

				ResultSet result = ps.executeQuery();
				//result.next();
				
				Booking B = new Booking();
				B.setBookingId(result.getInt("booking_id"));
				B.setServiceId(result.getInt("service_id"));
				B.setUserId(result.getInt("user_id"));
				B.setFirstName(result.getString("firstname"));
				B.setLastName(result.getString("lastname"));
				B.setAge(result.getInt("age"));
				B.setDateFrom(result.getDate("date_from"));
				B.setDateTo(result.getDate("date_to"));
				B.setTimeFrom(result.getDate("time_from"));
				B.setTimeTo(result.getDate("time_to"));
				B.setStatus(result.getInt("status"));
				B.setTimeOfBooking(result.getDate("time_of_booking"));
				B.setBookingPhone(result.getString("booking_phone"));
				B.setAdminId(result.getInt("admin_id"));
				return B;
			}
	
	public static void verifyBooking(int bookingId)
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
				
		Connection con = DBConnection.getConnection();
		String sql="UPDATE booking SET status=1 WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}

	public static void unverifyBooking(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
				
		Connection con = DBConnection.getConnection();
		String sql="UPDATE booking SET status=0 WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}

	public static void deleteBooking(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
				
		Connection con = DBConnection.getConnection();
		String sql="DELETE FROM booking WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
	}
			
	public static List<Booking> getUnverifiedBookingsByServiceId(int serviceId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
						
		List<Booking> bookedDates = new ArrayList<Booking>();
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking where service_id=? AND status = 1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
					
		while(result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getDate("time_from"));
			B.setTimeTo(result.getDate("time_to"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));	
			bookedDates.add(B);
			}
						
		return bookedDates;
	}
			
	public static List<Booking> getBookingsByUserId(int userId) 
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
						
		List<Booking> bookedDates = new ArrayList<Booking>();
						
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking JOIN service ON booking.service_id=service.service_id WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ResultSet result = ps.executeQuery();
				
		while(result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getDate("time_from"));
			B.setTimeTo(result.getDate("time_to"));
			B.setStatus(result.getInt("status"));
			B.setServiceName(result.getString("service_name"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
						
		return bookedDates;
		}
}
