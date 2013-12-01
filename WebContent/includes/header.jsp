<%@page import="constants.SessionConstants" %>

<div class="CircleHeader">

	<div style="margin: 0px 0px -15px 0px;" class="CircleSearch">
		<form style="width:100%;" class="form-search input-group CircleSearchForm" action="<%=SessionConstants.SEARCH_USER_LOCATION%>" method="post">
			<div style="padding: 3px;" class="CircleSearchFormDiv">
				<span class="CircleSearchLabel">90's Cover Band</span> <input name="search" type="text"
					class="input-medium search-query form-control"
					placeholder="Search for a user" style="width: 350px;">
				<input type="submit" class="submitCircleSearch"/>
				<span style="float:right;">
					<%=session.getAttribute(SessionConstants.USERNAME) %>
					<a href="<%=SessionConstants.USER_LOGOUT_LOCATION%>">Logout</a>
				</span>
			</div>
		</form>
	</div>
	<hr />
</div>