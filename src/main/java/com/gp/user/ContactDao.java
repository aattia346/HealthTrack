package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class ContactDao {
	
	public static void insertContact(Contact contact)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO contact(name, email, msg, contact_time)VALUES(?,?,?, now())";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, contact.getName());
		ps.setString(2, contact.getEmail());
		ps.setString(3, contact.getMsg());
		
		ps.executeUpdate();
		con.close();
		
	}
	
	public static int countUnseenContacts() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT COUNT(contact_id) AS numOfContacts FROM contact";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet result = ps.executeQuery();
		result.next();
		
		int numOfContacts = result.getInt("numOfContacts");
		con.close();
		
		return numOfContacts;
	}
	
	public static List<Contact> getUnseenContacts() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		List<Contact> contacts = new ArrayList<Contact>();
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM contact WHERE seen = 0";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet result = ps.executeQuery();
		
		while(result.next()) {
			Contact contact = new Contact();
			
			contact.setContactId(result.getInt("contact_id"));
			contact.setName(result.getString("name"));	
			contact.setEmail(result.getString("email"));
			contact.setMsg(result.getString("msg"));
			contacts.add(contact);
		}
		con.close();
		return contacts;
		
	}

}
