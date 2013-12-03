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
private static class UserData {
	public String firstName;
	public String lastName;
	public String emailAddress;
	public String address;
	public String city;
	public String state;
	public String zipCode;
	public String telephone;
	public String gender;
	public String dateOfBirth;
	public Integer userID;
	
	public UserData(String firstName, String lastName,
				String emailAddress, String address, String city,
				String state, String zipCode, String telephone, String gender,
				Date dateOfBirth, Integer userID) {
		this.firstName = firstName == null ? "None Specified" : firstName;
		this.lastName = lastName == null ? "None Specified" : lastName;
		this.emailAddress = emailAddress == null ? "None Specified" : emailAddress;
		this.address = address == null ? "None Specified" : address;
		this.city = city == null ? "None Specified" : city;
		this.state = state == null ? "None Specified" : state;
		this.zipCode = zipCode == null ? "None Specified" : zipCode;
		this.telephone = telephone == null ? "None Specified" : telephone;
		this.gender = gender == null ? "None Specified" : ("F".equals(gender) ? "Female" : "Male");
		this.userID = userID;
		if(dateOfBirth == null) {
			this.dateOfBirth = "None Specified";
		}
		else {
		    Calendar calendar = Calendar.getInstance();
		    calendar.setTime(dateOfBirth);
		    this.dateOfBirth = calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1) + "-" + calendar.get(Calendar.DAY_OF_MONTH);
		}
	}
}
private static class Account {
    public String creditCardNumber;
    public Integer userID;
    public Integer accountNumber;
    public String dateCreated;
    public ArrayList<Purchase> purchases;
    
    public Account(String creditCard, Integer userID, Integer accountNumber, Date creationDate) {
		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(creationDate);
	  	dateCreated = getMonth(calendar.get(Calendar.MONTH)) + " " + calendar.get(Calendar.DAY_OF_MONTH) + ", " + calendar.get(Calendar.YEAR); 
    	this.creditCardNumber = creditCard;
    	this.userID = userID;
    	this.accountNumber = accountNumber;
    	purchases = new ArrayList<Purchase>();
    }
}
private static class Purchase {
    public String date;
    public Integer numProducts;
    public Integer cost;
    public String productName;
    public String companyName;
    
    public Purchase(Date datePurchased, Integer numBought, Integer cost, String productName, String companyName) {
		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(datePurchased);
	  	date = getMonth(calendar.get(Calendar.MONTH)) + " " + calendar.get(Calendar.DAY_OF_MONTH) + ", " + calendar.get(Calendar.YEAR); 
		this.numProducts = numBought;
		this.cost = cost;
		this.productName = productName;
		this.companyName = companyName;
    }
}
%>
<%
	// Make sure you can access the user you are trying to view
	String userToDisplay = request.getParameter("userToDisplayID");
	if(userToDisplay == null)
		userToDisplay = (String)session.getAttribute(SessionConstants.E_VIEW_USER_ID);
	if(userToDisplay == null)
   		response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);
	
	// Make sure someone is logged in
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
<title>Home Page</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>

