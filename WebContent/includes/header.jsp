<%@page import="constants.SessionConstants" %>

<div class="CircleHeader">

	<div style="margin: 0px 0px -15px 0px;" class="CircleSearch">
		<form style="width:100%;" class="form-search input-group CircleSearchForm" action="servlets/user_signup.jsp" method="post">
			<div style="padding: 3px;" class="CircleSearchFormDiv">
				<span class="CircleSearchLabel">90's Cover Band</span> <input type="text"
					class="input-medium search-query form-control"
					placeholder="Search for a user" style="width: 350px;">
				<input type="submit" class="submitCircleSearch"/>
				<span style="float:right;">
					<%=session.getAttribute(SessionConstants.USERNAME) %>
					<a href="/cse-305/servlets/user_logout.jsp">Logout</a>
				</span>
			</div>
		</form>
	</div>
	<hr />
</div>