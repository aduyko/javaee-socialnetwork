<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.Date" %>
<%@page import="java.util.Calendar" %>

<%!
public static String getMonth(int month) {
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
}
private static class EmployeeData {
    public Integer employeeID;
    public Integer ssn;
	public String firstName;
	public String lastName;
	public Integer hourlyRate;
	public String startDate;
	public String role;
	public String address;
	public String city;
	public String state;
	public String zipCode;
	public String telephone;
	
	public EmployeeData(Integer employeeID, Integer SSN, String firstName, String lastName,
				Integer hourlyRate, Date startDate, String role, String address, String city,
				String state, String zipCode, String telephone) {
	    this.employeeID = employeeID;
	    this.ssn = SSN;
		this.firstName = firstName == null ? "None Specified" : firstName;
		this.lastName = lastName == null ? "None Specified" : lastName;
		this.hourlyRate = hourlyRate;
		this.address = address == null ? "None Specified" : address;
		this.city = city == null ? "None Specified" : city;
		this.state = state == null ? "None Specified" : state;
		this.zipCode = zipCode == null ? "None Specified" : zipCode;
		this.telephone = telephone == null ? "None Specified" : telephone;
		this.role = role;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(startDate);
		this.startDate = getMonth(calendar.get(Calendar.MONTH)) + " " + calendar.get(Calendar.DAY_OF_MONTH) + ", " + calendar.get(Calendar.YEAR);
		
	}
}
%>


<%
	// Make sure there is an employee to view
	String employeeToView = request.getParameter("empID");
	if(employeeToView == null)
	    employeeToView = (String)session.getAttribute(SessionConstants.VIEW_EMPLOYEE_ID);
	if(employeeToView == null)
		response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);

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
<title>Employee Home Page</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>

