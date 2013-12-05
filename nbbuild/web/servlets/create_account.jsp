<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%

	String creditCard = request.getParameter("ccNumber");
	String userID = request.getParameter("userID");
	String from = request.getParameter("from");
	
	if(creditCard != null && userID != null) {
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
			result = stat.executeQuery("select * from account where Credit_Card_Number = '" + creditCard + "'");
			if(result.next()) {
				session.setAttribute(SessionConstants.ERROR, "An account with this credit card number already exists");	    
			}
			else {
				stat.executeUpdate("insert into account(User_Id, Credit_Card_Number, Account_Creation_Date) values(" + userID + ", '" + creditCard + "', NOW())");
			}
		}
		catch(Exception e) { session.setAttribute(SessionConstants.ERROR, "Error creation account."); }
		finally{
		    try{
				result.close();
				stat.close();
				conn.close();
		    }
		    catch(Exception e) {}
		}
	}
	else {
		session.setAttribute(SessionConstants.ERROR, "Error creating account.");
	}
	
	if(SessionConstants.EMPLOYEE_VIEW_USER_LOCATION.equals(from)) {
	    if(userID != null ){
			session.setAttribute(SessionConstants.E_VIEW_USER_ID, userID);
			response.sendRedirect(SessionConstants.EMPLOYEE_VIEW_USER_LOCATION);
	    }
	    else {
			response.sendRedirect(SessionConstants.EMPLOYEE_HOME_LOCATION);
	    }
	}
	else 
		response.sendRedirect(SessionConstants.HOME_LOCATION);

%>