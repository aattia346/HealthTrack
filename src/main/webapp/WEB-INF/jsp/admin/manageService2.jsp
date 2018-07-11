<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>
<%@page import="com.gp.user.Center"%>
<%@page import="com.gp.user.CenterDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.Department"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Validation"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<% 		
	String action = (String)request.getAttribute("action");

%>



<%if(action.equalsIgnoreCase("add")){
	String title = "Add New Service";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	%>
<%@include  file="includes/header.jsp" %>
<div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1><%=t.write("Dashboard",lang) %></h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="/HealthTrack/admin/dashboard"><%=t.write("Dashboard",lang) %></a></li>
                            <li><a href="/HealthTrack/admin/<%= admin.getUsername()%>/services"><%=t.write("Services",lang) %></a></li>
                            <li><%=t.write("Add New Service",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        
        <form class="col-lg-12" action="/HealthTrack/admin/service/insert" method="post">
                    <div class="card">
                      <div class="card-header"><strong><%=t.write("Service",lang) %></strong><small><%=t.write("Form",lang) %></small></div>
                      <div class="card-body card-block">
                      
                         	<div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Service Name",lang) %></label>
                              <select name="serviceName" class="form-control">
                                <option value="0"><%=t.write("Please select",lang) %></option>
                                <%
                                	List<String> services = new ArrayList<String>();
                                    services = ServiceDao.getServices();
                                	request.setAttribute("services", services);
                                %>
                                <c:forEach var="service" items="${services}">
                           <%      
                          String s = (String)pageContext.getAttribute("service");
                           %>
                             <option value="${service}"><%= t.write(s,lang) %></option>

                                </c:forEach>
                              </select>
                               ${invalidName}
	                           ${nameExist}
	                           ${shortName}                            
                            </div>
                          

<script type="text/javascript">

    function populate(s1, s2) {
  	  var s1 = document.getElementById(s1);
  	  var s2 = document.getElementById(s2);
  	  s2.innerHTML = "";
  	  if (s1.value =="Hospital"){
  		  var optionArray = ["i10", "i20", "Verna"];
  	  }else if (s1.value =="Center"){
  		  var optionArray = ["mero", "Ahmed", "Khalid"];
  	  }	    
  	 
  
</script>


                            <div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose add on center or hospital",lang) %></label>
                              <select id="slct1" class="form-control" onchange="populate(this.id,'slct2')">
                                <option value="0"><%=t.write("Please select",lang) %></option>
                                
                             <option value="Hospital"><%=t.write("Hospital",lang) %></option>
                             <option value="Center"><%=t.write("Center",lang) %></option>                             
                              </select>                                                          
                            </div>                     
                            <div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose the Center or Hospital",lang) %></label>
                              <select id=slct2 name="centerId" class="form-control">
                                <option value="0"><%=t.write("Please select",lang) %></option>
                                
                              </select>                                                          
                            </div>                
                            
                          <div class="form-group">
                      		  <label class=" form-control-label"><%=t.write("Choose Type of Service",lang) %></label>
                              <select name="type" class="form-control">
                                <option value="0"><%=t.write("Please select",lang) %></option>
                                
                             <option value=1><%=t.write("Day Service",lang) %></option>
                             <option value=2><%=t.write("Time Service",lang) %></option>                             
                              </select>                                                          
                            </div>

                            
                            <button type="submit" class="btn btn-primary col-sm-12"><i class="fa fa-send"></i><%=t.write("Submit",lang) %></button>
                      </div>
                    </div>
                  </form>
                  
                  
	<% } %>
<%@include  file="includes/footer.jsp" %>