package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class BookingDao {

	public static List<Booking> getBookingsByServiceId(int serviceId)throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		List<Booking> bookedDates = new ArrayList<Booking>();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking where service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();

		while (result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getTime("time_from"));
			B.setDayOfBooking(result.getDate("day_of_time"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
		con.close();
		return bookedDates;
	}

	public static List<Booking> getVerifiedBookingsByServiceId(int serviceId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		List<Booking> bookedDates = new ArrayList<Booking>();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking where service_id=? AND status=1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();

		while (result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getTime("time_from"));
			B.setDayOfBooking(result.getDate("day_of_time"));

			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
		con.close();
		return bookedDates;
	}

	public static void insertBookingDays(Booking b)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		java.sql.Date sqlDateFrom = new java.sql.Date(b.getDateFrom().getTime());
		java.sql.Date sqlDateTo = new java.sql.Date(b.getDateTo().getTime());

		Connection con = DBConnection.getConnection();
		String sql = "INSERT INTO booking(service_id, user_id, firstname, lastname, age, date_from, date_to, status, time_of_booking, booking_phone, sex)"
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
		ps.setString(10, b.getSex());

		ps.executeUpdate();

		con.close();
	}

	public static List<Booking> getAllBookings()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet result = ps.executeQuery();
		List<Booking> bookings = new ArrayList<Booking>();
		while (result.next()) {
			Booking booking = new Booking();
			booking.setBookingId(result.getInt("booking_id"));
			booking.setUserId(result.getInt("user_id"));
			booking.setServiceId(result.getInt("service_id"));
			booking.setDateFrom(result.getDate("date_from"));
			booking.setDateTo(result.getDate("date_to"));
			booking.setTimeFrom(result.getTime("time_from"));
			booking.setStatus(result.getInt("status"));

			bookings.add(booking);
		}
		return bookings;

	}

	public static Booking getBookingById(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking" + " JOIN service ON booking.service_id=service.service_id"
				+ " JOIN department ON service.dept_id=department.department_id"
				+ " JOIN hospital ON department.hospital_id=hospital.hospital_id"
				+ " WHERE booking.booking_id=? LIMIT 1";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);

		ResultSet result = ps.executeQuery();
		result.next();

		Booking B = new Booking();
		B.setBookingId(result.getInt("booking_id"));
		B.setServiceId(result.getInt("service_id"));
		B.setUserId(result.getInt("user_id"));
		B.setFirstName(result.getString("firstname"));
		B.setLastName(result.getString("lastname"));
		B.setAge(result.getInt("age"));
		B.setDateFrom(result.getDate("date_from"));
		B.setDateTo(result.getDate("date_to"));
		B.setTimeFrom(result.getTime("time_from"));
		B.setDayOfBooking(result.getDate("day_of_time"));
		B.setStatus(result.getInt("status"));
		B.setTimeOfBooking(result.getDate("time_of_booking"));
		B.setBookingPhone(result.getString("booking_phone"));
		B.setAdminId(result.getInt("admin_id"));

		con.close();
		return B;
	}

	public static List<Booking> getBookingTimeOrDaySlot(int day_or_time)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking" + " JOIN service ON booking.service_id=service.service_id"
				+ " WHERE service.day_or_time=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, day_or_time);

		ResultSet result = ps.executeQuery();
		List<Booking> bookings = new ArrayList<Booking>();
		while (result.next()) {
			Booking booking = new Booking();
			booking.setBookingId(result.getInt("booking_id"));
			booking.setUserId(result.getInt("user_id"));
			booking.setServiceId(result.getInt("service_id"));
			booking.setDateFrom(result.getDate("date_from"));
			booking.setDateTo(result.getDate("date_to"));
			booking.setTimeFrom(result.getTime("time_from"));
			booking.setStatus(result.getInt("status"));
			bookings.add(booking);
		}
		return bookings;

	}

	public static void verifyBooking(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "UPDATE booking SET status=1 WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
		con.close();
	}

	public static void unverifyBooking(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "UPDATE booking SET status=0 WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
		con.close();
	}

	public static void deleteBooking(int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "DELETE FROM booking WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookingId);
		ps.executeUpdate();
		con.close();
	}

	public static List<Booking> getUnverifiedBookingsByServiceId(int serviceId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		List<Booking> bookedDates = new ArrayList<Booking>();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking where service_id=? AND status = 1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();

		while (result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getTime("time_from"));
			B.setDayOfBooking(result.getDate("day_of_time"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			bookedDates.add(B);
		}
		con.close();
		return bookedDates;
	}

	public static List<Booking> getBookingsByUserId(int userId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		List<Booking> bookedDates = new ArrayList<Booking>();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking JOIN service ON booking.service_id=service.service_id WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ResultSet result = ps.executeQuery();

		while (result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getTime("time_from"));
			B.setDayOfBooking(result.getDate("day_of_time"));
			B.setStatus(result.getInt("status"));
			B.setServiceName(result.getString("service_name"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
		con.close();
		con.close();
		return bookedDates;
	}

	public static void insertBookingTimes(Booking b)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		java.sql.Date sqlDate = new java.sql.Date(b.getDayOfBooking().getTime());
		String sql = "INSERT INTO booking(service_id, user_id, firstname, lastname, age, time_from, status, time_of_booking, booking_phone, sex, day_of_time, msg)"
				+ " VALUES(?,?,?,?,?,?,?,now(),?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, b.getServiceId());
		ps.setInt(2, b.getUserId());
		ps.setString(3, b.getFirstName());
		ps.setString(4, b.getLastName());
		ps.setInt(5, b.getAge());
		ps.setTime(6, b.getTimeFrom());
		ps.setInt(7, 0);
		ps.setString(8, b.getPhone());
		ps.setString(9, b.getSex());
		ps.setDate(10, sqlDate);
		ps.setString(11, b.getMsg());
		ps.executeUpdate();
		con.close();
	}

	public static int getBookingsOfTheDay(int serviceId, String today)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking WHERE service_id=? AND day_of_time=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setString(2, today);
		ResultSet result = ps.executeQuery();
		result.last();
		return result.getRow();
	}

	public static void insertBookingClinic(Booking b)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		java.sql.Date sqlDate = new java.sql.Date(b.getDayOfBooking().getTime());
		String sql = "INSERT INTO booking(user_id, firstname, lastname, age, status, time_of_booking, booking_phone, sex, day_of_time, msg, clinic_id)"
				+ " VALUES(?,?,?,?,?,now(),?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, b.getUserId());
		ps.setString(2, b.getFirstName());
		ps.setString(3, b.getLastName());
		ps.setInt(4, b.getAge());
		ps.setInt(5, 0);
		ps.setString(6, b.getPhone());
		ps.setString(7, b.getSex());
		ps.setDate(8, sqlDate);
		ps.setString(9, b.getMsg());
		ps.setInt(10, b.getClinicId());
		ps.executeUpdate();
		con.close();

	}

	public static void updateStatus(int status, int bookingId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE booking set status=? WHERE booking_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, status);
		ps.setInt(2, bookingId);
		ps.executeUpdate();
	}

	public static List<Booking> getBookingsByClinicId(int serviceId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		List<Booking> bookedDates = new ArrayList<Booking>();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM booking where clinic_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();

		while (result.next()) {
			Booking B = new Booking();
			B.setBookingId(result.getInt("booking_id"));
			B.setServiceId(result.getInt("service_id"));
			B.setUserId(result.getInt("user_id"));
			B.setFirstName(result.getString("firstname"));
			B.setLastName(result.getString("lastname"));
			B.setAge(result.getInt("age"));
			B.setDateFrom(result.getDate("date_from"));
			B.setDateTo(result.getDate("date_to"));
			B.setTimeFrom(result.getTime("time_from"));
			B.setDayOfBooking(result.getDate("day_of_time"));
			B.setStatus(result.getInt("status"));
			B.setTimeOfBooking(result.getDate("time_of_booking"));
			B.setBookingPhone(result.getString("booking_phone"));
			bookedDates.add(B);
		}
		con.close();
		return bookedDates;
	}
}