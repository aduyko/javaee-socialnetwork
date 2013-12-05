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
<title>Customer Mailing List</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>

<script type="text/javascript">

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
							
				<h1 style="text-align: center;"> Customer Mailing List </h1>
				<hr />
				
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
						ResultSet result = stat.executeQuery("Select Email_Address from user");
						if(result.next()) {
						    String megaEmailer = "";
						    %>
						    	<table>
						    <%
						    do{
								String email = result.getString("Email_Address");
								megaEmailer+= email + ",";
							%>
								<tr>
									<td>
										<a href="mailto:<%=email%>"><%=email%></a>
									</td>
								</tr>
							<%
						    }while(result.next());
						    // Get rid of last comma
						    megaEmailer = megaEmailer.substring(0, megaEmailer.length() - 1);
						    %>
						    	</table>
						    	<br />
						    	<a href="mailto:<%=megaEmailer%>">Email All</a>
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
						   	<h4 style="text-align:center;"> You have no customers....... </h4>
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
				
			</div>
		</div>
	</div>
	
	<div class="CircleSideBarRight"></div>

	<!-- Include the footer -->
	<%@include file="../includes/footer.jsp" %>

</body>
</html>
<%}%>