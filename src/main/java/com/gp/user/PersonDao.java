package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gp.database.DBConnection;

public class PersonDao {

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
	}
	
	public static void verifyAccount(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE person set verified = 1 WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ps.executeUpdate();
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
		person.setFirstName(result.getString(3));
		person.setLastName((result.getString(4)));
		person.setEmail(result.getString(5));
		person.setPhone(result.getString(6));
		person.setVerified(result.getInt(7));
		
		return person;
	}
	
	public static Person getAllInfoAboutUserByEmail(String email) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM user JOIN person ON person.user_id = user.user_id where email=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet result = ps.executeQuery();
		result.next();
		Person person = new Person(result.getInt(1), result.getString(2), result.getString(3), result.getString(4),
				result.getInt(5), result.getString(8), result.getString(9), result.getString(10), result.getString(11),
				result.getInt(12));
		
		return person;
	}
	
	public static Person getAllInfoAboutUserByUsername(String username) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM user JOIN person ON person.user_id = user.user_id where username=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);
		ResultSet result = ps.executeQuery();
		result.next();
		Person person = new Person(result.getInt(1), result.getString(2), result.getString(3), result.getString(4),
				result.getInt(5), result.getString(8), result.getString(9), result.getString(10), result.getString(11),
				result.getInt(12));
		
		return person;
	}


}
