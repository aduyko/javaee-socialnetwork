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

	$(function(){
		setInterval(function(){
			$('#error').fadeOut();
		},4000);
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
					session.removeAttribute(SessionConstants.VIEW_USER);
					session.removeAttribute(SessionConstants.VIEW_USER_NAME);
					    
					if(userToDisplayID != null && userToDisplayName != null) {
					    
					    Connection conn = null;
					    try {
							ArrayList<CircleData> myCircles = new ArrayList<CircleData>();
							ArrayList<CircleData> theirCircles = new ArrayList<CircleData>();
							Class.forName(Database.JDBC_DRIVER).newInstance();
							java.util.Properties sysprops = System.getProperties();
							sysprops.put("user", Database.DATABASE_USERNAME);
							sysprops.put("password", Database.DATABASE_PASSWORD);
							conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
							Statement stat = conn.createStatement();
							ResultSet result = stat.executeQuery("Select * from my_circles where User_Id=" + userToDisplayID);
							while(result.next()) {
							    theirCircles.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							result = stat.executeQuery("Select * from my_circles where User_Id=" + userID);
							while(result.next()) {
							    myCircles.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							%>
								<h1 style="text-align: center;">Viewing <%=userToDisplayName%></h1>
								<hr>
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;">
											<h4 style="text-align:center;">Join <%=userToDisplayName%>'s Circles</h4>
											<% 
												if(theirCircles.size() > 0) {
											%>
												<table style="width:100%;">
												<%
													boolean hasUniqueCircle = false;
													for(int x = 0; x < theirCircles.size();x++){
													    
														if(!myCircles.contains(theirCircles.get(x))) {
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
														<td style="text-align:center"> You are in all of <%=userToDisplayName%>'s circles.</td>
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
											
											<h4 style="text-align:center;">Invite <%=userToDisplayName%> to Your Circles </h4>
											
											<% 
												if(myCircles.size() > 0) { 
											%>
												<table style="width:100%;">
													<% 
														boolean hasUniqueCircle = false;
														for(int x = 0; x < myCircles.size(); x++) {
														    if(!theirCircles.contains(myCircles.get(x))) {
																hasUniqueCircle = true;
													%>
																<tr class="circleDisplay">
																	<td><%=myCircles.get(x).name%></td>
																	<td>
																		<form id="<%=myCircles.get(x).circleID%>_Form" style="display:none;" action="/cse-305/servlets/join_circle.jsp" method="post">
																			<input type="text" name="circleID" value="<%=myCircles.get(x).circleID%>"/>
																			<input type="text" name="userID" value="<%=userToDisplayID%>"/>
																			<input type="text" name="viewUserID" value="<%=userToDisplayID%>"/>
																			<input type="text" name="viewUsersName" value="<%=userToDisplayName%>"/>
																		</form>
																		<a onClick="joinCircle(<%=myCircles.get(x).circleID%>)" class="button">Invite</a>
																	</td>
																</tr>
													<%
														    }
														}
														if(!hasUniqueCircle) {
													%>
														<tr>
															<td style="text-align:center;"><%=userToDisplayName%> is in all of your circles.</td>
														</tr>
													<%
														}
													%>
												</table>
											<% 
												}else {
											%>
													<h5 style="text-align:center;">You have no circles.</h5>
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
					    %>
					    	<div style="text-align:center;" id="error" class="error"><%=error == null ? "" : error%></div>
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