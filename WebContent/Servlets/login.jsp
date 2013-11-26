<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%
    /** User wants to log out */
	if((request.getParameter("action")!=null) &&	(request.getParameter("action").trim().equals("logout")))
	{
		session.putValue("login","");
		response.sendRedirect("/");
		return;
	}
	// Get the username and password
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Take the string out of the login
	session.putValue("login","");
	if((username != null) && (password!= null)) {
    // Get a connection to the database
    Connection conn = database.Database.getConnection();
    if (conn == null) {
			// An error occured when connecting to the database
			// Redirect somewhere
    }
    else {
			try {
				Statement stat = conn.createStatement();
				ResultSet result = stat.executeQuery("Select * from Student where Id='" + username + "' and Pswd='" + password + "'");
				if(result.next()) {
				    // Successful log in
				    session.putValue("login", username);
				    // Redirect somwhere
				}
				else {
				    // Invalid username or password
				    // Redirect somewhere
				}
			}
			catch(Exception e) {
			    // Error executing querry
			    // Redirect somewhere
			}
			finally{
			    try {
					conn.close();
			    }
			    catch(Exception e) {}
			}
		}
	   		
	}
%>