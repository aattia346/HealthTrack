<%@page import="com.gp.user.Service"%>
<%@page import="com.gp.user.ServiceDao"%>

<%@page import="java.util.List"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% String title = "Waiting List"; %>

<%@include  file="includes/header.jsp" %>

<div class="waiting-body">
	 <div class="container">
            <div class="row">
                <div class="col-sm-offset-3 col-sm-6 waiting-form">
                    <form method="post" action="/HealthTrack/Waiting/Submit">
                        <h4 class="waiting-header"><%= t.write("insert your contact info.") %></h4>
                        <input type="hidden" name="id">
                        <div class="form-group">
                            <input type="text" name="name" class="form-control" placeholder="<%= t.write("name") %>" value="${oldName}">
                            <div class="waiting-icon"><i class="fa fa-user fa-2x"></i></div>
                        </div>
                        ${invalidName}
                        <div class="form-group">
                            <input type="text" name="phone" class="form-control" placeholder="<%= t.write("phone") %>" value="${oldPhone}">
                            <div class="waiting-icon"><i class="fa fa-phone fa-2x"></i></div>
                        </div>
                        ${invalidPhone}
                        <div class="form-group">
                            <select name="service" class="form-control">
                                <option value="0"><%= t.write("select service") %></option>
                                <c:forEach var="service" items="${services}">
                                	<option value="ICU"><%= t.write("ICU") %></option>
                                	<option value="Incubator"><%= t.write("Incubator") %></option>
                                </c:forEach>
                            </select>
                        </div>
                        ${invalidService}
                        <div class="form-group">
                            <input type="submit" value="<%= t.write("submit") %>" class="form-control btn btn-danger">
                            <div class="waiting-icon submit-icon"><i class="fa fa-send fa-2x"></i></div>
                        </div>
                    </form>
            </div>
            </div>
            ${submitSucceed}
    </div>
</div>

<%@include  file="includes/footer.jsp" %>
