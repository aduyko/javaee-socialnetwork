<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%

	String circleID = request.getParameter("circleID");
	String userID = request.getParameter("userID");
	String viewUserId = request.getParameter("viewUserID");
	// If this field is present, came from the user info page
	String fromPage = request.getParameter("fromPage");
	
	if(circleID != null && userID != null) {
		Connection conn = null;
		try {
		 	// Connect to the jdbc driver and tell it your database credentials
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			ResultSet result = stat.executeQuery("Select * from joinrequest where User_Id=" + userID + " and Circle_Id=" + circleID);
			// This user has already requested to join the circle, add them to the circle
			if(result.next()) {
			    stat.executeUpdate("delete from joinrequest where User_Id=" + userID + " and Circle_Id=" + circleID);
			    stat.executeUpdate("Insert into addedto(User_Id, Circle_Id) Values(" + userID + "," + circleID + ")");
			}
			else {
			    // This user has not requested to join the circle
			    stat.executeUpdate("Insert into inviterequest(User_Id, Circle_Id) Values(" + userID + "," + circleID + ")");
			}
		}
		catch(Exception e) { session.setAttribute(SessionConstants.ERROR, "Error inviting to circle"); }
		finally{
		    try{
				conn.close();
		    }
		    catch(Exception e) {}
		}
	}
	else {
		session.setAttribute(SessionConstants.ERROR, "Error inviting to circle");
	}
	
	if(SessionConstants.USER_INFORMATION_LOCATION.equals(fromPage) && viewUserId != null) {
		session.setAttribute(SessionConstants.VIEW_USER, viewUserId);
		response.sendRedirect(SessionConstants.USER_INFORMATION_LOCATION);
	}
	else if(fromPage != null) { 
		response.sendRedirect(fromPage);
	}
	else {
	    response.sendRedirect(SessionConstants.HOME_LOCATION);
	}

%>