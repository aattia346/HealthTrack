package com.gp.user;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class UserDao {
	
	public static int loginSubmit(String username , String password) throws InstantiationException
	, IllegalAccessException, ClassNotFoundException, SQLException, NoSuchAlgorithmException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM user WHERE username=? AND password=? AND ban=0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);	
		ps.setString(2, password); 
		ResultSet result = ps.executeQuery();
		result.next();
		
		if(result.getRow()==1) {			
			int userId = result.getInt(1);
			return userId;
		}else {
			return 0;
		}
	}
	
	public static User getUserById(int id) throws InstantiationException,
	IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM user WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		User user = new User();
		user.setId(id);
		user.setUsername(result.getString(2));
		user.setPassword(result.getString(3));
		user.setType(result.getString(4));
		
		return user;
	}
	
	public static int insertUser(User user) throws SQLException,
	InstantiationException, IllegalAccessException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO user(username, password, type, verificationcode) VALUES(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, user.getUsername());
		ps.setString(2, user.getPassword());
		ps.setString(3, user.getType());
		ps.setInt(4, user.getVerificationCode());
		ps.executeUpdate();
		
		//get the id of the new user
		Connection con2 = DBConnection.getConnection();
		String sql2="SELECT user_id FROM user WHERE username=?";
		PreparedStatement ps2 = con2.prepareStatement(sql2);
		ps2.setString(1, user.getUsername());
		ResultSet result2 = ps2.executeQuery();
		result2.next();
		return result2.getInt(1);
	}

	public static User getUserByUsername(String username) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM user WHERE username=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);
		ResultSet result = ps.executeQuery();
		User user = new User();
		result.next();
		if(result.getRow()!=0) {
			user.setId(result.getInt(1));
			user.setUsername(result.getString(2));
			user.setPassword(result.getString(3));
			user.setType(result.getString(4));
			user.setVerificationCode(result.getInt(5));
		}
		
		return user;
		
	}
	
	public static void changeCode(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		int code = Validation.generateCode();
		Connection con = DBConnection.getConnection();
		String sql = "UPDATE user set verificationcode = ? WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, code);
		ps.setInt(2, id);
		ps.executeUpdate();
	}

	public static int insertFacebookUser(String facebookId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO user(type, facebook_id) VALUES(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "facebookUser");
		ps.setString(2, facebookId);
		ps.executeUpdate();
		int userId = getUserIdByFacebookId(facebookId);
	
		return userId;
		
	}

	public static int getUserIdByFacebookId(String facebookId) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Connection con2 = DBConnection.getConnection();
		String sql2="SELECT user_id FROM user WHERE facebook_id=?";
		PreparedStatement ps2 = con2.prepareStatement(sql2);
		ps2.setString(1, facebookId);
		ResultSet result2 = ps2.executeQuery();
		result2.next();
		return result2.getInt(1);
	}

	public static int adminLoginSubmit(String username, String password)
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM user WHERE username=? AND password=? AND admin=1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);	
		ps.setString(2, password); 
		ResultSet result = ps.executeQuery();
		result.next();
		
		if(result.getRow()==1) {			
			int userId = result.getInt(1);
			return userId;
		}else {
			return 0;
		}
	}
	
	
	public static List<User> getUsers(String type) 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM user WHERE type=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, type);	
		ResultSet result = ps.executeQuery();
		
		List<User> users = new ArrayList<User>();
		while(result.next()) {
			User user = new User(result.getInt("user_id"), result.getString("username"), type);
			users.add(user);
		}
		return users;
	}
	public static List<User> getBannedUsers()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
					
			Connection con = DBConnection.getConnection();
			String sql="SELECT * FROM user WHERE ban =?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, 1);
			ResultSet result = ps.executeQuery();
			List<User> users = new ArrayList<User>();
			while(result.next()) {
				User user = new User();
				user.setId(result.getInt("user_id"));			
				user.setUsername(result.getString("username"));
				user.setType(result.getString("type"));
				user.setBan(result.getInt("ban"));
				
				users.add(user);
				}
			return users;
				
				}
	public static List<User> getAllUsers()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
					
			Connection con = DBConnection.getConnection();
			String sql="SELECT * FROM user";
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet result = ps.executeQuery();
			List<User> users = new ArrayList<User>();
			while(result.next()) {
				User user = new User();
				user.setId(result.getInt("user_id"));			
				user.setUsername(result.getString("username"));
				user.setType(result.getString("type"));
				user.setBan(result.getInt("ban"));
				
				users.add(user);
				}
			return users;
				
				}
	public static void upadateBan(int ban, int userId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Connection con = DBConnection.getConnection();
		String sql="UPDATE user set ban=? WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ban);
		ps.setInt(2, userId);
		ps.executeUpdate();
	}

	public static String getUsersType() 
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT type FROM user ";
		PreparedStatement ps = con.prepareStatement(sql);		
		ResultSet result = ps.executeQuery();	
		result.next();
		String type= result.getString("type");
		return type;
	}
	public static void insertNewUser(User user,Person person) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO user (username,type) VALUES (?,?); INSERT INTO person (user_id,firstname,lastname,email,phone) VALUES ((SELECT user_id WHERE username=?),?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,user.getUsername());
		ps.setString(2, user.getType());
		ps.setString(3,user.getUsername());
		ps.setString(4, person.getFirstName());
		ps.setString(5, person.getLastName());
		ps.setString(6, person.getEmail());
		ps.setString(7, person.getPhone());
		ps.executeUpdate();
	}

	public static boolean canUserComment(int userId, int serviceId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT comment FROM review WHERE user_id=? AND comment!=null";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		
		ResultSet result = ps.executeQuery();
		result.next();
		
		return result.getRow() < 10;

	}

	public static void updateUser(User user)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="UPDATE user "
				+ "SET username=?, password=?, type=? "
				+ "WHERE user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, user.getUsername());
		ps.setString(2, user.getPassword());		
		ps.setString(3, user.getType());
		ps.setInt(4, user.getId());
		
		ps.executeUpdate();
		
	}
	


	public static boolean isTheUserAuthorized(int userId, String place, int serviceId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = null;
		
		if(place.equalsIgnoreCase("hospital")) {
			sql="SELECT * FROM service"
					+ " JOIN department ON service.dept_id = department.department_id"
					+ " JOIN hospital ON hospital.hospital_id = department.hospital_id"
					+ " WHERE service_id=?";
		}else if(place.equalsIgnoreCase("center")){
			sql="SELECT * FROM service JOIN center ON service.center_id = center.center_id"
					+ " WHERE service_id=?";
		}
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		
		ResultSet result = ps.executeQuery();
		
		result.next();
		
		int adminId = result.getInt("admin_id");
		
		con.close();
		
		return  adminId == userId;	
	}
	
	public static int countUsers() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();		
		String sql = "SELECT COUNT(user_id) AS NumOfUsers FROM user";
		PreparedStatement ps = con.prepareStatement(sql);		
		ResultSet result = ps.executeQuery();	
		result.next();
		
		int numOfUsers = result.getInt("NumOfUsers");
		
		con.close();
		
		return numOfUsers;
		
	}

	
}
