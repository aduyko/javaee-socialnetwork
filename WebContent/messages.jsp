<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>

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

			<div class="CircleBodyHeader">
			
				<h1> My Messages </h1>
				<%
					Connection conn = Database.getConnection();
					if(conn != null) {    
					    try {
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
									Date date = result.getDate("Date");
									String senderEmail = result.getString("Sender_Email");
									Integer messageID = result.getInt("Message_Id");
									%>
										<tr sender="<%=sender%>" messageID = "<%=messageID %>">
											<td>
												<table>
													<tr>										
														<td><a>Respond</a></td>
														<td><a id="<%=messageID%>_Expand" onclick="expandMessage(<%=messageID%>)">+</a>
															<a id="<%=messageID%>_Hide" onclick="hideMessage(<%=messageID%>)" style="display:none">-</a></td>
														<td><%=senderEmail%></td>
														<td><%=subject %></td>
														
														<td><%=date.toString() %></td>
														<td>
															<form id="<%=messageID%>_DeleteForm" action="servlets/user_login.jsp" method="post">>
																<input name="messageID" value="<%=messageID%>" />
																<a onclick="deleteMessage()">Delete</a>
															</form>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td id="<%=messageID%>_Content" style="display:none;"><%=content %></td>
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