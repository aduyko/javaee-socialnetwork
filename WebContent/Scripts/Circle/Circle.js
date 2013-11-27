/**
 * JS for Circle.jsp, circle module
 * 
 * @author James C. Porcelli
 */

/**
 * When the page finishes loading in the browser
 */
function circleDOM_onReady() {

	// Button to submit a new Post
	var submitPostBtn = document.getElementById('PostSubmitBtn');
	submitPostBtn.addEventListener('click', makePost);

	// Link to comment on a post
	var posts = document.getElementsByClassName('PostComment');
	// Add listener to each post in DOM
	for ( var i = 0; i < posts.length; i++) {
		posts[i].addEventListener('click', function(e) {
			e.target.focus();
		});
	}

	// Submit in comment text box
	$('.WriteComment').keypress(function(e) {
		if (e.which == 13) {
			makeComment(e);
		}
	});

}

/**
 * 
 * @param e
 */
function likePost(e) {
	var post = e.target;

	var postId = post.getAttribute('data-postId');
	var userId = post.getAttribute('data-userId');

	$.ajax({
		type : 'POST',
		url : '/cse-305/CircleServlet?action=likePost',
		data : {
			'postId' : postId,
			'userId' : userId
		},
		success : function(data) {

		},
		dataType : json
	});
}

/**
 * 
 * @param e
 */
function unLikePost(e) {

}

/**
 * 
 * @param e
 */
function likeComment(e) {

}

/**
 * 
 * @param e
 */
function unLikeComment(e) {

}

/**
 * 
 * @param e
 */
function makePost(e) {

	console.log('Log: Making new post');

	var postTextArea = document.getElementById('UserPost');
	var postText = postTextArea.value;

	var postSubmitDiv = document.getElementById('PostSubmitDiv');
	var circleId = postSubmitDiv.getAttribute('data-circleId');
	var authorId = postSubmitDiv.getAttribute('data-curUserId');
	var authorName = postSubmitDiv.getAttribute('data-authorName');

	if (postText != "") {
		$
				.ajax({
					type : 'POST',
					url : '/cse-305/CircleServlet?action=makePost',
					data : {
						'content' : postText,
						'circleId' : circleId,
						'authorId' : authorId
					},
					success : function(data) {

						console.log('Log: new Post success');

						var newComment = '<li>\
								<div class="PostDiv">\
									<a href="#?action=ViewUser&Uid='
								+ authorId
								+ '" style="display: block; color: #00a; font-weight: bold;">'
								+ authorName
								+ '</a>\
									<p style="display: block;">'
								+ postText
								+ '</p>\
									<div class="PostDivOptions">\
										<span class="LikePost" data-postId="'
								+ data.postId
								+ '" data-userId="'
								+ authorId
								+ '">Like</span>\
										<span class="PostComment">Comment</span>\
									</div>\
									<div class="PostLikes">\
										<span><i class="glyphicon glyphicon-thumbs-up"></i> <span class="PeoplePostLikeList">0 people</span><span> like this</span></span>\
									</div>\
								</div>\
								<hr style="color: #dedede; width: 517px; margin-left: -40px;" />\
							</li>';

						var newCommentHtml = $(newComment);

						$('#Post_List').prepend(newCommentHtml);

						var postTextArea = document.getElementById('UserPost');
						postTextArea.value = "";
					},
					error : function(data, textStatus, jqXHR) {
						alert(textStatus);
					}
				});

	} else {
		// Text area empty
		return;
	}

}

/**
 * 
 * @param e
 */
function makeComment(e) {
	var commentInput = e.target;
	var comment = commentInput.value;

	var postId = commentInput.getAttribute('data-postId');
	var authorId = commentInput.getAttribute('data-userId');

	if (comment != "") {
		console.log(comment);

		$
				.ajax({
					type : 'POST',
					url : '/cse-305/CircleServlet?action=makePost',
					data : {

					},
					success : function(data) {
						console.log('Log: New commment success');

						var newComment = 
							'<li>\
								<div class="CommentDiv">\
									<span\
										style="font-size: small; color: #00a; font-weight: bold;">'+${comment.getAuthorName()}+'</span>\
								<div>\
									<span>'+${comment.getContent()}+'</span>\
								</div>\
								<span style="color: #aeaeae; font-size: small; margin-right: 3px;">'+${comment.getDate().toString()}+'</span>\
								<span class="LikeComment" data-commentId="'+${comment.getCommentId()}+'" data-userId="'+$userid+'"> Like</span>;\
								<span><i class="glyphicon glyphicon-thumbs-up"></i><span class="PeopleCommentLikeList">'+${comment.getLikeCount()}+'</span></span>\
								</div>\
							</li>';
						
						var newCommentHtml = $(newComment);
						
						var commentList = commentInput.closest('.CommentList');
						
						commentList.append(newCommentHtml);						
					},
					error : function(data, textStatus, jqXHR) {
						alert(textStatus);
					}

				});
	}

}

// DOM ready
$(document).ready(circleDOM_onReady);