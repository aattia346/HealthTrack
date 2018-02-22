package com.gp.service;

import java.sql.Connection;
//import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;
import com.gp.service.serviceClass;
///import com.gp.user.User;

public class serviceDao {
	
	public static int insertservice(serviceClass s)
	  {
		  int status=0;
		  try{
			 
			 // PreparedStatement ps=conn.prepareStatement("INSERT INTO `service`( `Name`, `Location`) VALUES(?,?)");
			  Connection con = DBConnection.getConnection();
				String sql="INSERT INTO `icu` ( `status`, `fees`, `rating`) VALUES(?,?,?)";
				PreparedStatement ps = con.prepareStatement(sql);
				//serviceClass s=new serviceClass();
			    ps.setString(1,s.getstatus());
			    ps.setString(2,s.getfees());
			    ps.setString(3,s.getrating());
			    // ps.setInt(4, s.getId());
			   
			   // ps.setInt(3,s.getTime());
			   // ResultSet result = ps.executeQuery();
				//result.next();
			    status=ps.executeUpdate();
		  }catch(Exception e){System.out.println(e);}
		  
		  return status;
	  }	
	

	 public static List<serviceClass>getAllRecords(){
		  List<serviceClass>list=new ArrayList<serviceClass>();
		  try{
		  //Connection conn= getConnection();
		  Connection con = DBConnection.getConnection();
		  PreparedStatement ps=con.prepareStatement("select * from icu");
		  ResultSet rs= ps.executeQuery();
		  while(rs.next()){
			  serviceClass s=new serviceClass();
			  s.setId(rs.getInt(1));
			  s.setstatus(rs.getString(2));
			  s.setfees(rs.getString(3));
			  s.setrating(rs.getString(4));
			//  s.setserviceId(rs.getInt(5));
			  
			 // s.setTime(rs.getInt("Time_available"));;
			 
			  list.add(s);
		  }
			  
		  }catch(Exception e){System.out.println(e);} 
		  return list;
			  
		  }
	  
	 public static int  delete(serviceClass s){
		  int status=0;
		  try{
		 // Connection conn=getConnection();
	      Connection con = DBConnection.getConnection();
		  PreparedStatement ps=con.prepareStatement("DELETE FROM `icu` WHERE id=?");
		  ps.setInt(1, s.getId());
		  status=ps.executeUpdate();
		  }catch(Exception e){System.out.println(e);}
		  
		  return status;
	  }
	 public static serviceClass getserviceById(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
			
			Connection con = DBConnection.getConnection();
			String sql="SELECT * FROM icu WHERE id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet result = ps.executeQuery();
			result.next();
			serviceClass service  = new serviceClass();
			service.setId(id);
			service.setstatus(result.getString(2));
			service.setfees(result.getString(3));
			service.setrating(result.getString(4));
			
			//service.setTime(result.getInt(4));
			
			
			return service;
		}
	 public static int update(serviceClass s){
		  int status=0;
		  try {
			//Connection conn = getConnection();
			Connection con = DBConnection.getConnection();
			String sql="update icu set status=? , fees=? ,rating=?  where id=?";
			PreparedStatement ps=con.prepareStatement(sql);
			 ps.setString(1,s.getstatus());
			  ps.setString(2,s.getfees());
			  ps.setString(3,s.getrating());
			 // ps.setInt(3, s.getTime());;
			  ps.setInt(4, s.getId());
			  status=ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		  return status ;
		  
		  
	  }
		  

}
