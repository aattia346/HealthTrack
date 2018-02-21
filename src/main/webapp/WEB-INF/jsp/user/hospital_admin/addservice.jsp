<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<title>Insert title here</title>
</head>
<body>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<% String title="addservice"; %>
	 <%@include  file="includes/header.jsp" %>
	 
	<h3>Welcome, add new service</h3>
        <form method="post" action="/HealthTrack/insert">
             <table>
                <tr>
                    <td><label>Status</label></td>
                    <td><input type="text" name="state"></td>
                </tr>
         
                 <tr>
                    <td><label>Fees</label></td>
                    <td><input type="text" name="fees"></td>
                </tr>
                 <tr>
                    <td><label>rating</label></td>
                    <td><input type="text" name="rating"></td>
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