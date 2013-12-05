<%@page import="constants.SessionConstants" %>
<div class="CircleSideBarLeft">

	<div class="CurrentUser">
		Employee Toolbar
	</div>
	

	<ul>
		<li>
		<a href="/cse-305/Advertisement?action=portal&actor=<%= session.getAttribute("employeetype") %>">Management</a>
		</li>
		<li>
		<a href="<%=SessionConstants.EMPLOYEE_HOME_LOCATION%>">Home</a>
		</li>
		<%
			if("Customer Representative".equals(session.getAttribute(SessionConstants.EMPLOYEE_TYPE))) {
		%>
		<li>
		<a href="<%=SessionConstants.CUSTOMER_MAILING_LIST_LOCATION%>">Customer Mailing List</a>
		</li>
		<% } %>
	</ul>

</div>