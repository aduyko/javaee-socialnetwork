<%@page import="constants.SessionConstants" %>
<div class="CircleSideBarLeft">

	<a href="<%=SessionConstants.HOME_LOCATION%>">Home</a>
	<br />
	<a href="<%=SessionConstants.MESSAGE_LOCATION%>">My Messages</a>
	<div class="CurrentUser">
		<span class="Username" style="color: #00a; font-weight: bold;">
			</span>
	</div>
	<a href="<%=SessionConstants.BEST_SELLER_LIST%>">Best Seller List</a>
	<br />
	<a href="/cse-305/Circle?action=home">My Circles</a>

</div>