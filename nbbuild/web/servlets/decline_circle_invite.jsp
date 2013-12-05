<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%

	String circleID = request.getParameter("circleID");
	String userID = request.getParameter("userID");
	
	if(circleID != null && userID != null) {
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
			stat.executeUpdate("delete from inviterequest where User_Id='" + userID + "' and Circle_Id='" + circleID + "'");
		}
		catch(Exception e) { session.setAttribute(SessionConstants.ERROR, "Error declining circle invite."); }
		finally{
		    try{
				stat.close();
				conn.close();
		    }
		    catch(Exception e) {}
		}
	}
	else {
		session.setAttribute(SessionConstants.ERROR, "Error declining circle invite.");
	}
	
	response.sendRedirect(SessionConstants.HOME_LOCATION);

%>