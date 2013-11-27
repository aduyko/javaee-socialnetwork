<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fbp</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />

<script type="text/javascript" src="/cse-305/Scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/cse-305/Scripts/Circle/Circle.js"></script>

</head>

<body>
	<div class="CircleHeader">

		<div class="CircleSearch">
			<form class="form-search input-group CircleSearchForm">
				<div style="padding: 3px;" class="CircleSearchFormDiv">
					<span class="CircleSearchLabel">Fb+</span> <input type="text"
						class="input-medium search-query form-control"
						placeholder="Search for Circle" style="width: 350px;">
					<button type="submit" class="submitCircleSearch">Search</button>
				</div>
			</form>

			<div class="Logout" style="float: right;">
				<a href="#">Logout</a>
			</div>

		</div>

		<hr />
	</div>

	<div class="CircleSideBarLeft">

		<div class="CurrentUser">
			<span class="Username" style="color: #00a; font-weight: bold;">
				${username}</span>
		</div>

		<div class="CirclesListOwner">
			<span class="ListTitle">Circle Owner</span>
			<ul class="OwnerList">
				<c:forEach items="${owner}" var="circle">
					<li class="OwnerCircle" data-circleId="${circle.getCircleId()}"
						data-circleName="${circle.getName()}"
						data-circleType="${circle.getType()}"><a
						style="text-decoration: none;"
						href="/cse-305/CircleServlet?action=ViewCircle&Id=
						${circle.getCircleId()}&Name=${circle.getName()}&Owner=Yes"><c:out
								value="${circle.getName()}" /></a></li>
				</c:forEach>
			</ul>
		</div>

		<div class="CirclesListMember">
			<span class="ListTitle">Circle Member</span>
			<ul class="MemberList">
				<c:forEach items="${member}" var="circle">
					<li class="MemberCircle" data-circleId="${circle.getCircleId()}"
						data-circleName="${circle.getCircleName()}"><a
						style="text-decoration: none;"
						href="/cse-305/CircleServlet?action=ViewCircle&Id=
						${circle.getCircleId()}&Name=${circle.getCircleName()}&Owner=No"><c:out
								value="${circle.getCircleName()}" /></a></li>
				</c:forEach>
			</ul>
		</div>

	</div>

	<div class="CircleCentral">

		<div id="circle_main" class="CircleBody" style="clear: both;">

			<div class="CircleBodyHeader">
				<c:choose>
					<c:when test="${view_post}">
						<a class="active"
							href="/cse-305/CircleServlet?action=ViewCircle&Id=${current_circle_id}">${current_circle_name}</a>
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewCircleMembers&Id=${current_circle_id}">Members</a>
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewAbout&Id=${current_circle_id}">About</a>
					</c:when>
					<c:when test="${view_members}">
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewCircle&Id=${current_circle_id}">${current_circle_name}</a>
						<a class="active"
							href="/cse-305/CircleServlet?action=ViewCircleMembers&Id=${current_circle_id}">Members</a>
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewAbout&Id=${current_circle_id}">About</a>
					</c:when>
					<c:when test="${view_about}">
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewCircle&Id=${current_circle_id}">${current_circle_name}</a>
						<a class="inactive"
							href="/cse-305/CircleServlet?action=ViewCircleMembers&Id=${current_circle_id}">Members</a>
						<a class="active"
							href="/cse-305/CircleServlet?action=ViewAbout&Id=${current_circle_id}">About</a>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</div>

			<c:if test="${view_post}">
				<div class="UserPost" style="clear: both;">
					<textarea id="UserPost" rows="3" cols="62"
						placeholder="What's on your mind?"
						style="display: block; border: 1px solid #aeaeae;"></textarea>
					<div id="PostSubmitDiv" class="UserPostSubmit"
						data-circleId="${current_circle_id}" data-curUserId="${userid}"
						data-authorName="${username}">
						<button id="PostSubmitBtn" class="btn btn-small btn-primary"
							type="button">Post</button>
					</div>
				</div>
			</c:if>

			<div
				style="text-align: center; width: 517px; padding-top: 10px; padding-bottom: 5px;">
				<hr
					style="width: 20%; float: left; margin-left: auto; margin-right: auto;" />
				<span style="font-size: smaller; color: #dedede; font-weight: bold;">Recent
					Posts</span>
				<hr
					style="width: 60%; float: right; margin-left: auto; margin-right: auto;" />
			</div>

			<div class="CirclePosts" style="clear: both;">
				<c:choose>
					<c:when test="${view_post}">
						<ul id="Post_List" class="PostList">
							<c:forEach items="${posts}" var="post">
								<li>
									<div class="PostDiv">
										<a href="#?action=ViewUser&Uid=${post.getAuthorId()}"
											style="display: block; color: #00a; font-weight: bold;">${post.getAuthorName()}</a>
										<p style="display: block;">${post.getContent()}</p>
										<div class="PostDivOptions">
											<!-- See if the current user has already liked this post -->
											<c:choose>
												<c:when test="${post.isCurrentUserLiked()}">
													<span class="LikePost" data-postId="${post.getPostId()}"
														data-userId="${userid} data-likeStatus="unlike">Unlike</span>
												</c:when>
												<c:when test="${!post.isCurrentUserLiked()}">
													<span class="LikePost" data-postId="${post.getPostId()}"
														data-userId="${userid} data-likestatus="like">Like</span>
												</c:when>
											</c:choose>
											<span class="PostComment" data-postId="${post.getPostId()}"
												data-userId="${userid}" data-userName="${username}">Comment</span>
										</div>
										<div class="PostLikes">
											<span><i class="glyphicon glyphicon-thumbs-up"></i> <span
												class="PeoplePostLikeList">${post.getLikeCount()}
													people</span><span> like this</span> </span>
										</div>
										<div class="PostDivComments">
											<ul class="CommentList">
												<c:forEach items="${post.getComments()}" var="comment">
													<li>
														<div class="CommentDiv">
															<span
																style="font-size: small; color: #00a; font-weight: bold;">${comment.getAuthorName()}</span>
															<div>
																<span>${comment.getContent()}</span>
															</div>
															<span
																style="color: #aeaeae; font-size: small; margin-right: 3px;">${comment.getDate().toString()}</span>
															<!-- See if the current user has already liked this comment -->
															<c:choose>
																<c:when test="${comment.isCurrentUserLiked()}">
																	<span class="LikeComment"
																		data-commentId="${comment.getCommentId()}"
																		data-userId="$userid"> Unlike</span>
																</c:when>
																<c:when test="${!comment.isCurrentUserLiked()}">
																	<span class="LikeComment"
																		data-commentId="${comment.getCommentId()}"
																		data-userId="$userid"> Like</span>
																</c:when>
															</c:choose>
															<span><i class="glyphicon glyphicon-thumbs-up"></i><span
																class="PeopleCommentLikeList">${comment.getLikeCount()}</span></span>
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
										<div class="WriteCommentDiv">
											<input type="text" placeholder="write a comment.."
												class="WriteComment" data-postId="${post.getPostId()}"
												data-userId="${$userid}" />
										</div>
									</div>
									<hr style="color: #dedede; width: 517px; margin-left: -40px;" />
								</li>
							</c:forEach>
						</ul>
					</c:when>
					<c:when test="${view_members}">
					</c:when>
					<c:when test="${view_about}">
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<div class="CircleSideBarRight"></div>

	<div class="CircleFooter">
		<span style="float: left; padding: 3px;">Fb+</span> <span
			style="float: right; padding: 3px;">Stony Brook University,
			Fall 2013</span>
	</div>

</body>
</html>