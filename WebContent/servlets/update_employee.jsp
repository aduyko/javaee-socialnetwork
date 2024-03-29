<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%
	
	String employeeID = request.getParameter("employeeID");
	String password = request.getParameter("password");
	String firstName = request.getParameter("fName");
	String lastName = request.getParameter("lName");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String phone = request.getParameter("phone");
	String from = request.getParameter("from");
	String role = request.getParameter("role");
	String rate = request.getParameter("rate");
	
	if(employeeID != null && password != null && firstName != null && lastName != null
		&& address != null && city != null && state != null && zipcode != null && phone != null) {
	    
	    Connection conn = null;
	    Statement stat = null;
	    try {
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			stat = conn.createStatement();
			// Nobody else has this email
			String update = "update employee " +
			  				"set First_Name = '" + firstName + "', " +
			   				"Last_Name = '" + lastName + "', " +
			   				("".equals(password) ? "" : "Password = '" + password + "', ") +
			   				(role == null ? "" : "Role = '" + role + "', ") +
			   				(rate == null ? "" : "Hourly_Rate = " + rate + ", ") +
			   				"Address = " + ("".equals(address) ? "null, " : "'" + address + "', ") +
			   				"City = " + ("".equals(city) ? "null, " : "'" + city + "', ") +
			   				"State = " + ("".equals(state) ? "null, " : "'" + state + "', ") +
			   				"Zip_Code = " + ("".equals(zipcode) ? "null, " : "'" + zipcode + "', ") +
			   				"Telephone = " + ("".equals(phone) ? "null " : "'" + phone + "' ") +
			   				"where Employee_Id = " + employeeID;
			stat.executeUpdate(update);
	    }catch(Exception e) {session.setAttribute(SessionConstants.ERROR, "Error updating employee.");}
	    finally {
			try {
			    stat.close();
			    conn.close();
			}
			catch(Exception e) {}
	    }
	}
	else {
	    session.setAttribute(SessionConstants.ERROR, "Error updating employee");
	}
	
	if(SessionConstants.VIEW_EMPLOYEE_LOCATION.equals(from)) {
	    if(employeeID != null) {
			session.setAttribute(SessionConstants.VIEW_EMPLOYEE_ID, employeeID);
			response.sendRedirect(SessionConstants.VIEW_EMPLOYEE_LOCATION);
	    }
	    else
			response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);
	}
	else 
		response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);

%>