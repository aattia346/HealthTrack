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
		String sql="SELECT COUNT(contact_id) AS numOfContacts FROM contact WHERE seen=0";
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
	public static List<Contact> getAllContacts()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
					
			Connection con = DBConnection.getConnection();
			String sql="SELECT * FROM contact";
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet result = ps.executeQuery();
			List<Contact> contacts = new ArrayList<Contact>();
			while(result.next()) {
				Contact contact = new Contact();
			
				contact.setName(result.getString("name"));
				contact.setEmail(result.getString("email"));
				contact.setMsg(result.getString("msg"));
				contact.setContactId(result.getInt("contact_id"));
				contact.setSeen(result.getInt("seen"));
				contact.setContactTime(result.getDate("contact_time"));
				
				contacts.add(contact);
				}
			return contacts;
				
				}

	public static void deleteContact(int contactId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="DELETE FROM contact WHERE contact_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, contactId);
		ps.executeUpdate();
		
	}

	public static void markContactAsRead(int contactId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql="UPDATE contact SET seen=1 WHERE contact_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, contactId);
		ps.executeUpdate();
		
	}
	
	public static void markContactAsUnread(int contactId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

		Connection con = DBConnection.getConnection();
		String sql="UPDATE contact SET seen=0 WHERE contact_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, contactId);
		ps.executeUpdate();
		
	}

}
