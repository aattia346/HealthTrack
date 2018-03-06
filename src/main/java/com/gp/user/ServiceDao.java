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
		
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString(2));
		service.setCenterId(result.getInt("center_id"));
		service.setDeptId(result.getInt("dept_id"));
		service.setDeptName(result.getString("name"));
		service.setHospitalName(result.getString(13));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("admin_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("review"));
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
			B.setBookingId(result.getInt("id"));
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
				//result.next();
				
				while(result.next()) {
					Booking B = new Booking();
					B.setBookingId(result.getInt("id"));
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
	
	public static void insertBookingDays(int serviceId, int userId, String firstName, String lastName, int age, Date bookFromAsDate, Date bookToAsDate, String phone)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		java.sql.Date sqlDateFrom = new java.sql.Date(bookFromAsDate.getTime());
		java.sql.Date sqlDateTo = new java.sql.Date(bookToAsDate.getTime());
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO booking(service_id, user_id, firstname, lastname, age, date_from, date_to, status, time_of_booking, booking_phone) VALUES(?,?,?,?,?,?,?,?, now(),?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setInt(2, userId);
		ps.setString(3, firstName);
		ps.setString(4, lastName);
		ps.setInt(5, age);
		ps.setDate(6, sqlDateFrom);
		ps.setDate(7, sqlDateTo);
		ps.setInt(8, 0);
		ps.setString(9, phone);
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
		B.setBookingId(result.getInt("id"));
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
	
	public static List<Booking> getUnverifiedBookingsByServiceId(int serviceId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
				List<Booking> bookedDates = new ArrayList<Booking>();
				
				Connection con = DBConnection.getConnection();
				String sql="SELECT * FROM booking where service_id=? AND status = 1";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, serviceId);
				ResultSet result = ps.executeQuery();
				//result.next();
				
				while(result.next()) {
					Booking B = new Booking();
					B.setBookingId(result.getInt("id"));
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
					B.setBookingId(result.getInt("id"));
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
					B.setServiceName(result.getString("name"));
					B.setTimeOfBooking(result.getDate("time_of_booking"));
					B.setBookingPhone(result.getString("booking_phone"));
					bookedDates.add(B);
				}
				
				return bookedDates;
			}

	public static List<Service> getAllServicesOfHospitals()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service JOIN department ON dept_id=department_id"
				+ " JOIN hospital ON hospital_id=department.hospital_id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		
		List<Service> services = new ArrayList<Service>();
		
		while(result.next()) {
		Service service = new Service();
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString("name"));
		service.setDeptId(result.getInt("dept_id"));
		service.setDeptName(result.getString("name"));
		service.setHospitalName(result.getString("name"));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("admin_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("review"));
		service.setLat(result.getFloat("lat"));
		service.setLang(result.getFloat("lang"));
		service.setWebsite(result.getString("website"));
		services.add(service);
		}
		return services;
			
			}
		
	public static List<Service> getAllServicesOfCenters()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service JOIN center ON service.center_id=center.center_id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		
		List<Service> services = new ArrayList<Service>();
		
		while(result.next()) {
		Service service = new Service();
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString("name"));
		service.setCenterId(result.getInt("center_id"));
		service.setCenterName(result.getString("name"));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("user_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("review"));
		service.setLat(result.getFloat("lat"));
		service.setLang(result.getFloat("lang"));
		service.setWebsite(result.getString("website"));
		services.add(service);
		}
		return services;
			
			}
	
}

