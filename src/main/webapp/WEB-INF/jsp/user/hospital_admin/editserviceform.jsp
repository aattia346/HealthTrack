<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256" />
<title>Edit service</title>
</head>
<body>

<%@ page import=' com.gp.service.serviceClass' %>
<%@ page import='com.gp.service.serviceDao' %>

<%@taglib uri='http://www.springframework.org/tags/form' prefix='form' %>
<%@taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>


<h1> Update service information</h1>
<form method="post" action="update">
             <table>
                 <tr>
                    <td><label>Status</label></td>
                    <td><input type="text" name="state"></td>
                </tr>
              
                <tr>
                    <td><label>fees</label></td>
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
</body>
</html>