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
        <form name="new_tr" action="Advertisement" method="post">
			<label>Transaction ID</label>
			<input type="text" name="tranId" /><br />
			<label>Ad ID</label>
			<input type="text" name="adId" /><br />
			<label>Number of Units</label>
			<input type="text" name="numUnits" /><br />
			<label>Account</label>
			<input type="text" name="account" /><br />
			<input type="submit" value="submit" />
			<input type="hidden" name="action" value="postTransaction" />
		</form>
    </body>
</html>
