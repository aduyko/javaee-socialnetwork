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
	session.removeValue(SessionConstants.USERID);
	session.removeValue(SessionConstants.USERNAME);
	session.removeValue(SessionConstants.ERROR);
	if((username != null) && (password!= null) && (fname != null) && (lname!= null)) {
    	// Get a connection to the database
    	Connection conn = database.Database.getConnection();
    	conn.setAutoCommit(true);
    	if (conn != null) {
			try {
				Statement stat = conn.createStatement();
				ResultSet result = stat.executeQuery("Select * from User where Email_Address='" + username + "'");
				if(!result.next()) {
			    	// Nobody has this email address
			    	stat.executeUpdate("Insert into User(First_Name, Last_Name, Email_Address, Password) Values('" + fname + "','" + lname + "','" + username + "','" + password + "')");
			    	result = stat.executeQuery("Select * from User where Email_Address='" + username + "'");
			    	// Get the userId of the user you just created
					if(result.next()) {
					    // Sucessfully created, log user in.
					    session.putValue(SessionConstants.USERID, "" + result.getInt("User_Id"));
						session.putValue(SessionConstants.USERNAME, result.getString("Email_Address"));
					}
					else {
					    session.putValue(SessionConstants.ERROR, "Error creating account.");
					}
				}
				else {
			    	session.putValue(SessionConstants.ERROR, "An account with this email address already exists");
				}
			}
			catch(Exception e) {
		    	session.putValue(SessionConstants.ERROR, "Error creating account.");
			}
			finally{
		    	try {
					conn.close();
		    	}
		    	catch(Exception e) {}
			}
		}
	}
	else {
	    session.putValue(SessionConstants.ERROR, "Error creating account.");
	}
	response.sendRedirect("../home.jsp"); 
%>