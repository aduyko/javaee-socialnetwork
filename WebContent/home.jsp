<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>90's Cover Band</title>
<link rel="stylesheet" type="text/css" href="styles/main_style.css">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="scripts/validation.js" type="text/javascript"></script>
<script type="text/javascript">

	// Sign the user into the system
	function signIn(){
		var validated = true;
		if(!validatePassword($('#password').val())) {
			validated = false;
			$('#password').addClass('input-error');
		}
		if(!validateEmail($('#email').val())) {
			validated = false;
			$('#email').addClass('input-error');
		}
		if(validated){
			$('#login_form').submit();
		}
	}
	
	// Sign the user up
	function signUp(){
		var validated = true;
		if(!validatePassword($('#password_signup').val())) {
			validated = false;
			$('#password_signup').addClass('input-error');
		}
		if($('#password_signup').val() != $('#confirm_password_signup').val()) {
			validated = false;
			$('#password_signup').addClass('input-error');
			$('#confirm_password_signup').addClass('input-error');
		}
		if(!validateEmail($('#email_signup').val())){
			validated = false;
			$('#email_signup').addClass('input-error');
		}
		if(!validateName($('#fname_signup').val())) {
			validated = false;
			$('#fname_signup').addClass('input-error');
		}
		if(!validateName($('#lname_signup').val())) {
			validated = false;
			$('#lname_signup').addClass('input-error');
		}
		if(validated) {
			$('#signup_form').submit();
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
		
		$('#btn_signup').click(function(){
			removeErrors();
			signUp();
		});
		
		$('#btn_logout').click(function(){
			$('#logout_form').submit();
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
	String username = (String)session.getValue(SessionConstants.USERNAME);
	if((userid == null) || (username == null)) {
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
		<br />
		<input id="lname_signup" name="last_name" placeholder="Last Name" type="text">
		<br />
		<input id="email_signup" name="username" placeholder="Email" type="text">
		<br />
		<input id="password_signup" name="password" placeholder="Password" type="password">
		<br />
		<input id="confirm_password_signup" name="confirm_password" placeholder="Confirm Password" type="password">
		<br />
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
<div class="main-layout">

	<h1>90's Cover Band</h1>
	
	<h3>Welcome <%= username %>!</h3>
	<!-- User is logged in, display logged in home page -->
	<form id="logout_form" action="servlets/user_logout.jsp" method="post">
		<a id="btn_logout" class="hover-hand">Log Out</a>
	</form>
	
	<a href="#"> View my messages </a>
	<br />
	<a href="#"> Change my account settings </a>
	<br />
	<a href="#"> View my circles </a>
	<br />
	<a href="#"> Search for users  </a>

</div>
<%
	}

%>

</body>
</html>