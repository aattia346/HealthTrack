package com.gp.service;

import java.sql.Connection;
import java.sql.Date;
//import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;
import com.gp.service.serviceClass;
import com.gp.user.Service;
///import com.gp.user.User;

public class serviceDao {
	
	public static int insertservice(String serviceName, String fees,java.util.Date available_from,java.util.Date available_to)
	  {
		  int status=0;
		  try{
			 java.sql.Date sqlDatetill = new java.sql.Date(available_from.getTime());
			java.sql.Date sqlDateTo = new java.sql.Date(available_to.getTime());
			 
			
			  Connection con = DBConnection.getConnection();
				String sql="INSERT INTO `service`( `name`,`fees`,`available_from`,`available_to`) VALUES(?,?,?,?)";
				PreparedStatement ps = con.prepareStatement(sql);
				//serviceClass s=new serviceClass();
			    ps.setString(1,serviceName);
			   // ps.setDate(2,(Date) s.getAvailable_from());
			  //  ps.setInt(2, 0);
			    ps.setString(2,fees);
			    ps.setDate(3,sqlDatetill );
			    ps.setDate(4, sqlDateTo);
			  
			    // ps.setInt(4, s.getId());
			   
			   // ps.setInt(3,s.getTime());
			   // ResultSet result = ps.executeQuery();
				//result.next();
			    status=ps.executeUpdate();
		  }catch(Exception e){System.out.println(e);}
		  
		  return status;
	  }	
	

	 public static List<Service>getAllRecords(){
		  List<Service>list=new ArrayList<Service>();
		  try{
		 
		  Connection con = DBConnection.getConnection();
		  PreparedStatement ps=con.prepareStatement("select * from service");
		  ResultSet rs= ps.executeQuery();
		  while(rs.next()){
			  Service s=new Service();
			  s.setServiceId(rs.getInt(1));
			  s.setServiceName(rs.getString(2));
			  s.setFees(rs.getString(7));
			  s.setAvailable_from(rs.getDate(9));
			 // s.setAvailable_to(rs.getDate(10));
			 // s.setLastUpdated(rs.getDate(6));
			//  s.setAvailable_from(rs.getDate(9));
			//  s.setserviceId(rs.getInt(5));
			  
			 // s.setTime(rs.getInt("Time_available"));;
			 
			  list.add(s);
		  }
			  
		  }catch(Exception e){System.out.println(e);} 
		  return list;
			  
		  }
	  
	 public static int  delete(Service s){
		  int status=0;
		  try{
		
	      Connection con = DBConnection.getConnection();
		  PreparedStatement ps=con.prepareStatement("DELETE FROM `service` WHERE service_id=?");
		  ps.setInt(1, s.getServiceId());
		  status=ps.executeUpdate();
		  }catch(Exception e){System.out.println(e);}
		  
		  return status;
	  }
	 public static Service getserviceById(int id) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
			
			Connection con = DBConnection.getConnection();
			String sql="SELECT * FROM service WHERE service_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet result = ps.executeQuery();
			result.next();
			Service service  = new Service();
			service.setServiceId(id);
			service.setServiceName(result.getString(2));
			//service.setAvailable_from(result.getDate(9));
			//service.setLastUpdated(result.getDate(6));
			service.setFees(result.getString(7));
			service.setAvailable_from(result.getDate(9));
			service.setAvailable_to(result.getDate(10));
			//service.setrating(result.getString(4));
			
			//service.setTime(result.getInt(4));
			
			
			return service;
		}
	 public static int update(Service s){
		  int status=0;
		  try {
			
			Connection con = DBConnection.getConnection();
			String sql="UPDATE `service` SET `name`=? ,`fees`=?,`available_from`=?,`available_to`=?  where service_id=?";
			PreparedStatement ps=con.prepareStatement(sql);
			 ps.setString(1,s.getServiceName());
			  ps.setString(2,s.getFees());
			  ps.setDate(3, (Date) s.getAvailable_from());
			  ps.setDate(4, (Date) s.getAvailable_to());			
			  ps.setInt(5, s.getServiceId());
			  status=ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		  return status ;
		  
		  
	  }


	 

}
