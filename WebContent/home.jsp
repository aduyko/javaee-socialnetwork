<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>90's Cover Band</title>
<link rel="stylesheet" type="text/css" href="styles/main_style.css">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="scripts/validation.js" type="text/javascript"></script>
<script type="text/javascript">

	// Make sure the user email and password are valid
	function signIn(){
		var validated = true;
		/*if(!validatePassword($('#password').val())) {
			validated = false;
			$('#password').addClass('input-error');
		}
		if(!validateEmail($('#email').val())) {
			validated = false;
			$('#email').addClass('input-error');
		}*/
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
		
		$('#btn_create_account').click(function(){
			$('#login_form').hide();
			$('#signup_form').fadeIn();
		});
		
		$('#btn_switch_login').click(function(){
			$('#signup_form').hide();
			$('#login_form').fadeIn();
		});
		
	});
	
</script>
</head>
<body>
<%
	String userid =  (String)session.getValue(SessionConstants.USERID);
	if(userid == null) {
%>
<div class="float-center">

	<h1>90's Cover Band</h1>
	<br>
	<br>
	<form id="login_form" action="servlets/user_login.jsp" method="post">
		<input id="email" name="username" placeholder="Email" type="text">
		<input id="password" name="password" placeholder="Password" type="password">
		<br/>
		<a id="btn_create_account" class="hover-hand">Create Account</a>
		<a id="btn_login" class="hover-hand">Log In</a>
	</form>
	
	<form id="signup_form" action="servlets/user_signup.jsp" method="post" style="display:none;">
		<input id="fname_signup" name="first_name" placeholder="First Name" type="text">
		<input id="lname_signup" name="last_name" placeholder="Last Name" type="text">
		<input id="email_signup" name="username" placeholder="Email" type="text">
		<input id="password_signup" name="password" placeholder="Password" type="password">
		<input id="confirm_password_signup" name="confirm_password" placeholder="Confirm Password" type="password">
		<a id="btn_signup" class="hover-hand">Sign Up</a>
		<a id="btn_switch_login" class="hover-hand">I already have an account</a>
	</form>
<%
	String error = (String)session.getValue(SessionConstants.ERROR);
	session.removeValue(SessionConstants.ERROR);
	if(error != null){
%>
	<div class="error"><%=error%></div>
<%
	}
%>
</div>
<%
	}
	else {
%>
<div>

	<!-- User is logged in, display logged in home page -->

</div>
<%
	}

%>

</body>
</html>