<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar" %>

<%! public String getMonth(int month) {
    	switch(month){
    	case 0: return "January";
    	case 1: return "February";
    	case 2: return "March";
    	case 3: return "April";
    	case 4: return "May";
    	case 5: return "June";
    	case 6: return "July";
    	case 7: return "August";
    	case 8: return "September";
    	case 9: return "October";
    	case 10: return "November";
    	case 11: return "December";
    	default: return "";
    	}
	} %>

<%
	Integer userID = (Integer)session.getAttribute(SessionConstants.USERID);
	String userName = (String)session.getAttribute(SessionConstants.USERNAME);
	if(userID == null || userName == null) {
	    response.sendRedirect(SessionConstants.LOGIN_LOCATION); 
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
<title>My Messages</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="/cse-305/styles/main_style.css" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="/cse-305/scripts/validation.js" type="text/javascript"></script>

<script type="text/javascript">

	function expandMessage(mID){
		$('#' + mID + '_Content').fadeIn();
		$('#' + mID + '_Expand').hide();
		$('#' + mID + '_Hide').show();
	}
	function hideMessage(mID){
		$('#' + mID + '_Content').fadeOut();
		$('#' + mID + '_Hide').hide();
		$('#' + mID + '_Expand').show();
	}
	function deleteMessage(mID){
		$('#' + mID + '_DeleteForm').submit();
	}
	function showResponseArea(mID) {
		$('#' + mID + '_Respond').fadeIn();
	}
	function sendMessage(mID) {
		removeErrors();
		var content = $('#' + mID + '_Response').val();
		var subject = $('#' + mID + '_Subject').val();
		var validated = true;
		if(!validateMessageSubject(subject)) {
			validated = false;
			$('#' + mID + '_Subject').addClass('input-error');
		}
		if(!validateMessageBody(content)) {
			validated = false;
			var content = $('#' + mID + '_Response').addClass('input-error');
		}
		if(validated){
			var input = '<input style="display:none;" type="text" name="content" value="' + content + '" />';
			$('#' + mID + '_Form').append(input);
			$('#' + mID + '_Form').submit();
		}
	}
	function hideMessageResponse(mID) {
		removeErrors();
		$('#' + mID + '_Respond').fadeOut();
	}
	function removeErrors(){
		$('*').removeClass('input-error');
	}
	
	// jQuery run on page load
	$(function(){
		setInterval(function(){
			$('#msgResponse').fadeOut();
		}, 4000);
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
			
				<h1 style="text-align: center;"> My Messages </h1>
				<%
					Connection conn = null; 
					try {
						// Connect to the jdbc driver and tell it your database credentials
						Class.forName(Database.JDBC_DRIVER).newInstance();
						java.util.Properties sysprops = System.getProperties();
						sysprops.put("user", Database.DATABASE_USERNAME);
						sysprops.put("password", Database.DATABASE_PASSWORD);
						conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
						Statement stat = conn.createStatement();
						ResultSet result = stat.executeQuery("Select * from Message_Sent where Receiver='" + userID + "'");
						if(result.next()) {
				 %>
						    <table class="messageTable">
				<%
						    do{
								String subject = result.getString("Subject");
								String content = result.getString("Content");
								Integer sender = result.getInt("Sender");
								Calendar date =  Calendar.getInstance();
								date.setTime(result.getDate("Date"));
								Integer messageID = result.getInt("Message_Id");
								String senderEmail = result.getString("Sender_Email");
				%>
									<tr>
										<td>
											<table class="messageHeader">
												<tr bgcolor="DDDDDD">										
													<td><a onclick="showResponseArea(<%=messageID%>)" class= "button">Respond</a></td>
													<td><a class="button" id="<%=messageID%>_Expand" onclick="expandMessage(<%=messageID%>)">+</a>
														<a class="button" id="<%=messageID%>_Hide" onclick="hideMessage(<%=messageID%>)" style="display:none">-</a></td>
													<td><b><%=senderEmail%></b></td>
													<td><%=subject %></td>
													
													<td><%= getMonth(date.get(Calendar.MONTH)) + " " + date.get(Calendar.DAY_OF_MONTH) + ", " + date.get(Calendar.YEAR)
													%></td>
													<td>
														<form id="<%=messageID%>_DeleteForm" action="<%=SessionConstants.DELETE_MESSAGE_LOCATION%>" method="post">
															<input name="messageID" value="<%=messageID%>" style="display:none;" />
															<a class="hoverHand" onclick="deleteMessage(<%=messageID%>)"><img src="/cse-305/images/btn_delete.png"></img></a>
														</form>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td id="<%=messageID%>_Content" style="display:none;"><p class="messageContent"><%=content %></p></td>
									</tr>
									<tr>
										<td id="<%=messageID%>_Respond" style="display:none;">
											<form id="<%=messageID%>_Form" action="<%=SessionConstants.SEND_MESSAGE_LOCATION%>" method="post">
												Subject: <input id="<%=messageID%>_Subject" type="text" name="subject" value="re: <%=subject%>" />
												<input style="display:none;" name="to" value="<%=sender%>" />
												<input style="display:none;" name="from" value="<%=userID%>" />
											</form>
											<br />
											<textarea id="<%=messageID%>_Response" class="respondMessage" rows=4></textarea>
											<div style="text-align: center;">
												<a onClick="sendMessage(<%=messageID%>)" class="button">Send</a>
												<a onClick="hideMessageResponse(<%=messageID%>)" class="button">Cancel</a>
											</div>
										</td>
									</tr>
					<%
						    }
						    while(result.next());
					%>
						    </table>
					<%
						}
						else {
					%>
								<br />
								<br />
								<br />
								<br />
								<br />
								<br />
					   			<h4 style="text-align:center;">  You do not have any messages. </h4>
					<%
						}
					}
					catch(Exception e) {}
					finally {
						try {
						    conn.close();
						}
						catch(Exception e) {}
					}
				
					%>
					
					<%
						String msgResponse = (String)session.getAttribute(SessionConstants.MSG_RESPONSE);
						session.removeAttribute(SessionConstants.MSG_RESPONSE);
						if(msgResponse != null) {
					%>
						<br />
						<br />
					<% 
						}
					%>
					<div style="text-align:center;" id="msgResponse" class="error"><%=msgResponse == null ? "" : msgResponse%></div>
				
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