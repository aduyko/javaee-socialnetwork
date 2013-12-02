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
private static class CircleData {
    public String name;
    public int circleID;
    public CircleData(String name, int id) {
        this.name=  name;
        this.circleID = id;
    }
  }

private static class CircleJoinRequest {
    public CircleData circle;
    public UserData user;
    public CircleJoinRequest(CircleData circle, UserData user) {
		this.circle = circle;
		this.user = user;
    }
}
private static class Account {
    public String creditCardNumber;
    public Integer userID;
    public Integer accountNumber;
    public String dateCreated;
    
    public Account(String creditCard, Integer userID, Integer accountNumber, Date creationDate) {
		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(creationDate);
	  	dateCreated = getMonth(calendar.get(Calendar.MONTH)) + " " + calendar.get(Calendar.DAY_OF_MONTH) + ", " + calendar.get(Calendar.YEAR); 
    	this.creditCardNumber = creditCard;
    	this.userID = userID;
    	this.accountNumber = accountNumber;
    }
}
%>


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
<title>Home Page</title>

<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="/cse-305/Content/css/Circle/Circle.css" />
	
<link rel="stylesheet" type="text/css" href="/cse-305/styles/main_style.css" />

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<script src="/cse-305/scripts/validation.js" type="text/javascript"></script>

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
	
	function declineCircleInvite(cID) {
		$('#' + cID + '_DeclineInviteForm').submit();
	}
	
	function acceptCircleInvite(cID) {
		$('#' + cID + '_AcceptInviteForm').submit();
	}
	
	function acceptCircleJoinRequest(cID, uID) {
		$('#' + cID + '_' + uID + '_AcceptJoinForm').submit();
	}
	
	function declineCircleJoinRequest(cID, uID) {
		$('#' + cID + '_' + uID + '_DeclineJoinForm').submit();
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
	<jsp:include page="includes/header.jsp" />

	<!-- Include the left side bar -->
	<jsp:include page="includes/left_bar.jsp" />

	<div class="CircleCentral">

		<div id="circle_main" class="CircleBody" style="clear: both;">

			<div class="messageBody">
			
				<h3 style="text-align: center;"> My Information </h3>
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
						ResultSet result = stat.executeQuery("Select * from user where User_Id=" + userID);
						if(result.next()) {
						    UserData user = new UserData(result.getString("First_Name"), result.getString("Last_Name"), result.getString("Email_Address"), result.getString("Address"), result.getString("City"), result.getString("State"), result.getString("Zip_Code"), result.getString("Telephone"), result.getString("Gender"), result.getDate("Date_Of_Birth"), userID);
							ArrayList<CircleData> myOwnedCircles = new ArrayList<CircleData>();
							ArrayList<CircleData> myCircleInvites = new ArrayList<CircleData>();
							// Join requests for all of the users who want to join a circle you own
							ArrayList<CircleJoinRequest> circleJoinRequests = new ArrayList<CircleJoinRequest>();
							ArrayList<Account> accounts = new ArrayList<Account>();
							ArrayList<String> preferences = new ArrayList<String>();
							// Get all circles this user owns
							result = stat.executeQuery("Select * from circle where Owner_Of_Circle=" + userID);
							while(result.next()) {
							    myOwnedCircles.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							// Get all circles this user was invited to join
							result = stat.executeQuery("Select c.Circle_Id, c.Circle_NAME from inviterequest i, circle c where c.Circle_Id = i.circle_ID and i.User_Id=" + userID);
							while(result.next()) {
							    myCircleInvites.add(new CircleData(result.getString("Circle_NAME"), result.getInt("Circle_Id")));
							}
							// Go through all the circles you own and add all join requests for those circles to list
							for(int x = 0; x < myOwnedCircles.size(); x++) {
							    result = stat.executeQuery("Select u.First_Name, u.Last_Name, u.User_Id from joinrequest j, user u where j.User_Id = u.User_Id and j.Circle_Id= " + myOwnedCircles.get(x).circleID);
								while(result.next()) {
								    circleJoinRequests.add(new CircleJoinRequest(myOwnedCircles.get(x), new UserData(result.getString("First_Name"), result.getString("Last_Name"), null, null, null, null, null, null, null, null, result.getInt("User_Id"))));
								}
							}
							result = stat.executeQuery("Select * from account where User_Id = " + userID);
							while(result.next()) {
							    accounts.add(new Account(result.getString("Credit_Card_Number"), userID, result.getInt("Account_Number"), result.getDate("Account_Creation_Date")));
							}
							result = stat.executeQuery("Select * from user_preferences where Id= " + userID);
							while(result.next()) {
							    preferences.add(result.getString("Preference"));
							}
							// Display user information
							%>
							<form id="infoForm" action="<%=SessionConstants.UPDATE_USER_LOCATION%>" method="post">
								<input style="display:none" name="userID" value="<%=userID%>" />
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
									<input style="display:none;" name="userID" value="<%= userID%>" />
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
									    	</tr>
									    <%
									    for(int x = 0; x < accounts.size(); x++) {
											%>
											<tr>
												<td><%=accounts.get(x).accountNumber%></td>
												<td><%=accounts.get(x).creditCardNumber%></td>
												<td><%=accounts.get(x).dateCreated%></td>
											</tr>
											<%
									    }
									    %>
									    </table>
									    <%
									}
									else {
									    %>
									    <h5 style="text-align:center;">You do not have any accounts.</h5>
									    <%
									}
								%>
								<center><a id="showCreateAccount" class="button">Create new account</a></center>
								<form style="display:none;" id="createAccountForm" action="<%=SessionConstants.CREATE_ACCOUNT_LOCATION%>" method="post">
									<input style="display:none;" name="userID" value="<%=userID%>"/>
									<table style="border-collapse: separate; border-spacing: 0 5px;margin-left:auto; margin-right:auto;">
										<tr>
											<td><input id="ccNumber" name="ccNumber" placeholder="Credit Card Number" type="text"/></td>
											<td><a id="createAccount" class="button">Create</a></td>
										</tr>
									</table>
								</form>
								<hr>
								<h3 style="text-align:center;">Circle Invites</h3>
								<% 
									if(myCircleInvites.size() > 0) {
									    %>
									    	<table class="messageTable">
									    <%
									    	for(int x = 0; x < myCircleInvites.size(); x++) {
									    	    %>
									    	    <tr>
									    	    	<td><%=myCircleInvites.get(x).name%></td>
									    	    	<td>
									    	    		<form style="display:none;" id="<%=myCircleInvites.get(x).circleID%>_AcceptInviteForm" action="<%=SessionConstants.JOIN_CIRCLE_LOCATION%>" method="post">
									    	    			<input name="fromPage" value="<%=SessionConstants.HOME_LOCATION%>" />
									    	    			<input name="userID" value="<%=userID%>" />
									    	    			<input name="circleID" value="<%=myCircleInvites.get(x).circleID%>" />
									    	    		</form>
									    	    		<a onClick="acceptCircleInvite(<%=myCircleInvites.get(x).circleID%>)" class="button">Join</a>
									    	    	</td>
									    	    	<td>
									    	    		<form style="display:none;" id="<%=myCircleInvites.get(x).circleID%>_DeclineInviteForm" action="<%=SessionConstants.DECLINE_CIRCLE_INVITE_LOCATION%>" method="post">
									    	    			<input name="userID" value="<%=userID%>" />
									    	    			<input name="circleID" value="<%=myCircleInvites.get(x).circleID%>" />
									    	    		</form>
									    	    		<a onClick="declineCircleInvite(<%=myCircleInvites.get(x).circleID%>)" class="button">Decline</a>
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
									    	<h5 style="text-align:center;">You do not have any circle invites.</h5>
									    <%
									}
								%>
								<hr>
								<h3 style="text-align:center;">Circle Join Requests Awaiting Your Approval</h3>
								<% 
									if(myOwnedCircles.size() > 0) {
									    if(circleJoinRequests.size() > 0) {
											%>
												<table class="messageTable">
											<%
											for(int x = 0; x < circleJoinRequests.size(); x++) {
											    %>
											    	<tr>
											    		<td><%=circleJoinRequests.get(x).user.firstName + " " + circleJoinRequests.get(x).user.lastName%></td>
											    		<td><%=circleJoinRequests.get(x).circle.name%></td>
											    		<td>
											    			<form style="display:none;" id="<%=circleJoinRequests.get(x).circle.circleID%>_<%= circleJoinRequests.get(x).user.userID%>_AcceptJoinForm" action="<%=SessionConstants.INVITE_CIRCLE_LOCATION%>" method="post">
									    	    				<input name="fromPage" value="<%=SessionConstants.HOME_LOCATION%>" />
									    	    				<input name="userID" value="<%=circleJoinRequests.get(x).user.userID%>" />
									    	    				<input name="circleID" value="<%=circleJoinRequests.get(x).circle.circleID%>" />
									    	    			</form>
											    			<a onClick="acceptCircleJoinRequest(<%=circleJoinRequests.get(x).circle.circleID%>,<%=circleJoinRequests.get(x).user.userID%>)" class="button">Accept</a>
											    		</td>
											    		<td>
											    			<form style="display:none;" id="<%=circleJoinRequests.get(x).circle.circleID%>_<%= circleJoinRequests.get(x).user.userID%>_DeclineJoinForm" action="<%=SessionConstants.DECLINE_CIRCLE_JOIN_LOCATION%>" method="post">
									    	    				<input name="userID" value="<%=circleJoinRequests.get(x).user.userID%>" />
									    	    				<input name="circleID" value="<%=circleJoinRequests.get(x).circle.circleID%>" />
									    	    			</form>
											    			<a onclick="declineCircleJoinRequest(<%=circleJoinRequests.get(x).circle.circleID%>,<%=circleJoinRequests.get(x).user.userID%> )" class="button">Reject</a>
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
												<h5 style="text-align:center;">You do not have any requests to join a circle you own.</h5>
											<%
									    }
									}
									else {
									    %>
									    	<h5 style="text-align:center;">You do not own any circles.</h5>
									    <%
									}
								%>
							<%
						}
						else {
						    session.removeAttribute(SessionConstants.USERID);
						    session.removeAttribute(SessionConstants.USERNAME);
						    response.sendRedirect(SessionConstants.LOGIN_LOCATION);
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