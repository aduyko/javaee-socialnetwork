<%-- 
    Document   : NewAd
    Created on : Dec 4, 2013, 7:46:36 PM
    Author     : Andy
--%>

<%@page import="sun.rmi.server.Dispatcher"%>
<%@page import="constants.SessionConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Advertisement</title>
		<% 
			if (!session.getAttribute(SessionConstants.EMPLOYEE_TYPE).equals("Customer Representative"))
				response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION);
		%>
    </head>
    <body>
        <form name="new_ad" action="Advertisement" method="post">
			<label>Item Name</label>
			<input type="text" name="itemName" /><br />
			<label>Type</label>
			<input type="text" name="type" /><br />
			<label>Company</label>
			<input type="text" name="company" /><br />
			<label>Description</label>
			<input type="textarea" name="content" /><br />
			<label>Price</label>
			<input type="text" name="unitPrice" /><br />
			<label>Available Units</label>
			<input type="text" name="availableUnits" /><br />
			${message}
			<%= request.getAttribute("message") %>
			<input type="submit" value="submit" />
			<input type="hidden" name="employee" value="${employeeid}" />
			<input type="hidden" name="action" value="newAd" />
		</form>
    </body>
</html>
