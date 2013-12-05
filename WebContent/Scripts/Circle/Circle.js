/**
 * JS for Circle.jsp, circle module
 * 
 * @author James C. Porcelli
 */

/**
 * When the DOM finishes loading in the browser
 */
function circleDOM_onReady() {

	var curUrl = document.URL;
	console.log(curUrl);

	var curAction = curUrl.substring(curUrl.indexOf('cse-305'));
	curAction = curAction.substring(curAction.indexOf('action'));
	curAction = curAction.substring(curAction.indexOf('=') + 1);

	console.log('Log: Current action = ' + curAction);

	if (curAction === 'NewCircle') {
		document.URL = document.getElementById('ViewCurrentCircleHref').href;
	}

	$('#CreateCircle')
			.click(
					function(e) {
						var userid = e.target.getAttribute('data-userid');

						var form = '<div id="CreateCircleDiv" title="+ Create A Circle"\
			style="background: #fff;">\
		<form action="/cse-305/Circle?action=NewCircle" method="POST"\
			style="height: 100%;">\
			<div\
				style="height: 13%; clear: both; padding-bottom: 5px; background: #dedede; margin-top: -10px; height: 35px; margin-bottom: 5px;">\
				<h5 style="float: left; margin-left: 5px; font-weight: bold;">+\
					Create New Circle</h5>\
			</div>\
			<div style="padding: 3px; clear: both;">\
				<label style="float: left;">Name:</label> <input\
					style="float: right;" type="text" name="CreateCircle_Name"\
					id="CreateCircle_Name" />\
			</div>\
			<div style="padding: 3px; clear: both; padding-bottom: 20px;">\
				<label style="float: left;">Type:</label> <input\
					style="float: right;" type="text" name="CreateCircle_Type"\
					id="CreateCircle_Type" />\
			</div>\
			<input type="hidden" value="'
								+ userid
								+ '" name="CreateCircle_Owner"\
				id="CreateCircle_Owner" />\
			<div\
				style="clear: both; background: #dedede; width: 100%; height: 40px; border: 1px solid #aeaeae; margin-top: 25px; padding-top: 2px;">\
				<input style="float: right; padding: 5px;" type="submit" />\
				<button id="closeNewCircleDialog" style="float: right; padding: 5px; margin-right: 3px;" \>cancel</button>\
			</div>\
		</form>\
	</div>';

						var formHtml = $(form);

						formHtml.dialog({
							modal : true,
							closeOnEscape : true,
							open : function(event, ui) {
								$('#closeNewCircleDialog').click(function(e) {
									e.preventDefault();
									$('#CreateCircleDiv').dialog('close');
								});
							}
						});

						// $(".ui-dialog-titlebar").hide();
					});

	var firstPostEditSpan = document.getElementsByClassName('PostEditSpan')[0];
	firstPostEditSpan.style.marginRight = '-310px';

	var postEditDivs = document.getElementsByClassName('PostEdit');
	var postEditDivsCount = postEditDivs.length;

	for (var i = 1; i < postEditDivsCount; i++) {
		postEditDivs[i].style.marginTop = '-20px';
	}

	var postEditIcons = document.getElementsByClassName('postEditIcon');
	var postEditIconsCount = postEditIcons.length;

	var commentEditIcons = document.getElementsByClassName('commentEditIcon');
	var commentEditIconsCount = commentEditIcons.length;

	var circleEditIcons = document.getElementsByClassName('circleEditIcon');
	var circleEditIconsCount = circleEditIcons.length;

	$('.PostEdit').on({
		mouseover : function() {
			$(this).css({
				'opacity' : 1
			});
		},
		mouseleave : function() {
			$(this).css({
				'opacity' : 0
			});
		},
		click : function() {
			$(this).off('mouseleave');
		}
	});

	$('.CommentEdit').on({
		mouseover : function() {
			$(this).css({
				'opacity' : 1
			});
		},
		mouseleave : function() {
			$(this).css({
				'opacity' : 0
			});
		},
		click : function() {
			$(this).off('mouseleave');
		}
	});

	$('.CircleEdit').on({
		mouseover : function() {
			$(this).css({
				'opacity' : 1
			});
		},
		mouseleave : function() {
			$(this).css({
				'opacity' : 0
			});
		},
		click : function() {
			$(this).off('mouseleave');
		}
	});

	// If the alter post menu option div is not hidden on click
	// on the main doc (outside the menu, since thats not the main doc)
	// hide it, if its hidden, no effect
	$(document).mouseup(function(e) {
		var container = $('.AlterPostMenuDiv');

		if (!container.is(e.target) && container.has(e.target).length === 0) {
			container.closest('.PostEdit').on({
				mouseover : function() {
					$(this).css({
						'opacity' : 1
					});
				},
				mouseleave : function() {
					$(this).css({
						'opacity' : 0
					});
				},
			});

			container.remove();
		}
	});

	// If the alter post menu option div is not hidden on click
	// on the main doc (outside the menu, since thats not the main doc)
	// hide it, if its hidden, no effect
	$(document).mouseup(function(e) {
		var container = $('.AlterCommentMenuDiv');

		if (!container.is(e.target) && container.has(e.target).length === 0) {
			container.closest('.CommentEdit').on({
				mouseover : function() {
					$(this).css({
						'opacity' : 1
					});
				},
				mouseleave : function() {
					$(this).css({
						'opacity' : 0
					});
				},
			});

			container.remove();
		}
	});

	// If the alter post menu option div is not hidden on click
	// on the main doc (outside the menu, since thats not the main doc)
	// hide it, if its hidden, no effect
	$(document).mouseup(function(e) {
		var container = $('.AlterCircleMenuDiv');

		if (!container.is(e.target) && container.has(e.target).length === 0) {
			container.closest('.CircleEdit').on({
				mouseover : function() {
					$(this).css({
						'opacity' : 1
					});
				},
				mouseleave : function() {
					$(this).css({
						'opacity' : 0
					});
				},
			});

			container.remove();
		}
	});

	// Add the on click event to be a drop down list for each circle
	// alter attribute which is all of them, remove and rename, since
	// only owners can alter a circles name or delete it
	for (var i = 0; i < circleEditIconsCount; i++) {
		circleEditIcons[i]
				.addEventListener(
						'click',
						function(e) {
							var alterCircleIcon = e.target;
							var alterCircleSpan = e.target.parentNode;

							var circleId = alterCircleSpan
									.getAttribute('data-circleId');

							var alterCircleMenuDiv = document
									.createElement('div');
							alterCircleMenuDiv.className = 'AlterCircleMenuDiv';
							alterCircleMenuDiv.style.marginTop = '18px';
							alterCircleMenuDiv.style.border = '1px solid #000';

							// The drop down menu list
							var alterCircleMenuUl = document
									.createElement('ul');
							alterCircleMenuUl.style.listStyleType = 'none';

							// Rename circle option
							var editLi = document.createElement('li');
							editLi.addEventListener('mouseenter', function(e) {
								e.target.style.background = '#fff';
								e.target.style.cursor = 'pointer';
							});
							editLi.addEventListener('mouseleave', function(e) {
								e.target.style.background = '';
								e.target.style.cursor = '';
							});

							editLi.style.marginLeft = '-40px';
							editLi.style.padding = '3px';

							var editLiSpan = document.createElement('span');
							editLiSpan.className = 'EditCircleOption';

							editLiSpan.innerText = 'Rename Circle';

							editLi.appendChild(editLiSpan);
							alterCircleMenuUl.appendChild(editLi);

							// Rename the circle
							editLiSpan
									.addEventListener(
											'click',
											function(e) {
												console
														.log("Log: Renaming circle circle");

												var circleLi = e.target.parentNode.parentNode.parentNode.parentNode.parentNode;
												var circleName = circleLi.children[0].innerText;

												var circleNameAnc = circleLi.children[0];

												// Edit circle alteration
												// container
												var circleEditContainer = document
														.createElement('div');

												// Edit circle input container
												var circleEditInputDiv = document
														.createElement('div');

												// Edit circle input field
												var circleEditInput = document
														.createElement('input');
												circleEditInput.className = 'CircleEditInput';
												circleEditInput.value = circleName;
												circleEditInput.style.width = '100%';
												circleEditInput.style.marginTop = '5px';

												circleEditInput
														.addEventListener(
																'keypress',
																function(e) {
																	console
																			.log('Log: Circle name edit input field keypress event fired');
																	console
																			.log('Log:Info:Keypress='
																					+ e.which);
																	console
																			.log(e);

																	var otxt = $(
																			'.CircleEditInput')
																			.data(
																					'otxt');

																	if (otxt === ''
																			|| otxt === undefined
																			|| otxt === null) {
																		$(
																				'.CircleEditInput')
																				.data(
																						'otxt',
																						e.target.value);
																	}

																	// Return
																	// key
																	// code
																	var ENTER = 13;

																	if (e.which == ENTER) {

																		circleNameAnc.innerText = e.target.value;
																		e.target.parentNode.parentNode.parentNode
																				.appendChild(circleNameAnc);

																		e.target.parentNode.parentNode.parentNode
																				.removeChild(e.target.parentNode.parentNode.parentNode.children[1]);

																		$(
																				'.CircleEdit')
																				.on(
																						{
																							mouseover : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 1
																												});
																							},
																							mouseleave : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 0
																												});
																							},
																							click : function() {
																								$(
																										this)
																										.off(
																												'mouseleave');
																							}
																						});

																		$
																				.ajax({
																					type : 'POST',
																					url : '/cse-305/Circle?action=RenameCircle',
																					data : {
																						'circleId' : circleId,
																						'name' : e.target.value,
																					},
																					success : function(
																							data) {
																						console
																								.log('Log: update made to comment');
																					},
																					error : function(
																							data,
																							textStatus,
																							jqXHR) {
																						console
																								.log('Log:'
																										+ textStatus);
																					}
																				});
																	}
																});

												circleEditInput
														.addEventListener(
																'keyup',
																function(e) {
																	// Escape
																	// edit
																	// input
																	// field
																	// =>
																	// exit
																	// edit
																	// mode
																	if (e.keyCode == 27) {
																		console
																				.log('Log: escaping edit circle rename input field');
																		console
																				.log(e);

																		var otxt = $(
																				'.CircleEditInput')
																				.data(
																						'otxt');
																		console
																				.log('Log: original text = '
																						+ otxt);

																		circleNameAnc.innerText = otxt;
																		e.target.parentNode.parentNode.parentNode
																				.appendChild(circleNameAnc);

																		e.target.parentNode.parentNode.parentNode
																				.removeChild(e.target.parentNode.parentNode.parentNode.children[1])

																		$(
																				'.CircleEdit')
																				.on(
																						{
																							mouseover : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 1
																												});
																							},
																							mouseleave : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 0
																												});
																							},
																							click : function() {
																								$(
																										this)
																										.off(
																												'mouseleave');
																							}
																						});
																	}
																});

												// Add the edit circle name
												// input to the input container
												circleEditInputDiv
														.appendChild(circleEditInput);

												// Add the circleEditInput div
												// to the main container
												circleEditContainer
														.appendChild(circleEditInputDiv);

												var exitToEscapeNotice = document
														.createElement('span');
												exitToEscapeNotice.style.fontSize = 'smaller';
												exitToEscapeNotice.style.color = '#aeaeae';
												exitToEscapeNotice.innerText = 'Press Esc to cancel';

												// Add the esc to exit
												// notice to the edit
												// container
												circleEditContainer
														.appendChild(exitToEscapeNotice);

												// Remove the original span
												circleLi
														.removeChild(circleNameAnc);
												// Add the edit container
												circleLi
														.appendChild(circleEditContainer);

												// Remove the alter comment
												// menu
												alterCircleSpan
														.removeChild(alterCircleMenuDiv);

												circleEditInput.focus();

											});

							// Delete circle option
							var deleteLi = document.createElement('li');
							deleteLi.addEventListener('mouseenter',
									function(e) {
										e.target.style.background = '#fff';
										e.target.style.cursor = 'pointer';
									});
							deleteLi.addEventListener('mouseleave',
									function(e) {
										e.target.style.background = '';
										e.target.style.cursor = '';
									});

							deleteLi.style.marginLeft = '-40px';
							deleteLi.style.padding = '3px';

							var deleteLiSpan = document.createElement('span');
							deleteLiSpan.className = 'EditCommentOption';

							deleteLiSpan.innerText = 'Delete Circle';

							deleteLi.appendChild(deleteLiSpan);
							alterCircleMenuUl.appendChild(deleteLi);

							// Delete the circle
							deleteLiSpan
									.addEventListener(
											'click',
											function(e) {
												console
														.log("Log: Deleting circle");

												var circleLi = e.target.parentNode.parentNode.parentNode.parentNode.parentNode;
												var circleName = circleLi.children[0].innerText;

												var circleUl = circleLi.parentNode;

												for (var i = 0; i < circleUl.children.length; i++) {

													if (circleUl.children[i].children[0].innerText === circleName) {

														var childToRemove = circleUl.children[i];

														circleUl
																.removeChild(childToRemove);
													}
												}

												$
														.ajax({
															type : 'POST',
															url : '/cse-305/Circle?action=DeleteCircle',
															data : {
																'circleId' : circleId
															},
															success : function(
																	data) {
																console
																		.log('Log: update made to comment');
															},
															error : function(
																	data,
																	textStatus,
																	jqXHR) {
																console
																		.log('Log:'
																				+ textStatus);
															}
														});
												
												// Remove the alter comment
												// menu
												alterCircleSpan
														.removeChild(alterCircleMenuDiv);

											});

							alterCircleMenuDiv.appendChild(alterCircleMenuUl);
							alterCircleSpan.appendChild(alterCircleMenuDiv);

						});
	}

	// Add the on click event to be a drop down list for each comment alter
	// attribute. For each alter option, edit, delete, another listener is
	// attached
	for (var i = 0; i < commentEditIconsCount; i++) {
		commentEditIcons[i]
				.addEventListener(
						'click',
						function(e) {
							// The alter comment icon that generated the event
							var alterCommentIcon = e.target;
							// The icon parent span
							var alterCommentIconSpan = alterCommentIcon.parentNode;

							// Attached data
							var op_EditComment = alterCommentIconSpan
									.getAttribute('data-commentAuthor');
							var op_DeleteComment = alterCommentIconSpan
									.getAttribute('data-circleOwner');

							var commentId = alterCommentIconSpan
									.getAttribute('data-commentId');
							var userId = alterCommentIconSpan
									.getAttribute('data-userId');
							var userName = alterCommentIconSpan
									.getAttribute('data-userName');

							// Create the drop down menu div
							var alterCommentMenuDiv = document
									.createElement('div');
							alterCommentMenuDiv.className = 'AlterCommentMenuDiv';
							alterCommentMenuDiv.style.marginTop = '18px';
							alterCommentMenuDiv.style.border = '1px solid #000';

							// The drop down menu list
							var alterCommentMenuUl = document
									.createElement('ul');
							alterCommentMenuUl.style.listStyleType = 'none';

							// Edit option is available
							if (op_EditComment === 'true') {
								var editLi = document.createElement('li');
								editLi.addEventListener('mouseenter', function(
										e) {
									e.target.style.background = '#dedede';
									e.target.style.cursor = 'pointer';
								});
								editLi.addEventListener('mouseleave', function(
										e) {
									e.target.style.background = '';
									e.target.style.cursor = '';
								});

								editLi.style.marginLeft = '-40px';
								editLi.style.padding = '3px';

								var editLiSpan = document.createElement('span');
								editLiSpan.className = 'EditCommentOption';

								// Handle selection of the edit option
								editLiSpan
										.addEventListener(
												'click',
												function(e) {
													console
															.log("Log: Editing comment");

													// *************************************
													// IF EDIT TEXT CONTAINER
													// DOES NOT EXIST
													// *************************************

													// Find the comment content
													// container in the DOM from
													// the html element that
													// fired off the event
													var edit = e.target;
													while (edit.className != 'CommentEdit') {
														edit = edit.parentNode;
													}

													edit = edit.nextSibling;
													while (edit.className != 'CommentContent') {
														edit = edit.nextSibling;
													}

													var children = edit.children;

													// Comment content container
													var contentSpan = children[0];

													// Edit post alteration
													// container
													var commentEditContainer = document
															.createElement('div');

													// Edit post input container
													var commentEditInputDiv = document
															.createElement('div');

													// Edit post input field
													var commentEditInput = document
															.createElement('input');
													commentEditInput.className = 'CommentEditInput';

													// Attach attributes
													// equivalent to the main
													// comment input field
													// commentId, userId,
													// authorName
													commentEditInput
															.setAttribute(
																	'data-commentId',
																	commentId);

													commentEditInput
															.addEventListener(
																	'keypress',
																	function(e) {
																		console
																				.log('Log: Comment edit input field keypress event fired');
																		console
																				.log('Log:Info:Keypress='
																						+ e.which);
																		console
																				.log(e);

																		var otxt = $(
																				'.CommentEditInput')
																				.data(
																						'otxt');

																		if (otxt === ''
																				|| otxt === undefined
																				|| otxt === null) {
																			$(
																					'.CommentEditInput')
																					.data(
																							'otxt',
																							e.target.value);
																		}

																		// Return
																		// key
																		// code
																		var ENTER = 13;

																		if (e.which == ENTER) {
																			var originalSpan = document
																					.createElement('span');
																			originalSpan.innerText = e.target.value;

																			e.target.parentNode.parentNode.parentNode
																					.appendChild(originalSpan);
																			e.target.parentNode.parentNode.parentNode
																					.removeChild(e.target.parentNode.parentNode);

																			$(
																					'.CommentEdit')
																					.on(
																							{
																								mouseover : function() {
																									$(
																											this)
																											.css(
																													{
																														'opacity' : 1
																													});
																								},
																								mouseleave : function() {
																									$(
																											this)
																											.css(
																													{
																														'opacity' : 0
																													});
																								},
																								click : function() {
																									$(
																											this)
																											.off(
																													'mouseleave');
																								}
																							});

																			$
																					.ajax({
																						type : 'POST',
																						url : '/cse-305/Circle?action=updateComment',
																						data : {
																							'commentId' : commentId,
																							'content' : originalSpan.innerText,
																						},
																						success : function(
																								data) {
																							console
																									.log('Log: update made to comment');
																						},
																						error : function(
																								data,
																								textStatus,
																								jqXHR) {
																							console
																									.log('Log:'
																											+ textStatus);
																						}
																					});
																		}
																	});

													commentEditInput
															.addEventListener(
																	'keyup',
																	function(e) {
																		// Escape
																		// edit
																		// input
																		// field
																		// =>
																		// exit
																		// edit
																		// mode
																		if (e.keyCode == 27) {
																			console
																					.log('Log: escaping edit comment input field');
																			console
																					.log(e);

																			var otxt = $(
																					'.CommentEditInput')
																					.data(
																							'otxt');
																			console
																					.log('Log: original text = '
																							+ otxt);

																			var originalSpan = document
																					.createElement('span');
																			originalSpan.innerText = otxt;

																			e.target.parentNode.parentNode.parentNode
																					.appendChild(originalSpan);
																			e.target.parentNode.parentNode.parentNode
																					.removeChild(e.target.parentNode.parentNode);

																			$(
																					'.CommentEdit')
																					.on(
																							{
																								mouseover : function() {
																									$(
																											this)
																											.css(
																													{
																														'opacity' : 1
																													});
																								},
																								mouseleave : function() {
																									$(
																											this)
																											.css(
																													{
																														'opacity' : 0
																													});
																								},
																								click : function() {
																									$(
																											this)
																											.off(
																													'mouseleave');
																								}
																							});
																		}
																	});

													commentEditInputDiv
															.appendChild(commentEditInput);

													// Add the input field to
													// the edit container
													commentEditContainer
															.appendChild(commentEditInputDiv);

													var exitToEscapeNotice = document
															.createElement('span');
													exitToEscapeNotice.style.fontSize = 'smaller';
													exitToEscapeNotice.style.color = '#aeaeae';
													exitToEscapeNotice.innerText = 'Press Esc to cancel';

													// Add the esc to exit
													// notice to the edit
													// container
													commentEditContainer
															.appendChild(exitToEscapeNotice);

													commentEditInput.style.width = '95%';
													commentEditInput.value = contentSpan.innerText;

													// Remove the original span
													edit
															.removeChild(contentSpan);
													// Add the edit container
													edit
															.appendChild(commentEditContainer);

													// Remove the alter comment
													// menu
													alterCommentIconSpan
															.removeChild(alterCommentMenuDiv);

													commentEditInput.focus();
												});

								editLiSpan.innerText = 'Edit Comment';

								editLi.appendChild(editLiSpan);

								alterCommentMenuUl.appendChild(editLi);
							}

							if (op_DeleteComment === 'true') {
								var deleteLi = document.createElement('li');
								deleteLi
										.addEventListener(
												'mouseenter',
												function(e) {
													e.target.style.background = '#dedede';
													e.target.style.cursor = 'pointer';
												});
								deleteLi.addEventListener('mouseleave',
										function(e) {
											e.target.style.background = '';
											e.target.style.cursor = '';
										});

								deleteLi.style.marginLeft = '-40px';
								deleteLi.style.padding = '3px';

								var deleteLiSpan = document
										.createElement('span');
								deleteLiSpan.className = 'EditCommentOption';

								// Delete the comment
								deleteLiSpan
										.addEventListener(
												'click',
												function(e) {

													console
															.log("Log: Deleting comment");

												});

								deleteLiSpan.innerText = 'Delete Comment';

								deleteLi.appendChild(deleteLiSpan);

								alterCommentMenuUl.appendChild(deleteLi);
							}

							alterCommentMenuDiv.appendChild(alterCommentMenuUl);
							alterCommentIconSpan
									.appendChild(alterCommentMenuDiv);
						});

	}

	// Add the on click event to be a drop down list for each post alter
	// attribute. For each alter option, edit, delete, another listener is
	// attached
	for (var i = 0; i < postEditIconsCount; i++) {
		postEditIcons[i]
				.addEventListener(
						'click',
						function(e) {
							// The alter post icon that generated the event
							var alterPostIcon = e.target;

							// The icon parent span
							var alterPostIconSpan = alterPostIcon.parentNode;

							// Attached data
							var op_EditPost = alterPostIconSpan
									.getAttribute('data-postAuthor');
							var op_DeletePost = alterPostIconSpan
									.getAttribute('data-circleOwner');

							var postId = alterPostIconSpan
									.getAttribute('data-postId');
							var userId = alterPostIconSpan
									.getAttribute('data-userId');

							// Create the drop down menu div
							var alterPostMenuDiv = document
									.createElement('div');
							alterPostMenuDiv.className = 'AlterPostMenuDiv';
							alterPostMenuDiv.style.marginTop = '18px';
							alterPostMenuDiv.style.border = '1px solid #000';

							// The drop down menu list
							var alterPostMenuUl = document.createElement('ul');
							alterPostMenuUl.style.listStyleType = 'none';

							// Edit option is available
							if (op_EditPost === 'true') {
								var editLi = document.createElement('li');
								editLi.addEventListener('mouseenter', function(
										e) {
									e.target.style.background = '#dedede';
									e.target.style.cursor = 'pointer';
								});
								editLi.addEventListener('mouseleave', function(
										e) {
									e.target.style.background = '';
									e.target.style.cursor = '';
								});

								editLi.style.marginLeft = '-40px';
								editLi.style.padding = '3px';

								var editLiSpan = document.createElement('span');
								editLiSpan.className = 'EditPostOption';

								// Handle selection of the edit option
								editLiSpan
										.addEventListener(
												'click',
												function(e) {
													console
															.log("Log: Editing post");

													// *************************************
													// IF EDIT TEXT CONTAINER
													// DOES NOT EXIST
													// *************************************

													// Find the post content
													// container in the DOM from
													// the html element that
													// fired off the event
													var edit = e.target;
													while (edit.className != 'PostEdit') {
														edit = edit.parentNode;
													}

													edit = edit.nextSibling;
													while (edit.className != 'PostDiv') {
														edit = edit.nextSibling;
													}

													var children = edit.children;

													// Post content container
													var contentPar = children[1];

													var content = contentPar.innerText;

													// Edit text container
													// element
													var contentEditContainer = document
															.createElement('div');
													contentEditContainer.style.border = '1px solid #000';

													// Edit text area
													var contentEditArea = document
															.createElement('textarea');
													contentEditArea.innerText = content;
													contentEditArea.style.width = '100%';
													contentEditArea.style.border = 'none';
													contentEditArea.style.overflow = 'auto';
													contentEditArea.style.outline = 'none';
													contentEditArea.style.boxShadow = 'none';
													contentEditArea.style.webkitBoxShadow = 'none';
													contentEditArea.style.mozBoxShadow = 'none';

													// Add the edit text area to
													// the container
													contentEditContainer
															.appendChild(contentEditArea);

													var contentEditOptionsArea = document
															.createElement('div');

													// Add the edit options
													// buttons to the container
													var editSubmit = document
															.createElement('button');
													editSubmit.innerText = 'Submit';
													editSubmit.style.padding = '3px';
													editSubmit.style.color = '#fff';
													editSubmit.style.backgroundColor = '#3276b1';
													editSubmit.style.borderColor = '#285e8e';
													editSubmit.style.border = 'none';
													editSubmit.style.marginLeft = '1px';

													// Submit changes to the
													// post
													editSubmit
															.addEventListener(
																	'click',
																	function(e) {
																		var submitBtn = e.target;
																		var containerPar = submitBtn.parentNode.parentNode.parentNode;
																		var contentTextArea = submitBtn.parentNode.parentNode.children[0];

																		containerPar.innerText = contentTextArea.value;

																		$(
																				'.PostEdit')
																				.on(
																						{
																							mouseover : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 1
																												});
																							},
																							mouseleave : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 0
																												});
																							},
																							click : function() {
																								$(
																										this)
																										.off(
																												'mouseleave');
																							}
																						});

																		$
																				.ajax({
																					type : 'POST',
																					url : '/cse-305/Circle?action=updatePost',
																					data : {
																						'postId' : postId,
																						'content' : containerPar.innerText,
																					},
																					success : function(
																							data) {
																						console
																								.log('Log: update made to post');
																					},
																					error : function(
																							data,
																							textStatus,
																							jqXHR) {
																						console
																								.log('Log:'
																										+ textStatus);
																					}
																				});
																	});

													contentEditOptionsArea
															.appendChild(editSubmit);

													var editCancel = document
															.createElement('button');
													editCancel.innerText = 'Cancel';
													editCancel.style.padding = '3px';
													editCancel.style.marginLeft = '5px';
													editCancel.style.color = '#fff';
													editCancel.style.backgroundColor = '#3276b1';
													editCancel.style.borderColor = '#285e8e';
													editCancel.style.border = 'none';

													// Cancel change(s/ing) to
													// the post
													editCancel
															.addEventListener(
																	'click',
																	function(e) {
																		var content = e.target.parentNode.parentNode.children[0].value;

																		// Remove
																		// child
																		// and
																		// swap
																		// back
																		// content
																		// hack
																		// in 1
																		e.target.parentNode.parentNode.parentNode.innerText = content;

																		$(
																				'.PostEdit')
																				.on(
																						{
																							mouseover : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 1
																												});
																							},
																							mouseleave : function() {
																								$(
																										this)
																										.css(
																												{
																													'opacity' : 0
																												});
																							},
																							click : function() {
																								$(
																										this)
																										.off(
																												'mouseleave');
																							}
																						});
																	});

													contentEditOptionsArea
															.appendChild(editCancel);

													// Add the options element
													// to the container
													contentEditContainer
															.appendChild(contentEditOptionsArea);

													contentPar.innerText = '';

													// Add the container to the
													// content area
													contentPar
															.appendChild(contentEditContainer);

													// Remove the alter post
													// menu
													alterPostIconSpan
															.removeChild(alterPostMenuDiv);

													contentEditArea.focus();
												});

								editLiSpan.innerText = 'Edit Post';

								editLi.appendChild(editLiSpan);

								alterPostMenuUl.appendChild(editLi);
							}

							if (op_DeletePost === 'true') {
								var deleteLi = document.createElement('li');
								deleteLi
										.addEventListener(
												'mouseenter',
												function(e) {
													e.target.style.background = '#dedede';
													e.target.style.cursor = 'pointer';
												});
								deleteLi.addEventListener('mouseleave',
										function(e) {
											e.target.style.background = '';
											e.target.style.cursor = '';
										});

								deleteLi.style.marginLeft = '-40px';
								deleteLi.style.padding = '3px';

								var deleteLiSpan = document
										.createElement('span');
								deleteLiSpan.className = 'EditPostOption';

								// Delete the post
								deleteLiSpan
										.addEventListener(
												'click',
												function(e) {
													console
															.log("Log: Deleting post");

													var postSuperContainer = alterPostIconSpan.parentNode.parentNode;

													// Remove my self hack
													postSuperContainer.parentNode
															.removeChild(postSuperContainer);

													var nextPost = document
															.getElementsByClassName('PostEditSpan')[0];
													nextPost.style.marginRight = '-310px';
													nextPost.style.marginTop = '20px';

													$
															.ajax({
																type : 'POST',
																url : '/cse-305/Circle?action=deletePost',
																data : {
																	'postId' : postId,
																},
																success : function(
																		data) {
																	console
																			.log('Log: Deleting post');
																},
																error : function(
																		data,
																		textStatus,
																		jqXHR) {
																	console
																			.log('Log:'
																					+ textStatus);
																}
															});
												});

								deleteLiSpan.innerText = 'Delete Post';

								deleteLi.appendChild(deleteLiSpan);

								alterPostMenuUl.appendChild(deleteLi);
							}

							alterPostMenuDiv.appendChild(alterPostMenuUl);
							alterPostIconSpan.appendChild(alterPostMenuDiv);
						});
	}

	// Attach listener to button to submit a new Post
	var submitPostBtn = document.getElementById('PostSubmitBtn');
	submitPostBtn.addEventListener('click', makePost);

	// Attach listener to link to comment on a post
	var posts = document.getElementsByClassName('PostComment');
	// Add listener to each post in DOM
	for (var i = 0; i < posts.length; i++) {
		posts[i].addEventListener('click', function(e) {
			var nearestCommentInput = $(e.target).closest('.PostDiv').find(
					'.PostDivComments').find('.WriteCommentDiv').find(
					'.WriteComment');
			nearestCommentInput.focus();
		});
	}

	// Attach listener for submit of input in comment text box
	$('.WriteComment')
			.keypress(
					function(e) {
						// Return key code
						var ENTER = 13;

						if (e.which == ENTER
								&& e.target.className === 'WriteComment'
								&& e.target.parentNode.className === 'WriteCommentDiv') {
							console
									.log('Log: Make comment fired from main comment input field');

							makeComment(e);
						}
					});

	// Attach listener to link to like a post
	var likePost = document.getElementsByClassName('LikePost');
	// Add listener to each link to like a post in the DOM
	for (var i = 0; i < likePost.length; i++) {

		var likeStatus = likePost[i].getAttribute('data-likeStatus');

		// If the element had likeStatus attribute like then use like a post
		// event handler, else unlike a post
		if (likeStatus === 'Like') {
			console.log('Log: Adding listener to post like');
			likePost[i].addEventListener('click', like_Post);
		} else {
			likePost[i].addEventListener('click', unlike_Post);
		}
	}

	// Attach listener to link to like a comment
	var likeComment = document.getElementsByClassName('LikeComment');
	// Add listener to each link to like a comment in the DOM
	for (var i = 0; i < likeComment.length; i++) {

		var likeStatus = likeComment[i].getAttribute('data-likeStatus');

		if (likeStatus === 'Like') {
			console.log('Log: Adding listener to comment like');
			likeComment[i].addEventListener('click', like_Comment);
		} else {
			likeComment[i].addEventListener('click', unlike_Comment);
		}

	}

	// Cache of add circle member user searches for this browser session
	var cache = {};

	// Auto complete for add circle member input field
	$('#AddCircleMember')
			.autocomplete(
					{
						source : function(request, response) {
							if (request.term in cache) {
								response($.map(cache[request.term], function(
										item, key) {
									return {
										label : item.firstName + ", "
												+ item.lastName,
										value : item.firstName + ", "
												+ item.lastName
									};
								}))
								return;
							}
							$
									.ajax({
										type : 'GET',
										url : '/cse-305/Circle?action=CircleAddMemberAutoComplete&term='
												+ request.term,
										success : function(data) {
											cache[request.term] = data;
											response($.map(data, function(item,
													key) {
												return {
													label : item.firstName
															+ ", "
															+ item.lastName,
													value : item.firstName
															+ ", "
															+ item.lastName
												};
											}));
										}
									});
						},
						minLength : 2,
						select : function(event, ui) {
							console.log(event);
							// Do something with the selection if it isnt empty
						}
					});
}

