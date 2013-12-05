<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>User Help Menu</title>
<link rel="stylesheet" type="text/css" href="../styles/main_style.css">
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
<script type="text/javascript">

	$(function(){
		
		$('#showAddEditEmployee').click(function(){
			$('#hideAddEditEmployee').show();
			$('#showAddEditEmployee').hide();
			$('#addEditEmployeeDiv').fadeIn();
		});
		
		$('#hideAddEditEmployee').click(function(){
			$('#hideAddEditEmployee').hide();
			$('#showAddEditEmployee').show();
			$('#addEditEmployeeDiv').fadeOut();
		});
		
		$('#showAddEditCustomer').click(function(){
			$('#hideAddEditCustomer').show();
			$('#showAddEditCustomer').hide();
			$('#addEditCustomerDiv').fadeIn();
		});
		
		$('#hideAddEditCustomer').click(function(){
			$('#hideAddEditCustomer').hide();
			$('#showAddEditCustomer').show();
			$('#addEditCustomerDiv').fadeOut();
		});
		
		$('#showItemSuggestion').click(function(){
			$('#hideItemSuggestion').show();
			$('#showItemSuggestion').hide();
			$('#itemSuggestionDiv').fadeIn();
		});
		
		$('#hideItemSuggestion').click(function(){
			$('#hideItemSuggestion').hide();
			$('#showItemSuggestion').show();
			$('#itemSuggestionDiv').fadeOut();
		});
		
	});
	
</script>
</head>
<body>

<div class="float-center" style="text-align:left;">

	<h1 style="text-align:center;">90's Cover Band Employee Help Menu</h1>
	<hr/>
	<br>
	<br>
	<div>
		<h3><a id="showAddEditEmployee" class="button">+</a><a id="hideAddEditEmployee" style="display:none;" class="button">-</a>Add, Edit, Delete Employee Information</h3>
	</div>
	<div id="addEditEmployeeDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Create an Employee (only managers)</b>
				<p style="margin-left:10px;">Log into your account<br/>
				At the bottom of your home screen, you will see a form to create an employee<br />
				Fill in the employees information <br />
				Click submit and the employee will be created.<br />
				</p>
			</li>
			<li>
				<b>Edit your account</b> 
				<p style="margin-left:10px;">Log into your account <br/>
				Click on edit account <br/>
				Make changes to your account<br/>
				Click submit changes and the changes will be submitted <br />
				</p>
			</li>
			<li>
				<b>Edit an employee's account (only managers)</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the employee you wish to edit in the search bar on the top of screen<br/>
				Click on the name of the employee in the list that appears<br/>
				Click on edit account<br />
				Make changes to the employees account<br/>
				Click submit and the changes to the employee will be submitted<br/>
				</p>
			</li>
			<li>
				<b>Delete your account</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Click on delete account <br/>
				Another alert will pop up, click delete account again and your account will be deleted<br />
				</p>
			</li>
			<li>
				<b>Delete an employee's account (only managers)</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the employee you wish to delete in the search bar on the top of screen<br/>
				Click on the name of the employee in the list that appears<br/>
				Click on delete account<br />
				Another alert will pop up, click delete account again and the employee's account will be deleted<br />
			</li>
		</ul>
	</div>
	<div style="margin-top:20px">
		<h3><a id="showAddEditCustomer" class="button">+</a><a id="hideAddEditCustomer" style="display:none;" class="button">-</a>Add, Edit, Delete Customer Information</h3>
	</div>
	<div id="addEditCustomerDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Edit an customers's account (Customer Reps only)</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the customer you wish to edit in the search bar on the top of screen<br/>
				Click on the name of the customer in the list that appears<br/>
				Click on edit account<br />
				Make changes to the customers account<br/>
				Click submit and the changes to the customer will be submitted<br/>
				</p>
			</li>
			<li>
				<b>Delete a customer's account (Customer Reps only)</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the customer you wish to delete in the search bar on the top of screen<br/>
				Click on the name of the customer in the list that appears<br/>
				Click on delete account<br />
				Another alert will pop up, click delete account again and the customer's account will be deleted<br />
			</li>
		</ul>
	</div>
	<div style="margin-top:20px">
		<h3><a id="showItemSuggestion" class="button">+</a><a id="hideItemSuggestion" style="display:none;" class="button">-</a>Produce a list of items to suggest to a customer</h3>
	</div>
	<div id="itemSuggestionDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Produce item suggestion list (Customer Reps only)</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the customer you wish to produce an item suggestion list for into the bar on the top of screen<br/>
				Click on the name of the customer in the list that appears<br/>
				Scroll to the button of the users page to find a list of items to suggest to the user<br />
				</p>
			</li>
		</ul>
	</div>
	
	
	

</div>


</body>
</html>