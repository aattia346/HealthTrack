package com.gp.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		result.next();
		
		Appointment app = new Appointment();
		app.setAppointmenId(result.getInt("appointment_id"));
		app.setDay(result.getString("app_day"));
		app.setAppFrom(result.getTime("app_from"));
		app.setAppTo(result.getTime("app_to"));
		app.setServiceId(result.getInt("service_id"));
		app.setClinicId(result.getInt("clinic_id"));
		app.setAvailable(result.getInt("available"));
		app.setBookedSessions(result.getInt("booked_sessions"));
					
		con.close();
		return app;
	}
}

