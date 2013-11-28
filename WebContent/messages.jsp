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
<title>My Messages</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="/cse-305/styles/main_style.css" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

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
			
				<h1> My Messages </h1>
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
									<tr sender="<%=sender%>" messageID = "<%=messageID %>">
										<td>
											<table class="messageHeader">
												<tr bgcolor="DDDDDD">										
													<td><a class= "button">Respond</a></td>
													<td><a class="button" id="<%=messageID%>_Expand" onclick="expandMessage(<%=messageID%>)">+</a>
														<a class="button" id="<%=messageID%>_Hide" onclick="hideMessage(<%=messageID%>)" style="display:none">-</a></td>
													<td><b><%=senderEmail%></b></td>
													<td><%=subject %></td>
													
													<td><%= getMonth(date.get(Calendar.MONTH)) + " " + date.get(Calendar.DAY_OF_MONTH) + ", " + date.get(Calendar.YEAR)
													%></td>
													<td>
														<form id="<%=messageID%>_DeleteForm" action="servlets/delete_message.jsp" method="post">
															<input name="messageID" value="<%=messageID%>" style="display:none;" />
															<a onclick="deleteMessage(<%=messageID%>)"><img src="/cse-305/images/btn_delete.png"></img></a>
														</form>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td id="<%=messageID%>_Content" style="display:none;"><p class="messageContent"><%=content %></p></td>
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
					   			<h3>  You do not have any messages. </h3>
					<%
						}
					}
					catch(Exception e) { conn.close();}
					finally {
						try {
						    conn.close();
						}
						catch(Exception e) {}
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