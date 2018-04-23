package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.gp.database.DBConnection;

abstract public class ServiceDao {

	public static Service getServiceById(int id, String table) throws
	InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql = null;
		boolean executeLine = false;
		if(table.equalsIgnoreCase("hospital")) {
			sql="SELECT * FROM service JOIN department ON dept_id=department_id JOIN hospital ON department.hospital_id=hospital.hospital_id"
					+ " WHERE service_id=?";
			executeLine = true;
		}else if(table.equalsIgnoreCase("center")){
			sql="SELECT * FROM service JOIN center ON service.center_id=center.center_id"
					+ " WHERE service_id=?";
		}
		
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet result = ps.executeQuery();
		result.next();
		
		Service service = new Service();
		
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString("service_name"));
		service.setCenterId(result.getInt("center_id"));
		if(executeLine) {
			service.setDeptId(result.getInt("dept_id"));
			service.setDeptName(result.getString("dept_name"));
			service.setHospitalName(result.getString("hospital_name"));
		}	
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("admin_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("service_review"));
		service.setSlotType(result.getInt("day_or_time"));
		service.setPhone(result.getString("phone"));
		service.setSlot(result.getInt("slot"));
		
		con.close();
		return service;
	}
	
	public static List<Service> getServicesByDeptID(int deptId) 
		throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service WHERE dept_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, deptId);
		ResultSet result = ps.executeQuery();
		List<Service> list = new ArrayList<Service>();
		while(result.next()) {
			Service s = new Service();
			s.setServiceId(result.getInt("service_id"));
			s.setServiceName(result.getString("service_name"));
			s.setCenterId(result.getInt("center_id"));
			s.setDeptId(result.getInt("dept_id"));
			s.setFees(result.getString("fees"));
			s.setServiceReview(result.getFloat("service_review"));
			s.setSlotType(result.getInt("day_or_time"));
			s.setSlot(result.getInt("slot"));
			list.add(s);
		}
		con.close();
		return list;
	}

	public static List<Service> getAllServicesOfHospitals()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service JOIN department ON dept_id=department_id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet result = ps.executeQuery();
		
		List<Service> services = new ArrayList<Service>();
		
		while(result.next()) {
		Service service = new Service();
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString("service_name"));
		service.setDeptId(result.getInt("dept_id"));
		service.setDeptName(result.getString("dept_name"));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setServiceReview(result.getFloat("service_review"));
		service.setSlotType(result.getInt("day_or_time"));
		service.setSlot(result.getInt("slot"));
		services.add(service);
		}
		
		for(Service S: services) {
			int deptId = S.getDeptId();
			Connection con2 = DBConnection.getConnection();
			String sql2="SELECT * FROM hospital JOIN department ON department.hospital_id=hospital.hospital_id"
					+ " WHERE department_id=?";
			PreparedStatement ps2 = con2.prepareStatement(sql2);
			ps2.setInt(1, deptId);
			ResultSet result2 = ps2.executeQuery();
			result2.next();
			S.setAdminId(result2.getInt("admin_id"));
			S.setHospitalName(result2.getString("hospital_name"));
			S.setGoogleMapsUrl(result2.getString("google_maps_url"));
			S.setAddress(result2.getString("address"));
			S.setLat(result2.getFloat("lat"));
			S.setLang(result2.getFloat("lang"));
			S.setWebsite(result2.getString("website"));
		}
		con.close();
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
		service.setServiceName(result.getString("service_name"));
		service.setCenterId(result.getInt("center_id"));
		service.setCenterName(result.getString("center_name"));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("admin_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("service_review"));
		service.setLat(result.getFloat("lat"));
		service.setLang(result.getFloat("lang"));
		service.setWebsite(result.getString("website"));
		service.setSlotType(result.getInt("day_or_time"));
		service.setSlot(result.getInt("slot"));
		services.add(service);
		}
		con.close();
		return services;
			
	}
	
	public static List<Service> getServicesOfCenter(int centerId)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
				
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM service JOIN center ON service.center_id=center.center_id WHERE center.center_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, centerId);
		ResultSet result = ps.executeQuery();
		
		List<Service> services = new ArrayList<Service>();
		
		while(result.next()) {
		Service service = new Service();
		service.setServiceId(result.getInt("service_id"));
		service.setServiceName(result.getString("service_name"));
		service.setCenterId(result.getInt("center_id"));
		service.setCenterName(result.getString("center_name"));
		service.setLastUpdated(result.getDate("last_updated"));
		service.setFees(result.getString("fees"));
		service.setAdminId(result.getInt("admin_id"));
		service.setGoogleMapsUrl(result.getString("google_maps_url"));
		service.setAddress(result.getString("address"));
		service.setServiceReview(result.getFloat("service_review"));
		service.setLat(result.getFloat("lat"));
		service.setLang(result.getFloat("lang"));
		service.setWebsite(result.getString("website"));
		service.setSlotType(result.getInt("day_or_time"));
		service.setSlot(result.getInt("slot"));
		services.add(service);
		}
		con.close();
		return services;
			
			}	
	
	public static List<Appointment> getAppointmentsOfService(int serviceId) throws 
	SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM appointment JOIN service ON appointment.service_id = service.service_id WHERE appointment.service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
		
		List<Appointment> apps = new ArrayList<Appointment>();
		
		while(result.next()) {
			Appointment app = new Appointment();
			app.setAppointmenId(result.getInt("appointment_id"));
			app.setDay(result.getString("app_day"));
			app.setAppFrom(result.getTime("app_from"));
			app.setAppTo(result.getTime("app_to"));
			app.setServiceId(result.getInt("service_id"));
			app.setClinicId(result.getInt("clinic_id"));
			app.setAvailable(result.getInt("available"));
			app.setBookedSessions(result.getInt("booked_sessions"));
			
			apps.add(app);
		}
		con.close();
		return apps;
	}
	
	public static Appointment getAppointmentOfService(int serviceId, String day) throws 
	SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException{
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM appointment JOIN service ON appointment.service_id = service.service_id WHERE appointment.service_id=? AND appointment.app_day=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setString(2, day);
		ResultSet result = ps.executeQuery();
		Appointment app = new Appointment();
		if(result.next()) {			
		app.setAppointmenId(result.getInt("appointment_id"));
		app.setDay(result.getString("app_day"));
		app.setAppFrom(result.getTime("app_from"));
		app.setAppTo(result.getTime("app_to"));
		app.setServiceId(result.getInt("service_id"));
		app.setClinicId(result.getInt("clinic_id"));
		app.setAvailable(result.getInt("available"));
		app.setBookedSessions(result.getInt("booked_sessions"));
		}
		con.close();
		return app;
	}
	
	public static boolean checkTimeBooking(int serviceId, String day, Time time) throws 
	SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException{
		
		String timeAsString = time.toString();
		timeAsString = timeAsString+":00";
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM booking WHERE service_id=? AND day_of_time=? AND time_from=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setString(2, day);
		ps.setTime(3, time);
		ResultSet result = ps.executeQuery();
		result.next();
		boolean exists = (result.getRow()==1);
		
		con.close();
		return exists;
	}
	
	public static List<String> getServices(){
		
		List<String> services = new ArrayList<String>();
		services.add("MRI");
		services.add("ICU");
		services.add("CT");
		
		return services;
	}

	public static boolean checkUserReviewOfService(int userId, int serviceId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM review WHERE service_id=? AND user_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ps.setInt(2, userId);
		ResultSet result = ps.executeQuery();
		result.next();
		boolean exists = result.getRow()>0;		
		con.close();
		
		return exists;
	}

	public static void setServiceReview(int userId, int serviceId, int review) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO review (user_id, service_id, review) VALUES(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ps.setInt(2, serviceId);
		ps.setInt(3, review);
		ps.executeUpdate();
		con.close();
	}

	public static void updateServiceReview(int serviceId) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT review FROM review WHERE service_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, serviceId);
		ResultSet result = ps.executeQuery();
		float totalReview = 0;
		int numOfRows = 0;
		while(result.next()) {
			totalReview += result.getFloat("review"); 
			numOfRows++;
		}
		
		float average = totalReview/numOfRows;
		
		String sql2 ="UPDATE service SET service_review=? WHERE service_id=?";
		PreparedStatement ps2 = con.prepareStatement(sql2);
		ps2.setFloat(1, average);
		ps2.setInt(2, serviceId);
		ps2.executeUpdate();
		
		con.close();
	}

	public static void updateUserServiceReview(int userId, int serviceId, int review) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql2 ="UPDATE review SET review=? WHERE service_id=? AND user_id=?";
		PreparedStatement ps2 = con.prepareStatement(sql2);
		ps2.setInt(1, review);
		ps2.setFloat(2, serviceId);
		ps2.setInt(3, userId);
		ps2.executeUpdate();
		
		con.close();		
	}

	
	public static void insertComment(int userId, int serviceId, String comment) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="INSERT INTO review (user_id, service_id, comment) VALUES(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, userId);
		ps.setInt(2, serviceId);
		ps.setString(3, comment);
		ps.executeUpdate();
		con.close();	
	}

}