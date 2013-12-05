<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String ssn = request.getParameter("ssn");
	String fname = request.getParameter("first_name");
	String lname = request.getParameter("last_name");
	String password = request.getParameter("password");
	String role = request.getParameter("role");
	String rate = request.getParameter("rate");
	String manager = request.getParameter("mngr");
	
	// Remove session variables
	if((ssn != null) && (password!= null) && (fname != null) && (lname!= null) && 
			(role != null) && (rate != null) && (manager != null)) {
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
			result = stat.executeQuery("Select * from Employee where SSN= " + ssn);
			if(!result.next()) {
		    	// Nobody has this email address
		    	String update = "Insert into Employee(First_Name, Last_Name, SSN, Password, Role, Hourly_Rate, Start_Date) Values('" + fname + "','" + lname + "'," + ssn + ",'" + password + "','" + role + "', " + rate + ", NOW())";
		    	System.out.println(update);
		    	stat.executeUpdate(update);
		    	result = stat.executeQuery("Select * from Employee where SSN=" + ssn);
		    	// Get the userId of the employee
				if(result.next()) {
				    // Sucessfully created, by default manager who created is manager
				    session.setAttribute(SessionConstants.VIEW_EMPLOYEE_ID, "" + result.getInt("Employee_Id"));
				    stat.executeUpdate("Insert into has_manager(Employee, Manager) values(" + result.getInt("Employee_Id") + "," + manager + ")");
				}
				else {
				    session.setAttribute(SessionConstants.ERROR, "Error creating employee.");
				}
			}
			else {
		    	session.setAttribute(SessionConstants.ERROR, "An employee with this ssn already exists");
			}
		}
		catch(Exception e) {
		   	session.setAttribute(SessionConstants.ERROR, "Error creating employee.");
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
	    response.sendRedirect(SessionConstants.VIEW_EMPLOYEE_LOCATION); 
%>