/**
 * Like a post;
 * 
 * @param e
 *            The event generated by liking a post.
 */
function like_Post(e) {
	// The target post element
	var post = e.target;

	console.log('Log: like post');

	// The elements data attributes
	var postId = post.getAttribute('data-postId');
	var userId = post.getAttribute('data-userId');

	$.ajax({
		type : 'POST',
		url : '/cse-305/Circle?action=likePost',
		data : {
			'postId' : postId,
			'userId' : userId,
		},
		success : function(data) {

			// Change the target post like option to unlike for the current user
			e.target.innerText = "Unlike";
			var postDiv = $(e.target).closest('.PostDiv');
			var postLikes = postDiv.find('.PostLikes');
			var likesCountSpan = postLikes.find('.PeoplePostLikeList')[0];
			var likesCount = parseInt(likesCountSpan.innerText.trim());

			// Increment the like count
			likesCount++;
			likesCountSpan.innerText = likesCount;

		},
		error : function(data, textStatus, jqXHR) {
			// Should notify the user of the error somehow
			console.log('Log:' + textStatus);
		}
	});
}

/**
 * 
 * @param e
 */
function unlike_Post(e) {
	// The target post element
	var post = e.target;

	console.log('Log: like post');

	// The elements data attributes
	var postId = post.getAttribute('data-postId');
	var userId = post.getAttribute('data-userId');

	$.ajax({
		type : 'POST',
		url : '/cse-305/Circle?action=unlikePost',
		data : {
			'postId' : postId,
			'userId' : userId,
		},
		success : function(data) {

			// Change the target post like option to unlike for the current user
			e.target.innerText = "Like";
			var postDiv = $(e.target).closest('.PostDiv');
			var postLikes = postDiv.find('.PostLikes');
			var likesCountSpan = postLikes.find('.PeoplePostLikeList')[0];
			var likesCount = parseInt(likesCountSpan.innerText.trim());

			// Decrement the like count
			likesCount--;
			likesCountSpan.innerText = likesCount;

		},
		error : function(data, textStatus, jqXHR) {
			// Should notify the user of the error somehow
			console.log('Log:' + textStatus);
		}
	});
}

