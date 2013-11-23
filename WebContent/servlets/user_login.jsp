<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%
	// Get the username and password
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Remove session variables
	session.removeValue(SessionConstants.USERID);
	session.removeValue(SessionConstants.USERNAME);
	session.removeValue(SessionConstants.ERROR);
	if((username != null) && (password!= null)) {
    	// Get a connection to the database
    	Connection conn = database.Database.getConnection();
    	if (conn != null) {
			try {
				Statement stat = conn.createStatement();
				ResultSet result = stat.executeQuery("Select * from User where Email_Address='" + username + "' and Password='" + password + "'");
				if(result.next()) {
			    	// Successful log in
			    	session.putValue(SessionConstants.USERID, "" + result.getInt("User_Id"));  
					session.putValue(SessionConstants.USERNAME, "" + result.getString("Email_Address"));
				}
				else {
			    	session.putValue(SessionConstants.ERROR, "Invalid username / password.");
				}
			}
			catch(Exception e) {
		    	session.putValue(SessionConstants.ERROR, "Error logging in.");
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
	    session.putValue(SessionConstants.ERROR, "Error logging in.");
	}
	response.sendRedirect("../home.jsp"); 
%>