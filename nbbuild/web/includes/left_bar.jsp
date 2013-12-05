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

	<div class="CirclesListOwner">
		<span class="ListTitle">Circle Owner</span>
		<ul class="OwnerList">
				
		</ul>
	</div>

	<div class="CirclesListMember">
		<span class="ListTitle">Circle Member</span>
		<ul class="MemberList">
			
		</ul>
	</div>

</div>