<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String employeeID = (String)request.getParameter("employeeID");
	String to = (String)request.getParameter("to");
    // Get a connection to the database
    Connection conn = null;
    Statement stat = null;
	try {
		 // Connect to the jdbc driver and tell it your database credentials
		Class.forName(Database.JDBC_DRIVER).newInstance();
		java.util.Properties sysprops = System.getProperties();
		sysprops.put("user", Database.DATABASE_USERNAME);
		sysprops.put("password", Database.DATABASE_PASSWORD);
		conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
		stat = conn.createStatement();
		stat.executeUpdate("delete from Employee where Employee_Id=" + employeeID);
		session.setAttribute(SessionConstants.ERROR, "Employee deleted.");
	}
	catch(Exception e) {
	    session.setAttribute(SessionConstants.ERROR, "Error deleting employee.");
	}
	finally{
	    try {
			stat.close();
			conn.close();
	   	}
	   	catch(Exception e) {}
	}
	response.sendRedirect(to); 
%>