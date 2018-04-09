package com.gp.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

	public static Connection getConnection() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			String unicode= "?useUnicode=yes&characterEncoding=UTF-8";
			
			Connection con =  DriverManager.getConnection("jdbc:mysql://localhost:3306/healthtrack" + unicode ,"root","");
	
			return con;
		}
	
}
