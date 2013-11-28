<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>90's Cover Band</title>
<link rel="stylesheet" type="text/css" href="styles/main_style.css">
<style>
html { 
	background: url(/cse-305/images/bg.jpg) no-repeat center center fixed; 
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
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
		
		setInterval(function(){
			$('#error').fadeOut();
		}, 4000);
		
		$('#btn_signup').click(function(){
			removeErrors();
			signUp();
		});
		
		$('#btn_logout').click(function(){
			$('#logout_form').submit();
		});
		
		$('#btn_create_account').click(function(){
			removeErrors();
			$('#login_form').hide();
			$('#signup_form').fadeIn();
		});
		
		$('#btn_switch_login').click(function(){
			removeErrors();
			$('#signup_form').hide();
			$('#login_form').fadeIn();
		});
		
	});
	
</script>
</head>
<body>
<%
	Integer userid =  (Integer)session.getAttribute(SessionConstants.USERID);
	String username = (String)session.getAttribute(SessionConstants.USERNAME);
	if((userid == null) || (username == null)) {
%>
<div class="float-center">

	<h1>90's Cover Band</h1>
	<br>
	<br>
	<form id="login_form" action="servlets/user_login.jsp" method="post">
		<input id="email" name="username" placeholder="Email" type="text">
		<input id="password" name="password" placeholder="Password" type="password">
		<a id="btn_login" class="button">Log In</a>
		<br />
		<br />
		<br />
		<a id="btn_create_account" class="button">Create Account</a>
	</form>
	
	<form id="signup_form" action="servlets/user_signup.jsp" method="post" style="display:none;">
		<table style="margin:20px auto; text-align:left">
			<tr>
				<td>
					First Name:
				</td>
				<td>
					<input id="fname_signup" name="first_name" placeholder="First Name" type="text" />
				</td>
			</tr>
			<tr>
				<td>
					Last Name:
				</td>
				<td>
					<input id="lname_signup" name="last_name" placeholder="Last Name" type="text" />
				</td>
			</tr>
			<tr>
				<td>
					Email:
				</td>
				<td>
					<input id="email_signup" name="username" placeholder="Email" type="text">
				</td>
			</tr>
			<tr>
				<td>
					Password:
				</td>
				<td>
					<input id="password_signup" name="password" placeholder="Password" type="password" />
				</td>
			</tr>
			<tr>
				<td>
					Confirm Password:
				</td>
				<td>
					<input id="confirm_password_signup" name="confirm_password" placeholder="Confirm Password" type="password" />
				</td>
			</tr>
		</table>
		<br />
		<a id="btn_signup" class="button">Sign Up</a>
		<br />
		<br />
		<br />
		<a href="#" id="btn_switch_login">I already have an account</a>
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

</div>
<%
	}
	else {
%>
<div class="main-layout">

	<h1>90's Cover Band</h1>
	
	<h3>Welcome <%= username %>!</h3>
	<!-- User is logged in, display logged in home page -->
	<a href="servlets/user_logout.jsp" class="button">Log Out</a>
	<br />
	<a href="messages.jsp"> View my messages </a>
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