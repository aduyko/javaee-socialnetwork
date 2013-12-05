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
	</ul>
</div>