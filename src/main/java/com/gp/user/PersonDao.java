package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gp.database.DBConnection;

abstract public class PersonDao {

	public static void insertPerson(Person person) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO person(user_id, firstname, lastname, email, phone, verified) VALUES(?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, person.getUserId());
		ps.setString(2, person.getFirstName());
		ps.setString(3, person.getLastName());
		ps.setString(4, person.getEmail());
		ps.setString(5, person.getPhone());
		ps.setInt(6, person.getVerified());
		ps.executeUpdate();
		con.close();
	}
	
	public static void verifyAccount(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE person set verified = 1 WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ps.executeUpdate();
		con.close();
	}
	
	public static Person getPersonByUserID(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM person WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		Person person = new Person();
		person.setUserId(result.getInt("user_id"));
		person.setFirstName(result.getString("firstname"));
		person.setLastName((result.getString("lastname")));
		person.setEmail(result.getString("email"));
		person.setPhone(result.getString("phone"));
		person.setVerified(result.getInt("verified"));
		person.setBookingsPerDay(result.getInt("bookings_per_day"));
		
		con.close();
		return person;
	}
	
	public static Person getAllInfoAboutUserByEmail(String email) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM user JOIN person ON person.user_id = user.user_id where email=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet result = ps.executeQuery();
		result.next();

		Person person = new Person();
		person.setUserId(result.getInt("user_id"));
		person.setFirstName(result.getString("firstname"));
		person.setFirstName(result.getString("lastname"));
		person.setUsername(result.getString("username"));
		person.setEmail(result.getString("email"));
		person.setPhone(result.getString("phone"));
		person.setVerified(result.getInt("verified"));
		person.setBookingsPerDay(result.getInt("bookings_per_day"));
		person.setVerificationCode(result.getInt("verificationcode"));
		con.close();
		return person;
	}
	
	public static Person getAllInfoAboutUserByUsername(String username) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM user JOIN person ON person.user_id = user.user_id where username=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);
		ResultSet result = ps.executeQuery();
		result.next();
		
		Person person = new Person();
		person.setUserId(result.getInt("user_id"));
		person.setFirstName(result.getString("firstname"));
		person.setLastName(result.getString("lastname"));
		person.setUsername(result.getString("username"));
		person.setEmail(result.getString("email"));
		person.setPhone(result.getString("phone"));
		person.setVerified(result.getInt("verified"));
		person.setBookingsPerDay(result.getInt("bookings_per_day"));
		person.setVerificationCode(result.getInt("verificationcode"));
		
		con.close();
		return person;
	}

	public static void increaseBookings(int userId) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE person SET bookings_per_day = bookings_per_day +1 where user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ps.executeUpdate();
		con.close();
	}
	
	public static boolean canPersonBook(int userId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Connection con = DBConnection.getConnection();
		String sql = "SELECT bookings_per_day FROM person WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);		
		ResultSet result = ps.executeQuery();
		result.next();
		int numOfBookings = result.getInt("bookings_per_day");
		con.close();
		
		return numOfBookings<3;
	}

	public static void changePassword(int id, String password) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE user set password = ? WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, password);
		ps.setInt(2, id);
		ps.executeUpdate();
		con.close();	
	}

	public static int countUserBookings(int userId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT COUNT(booking_id) AS NoOfBookings FROM booking WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ResultSet result = ps.executeQuery();
		result.next();
		int NoOfBookings = result.getInt("NoOfBookings");
		con.close();
		return NoOfBookings;
	}
}
