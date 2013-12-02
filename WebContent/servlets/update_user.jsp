<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
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
	String userID = request.getParameter("userID");
	String password = request.getParameter("password");
	
	if(firstName != null && lastName != null && email != null && gender != null && dob != null
		&& address != null && city != null && state != null && zipcode != null && phone != null
		&& userID != null && password != null) {
	    
	    Connection conn = null;
	    try {
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			ResultSet result = stat.executeQuery("select * from user where User_Id <>" + userID + " and Email_Address= '" + email + "'");
			if(!result.next()) {
			    // Nobody else has this email
			    String update = "update user " +
			    				"set First_Name = '" + firstName + "', " +
			    				"Last_Name = '" + lastName + "', " +
			    				"Email_Address = '" + email + "', " +
			    				("".equals(password) ? "" : "Password = '" + password + "', ") +
			    				"Address = " + ("".equals(address) ? "null, " : "'" + address + "', ") +
			    				"City = " + ("".equals(city) ? "null, " : "'" + city + "', ") +
			    				"State = " + ("".equals(state) ? "null, " : "'" + state + "', ") +
			    				"Zip_Code = " + ("".equals(zipcode) ? "null, " : "'" + zipcode + "', ") +
			    				"Telephone = " + ("".equals(phone) ? "null, " : "'" + phone + "', ") +
			    				"Gender = " + ("".equals(gender) ? "null, " : "'" + gender + "', ") +
			    				"Date_Of_Birth = " + ("".equals(dob) ? "null " : "'" + dob + "' ") +
			    				"where User_Id = " + userID;
			    stat.executeUpdate(update);
			}
			else {
			 	session.setAttribute(SessionConstants.ERROR, "A user with this email already exists.");   
			}
	    }catch(Exception e) {session.setAttribute(SessionConstants.ERROR, "Error updating user.");}
	    finally {
			try {
			    conn.close();
			}
			catch(Exception e) {}
	    }
	}
	else {
	    session.setAttribute(SessionConstants.ERROR, "Error updating user");
	}
	
	response.sendRedirect(SessionConstants.HOME_LOCATION);

%>