<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<title>Add service</title>

</head>
<body>

<%@ page import=' com.gp.user.Service' %>
<%@ page import='com.gp.service.serviceDao' %>

<%@ page import='java.util.*' %>
<%@ page import='javax.servlet.http.*,javax.servlet.*' %>

<div class='container'>
<h3>Service List</h3>
<table class='table table-bordered'>

<tr>
<th>Id</th>
<th>Service Name</th>
<th>Available From</th> 
<th>Available To</th> 
<th>Fees</th>

<%--    <th>Time available</th> --%>

</tr>

<%
List<Service> list =serviceDao.getAllRecords();%>
<% for (Service s:list){ %>
<tbody>
<c:foreach>
<tr>
<td><%=s.getServiceId() %></td>
<td><%=s.getServiceName() %></td>
<td> <%=s.getAvailable_from() %></td>
<td> <%=s.getAvailable_to() %></td>
<td><%=s.getFees() %></td>




<%--   <td><%=s.getTime()%></td> --%>

<td><a href='/HealthTrack/deleteservice/<%=s.getServiceId()%>'>Delete</a></td>
<td><a href='/HealthTrack/editservice/<%=s.getServiceId()%>'>Edit</a></td>



</tr>
</c:foreach>
</tbody>
<% } %>
</table>
</div>
<a  href="/HealthTrack/addservice" class="btn btn-primary">Add service</a>

 <%@include  file="includes/footer.jsp" %>

</body>
</html>