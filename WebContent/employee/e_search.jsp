<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList" %>
<%
	Integer employeeID = (Integer)session.getAttribute(SessionConstants.EMPLOYEE_ID);
	String employeeName = (String)session.getAttribute(SessionConstants.EMPLOYEE_NAME);
	String employeeType = (String)session.getAttribute(SessionConstants.EMPLOYEE_TYPE);
	if(employeeID == null || employeeName == null || employeeType == null) {
	    response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION); 
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
<title>Employee Search Tool</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>

<script type="text/javascript">

	function submitUserForm(uID) {
		$('#' + uID + '_UserForm').submit();
	}
	
	function submitEmployeeForm(eID) {
		$('#' + eID + '_EmployeeForm').submit();
	}

</script>

</head>

<body>
	<!-- Include the header file -->
	<jsp:include page="../includes/e_header.jsp" />

	<!-- Include the left side bar -->
	<jsp:include page="../includes/e_left_bar.jsp" />

	<div class="CircleCentral">

		<div id="circle_main" class="CircleBody" style="clear: both;">

			<div class="messageBody">
							
				<h1 style="text-align: center;"> Search Results </h1>
				<hr />
				<h3>Users</h3>
			
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
						query += ")";
						
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
										<form id="<%=searchUserID%>_UserForm" action="<%=SessionConstants.EMPLOYEE_VIEW_USER_LOCATION%>" method="post">
											<input style="display:none;" name="userToDisplayID" value="<%=searchUserID%>" />
										</form>
										<a onclick="submitUserForm(<%=searchUserID%>)" href="#"><%=firstName + " " + lastName%></a>
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
						   	<h4 style="margin-left: 50px;"> None </h4>
						<%	    
						}
						query = "select * from employee where ((First_Name like '%" + tokens[0] + "%') or (Last_Name like '%" + tokens[0] + "%')";
						// If two tokens, look for people with last name
						if(tokens.length > 1) {
						    query += " or (First_Name like '%" + tokens[1] + "%') or (Last_Name like '%" + tokens[1] + "%')";
						}
						query += ") and Employee_Id <> " + employeeID;
						result = stat.executeQuery(query);
						%>
							<h3>Employees</h3>
						<%
						if(result.next()) {
						    %>
						    	<table>
						    <%
						    do{
							    Integer searchEmployeeID = result.getInt("Employee_Id");
							    String firstName = result.getString("First_Name");
							    String lastName = result.getString("Last_Name");
							%>
								<tr>
									<td>
										<form id="<%=searchEmployeeID%>_EmployeeForm" action="<%=SessionConstants.VIEW_EMPLOYEE_LOCATION%>" method="post">
											<input style="display:none;" name="empID" value="<%=searchEmployeeID%>" />
										</form>
										<a onclick="submitEmployeeForm(<%=searchEmployeeID%>)" href="#"><%=firstName + " " + lastName%></a>
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
							   	<h4 style="margin-left: 50px;"> None </h4>
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
	
	<div class="CircleSideBarRight"></div>

	<!-- Include the footer -->
	<%@include file="../includes/footer.html" %>

</body>
</html>
<%}%>