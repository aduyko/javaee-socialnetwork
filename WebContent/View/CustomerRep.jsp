<%-- 
    Document   : CustomerRep
    Created on : Dec 4, 2013, 7:37:51 PM
    Author     : Andy
--%>

<%@page import="constants.SessionConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Representative Portal</title>
		<% 
			if (!session.getAttribute(SessionConstants.EMPLOYEE_TYPE).equals("Customer Representative"))
				response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION);
		%>
    </head>
    <body>
		${message}
		<a href ="Advertisement?action=newAd">New Ad</a><br />
		<a href ="Advertisement?action=newTransaction">Record Transaction</a><br />
        <h1>Hello ${employeetype}!</h1>
		<c:forEach items="${repAds}" var="ad">
			${ad.adId} 
			<form action="Advertisement" method="post">
				<input type="hidden" name="action" value="deleteAd" />
				<input type="submit" value="Delete Ad" />
				<input type="hidden" name="deleteId" value="${ad.adId}" />
			</form>
		</c:forEach>
    </body>
</html>
