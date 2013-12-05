<%-- 
    Document   : AllAds
    Created on : Dec 5, 2013, 1:38:37 AM
    Author     : Andy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Ads</title>
    </head>
    <body>
		<table>
			<tr>
				<th>ID</th>
				<th>Employee ID</th>
				<th>Type</th>
				<th>Date Posted</th>
				<th>Company</th>
				<th>Name</th>
				<th>Content</th>
				<th>Price</th>
				<th>Units Available</th>
			</tr>
			<c:forEach items="${allAds}" var="ad">
				<tr>
					<td>${ad.adId}</td>
					<td>${ad.employee}</td>
					<td>${ad.type}</td>
					<td>${ad.timePosted}</td>
					<td>${ad.company}</td>
					<td>${ad.itemName}</td>
					<td>${ad.content}</td>
					<td>${ad.unitPrice}</td>
					<td>${ad.availableUnits}</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>