/**
 * Like a comment.
 * 
 * @param e
 */
function like_Comment(e) {
	var comment = e.target;

	console.log('Log: like post');

	var commentId = comment.getAttribute('data-commentId');
	var userId = comment.getAttribute('data-userId');

	$.ajax({
		type : 'POST',
		url : '/cse-305/Circle?action=likeComment',
		data : {
			'commentId' : commentId,
			'userId' : userId,
		},
		success : function(data) {
			e.target.innerText = "Unlike";
			var commentDiv = $(e.target).closest('.CommentDiv');
			var likesCountSpan = commentDiv.find('.PeopleCommentLikeList')[0];
			var likesCount = parseInt(likesCountSpan.innerText.trim());

			// Decrement the like count
			likesCount++;
			likesCountSpan.innerText = likesCount;

		},
		error : function(data, textStatus, jqXHR) {
			alert(textStatus);
		}
	});
}

/**
 * 
 * @param e
 */
function unlike_Comment(e) {
	var comment = e.target;

	console.log('Log: like post');

	var commentId = comment.getAttribute('data-commentId');
	var userId = comment.getAttribute('data-userId');

	$.ajax({
		type : 'POST',
		url : '/cse-305/Circle?action=unlikeComment',
		data : {
			'commentId' : commentId,
			'userId' : userId,
		},
		success : function(data) {
			e.target.innerText = "Like";
			var commentDiv = $(e.target).closest('.CommentDiv');
			var likesCountSpan = commentDiv.find('.PeopleCommentLikeList')[0];
			var likesCount = parseInt(likesCountSpan.innerText.trim());

			// Increment the like count
			likesCount--;
			likesCountSpan.innerText = likesCount;

		},
		error : function(data, textStatus, jqXHR) {
			alert(textStatus);
		}
	});
}

