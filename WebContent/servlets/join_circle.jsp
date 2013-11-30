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
	String viewUsersName = request.getParameter("viewUsersName");
	
	if(viewUserId != null && viewUsersName != null) {
		
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
				//stat.executeUpdate("Insert into addedto(User_Id, Circle_Id) Values(" + userID + "," + circleID + ")");
			}
			catch(Exception e) { session.setAttribute(SessionConstants.ERROR, "Error joining circle"); }
			finally{
			    try{
					conn.close();
			    }
			    catch(Exception e) {}
			}
	    }
	    else {
			session.setAttribute(SessionConstants.ERROR, "Error joining circle");
	    }
	    session.setAttribute(SessionConstants.VIEW_USER_NAME, viewUsersName);
		session.setAttribute(SessionConstants.VIEW_USER, viewUserId);
		response.sendRedirect("/cse-305/user-information.jsp");
	}
	else {
	    response.sendRedirect(SessionConstants.HOME_LOCATION);
	}

%>