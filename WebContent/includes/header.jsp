<%@page import="constants.SessionConstants" %>

<div class="CircleHeader">

	<div class="CircleSearch">
		<form class="form-search input-group CircleSearchForm" action="servlets/user_signup.jsp" method="post">
			<div style="padding: 3px;" class="CircleSearchFormDiv">
				<span class="CircleSearchLabel">90's Cover Band</span> <input type="text"
					class="input-medium search-query form-control"
					placeholder="Search for a user" style="width: 350px;">
				<input type="submit" class="submitCircleSearch"/>
			</div>
		</form>

		<div class="Logout" style="float: right;">
			<%=session.getAttribute(SessionConstants.USERNAME) %>
			<a href="/cse-305/servlets/user_logout.jsp">Logout</a>
		</div>

	</div>

	<hr />
</div>