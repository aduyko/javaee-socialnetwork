<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${ads}" var="ad">
	<div class="advertisement">
		<ul>
			<li>${ad.adId}</li>
			<li>${ad.employee}</li>
			<li>${ad.type}</li>
			<li>${ad.timePosted}</li>
			<li>${ad.company}</li>
			<li>${ad.itemName}</li>
			<li>${ad.content}</li>
			<li>${ad.unitPrice}</li>
			<li>${ad.availableUnits}</li>
		</ul>
	</div>
</c:forEach>