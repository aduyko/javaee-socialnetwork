<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String username = (String)request.getParameter("username");
	String password = (String)request.getParameter("password");
	// Remove session variables
	session.removeAttribute(SessionConstants.USERID);
	session.removeAttribute(SessionConstants.USERNAME);
	session.removeAttribute(SessionConstants.ERROR);
	if((username != null) && (password!= null)) {
    	// Get a connection to the database
    	Connection conn = null;
		try {
			 // Connect to the jdbc driver and tell it your database credentials
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			ResultSet result = stat.executeQuery("Select * from User where Email_Address='" + username + "' and Password='" + password + "'");
			if(result.next()) {
			   	// Successful log in
			   	session.setAttribute(SessionConstants.USERID, result.getInt("User_Id"));  
				session.setAttribute(SessionConstants.USERNAME, "" + result.getString("Email_Address"));
			}
			else {
			   	session.setAttribute(SessionConstants.ERROR, "Invalid username / password.");
			}
		}
		catch(Exception e) {
		    session.setAttribute(SessionConstants.ERROR, "Error logging in.");
		}
		finally{
		    try {
				conn.close();
	    	}
		   	catch(Exception e) {}
		}
	}
	response.sendRedirect("../home.jsp"); 
%>