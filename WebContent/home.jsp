<%@page import="constants.SessionConstants" %>
<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.Date" %>
<%@page import="java.util.Calendar" %>

<%!
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
	
	public UserData(String firstName, String lastName,
				String emailAddress, String address, String city,
				String state, String zipCode, String telephone, String gender,
				Date dateOfBirth) {
		this.firstName = firstName == null ? "None Specified" : firstName;
		this.lastName = lastName == null ? "None Specified" : lastName;
		this.emailAddress = emailAddress == null ? "None Specified" : emailAddress;
		this.address = address == null ? "None Specified" : address;
		this.city = city == null ? "None Specified" : city;
		this.state = state == null ? "None Specified" : state;
		this.zipCode = zipCode == null ? "None Specified" : zipCode;
		this.telephone = telephone == null ? "None Specified" : telephone;
		this.gender = gender == null ? "None Specified" : ("F".equals(gender) ? "Female" : "Male");
		if(dateOfBirth == null) {
			this.dateOfBirth = "None Specified";
		}
		else {
		    Calendar calendar = Calendar.getInstance();
		    calendar.setTime(dateOfBirth);
		    this.dateOfBirth = calendar.get(Calendar.MONTH) + "/" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + calendar.get(Calendar.YEAR);
		}
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
		
		/*if(($('#state').val().length > 0) && !validateState($('#state').val())) {
			validated = false;
			$('#state').addClass('input-error');
		}*/
		
		if(($('#zipcode').val().length > 0) && !validateZipCode($('#zipcode').val())) {
			validated = false;
			$('#zipcode').addClass('input-error');
		}
		
		if(($('#phone').val().length > 0) && !validatePhone($('#phone').val())) {
			validated = false;
			$('#phone').addClass('input-error');
		}
		
		if(validated) {
			var gender = $('#genderSelector').val() == "None Specified" ? "" : $('#genderSelector').val();
			var state = $('#stateSelector').val() == "None Specified" ? "" : $('#stateSelector').val();
			$('#infoForm').append('<input name="gender" style="display:none;" value="' + gender + '" />');
			$('#infoForm').append('<input name="state" style="display:none;" value="' + state + '"');
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
			
				<h1 style="text-align: center;"> My Information </h1>
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
						    UserData user = new UserData(result.getString("First_Name"), result.getString("Last_Name"), result.getString("Email_Address"), result.getString("Address"), result.getString("City"), result.getString("State"), result.getString("Zip_Code"), result.getString("Telephone"), result.getString("Gender"), result.getDate("Date_Of_Birth"));
							ArrayList<Integer> myOwnedCircles = new ArrayList<Integer>();
							ArrayList<Integer> myCircleInvites = new ArrayList<Integer>();
							// Get all circles this user owns
							result = stat.executeQuery("Select * from circle where Owner_Of_Circle=" + userID);
							while(result.next()) {
							    myOwnedCircles.add(result.getInt("Circle_Id"));
							}
							// Get all circles this user was invited to join
							result = stat.executeQuery("Select * from inviterequest where User_Id=" + userID);
							while(result.next()) {
							    myCircleInvites.add(result.getInt("Circle_Id"));
							}
							// Display user information
							%>
							<form id="infoForm" action="/cse-305/servlets/update_user.jsp" method="post">
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
														<td><input placeholder="MM/DD/YYYY" id="dob" name="dob" style="padding-left:10px;" type="text" value="<%=user.dateOfBirth%>" size="<%=user.dateOfBirth.length()%>" disabled></td>
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
															<input id="state" name="state" style="padding-left:10px;" type="text" value="<%=user.state%>" size="<%=user.state.length()%>" disabled>
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