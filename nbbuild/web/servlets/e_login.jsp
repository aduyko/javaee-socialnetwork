<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String ssn = (String)request.getParameter("username");
	String password = (String)request.getParameter("password");
	// Remove session variables
	session.removeAttribute(SessionConstants.EMPLOYEE_ID);
	session.removeAttribute(SessionConstants.EMPLOYEE_NAME);
	session.removeAttribute(SessionConstants.EMPLOYEE_NAME);
	session.removeAttribute(SessionConstants.ERROR);
	if((ssn != null) && (password!= null)) {
    	// Get a connection to the database
    	Connection conn = null;
    	Statement stat = null;
    	ResultSet result = null;
		try {
			 // Connect to the jdbc driver and tell it your database credentials
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			stat = conn.createStatement();
			result = stat.executeQuery("Select * from employee where SSN= " + ssn + " and Password='" + password + "'");
			if(result.next()) {
			   	// Successful log in
			   	session.setAttribute(SessionConstants.EMPLOYEE_ID, result.getInt("Employee_Id"));  
				session.setAttribute(SessionConstants.EMPLOYEE_TYPE, result.getString("Role"));
				session.setAttribute(SessionConstants.EMPLOYEE_NAME, result.getString("First_Name") + " " + result.getString("Last_Name") );
			}
			else {
			   	session.setAttribute(SessionConstants.ERROR, "Invalid ssn / password.");
			}
		}
		catch(Exception e) {
		    session.setAttribute(SessionConstants.ERROR, "Error logging in.");
		}
		finally{
		    try {
				result.close();
				stat.close();
				conn.close();
	    	}
		   	catch(Exception e) {}
		}
	}
	response.sendRedirect(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION); 
%>