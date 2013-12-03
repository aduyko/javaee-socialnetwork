<%@page import="constants.SessionConstants" %>
<%
	session.removeAttribute(SessionConstants.EMPLOYEE_ID);
	session.removeAttribute(SessionConstants.EMPLOYEE_TYPE);
	session.removeAttribute(SessionConstants.EMPLOYEE_NAME);
	response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION); 
%>