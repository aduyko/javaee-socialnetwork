<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String fname = request.getParameter("first_name");
	String lname = request.getParameter("last_name");
	// Remove session variables
	session.removeAttribute(SessionConstants.USERID);
	session.removeAttribute(SessionConstants.USERNAME);
	session.removeAttribute(SessionConstants.ERROR);
	if((username != null) && (password!= null) && (fname != null) && (lname!= null)) {
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
			result = stat.executeQuery("Select * from User where Email_Address='" + username + "'");
			if(!result.next()) {
		    	// Nobody has this email address
		    	stat.executeUpdate("Insert into User(First_Name, Last_Name, Email_Address, Password) Values('" + fname + "','" + lname + "','" + username + "','" + password + "')");
		    	result = stat.executeQuery("Select * from User where Email_Address='" + username + "'");
		    	// Get the userId of the user you just created
				if(result.next()) {
				    // Sucessfully created, log user in.
				    session.setAttribute(SessionConstants.USERID, result.getInt("User_Id"));
					session.setAttribute(SessionConstants.USERNAME, result.getString("Email_Address"));
				}
				else {
				    session.setAttribute(SessionConstants.ERROR, "Error creating account.");
				}
			}
			else {
		    	session.setAttribute(SessionConstants.ERROR, "An account with this email address already exists");
			}
		}
		catch(Exception e) {
		   	session.setAttribute(SessionConstants.ERROR, "Error creating account.");
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
	response.sendRedirect(SessionConstants.LOGIN_LOCATION); 
%>