<script type="text/javascript">

	function enterEditMode() {
		$('#gender').hide();
		$('#genderSelector').val($('#gender').val());
		$('#genderSelector').show();
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
	}
	
	function removeErrors(){
		$('*').removeClass('input-error');
	}
	
	function createAccount() {
		removeErrors();
		if(validateCreditCard($('#ccNumber').val())) {
			$('#createAccountForm').submit();
		}
		else {
			$('#ccNumber').addClass('input-error');
		}
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
		
		if(!validateEmail($('#email').val())) {
			validated = false;
			$('#email').addClass('input-error');
		}
		// GENDER WILL BE A DROP DOWN, CAN'T BE WRONG
		if(($('#dob').val().length > 0) && !validateDate($('#dob').val())) {
			validated = false;
			$('#dob').addClass('input-error');
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
			var gender = $('#genderSelector').val() == "None Specified" ? "" : ($('#genderSelector').val() == "Male" ? "M" : "F");
			var state = $('#stateSelector').val() == "None Specified" ? "" : $('#stateSelector').val();
			$('#infoForm').append('<input name="gender" style="display:none;" value="' + gender + '" />');
			$('#infoForm').append('<input name="state" style="display:none;" value="' + state + '" />');
			$('#infoForm').submit();
		}
	}
	
	function displayAccountHistory(accID) {
		$('#' + accID + '_accbtn').hide();
		$('#' + accID + "_AccountHistory").fadeIn();
	}

	$(function(){
		$('#editButton').click(function(){
			enterEditMode();
		});
		$('#submitButton').click(function(){
			submitChanges();
		});
		$('#showCreateAccount').click(function(){
			$('#showCreateAccount').hide();
			$('#createAccountForm').fadeIn();
		});
		$('#createAccount').click(function(){
			createAccount();
		});
		$('#updatePreferences').click(function(){
			$('#updatePreferencesForm').submit();
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
			
				<h3 style="text-align: center;"> Users Information </h3>
				
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
						ResultSet result = stat.executeQuery("Select * from user where User_Id=" + userToDisplay);
						if(result.next()) {
						    UserData user = new UserData(result.getString("First_Name"), result.getString("Last_Name"), result.getString("Email_Address"), result.getString("Address"), result.getString("City"), result.getString("State"), result.getString("Zip_Code"), result.getString("Telephone"), result.getString("Gender"), result.getDate("Date_Of_Birth"), Integer.parseInt(userToDisplay));
							ArrayList<Account> accounts = new ArrayList<Account>();
							ArrayList<String> preferences = new ArrayList<String>();
							result = stat.executeQuery("Select * from account where User_Id = " + userToDisplay);
							while(result.next()) {
							    accounts.add(new Account(result.getString("Credit_Card_Number"), Integer.parseInt(userToDisplay), result.getInt("Account_Number"), result.getDate("Account_Creation_Date")));
							}
							// Go through each of the accounts and add all of the purchases to it
							for(int x = 0; x < accounts.size(); x++) {
							    result = stat.executeQuery("select * from purchase_information where account =" + accounts.get(x).accountNumber);
								while(result.next()) {
								   	accounts.get(x).purchases.add(new Purchase(result.getDate("Date"), result.getInt("Number_Of_Units"), result.getInt("cost"), result.getString("Item_Name"), result.getString("Company")));
								}
							}
							result = stat.executeQuery("Select * from user_preferences where Id= " + userToDisplay);
							while(result.next()) {
							    preferences.add(result.getString("Preference"));
							}
							// Display user information
							%>
							<form id="infoForm" action="<%=SessionConstants.UPDATE_USER_LOCATION%>" method="post">
								<input style="display:none" name="userID" value="<%=userToDisplay%>" />
								<input style="display:none;" name="from" value="<%=SessionConstants.EMPLOYEE_VIEW_USER_LOCATION%>"/>
								<table style="width:100%">
										<tr>
											<td>
												<table class="messageTable" style="margin:20px auto; text-align:left">
													<tr>
														<td>First Name:</td>
														<td><input id="fName" name="fName" style="padding-left:10px;" type="text" value="<%= user.firstName %>" size="<%=user.firstName.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>Last Name:</td>
														<td><input id="lName" name="lName" style="padding-left:10px;" type="text" value="<%= user.lastName%>" size="<%=user.lastName.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>Email:</td>
														<td><input id="email" name="email" style="padding-left:10px;" type="text" value="<%=user.emailAddress%>" size="<%=user.emailAddress.length()%>" disabled></td>
													</tr>
													<tr>
														<td>Password:</td>
														<td><input id="password" placeholder="Leave blank if not changing" name="password" style="padding-left:10px;" type="password" value="None Specified" size="27" disabled/></td>
													</tr>
													<tr>
														<td>Gender:</td>
														<td>
															<input id="gender" style="padding-left:10px;" type="text" value="<%=user.gender%>" size="<%=user.gender.length()%>" disabled>
															<select id="genderSelector" style="display:none;">
																<option value="None Specified">None Specified</option>
																<option value="Male">Male</option>
																<option value="Female">Female</option>
															</select>
														</td>
													</tr>
													<tr>
														<td>Date of Birth:</td>
														<td><input placeholder="YYYY-MM-DD" id="dob" name="dob" style="padding-left:10px;" type="text" value="<%=user.dateOfBirth%>" size="<%=user.dateOfBirth.length()%>" disabled></td>
													</tr>
												</table>
											</td>
											<td>
												<table class="messageTable" style="margin:20px auto; text-align:left">
													<tr>
														<td>Address:</td>
														<td><input id="address" name="address" style="padding-left:10px;" type="text" value="<%= user.address%>" size="<%=user.address.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>City:</td>
														<td><input id="city" name="city" style="padding-left:10px;" type="text" value="<%= user.city%>" size="<%=user.city.length()%>" disabled /></td>
													</tr>
													<tr>
														<td>State:</td>
														<td>
															<input id="state" style="padding-left:10px;" type="text" value="<%=user.state%>" size="<%=user.state.length()%>" disabled>
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
														<td><input id="zipcode" name="zipcode" style="padding-left:10px;" type="text" value="<%=user.zipCode%>" size="<%=user.zipCode.length()%>" disabled></td>
													</tr>
													<tr>
														<td>Phone Number:</td>
														<td><input id="phone" name="phone" style="padding-left:10px;" type="text" value="<%=user.telephone%>" size="<%=user.telephone.length()%>" disabled></td>	
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</form>
								<div style="text-align:center;">
									<a id="editButton" class="button">Edit</a>
									<a id="submitButton" class="button" style="display:none;'">Submit Changes</a>
								</div>
								<hr>
								<h3 style="text-align:center;">Preferences</h3>
								<form style="text-align:center" id="updatePreferencesForm" action="<%=SessionConstants.UPDATE_PREFERENCES_LOCATION%>" method="post">
									<input style="display:none;" name="userID" value="<%= userToDisplay%>" />
									<input style="display:none;" name="from" value="<%=SessionConstants.EMPLOYEE_VIEW_USER_LOCATION %>" />
									<table style="border-collapse: separate; border-spacing: 0 5px;margin-left:auto; margin-right:auto;">
										<tr>
											<td>cars</td>
											<td><input name="cars" type="checkbox" <%=preferences.contains("cars") ? "checked" : "" %> /></td>
										</tr>
										<tr>
											<td>life insurance</td>
											<td> <input name="lifeinsurance" type="checkbox" <%=preferences.contains("life insurance") ? "checked" : "" %> /> </td>
										</tr>
										<tr>
											<td>clothing</td>
											<td> <input name="clothing" type="checkbox" <%=preferences.contains("clothing") ? "checked" : "" %> /> </td>
										</tr>
										<tr>
											<td>toys</td>
											<td> <input name="toys" type="checkbox" <%=preferences.contains("toys") ? "checked" : "" %> /> </td>
										</tr>
									</table>
									<a id="updatePreferences" style="text-align:center;" class="button">Update Preferences</a>
								</form>
								<hr>
								<h3 style="text-align:center;">Accounts</h3>
								<% 
									if(accounts.size() > 0) {
									    %>
									    <table class="messageTable">
									    	<tr>
									    		<th>Account #</th>
									    		<th>Credit Card #</th>
									    		<th>Date Created</th>
									    		<th></th>
									    	</tr>
									    <%
									    for(int x = 0; x < accounts.size(); x++) {
											%>
											<tr>
												<td><%=accounts.get(x).accountNumber%></td>
												<td><%=accounts.get(x).creditCardNumber%></td>
												<td><%=accounts.get(x).dateCreated%></td>
												<td><a id="<%=accounts.get(x).accountNumber%>_accbtn" onClick="displayAccountHistory(<%=accounts.get(x).accountNumber%>)" class="button">Account History</a></td>
											</tr>
											<tr id="<%=accounts.get(x).accountNumber%>_AccountHistory" style="display:none;">
												<td colspan="4">
													<table style="padding-left:50px;background-color:#EEEEEE" class="messageTable">
														<% 
															if(accounts.get(x).purchases.size() > 0) {
															    %>
															    <tr>
																	<th>Item Name</th>
																	<th>Company</th>
																	<th>Units Purchased</th>
																	<th>Cost</th>
																	<th>Date</th>
																</tr>
															    <%
															    ArrayList<Purchase> purchases = accounts.get(x).purchases;
															    for(int y = 0; y < purchases.size(); y++) {
																	%>
																		<tr>
																			<td><%=purchases.get(y).productName%></td>
																			<td><%=purchases.get(y).companyName%></td>
																			<td><%=purchases.get(y).numProducts%></td>
																			<td><%=purchases.get(y).cost%></td>
																			<td><%=purchases.get(y).date%></td>
																		</tr>
																	<%
															    }
															}
															else {
															    %>
															    	<tr>
															    		<th>No Purchase History</th>
															    	</tr>
															    <%
															}
														%>
													</table>
													<hr>
												</td>
											</tr>
											<%
									    }
									    %>
									    </table>
									    <%
									}
									else {
									    %>
									    <h5 style="text-align:center;"> User does not have any accounts.</h5>
									    <%
									}
								%>
								<center><a id="showCreateAccount" class="button">Create new account</a></center>
								<form style="display:none;" id="createAccountForm" action="<%=SessionConstants.CREATE_ACCOUNT_LOCATION%>" method="post">
									<input style="display:none;" name="userID" value="<%=userToDisplay%>"/>
									<input style="display:none;" name="from" value="<%=SessionConstants.EMPLOYEE_VIEW_USER_LOCATION%>" />
									<table style="border-collapse: separate; border-spacing: 0 5px;margin-left:auto; margin-right:auto;">
										<tr>
											<td><input id="ccNumber" name="ccNumber" placeholder="Credit Card Number" type="text"/></td>
											<td><a id="createAccount" class="button">Create</a></td>
										</tr>
									</table>
								</form>
								<br/>
								<br/>
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
				
				<div class="error" style="text-align:center" id="error"><%=error == null ? "" : error %></div>
				<br/>
			</div>
		
		</div>
	</div>
	
	<div class="CircleSideBarRight"></div>

	<!-- Include the footer -->
	<%@include file="../includes/footer.html" %>

</body>
</html>
<%}%>