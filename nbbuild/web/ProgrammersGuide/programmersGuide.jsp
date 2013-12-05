<%@page import="constants.SessionConstants" %>
<html>
<head>
<title>Programmers Guide</title>
<link rel="stylesheet" type="text/css" href="<%=SessionConstants.STYLE_SHEET_LOCATION%>" />
<style>
html { 
	background: url(<%=SessionConstants.BG_LOCATION%>) no-repeat center center fixed; 
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
</head>
<body>
<div class="float-center">

	<h1>90's Cover Band - Programmers Guide</h1>
	<br>
	<br>
	
	<div style="text-align:center;">
		<a href="ERModel.pdf">E-R Model</a>
		<br />
		<a href="DatabaseSchema.pdf">Database Schema</a>
		<br />
		<a href="Transactions.pdf">Transactions</a>
	</div>
	<br/>
	<br/>
</div>

</body>
</html>