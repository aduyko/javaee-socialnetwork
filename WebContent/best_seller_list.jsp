<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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
<title>Item Best seller list</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>

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
			
				<h1 style="text-align: center;"> 10 Top Selling Items </h1>
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
						ResultSet result = stat.executeQuery("select * from bestSellerList b, advertisement a where b.Advertisement_Id = a.Advertisement_Id and a.Available_Units > 0 order by b.sales desc limit 10");
						if(result.next()) {
						    %>
						    	<table class="messageTable">
						    	<tr>
						    		<th>Item Name</th>
						    		<th>Company</th>
						    		<th>Description</th>
						    		<th>Price</th>
						    		<th>Amount Sold</th>
						    	</tr>
						    <%
						    do{
							    String itemName = result.getString("Item_Name");
							    String description = result.getString("Content");
							    String company = result.getString("Company");
							    Integer sales = result.getInt("sales");
							    Integer price = result.getInt("Unit_Price");
							%>
								<tr>
									<td><%=itemName %></td>
									<td><%=company %></td>
									<td><%=description %></td>
									<td><%=price %></td>
									<td><%=sales %></td>
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
						   	<h4 style="text-align:center;"> There are not any items available... </h4>
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
	
	<!-- Include the right side bar -->
	<jsp:include page="includes/right_bar.jsp" />

	<!-- Include the footer -->
	<%@include file="includes/footer.jsp" %>

</body>
</html>
<%}%>