/**
 * Make a new post.
 * 
 * @param e
 *            The event generated by making a new post on a given circle.
 */
function makePost(e) {
	console.log('Log: Making new post');

	// The target post field information
	var postTextArea = document.getElementById('UserPost');
	var postText = postTextArea.value;

	// The data attributes attached to the element
	var postSubmitDiv = document.getElementById('PostSubmitDiv');
	var circleId = postSubmitDiv.getAttribute('data-circleId');
	var authorId = postSubmitDiv.getAttribute('data-curUserId');
	var authorName = postSubmitDiv.getAttribute('data-authorName');

	if (postText != "") {
		$
				.ajax({
					type : 'POST',
					url : '/cse-305/Circle?action=makePost',
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
									<div class="PostDivComments">\
										<ul class="CommentList">\
										</ul>\
										<div class="WriteCommentDiv">\
											<input type="text" placeholder="write a comment.." class="WriteComment" data-postId="'
								+ data.postId
								+ '" data-userId="'
								+ authorId
								+ '" data-userName="'
								+ authorName
								+ '" />\
										</div>\
									</div>\
								</div>\
								<hr style="color: #dedede; width: 517px; margin-left: -40px;" />\
							</li>';

						var newCommentHtml = $(newComment);

						// Attach listener for liking this new post
						newCommentHtml.find('.LikePost')[0].addEventListener(
								'click', like_Post);

						// Attach listener for clicking on the comment link on
						// this new post
						newCommentHtml.find('.PostComment')[0]
								.addEventListener('click', function(e) {
									var nearestCommentInput = $(e.target)
											.closest('.PostDiv').find(
													'.PostDivComments').find(
													'.WriteCommentDiv').find(
													'.WriteComment');

									nearestCommentInput.focus();
								});

						// Comment input for this post
						var nearestCommentInput = newCommentHtml
								.find('.WriteComment');

						// Attach keypress listener to listen for return in the
						// comment input for this new post
						nearestCommentInput.keypress(function(e) {
							// Return key code
							var ENTER = 13;

							if (e.which == ENTER) {
								makeComment(e);
							}
						});

						// Prepend the new post structure to the post list
						$('#Post_List').prepend(newCommentHtml);

						// Clear the post input field
						var postTextArea = document.getElementById('UserPost');
						postTextArea.value = "";

					},
					error : function(data, textStatus, jqXHR) {
						// Should notify user of the error somehow
						console.log('Log:Error:' + textStatus);
					}
				});

	} else {
		// Text area empty
		Console.log('Log: Post body empty');
		return;
	}

}

