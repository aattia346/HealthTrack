<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<title>Insert title here</title>
</head>
<body>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.service.serviceDao"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Booking"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<% String title="addservice"; %>
	 <%@include  file="includes/header.jsp" %>
	 <% 
	 HttpSession hospitalSession = request.getSession();
		int serviceId = (Integer)hospitalSession.getAttribute("serviceId");
		Calendar calendar = Calendar.getInstance();
		Date today = Calendar.getInstance().getTime();
		calendar.setTime(today);
		calendar.add(Calendar.DAY_OF_MONTH, 2);
		

		SimpleDateFormat todayFormat = new SimpleDateFormat ("yyyy-MM-dd");
		Date available_to = calendar.getTime();
		String available_toMyFormat = todayFormat.format(available_to);
		String todayInMyFormat = todayFormat.format(today);		
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		Date available_from = calendar.getTime();
		String available_fromMyFormat = todayFormat.format(available_from); %>
	 
	<h3>Welcome, add new service</h3>
        <form method="post" action="/HealthTrack/insert">
             <table>
                <tr>
                    <td><label>Service Name</label></td>
                    <td><input type="text" name="Name"></td>
                </tr>
            <tr>
                    <td><label>Available from</label></td>
                    <td> <input type="date"  class="booking-date" name="available"  value="<%= available_fromMyFormat %>"></td>
                </tr>
                
                <tr>
                    <td><label>Available to</label></td>
                    <td> <input type="date"  class="booking-date" name="available2"  value="<%= available_toMyFormat %>"></td>
                </tr>
                    
            <!--    <tr>
                    <td><label>Available from</label></td>
                    <td><input type="text" name="lastUpdate" value=<%=todayInMyFormat %>></td>
                </tr>
                 -->  
         
                 <tr>
                    <td><label>Fees</label></td>
                    <td><input type="text" name="fees"></td>
                </tr>
                 
                
              <!--   <tr> <td><label>Time available</label></td>  <td><input type="int" name="Time_available" value=></td> </tr>      --> 
   
                <tr>
                    <td><input type="submit" value="Submit"/></td>
                </tr>
            </table>
        </form>



 <%@include  file="includes/footer.jsp" %>

</body>
</html>
