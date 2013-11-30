<%-- 
    Document   : AdServlet
    Created on : Nov 30, 2013, 4:20:53 PM
    Author     : Andy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
		<h1>Data:</h1>
		${data}
		<form id="data" action="/Advertisement" method="post">
			<input type="text" name="textInput"></input>
			<input type="hidden" name="action" value="displayText"></input>
			<input type="submit"></input>
		</form>
    </body>
</html>
