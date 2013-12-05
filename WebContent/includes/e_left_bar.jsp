<%@page import="constants.SessionConstants" %>
<div class="CircleSideBarLeft">

	<div class="CurrentUser">
		Employee Toolbar
	</div>
	
	<a href="<%=SessionConstants.EMPLOYEE_HOME_LOCATION%>">Home</a>
	<%
		if("Customer Representative".equals(session.getAttribute(SessionConstants.EMPLOYEE_TYPE))) {
	%>
		<br />
		<a href="<%=SessionConstants.CUSTOMER_MAILING_LIST_LOCATION%>">Customer Mailing List</a>
	<% } %>

</div>