<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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
<title>Search for a user</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="/cse-305/styles/main_style.css" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="/cse-305/scripts/validation.js" type="text/javascript"></script>

<script type="text/javascript">

	function submitForm(uID) {
		$('#' + uID + '_Form').submit();
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
			
				<h1 style="text-align: center;"> Search Results </h1>
			
				<% 
					String searchQuery = request.getParameter("search");
					Connection conn = null;
					try {
						String[] tokens = searchQuery.split(" ");
						// Check for users with first name like value or email like value
						String query = "select * from user where ((First_Name like '%" + tokens[0] + "%') or (Last_Name like '%" + tokens[0] + "%') or (Email_Address like '%" + tokens[0] + "%')";
						// If two tokens, look for people with last name
						if(tokens.length > 1) {
						    query += " or (First_Name like '%" + tokens[1] + "%') or (Last_Name like '%" + tokens[1] + "%') or (Email_Address like '%" + tokens[1] + "%')";
						}
						query += ") and (User_Id <> " + userID + ")";
						
						System.out.println(query);
						// Connect to the jdbc driver and tell it your database credentials
						Class.forName(Database.JDBC_DRIVER).newInstance();
						java.util.Properties sysprops = System.getProperties();
						sysprops.put("user", Database.DATABASE_USERNAME);
						sysprops.put("password", Database.DATABASE_PASSWORD);
						conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
						Statement stat = conn.createStatement();
						ResultSet result = stat.executeQuery(query);
						if(result.next()) {
						    %>
						    	<table>
						    <%
						    do{
							    Integer searchUserID = result.getInt("User_Id");
							    String firstName = result.getString("First_Name");
							    String lastName = result.getString("Last_Name");
							%>
								<tr>
									<td>
										<form id="<%=searchUserID%>_Form" action="/cse-305/user-information.jsp" method="post">
											<input style="display:none;" name="userToDisplayID" value="<%=searchUserID%>" />
											<input style="display:none;" name="userToDisplayName" value="<%=firstName + " " + lastName%>" />
										</form>
										<a onclick="submitForm(<%=searchUserID%>)" href="#"><%=firstName + " " + lastName%></a>
									</td>
								</tr>
							<%
						    }while(result.next());
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
						   	<h4 style="text-align:center;">  Your search returned no results. </h4>
						<%	    
						}
					}
					catch(Exception e) {
					%>
						<br />
						<br />
						<br />
						<br />
						<br />
						<br />
					   	<h4 style="text-align:center;">  Your search returned no results. </h4>
					<%
					}
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