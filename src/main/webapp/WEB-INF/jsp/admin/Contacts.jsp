<%@page import="com.gp.user.User"%>
<%@page import="com.gp.user.UserDao"%>
<%@page import="com.gp.user.Hospital"%>
<%@page import="com.gp.user.HospitalDao"%>
<%@page import="com.gp.user.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 	String title = "Contacts";
	String username = (String)session.getAttribute("username");
	User admin = UserDao.getUserByUsername(username);
	List<Contact> allContacts = new ArrayList<Contact>();
	allContacts = ContactDao.getAllContacts();
	request.setAttribute("contacts", allContacts);
       
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
                            <li><%=t.write("Contacts",lang) %></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <strong class="card-title"><%=t.write("Data Table",lang) %></strong>
                        </div>
                        <div class="card-body">
                  <table id="bootstrap-data-table" class="table table-striped table-bordered">
                    <thead>
                      <tr>

                      	<th><%=t.write("Contact ID",lang) %></th>
                        <th><%=t.write("User Name",lang) %></th>
                        <th><%=t.write("Email",lang) %></th>
                        <th><%=t.write("msg",lang) %></th>
                        <th><%=t.write("Action",lang) %></th>

                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="contact" items="${contacts}">
                      	
                      	<% 
                      	    Contact contact         = (Contact)pageContext.getAttribute("contact");
                      	    String userName         = contact.getName();
                      	    User user               = UserDao.getUserByUsername(userName);
                      	    request.setAttribute("user", user);
                      		
                      	%>
                      	<tr id="contact-${contact.getContactId()}">
                        <td>${contact.contactId}</td>
                        <td><a href="/HealthTrack/profile/user/${user.id}" target="_blank"><%= contact.getName() %></a></td>
                        <td>${contact.email}</td>
                        <td>${contact.msg}</td>
                       
                        
                         <td>
                        <a class="dashboard-btn confirm-delete-contact" href="/HealthTrack/admin/<%= admin.getUsername() %>/contact/delete/<%=contact.getContactId()%>" title=<%=t.write("Delete this Contact",lang) %>><i class="fa fa-close"></i></a>
                        <% if(contact.getSeen() == 0){ %>
                        		<a class="confirm-read-contact" href="/HealthTrack/admin/<%= admin.getUsername() %>/contact/seen/<%=contact.getContactId()%>" title="<%= t.write("Mark as read" , lang) %>"><i class="fa fa-eye"></i></a>
                        <% }else if(contact.getSeen() == 1){ %>
                        		<a class="confirm-unread-contact" href="/HealthTrack/admin/<%= admin.getUsername() %>/contact/unseen/<%=contact.getContactId()%>" title="<%= t.write("Mark as unread" , lang) %>"><i class="fa fa-eye-slash"></i></a>
                        <% } %>
                        </td>
                       
                       
                      </tr>
                      
                      </c:forEach>
                    
                    </tbody>
                  </table>
                        </div>
                    </div>

                </div>

                </div>
            </div><!-- .animated -->
        </div><!-- .content -->

    </div><!-- /#right-panel -->

    <!-- Right Panel -->

<%@include  file="includes/footer.jsp" %>