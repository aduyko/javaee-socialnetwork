<%@page import="constants.SessionConstants" %>
<%
	session.removeValue(SessionConstants.USERID);
	session.removeValue(SessionConstants.USERNAME);
	response.sendRedirect("../home.jsp"); 
%>