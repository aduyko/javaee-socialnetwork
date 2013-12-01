<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="constants.SessionConstants" %>
<%

	String messageID = request.getParameter("messageID");

	if(messageID != null) {
	    Connection conn = null;
	    try {
			// Connect to the jdbc driver and tell it your database credentials
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			stat.executeUpdate("delete from Message where Message_Id = " + messageID);
	    }
	    catch(Exception e){}
	    finally{
			try{
			    conn.close();
			}
			catch(Exception f){}
	    }
	    
	}

	response.sendRedirect(SessionConstants.MESSAGE_LOCATION);
%>