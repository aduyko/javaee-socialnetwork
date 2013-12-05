<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>User Help Menu</title>
<link rel="stylesheet" type="text/css" href="styles/main_style.css">
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
		
		$('#showSearchUser').click(function(){
			$('#hideSearchUser').show();
			$('#showSearchUser').hide();
			$('#searchUserDiv').fadeIn();
		});
		
		$('#hideSearchUser').click(function(){
			$('#hideSearchUser').hide();
			$('#showSearchUser').show();
			$('#searchUserDiv').fadeOut();
		});

		$('#showJoinCircle').click(function(){
			$('#hideJoinCircle').show();
			$('#showJoinCircle').hide();
			$('#joinCircleDiv').fadeIn();
		});
		
		$('#hideJoinCircle').click(function(){
			$('#hideJoinCircle').hide();
			$('#showJoinCircle').show();
			$('#joinCircleDiv').fadeOut();
		});
		
		$('#showMessage').click(function(){
			$('#hideMessage').show();
			$('#showMessage').hide();
			$('#messageDiv').fadeIn();
		});
		
		$('#hideMessage').click(function(){
			$('#hideMessage').hide();
			$('#showMessage').show();
			$('#messageDiv').fadeOut();
		});
		
		$('#showCurrentCircle').click(function(){
			$('#hideCurrentCircle').show();
			$('#showCurrentCircle').hide();
			$('#currentCircleDiv').fadeIn();
		});
		
		$('#hideCurrentCircle').click(function(){
			$('#hideCurrentCircle').hide();
			$('#showCurrentCircle').show();
			$('#currentCircleDiv').fadeOut();
		});
		////
		$('#showAccounts').click(function(){
			$('#hideAccounts').show();
			$('#showAccounts').hide();
			$('#accountsDiv').fadeIn();
		});
		
		$('#hideAccounts').click(function(){
			$('#hideAccounts').hide();
			$('#showAccounts').show();
			$('#accountsDiv').fadeOut();
		});
		
		
	});
	
</script>
</head>
<body>

<div class="float-center" style="text-align:left;">

	<h1 style="text-align:center;">90's Cover Band User Help Menu</h1>
	<hr/>
	<br>
	<br>
	<div>
		<h3><a id="showSearchUser" class="button">+</a><a id="hideSearchUser" style="display:none;" class="button">-</a>Search for a user and add them to a circle you own</h3>
	</div>
	<div id="searchUserDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Search for user</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the user in the search box at the top of the page <br />
				Select the user whom you want to add to your circle <br />
				Under the user's information, you will see a list of circles you own <br/>
				Click invite for the circle you wish to invite this user to and an invite request will be sent to them<br />
				</p>
			</li>
		</ul>
	</div>
	
	<div style="margin-top:20px">
		<h3><a id="showJoinCircle" class="button">+</a><a id="hideJoinCircle" style="display:none;" class="button">-</a>Join a circle</h3>
	</div>
	<div id="joinCircleDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Join a circle</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the user whose circle you wish to join into the search box at the top of the page <br />
				Select the user whose circle you wish to join<br />
				Under the user's information, you will see a list of circles the user is in <br/>
				Click join for the circle you wish to join and a request will be sent to the owner for you to join the circle<br />
				</p>
			</li>
		</ul>
	</div>
	
	<div style="margin-top:20px">
		<h3><a id="showMessage" class="button">+</a><a id="hideMessage" style="display:none;" class="button">-</a>Messaging</h3>
	</div>
	<div id="messageDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Receive a message</b>
				<p style="margin-left:10px;">Log into your account <br/>
				On the left side toolbar, click messages <br />
				A list of messages will appear on this page <br/>
				Click on the + icon to view the contents of any message <br />
				</p>
			</li>
			<li>
				<b>Send a message</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the user who you wish to send a message to into the search box at the top of the page <br />
				Select the user who you want to send a message to<br />
				Under the user's information, you will see a section to send the user a message<br/>
				Fill in the subject and message content and click send to send a message to the user <br />
				</p>
			</li>
			<li>
				<b>Respond to a message</b>
				<p style="margin-left:10px;">Log into your account <br/>
				On the left side toolbar, click messages <br />
				A list of messages will appear on this page <br/>
				Click the respond button and a section to respond to this message will appear <br />
				Fill in the subject and message content and click send to respond to the user's message<br />
				</p>
			</li>
			<li>
				<b>Delete a message</b>
				<p style="margin-left:10px;">Log into your account <br/>
				On the left side toolbar, click messages <br />
				A list of messages will appear on this page <br/>
				Click on the big red x next to any message and that message will be deleted <br />
				</p>
			</li>
		</ul>
	</div>
	
	<div style="margin-top:20px">
		<h3><a id="showCurrentCircle" class="button">+</a><a id="hideCurrentCircle" style="display:none;" class="button">-</a>List a customers current circles</h3>
	</div>
	<div id="currentCircleDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>List your current circles</b>
				<p style="margin-left:10px;">Log into your account <br/>
				A list of all of the circle you own and are is in listen on the left side toolbar/>
				</p>
			</li>
			<li>
				<b>List another user's circles</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Enter the name of the user whose circles you wish to view into the search bar on the top of the page<br />
				Select the user whose circles you want to view <br />
				Under the user's information, you will see a list of all of the circles they're in<br/>
				</p>
			</li>
		</ul>
	</div>
	
	<div style="margin-top:20px">
		<h3><a id="showAccounts" class="button">+</a><a id="hideAccounts" style="display:none;" class="button">-</a>List your account history</h3>
	</div>
	<div id="accountsDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>View your account history</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Scroll to the bottom of your home page to view a list of all of your accounts <br />
				Clicking on the + button next to an account will display that accounts purchase history <br />
				</p>
			</li>
		</ul>
	</div>
	
	<div style="margin-top:20px">
		<h3><a id="showItemSuggestion" class="button">+</a><a id="hideItemSuggestion" style="display:none;" class="button">-</a>Produce a list of suggested items</h3>
	</div>
	<div id="itemSuggestionDiv" style="text-align:left;display:none;">
		<ul>
			<li>
				<b>Produce item suggestion list</b>
				<p style="margin-left:10px;">Log into your account <br/>
				Scroll to the bottom of your home page to see a list of suggested items.<br />
				</p>
			</li>
		</ul>
	</div>
	
</div>


</body>
</html>