<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList" %>

<%!
private static class CircleData {
  public String name;
  public int circleID;
  public CircleData(String name, int id) {
      this.name=  name;
      this.circleID = id;
  }
  public boolean equals(Object other){
      if(!(other instanceof CircleData))
	  		return false;
      return circleID == ((CircleData)other).circleID;
  }
}
%>
<%
	Integer userID = (Integer)session.getAttribute(SessionConstants.USERID);
	String userName = (String)session.getAttribute(SessionConstants.USERNAME);
	if(userID == null || userName == null) {
	    response.sendRedirect("home.jsp"); 
	}
	else {
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>View information about user</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="/cse-305/styles/main_style.css" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="/cse-305/scripts/validation.js" type="text/javascript"></script>

<script type="text/javascript">

	function joinCircle(cID) {
		$('#' + cID + '_Form').submit();
	}
	
	function sendMessage() {
		removeErrors();
		var content = $('#messageContent').val();
		var subject = $('#messageSubject').val();
		var validated = true;
		if(!validateMessageSubject(subject)) {
			validated = false;
			$('#messageSubject').addClass('input-error');
		}
		if(!validateMessageBody(content)) {
			validated = false;
			var content = $('#messageContent').addClass('input-error');
		}
		if(validated){
			var input = '<input style="display:none;" type="text" name="content" value="' + content + '" />';
			$('#messageForm').append(input);
			$('#messageForm').submit();
		}
	}
	
	function removeErrors(){
		$('*').removeClass('input-error');
	}

	$(function(){
		setInterval(function(){
			$('#error').fadeOut();
		},4000);
		
		$('#sendMessage').click(function(){
			sendMessage();
		});
	});

</script>

</head>

<body>
	<!-- Include the header file -->
	<jsp:include page="includes/header.jsp" />

	<!-- Include the left side bar -->
	<jsp:include page="includes/left_bar.jsp" />

	<div class="CircleCentral">

		<div id="circle_main" class="CircleBody" style="clear: both;">

			<div class="messageBody">
			
				<% 
					/* 
				 	 *	This page can be accessed from both the session and a form submit,
				 	 *  check for both situations.
					 */
					String userToDisplayID = request.getParameter("userToDisplayID");
					String userToDisplayName = request.getParameter("userToDisplayName");
					
					if(userToDisplayID == null && session.getAttribute(SessionConstants.VIEW_USER) != null ) {
					    userToDisplayID = (String)session.getAttribute(SessionConstants.VIEW_USER);
					}
					if(userToDisplayName == null && (String)session.getAttribute(SessionConstants.VIEW_USER_NAME) != null) {
					    userToDisplayName = (String)session.getAttribute(SessionConstants.VIEW_USER_NAME);
					}
					    
					if(userToDisplayID != null && userToDisplayName != null) {
					    
					    Connection conn = null;
					    try {
							/*
							 *  YOU CAN INVITE SOMEONE TO ANY CIRCLE THAT YOU OWN.  IF THEY HAVE
							 *  ALREADY BEEN INVITED, DO NOT DISPLAY SAID CIRCLE.
							 *
							 *  YOU CAN REQUEST TO JOIN ANY CIRCLE THEY ARE A PART OF.  IF YOU
							 *  ALREADY ASKED TO JOIN THAT CIRCLE, DO NOT DISPLAY SAID CIRCLE.
							 *
							 *  IN ALL CASES, IF A USER IS ALREADY IN THE CIRCLE, DO NOT DISPLAY
							 *  THAT CIRCLE TO INVITE OR JOIN.
							 */
							
							// A list of all of the circles they're a part of
							ArrayList<CircleData> theirCircles = new ArrayList<CircleData>();
							// A list of all of the circles that you are in
							ArrayList<CircleData> myCircles = new ArrayList<CircleData>();
							// A list of all of the circles they have been invited to
							ArrayList<CircleData> theirCircleInviteRequests = new ArrayList<CircleData>();
							// A list of all of the circles you have requested to join
							ArrayList<CircleData> myCircleJoinRequests = new ArrayList<CircleData>();
							// A list of all of the circles that you own
							ArrayList<CircleData> myOwnedCircles = new ArrayList<CircleData>();
							Class.forName(Database.JDBC_DRIVER).newInstance();
							java.util.Properties sysprops = System.getProperties();
							sysprops.put("user", Database.DATABASE_USERNAME);
							sysprops.put("password", Database.DATABASE_PASSWORD);
							conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
							Statement stat = conn.createStatement();
							// A list of all of the circles they're a member of
							ResultSet result = stat.executeQuery("select c.Circle_Id, c.Circle_NAME from circle c, addedto a where c.Circle_Id = a.Circle_Id and a.User_Id =" + userToDisplayID);
							while(result.next()) {
							    theirCircles.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							// A list of all circles you are a member of
							result = stat.executeQuery("select Circle_Id from addedto where User_Id =" + userID);
							while(result.next()) {
							    myCircles.add(new CircleData(null, result.getInt("Circle_Id")));
							}
							// A list of all of the circles they have been invited to
							result = stat.executeQuery("select Circle_Id from inviterequest where User_Id =" + userToDisplayID);
							while(result.next()) {
							    theirCircleInviteRequests.add(new CircleData(null, result.getInt("Circle_Id")));
							}
							// A list of all of the circles you have requested to join
							result = stat.executeQuery("select Circle_Id from joinrequest where User_Id =" + userID);
							while(result.next()) {
							    myCircleJoinRequests.add(new CircleData(null, result.getInt("Circle_Id")));
							}
							// A list of all of the circles that you own
							result = stat.executeQuery("select Circle_Id, Circle_NAME from circle where Owner_Of_Circle =" + userID);
							while(result.next()) {
							    myOwnedCircles.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							%>
								<h1 style="text-align: center;">Viewing <%=userToDisplayName%></h1>
								<hr>
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;">
											<h4 style="text-align:center;"> Join a circle <%=userToDisplayName%> is in </h4>
											<% 
												if(theirCircles.size() > 0) {
											%>
												<table style="width:100%;">
												<%
													boolean hasUniqueCircle = false;
													for(int x = 0; x < theirCircles.size();x++){
													    
													    // Only can join circles you aren't in and havn't asked to join already
														if(!myCircles.contains(theirCircles.get(x)) && !myCircleJoinRequests.contains(theirCircles.get(x))) {
														    hasUniqueCircle = true;
												%>
															<tr class="circleDisplay">
																<td><%=theirCircles.get(x).name%></td>
																<td>
																	<form id="<%=theirCircles.get(x).circleID%>_Form" style="display:none;" action="/cse-305/servlets/join_circle.jsp" method="post">
																		<input type="text" name="circleID" value="<%=theirCircles.get(x).circleID%>"/>
																		<input type="text" name="userID" value="<%=userID%>"/>
																		<input type="text" name="viewUserID" value="<%=userToDisplayID%>"/>
																		<input type="text" name="viewUsersName" value="<%=userToDisplayName%>"/>
																	</form>
																	<a onClick="joinCircle(<%=theirCircles.get(x).circleID%>)" class="button">Join</a></td>
															</tr>
												<%
														} 
													}
													if(!hasUniqueCircle) {
												%>
													<tr>
														<td style="text-align:center"> <%=userToDisplayName%> has no circles you aren't <br/> in or havn't already asked to join.</td>
													</tr>
												<%
													}
												%>
												</table>
										<%	
											}else {
										%>
												<h5 style="text-align:center;"><%=userToDisplayName%> has no circles.</h5>
										<%	
											} 
										%>
										</td>
										<td style="vertical-align:top;">
											
											<h4 style="text-align:center;">Invite <%=userToDisplayName%> to a circle you own </h4>
											
											<% 
												if(myCircles.size() > 0) { 
											%>
												<table style="width:100%;">
													<% 
														boolean hasUniqueCircle = false;
														for(int x = 0; x < myOwnedCircles.size(); x++) {
														    if(!theirCircles.contains(myOwnedCircles.get(x)) && !theirCircleInviteRequests.contains(myOwnedCircles.get(x))) {
																hasUniqueCircle = true;
													%>
																<tr class="circleDisplay">
																	<td><%=myOwnedCircles.get(x).name%></td>
																	<td>
																		<form id="<%=myOwnedCircles.get(x).circleID%>_Form" style="display:none;" action="/cse-305/servlets/invite_circle.jsp" method="post">
																			<input type="text" name="circleID" value="<%=myCircles.get(x).circleID%>"/>
																			<input type="text" name="userID" value="<%=userToDisplayID%>"/>
																			<input type="text" name="viewUserID" value="<%=userToDisplayID%>"/>
																			<input type="text" name="viewUsersName" value="<%=userToDisplayName%>"/>
																		</form>
																		<a onClick="joinCircle(<%=myOwnedCircles.get(x).circleID%>)" class="button">Invite</a>
																	</td>
																</tr>
													<%
														    }
														}
														if(!hasUniqueCircle) {
													%>
														<tr>
															<td style="text-align:center;"><%=userToDisplayName%> is already in or has already </br> been invited to join all circles you own.</td>
														</tr>
													<%
														}
													%>
												</table>
											<% 
												}else {
											%>
													<h5 style="text-align:center;">You do not own any circles.</h5>
											<% 
												}
											%>	
										</td>
									</tr>
								</table>
							<%
					    }
					    catch(Exception e) {}
					    finally {
							try{
							    conn.close();
							}
							catch(Exception e) {}
					    }
					    String error = (String)session.getAttribute(SessionConstants.ERROR);
					    session.removeAttribute(SessionConstants.ERROR);
					    String msgResponse = (String)session.getAttribute(SessionConstants.MSG_RESPONSE);
					    session.removeAttribute(SessionConstants.MSG_RESPONSE);
					    %>
					    	<hr>
					    	<h4> Send <%=userToDisplayName%> a message</h4>
					    	<table width="100%">
					    			<tr>
										<td>
											<form id="messageForm" action="/cse-305/servlets/send_message.jsp" method="post">
												Subject: <input id="messageSubject" type="text" name="subject" size="50%" />
												<input style="display:none;" name="to" value="<%=userToDisplayID%>" />
												<input style="display:none;" name="from" value="<%=userID%>" />
												<input style="display:none;" name="viewUsersName" value="<%=userToDisplayName%>" />
											</form>
											<br />
											<textarea id="messageContent" class="respondMessage" rows=4></textarea>
											<div style="text-align: center;">
												<a id="sendMessage" class="button">Send</a>
											</div>
										</td>
									</tr>
					    	</table>
					    	<br />
					    	<div style="text-align:center;" id="error" class="error"><%=error == null ? (msgResponse == null ? "" : msgResponse) : error%></div>
					    <%
					}
					else {
				%>
						<h1 style="text-align: center;"> Error viewing user </h1>
				<%
					}
				%>
			
			 </div>
		
		</div>
	</div>
	
	<!-- Include the right side bar -->
	<jsp:include page="includes/right_bar.jsp" />

	<!-- Include the footer -->
	<%@include file="includes/footer.html" %>

</body>
</html>
<%}%>