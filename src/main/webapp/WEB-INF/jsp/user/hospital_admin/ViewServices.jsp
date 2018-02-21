<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<title>Add service</title>

</head>
<body>

<%@ page import=' com.gp.service.serviceClass' %>
<%@ page import='com.gp.service.serviceDao' %>

<%@ page import='java.util.*' %>
<%@ page import='javax.servlet.http.*,javax.servlet.*' %>

<div class='container'>
<h3>Service List</h3>
<table class='table table-bordered'>

<tr>
<th>Id</th>
<th>Status</th>
<th>Fees</th>
<th>rating</th>

<%--    <th>Time available</th> --%>

</tr>

<%
List<serviceClass> list =serviceDao.getAllRecords();%>
<% for (serviceClass s:list){ %>
<tbody>
<c:foreach>
<tr>
<td><%=s.getId() %></td>
<td><%=s.getstatus() %></td>
<td><%=s.getfees() %></td>
<td><%=s.getrating() %></td>


<%--   <td><%=s.getTime()%></td> --%>

<td><a href='/HealthTrack/deleteservice/<%=s.getId()%>'>Delete</a></td>
<td><a href='/HealthTrack/editservice/<%=s.getId()%>'>Edit</a></td>



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