/**
 * Comment on a post.
 * 
 * @param e
 *            The event generated by submitting the comment in the input field
 *            for the target post
 */
function makeComment(e) {
	// The target input field information
	var commentInput = e.target;
	var comment = commentInput.value;

	// The data attributes attached to the element
	var postId = commentInput.getAttribute('data-postId');
	var authorId = commentInput.getAttribute('data-userId');
	var authorName = commentInput.getAttribute('data-userName');

	if (comment != "") {
		console.log('Log: Comment content = ' + comment);

		$
				.ajax({
					type : 'POST',
					url : '/cse-305/Circle?action=makeComment',
					data : {
						'content' : comment,
						'postId' : postId,
						'authorId' : authorId
					},
					success : function(data) {
						console.log('Log: New commment success');

						var newComment = '<li>\
								<div class="CommentDiv">\
									<span style="font-size: small; color: #00a; font-weight: bold;">'
								+ authorName
								+ '</span>\
									<div>\
										<span>'
								+ comment
								+ '</span>\
									</div>\
									<span style="color: #aeaeae; font-size: small; margin-right: 3px;">'
								+ data.dateString
								+ '</span>\
									<span class="LikeComment" data-commentId="'
								+ data.commentId
								+ '" data-userId="'
								+ authorId
								+ '"> Like</span>\
									<span><i class="glyphicon glyphicon-thumbs-up"></i><span class="PeopleCommentLikeList"> 0 </span></span>\
								</div>\
							</li>';

						var newCommentHtml = $(newComment);

						// Attach event handler for liking this new comment
						newCommentHtml.find('.LikeComment')[0]
								.addEventListener('click', like_Comment);

						// Clear the input field
						commentInput.value = "";

						// Append the new comment structure to the comment list
						// for the target post
						var commentList = $(e.target).closest(
								'.PostDivComments').find('.CommentList');

						commentList.append(newCommentHtml);
					},
					error : function(data, textStatus, jqXHR) {
						// Should notify user of the error somehow
						console.log('Log:Error:' + textStatus);
					}
				});
	} else {
		console.log('Log: Comment body empty.');
		return;
	}

}

// DOM ready
$(document).ready(circleDOM_onReady);