<script type="text/javascript">

	function enterEditMode() {
		$('#state').hide();
		$('#stateSelector').val($('#state').val());
		$('#stateSelector').show();
		$('#editButton').hide();
		$('#submitButton').show();
		$.each($('input'), function(){
			$(this).prop('disabled', false);
			if($(this).val() == "None Specified")
				$(this).val("");
		});
		$('#startDate').prop('disabled', true);
		$('#role').hide();
		$('#roleSelector').val($('#role').val());
		$('#roleSelector').show();
		
	}
	
	function removeErrors(){
		$('*').removeClass('input-error');
	}
	
	function submitChanges(){
		removeErrors();
		var validated = true;
		
		if(!validateName($('#fName').val())) {
			validated = false;
			$('#fName').addClass('input-error');
		}
		
		if(!validateName($('#lName').val())) {
			validated = false;
			$('#lName').addClass('input-error');
		}
		
		if(!validateSalary($('#rate').val())) {
			validated = false;
			$('#rate').addClass('input-error');
		}
		
		if(($('#address').val().length > 0) && !validateAddress($('#address').val())) {
			validated = false;
			$('#address').addClass('input-error');
		}
		
		if(($('#zipcode').val().length > 0) && !validateZipCode($('#zipcode').val())) {
			validated = false;
			$('#zipcode').addClass('input-error');
		}
		
		if(($('#phone').val().length > 0) && !validatePhone($('#phone').val())) {
			validated = false;
			$('#phone').addClass('input-error');
		}
		
		if(($('#password').val().length > 0) && !validatePassword($('#password').val())) {
			validated = false;
			$('#password').addClass('input-error');
		}
		
		if(validated) {
			var role = $('#roleSelector').val();
			var state = $('#stateSelector').val() == "None Specified" ? "" : $('#stateSelector').val();
			$('#infoForm').append('<input name="state" style="display:none;" value="' + state + '" />');
			$('#infoForm').append('<input name="role" style="display:none;" value="' + role + '" />');
			$('#infoForm').submit();
		}
	}

	$(function(){
		$('#editButton').click(function(){
			enterEditMode();
		});
		$('#submitButton').click(function(){
			submitChanges();
		});
		$('#tryDeleteButton').click(function(){
			$('#tryDeleteButton').hide();
			$('#deleteAlert').fadeIn();
		});
		$('#deleteButton').click(function(){
			$('#deleteForm').submit();
		});
		
		setTimeout(function(){
			$('#error').fadeOut();
		}, 4000);
	});

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
			
				<h3 style="text-align: center;"> Employee Information </h3>
				
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
						ResultSet result = stat.executeQuery("Select * from employee where Employee_Id=" + employeeToView);
						if(result.next()) {
						    EmployeeData employee = new EmployeeData(result.getInt("Employee_Id"), result.getInt("SSN") ,result.getString("First_Name"), result.getString("Last_Name"), result.getInt("Hourly_Rate"), result.getDate("Start_Date"), result.getString("Role"), result.getString("Address"), result.getString("City"), result.getString("State"), result.getString("Zip_Code"), result.getString("Telephone"));
							// Display user information
							%>
							<form id="infoForm" action="<%=SessionConstants.UPDATE_EMPLOYEE_LOCATION%>" method="post">
								<input style="display:none" name="from" value="<%=SessionConstants.VIEW_EMPLOYEE_LOCATION%>" />
								<input style="display:none" name="employeeID" value="<%=employeeToView%>" />
								<table style="width:100%">
										<tr>
											<td>
												<table class="messageTable" style="margin:20px auto; text-align:left">
													<tr>
														<td>First Name:</td>
														<td><input id="fName" name="fName" style="padding-left:10px;" type="text" value="<%= employee.firstName %>" size="<%=employee.firstName.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>Last Name:</td>
														<td><input id="lName" name="lName" style="padding-left:10px;" type="text" value="<%= employee.lastName%>" size="<%=employee.lastName.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>Password:</td>
														<td><input id="password" placeholder="Leave blank if not changing" name="password" style="padding-left:10px;" type="password" value="None Specified" size="27" disabled/></td>
													</tr>
													<tr>
														<td>Start Date:</td>
														<td><input id="startDate" style="padding-left:10px;" type="text" value="<%=employee.startDate%>" size="<%=employee.startDate.length()%>" disabled></td>
													</tr>
													<tr>
														<td>Role:</td>
														<td>
															<input id="role" style="padding-left:10px;" type="text" value="<%=employee.role %>" size="<%=employee.role.length()%>" disabled>
															<select id="roleSelector" style="display:none;">
																<option value="Customer Representative" >Customer Representative</option>
																<option value="Manager">Manager</option>
															</select>
														</td>
													</tr>
													<% 
														if("Manager".equals(employeeType)) {
													%>
													<tr>
														<td>Hourly Rate:</td>
														<td><input name="rate" id="rate" style="padding-left:10px;" type="text" value="<%=employee.hourlyRate %>" size="10" disabled></td>
													</tr>
													<% 
														}
													%>
												</table>
											</td>
											<td>
												<table class="messageTable" style="margin:20px auto; text-align:left">
													<tr>
														<td>Address:</td>
														<td><input id="address" name="address" style="padding-left:10px;" type="text" value="<%= employee.address%>" size="<%=employee.address.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>City:</td>
														<td><input id="city" name="city" style="padding-left:10px;" type="text" value="<%= employee.city%>" size="<%=employee.city.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>State:</td>
														<td>
															<input id="state" style="padding-left:10px;" type="text" value="<%=employee.state%>" size="<%=employee.state.length()%>" disabled>
															<select id="stateSelector" style="display:none;">
																<option value="None Specified">None Specified</option>
																<option value="AL">Alabama</option>
																<option value="AK">Alaska</option>
																<option value="AZ">Arizona</option>
																<option value="AR">Arkansas</option>
																<option value="CA">California</option>
																<option value="CO">Colorado</option>
																<option value="CT">Connecticut</option>
																<option value="DE">Delaware</option>
																<option value="DC">District Of Columbia</option>
																<option value="FL">Florida</option>
																<option value="GA">Georgia</option>
																<option value="HI">Hawaii</option>
																<option value="ID">Idaho</option>
																<option value="IL">Illinois</option>
																<option value="IN">Indiana</option>
																<option value="IA">Iowa</option>
																<option value="KS">Kansas</option>
																<option value="KY">Kentucky</option>
																<option value="LA">Louisiana</option>
																<option value="ME">Maine</option>
																<option value="MD">Maryland</option>
																<option value="MA">Massachusetts</option>
																<option value="MI">Michigan</option>
																<option value="MN">Minnesota</option>
																<option value="MS">Mississippi</option>
																<option value="MO">Missouri</option>
																<option value="MT">Montana</option>
																<option value="NE">Nebraska</option>
																<option value="NV">Nevada</option>
																<option value="NH">New Hampshire</option>
																<option value="NJ">New Jersey</option>
																<option value="NM">New Mexico</option>
																<option value="NY">New York</option>
																<option value="NC">North Carolina</option>
																<option value="ND">North Dakota</option>
																<option value="OH">Ohio</option>
																<option value="OK">Oklahoma</option>
																<option value="OR">Oregon</option>
																<option value="PA">Pennsylvania</option>
																<option value="RI">Rhode Island</option>
																<option value="SC">South Carolina</option>
																<option value="SD">South Dakota</option>
																<option value="TN">Tennessee</option>
																<option value="TX">Texas</option>
																<option value="UT">Utah</option>
																<option value="VT">Vermont</option>
																<option value="VA">Virginia</option>
																<option value="WA">Washington</option>
																<option value="WV">West Virginia</option>
																<option value="WI">Wisconsin</option>
																<option value="WY">Wyoming</option>
															</select>		
														</td>
													</tr>
													<tr>
														<td>ZipCode:</td>
														<td><input id="zipcode" name="zipcode" style="padding-left:10px;" type="text" value="<%=employee.zipCode%>" size="<%=employee.zipCode.length()%>" disabled></td>
													</tr>
													<tr>
														<td>Phone Number:</td>
														<td><input id="phone" name="phone" style="padding-left:10px;" type="text" value="<%=employee.telephone%>" size="<%=employee.telephone.length()%>" disabled></td>	
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</form>
								<% 
									if("Manager".equals(employeeType)) {
								%>
									<div style="text-align:center;">
										<a id="tryDeleteButton" class="delete-button">Delete Employee</a>
										<a id="editButton" class="button">Edit</a>
										<a id="submitButton" class="button" style="display:none;'">Submit Changes</a>
										<div id="deleteAlert" style="display:none;">Are you sure you want to delete this employee?<a id="deleteButton" class="delete-button">Yes I'm Sure</a></div>
										<form id="deleteForm" style="display:none;" action="<%=SessionConstants.DELETE_EMPLOYEE_LOCATION%>" method="post">
											<input name="employeeID" value="<%=employeeToView%>" />
											<input name="to" value="<%=SessionConstants.EMPLOYEE_HOME_LOCATION%>" />
										</form>
									</div>
								<% 
									}
								%>
							<%
						}
						else {
						    response.sendRedirect(SessionConstants.EMPLOYEE_LOGOUT_LOCATION);
						}
					}
					catch(Exception e){}
					finally{
						try{
							conn.close();
						}
						catch(Exception e) {}
					}
				
					String error = (String)session.getAttribute(SessionConstants.ERROR);
					session.removeAttribute(SessionConstants.ERROR);
				%>
				<br />
				<br />
				<div class="error" style="text-align:center" id="error"><%=error == null ? "" : error %></div>
			</div>
		
		</div>
	</div>
	
	<div class="CircleSideBarRight"></div>

	<!-- Include the footer -->
	<%@include file="../includes/footer.html" %>

</body>
</html>
<%}%>