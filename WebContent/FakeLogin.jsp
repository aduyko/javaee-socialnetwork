<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Auth</title>
</head>
<body>
	<%
		session.setAttribute("userid", 100100101);
		session.setAttribute("username", "Alice");
		response.sendRedirect("/cse-305/Circle?action=Home");
	%>
</body>
</html>