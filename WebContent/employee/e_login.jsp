<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>90's Cover Band</title>
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>">
<style>
html { 
	background: url(<%=SessionConstants.BG_LOCATION%>) no-repeat center center fixed; 
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="<%=SessionConstants.VALIDATION_LOCATION%>" type="text/javascript"></script>
<script type="text/javascript">

	// Sign the user into the system
	function signIn(){
		var validated = true;
		if(!validatePassword($('#password').val())) {
			validated = false;
			$('#password').addClass('input-error');
		}
		if(!validateSSN($('#ssn').val())) {
			validated = false;
			$('#ssn').addClass('input-error');
		}
		if(validated){
			$('#login_form').submit();
		}
	}
	
	// Remove all errors from the page
	function removeErrors(){
		$('*').removeClass('input-error');
	}

	// jQuery wrapper, doesn't execute until page loads 
	$(function(){
		
		// React to clicking on button
		$('#btn_login').click(function(){
			removeErrors();
			signIn();
		});
		
		setInterval(function(){
			$('#error').fadeOut();
		}, 4000);
		
	});
	
</script>
</head>
<body>
<%
	Integer employeeID =  (Integer)session.getAttribute(SessionConstants.EMPLOYEE_ID);
	String employeeType = (String)session.getAttribute(SessionConstants.EMPLOYEE_TYPE);
	String employeeName = (String)session.getAttribute(SessionConstants.EMPLOYEE_NAME);
	if((employeeID == null) || (employeeType == null) || (employeeName == null)) {
%>
<div class="float-center">

	<h1>Employee Portal - 90's Cover Band</h1>
	<br>
	<br>
	<form id="login_form" action="<%=SessionConstants.EMPLOYEE_LOGIN_LOCATION%>" method="post">
		<input id="ssn" name="username" placeholder="SSN" type="text">
		<input id="password" name="password" placeholder="Password" type="password">
		<a id="btn_login" class="button">Log In</a>
		<br />
		<br />
		<br />
	</form>
	
	<div id="error" class="error">
		<% 
			String error = (String)session.getAttribute(SessionConstants.ERROR);
			session.removeAttribute(SessionConstants.ERROR);
			if(error != null) {
		%>
			<br />
			<br />
		<%
			}
		%>
		<%=error == null ? "" : "* " + error%>
	</div>
	<br />
	<br />
	<a href="<%=SessionConstants.EMPLOYEE_HELP_MENU_LOCATION%>">Help Menu</a>

</div>
<%
	}
	else {
	    response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);
	}

%>

</body>
</html>