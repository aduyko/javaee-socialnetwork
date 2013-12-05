<%-- 
    Document   : Manager
    Created on : Dec 4, 2013, 8:04:09 PM
    Author     : Andy
--%>

<%@page import="constants.SessionConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
		<% 
			if (!session.getAttribute(SessionConstants.EMPLOYEE_TYPE).equals("Manager"))
				response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION);
		%>
    </head>
    <body>
		${message}<br />
        <form action="Advertisement" method="post">
			<label>Obtain Sales Report</label><br />
			<select name="month">
				<option value="" disabled="disabled" selected="selected">Month</option>
				<option value="1">January</option>
				<option value="2">February</option>
				<option value="3">March</option>
				<option value="4">April</option>
				<option value="5">May</option>
				<option value="6">June</option>
				<option value="7">July</option>
				<option value="8">August</option>
				<option value="9">September</option>
				<option value="10">October</option>
				<option value="11">November</option>
				<option value="12">December</option>
			</select>
			<select name="year">
				<option value="" disabled="disabled" selected="selected">Year</option>
				<option value="2005">2005</option>
				<option value="2006">2006</option>
				<option value="2007">2007</option>
				<option value="2008">2008</option>
				<option value="2009">2009</option>
				<option value="2010">2010</option>
				<option value="2011">2011</option>
				<option value="2012">2012</option>
				<option value="2013">2013</option>
			</select><br />
			<input type="hidden" name="action" value="salesReport" />
			<input type="submit" value="Obtain Report" />
		</form><br/>
		${salesReport}
		<a href="Advertisement?action=allAds">View All Advertisements</a><br />
		<br/>
		<form action="Advertisement" method="post">
			<label>List Transactions</label><br />
			<input type="text" name="targetName" placeholder="Name"/><br />
			<input type="radio" name="reportType" value="1" />Item Name
			<input type="radio" name="reportType" value="2" />Customer Name<br/>
			<input type="hidden" name="action" value="listTransactions"/>
			<input type="submit" value="Obtain Report" />
		</form><br/>
		${transactions}
		<form action="Advertisement" method="post">
			<label>Revenue Summary</label><br />
			<input type="text" name="targetName" placeHolder="Name"/><br />
			<input type="radio" name="reportType" value="1" />Item Name
			<input type="radio" name="reportType" value="2" />Item Type
			<input type="radio" name="reportType" value="3" />Customer Name<br/>
			<input type="hidden" name="action" value="listRevenue"/>
			<input type="submit" value="Revenue Summary" />
		</form><br/>
		${revenue}
		<br />
		<label>Most Profitable Customer Representative</label><br />
		${bestRep}<br />
		<label>Most Profitable Customer</label><br/>
		${bestCustomer}<br/>
		<label>Most Active Items</label><br/>
		${mostActiveItems}<br/>
		<form action="Advertisement" method="post">
			<label>List Customers by Item</label><br />
			<input type="text" name="itemName" placeholder="Item Name"/><br />
			<input type="hidden" name="action" value="listCustomers"/>
			<input type="submit" value="List Customers" />
		</form><br/>
		${customers}
		<form action="Advertisement" method="post">
			<label>List Items by Company</label><br />
			<input type="text" name="company" placeholder="Company Name"/><br />
			<input type="hidden" name="action" value="listCompanyItems"/>
			<input type="submit" value="List Items" />
		</form><br/>
		${items}
    </body>
</html>
