<%-- 
    Document   : Manager
    Created on : Dec 4, 2013, 8:04:09 PM
    Author     : Andy
--%>

<%@page import="constants.SessionConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
		<% 
			if (!session.getAttribute(SessionConstants.EMPLOYEE_TYPE).equals("Manager"))
				response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION);
		%>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
