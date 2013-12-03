<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%

	String userID = request.getParameter("userID");
	String cars = request.getParameter("cars");
	String lifeInsurance = request.getParameter("lifeinsurance");
	String clothing = request.getParameter("clothing");
	String toys = request.getParameter("toys");
	String from = request.getParameter("from");
	
	if(userID != null) {
		Connection conn = null;
		try {
		 	// Connect to the jdbc driver and tell it your database credentials
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			stat.executeUpdate("delete from user_preferences where Id = " + userID);
			if("on".equals(cars)) {
			    stat.executeUpdate("insert into user_preferences(Id,Preference) values(" + userID + ",'cars') ");
			}
			if("on".equals(lifeInsurance)) {
			    stat.executeUpdate("insert into user_preferences(Id,Preference) values(" + userID + ",'life insurance') ");
			}
			if("on".equals(clothing)) {
			    stat.executeUpdate("insert into user_preferences(Id,Preference) values(" + userID + ",'clothing') ");
			}
			if("on".equals(toys)) {
			    stat.executeUpdate("insert into user_preferences(Id,Preference) values(" + userID + ",'toys') ");
			}
		}
		
		catch(Exception e) { session.setAttribute(SessionConstants.ERROR, "Error creation account."); }
		finally{
		    try{
				conn.close();
		    }
		    catch(Exception e) {}
		}
	}
	else {
		session.setAttribute(SessionConstants.ERROR, "Error creating account.");
	}
	
	if(SessionConstants.EMPLOYEE_VIEW_USER_LOCATION.equals(from)) {
		if(userID != null) {
		    session.setAttribute(SessionConstants.E_VIEW_USER_ID, userID);
		    response.sendRedirect(SessionConstants.EMPLOYEE_VIEW_USER_LOCATION);
		}
		else {
		    response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);
		}
	}
	else {
		response.sendRedirect(SessionConstants.HOME_LOCATION);
	}

%>