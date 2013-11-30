<%@page import="constants.SessionConstants" %>
<%
	session.removeAttribute(SessionConstants.USERID);
	session.removeAttribute(SessionConstants.USERNAME);
	response.sendRedirect(SessionConstants.LOGIN_LOCATION); 
%>