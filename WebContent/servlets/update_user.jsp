<%

	String firstName = request.getParameter("fName");
	String lastName = request.getParameter("lName");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	String dob = request.getParameter("dob");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String phone = request.getParameter("phone");
	
	response.sendRedirect("/cse-305/home.jsp");

%>