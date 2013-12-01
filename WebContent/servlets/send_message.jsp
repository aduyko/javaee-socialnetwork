<%@page import="constants.SessionConstants" %>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database"%>
<%@page import="java.sql.Statement"%>
<% 
	String content = request.getParameter("content");
	String subject = request.getParameter("subject");
	String to = request.getParameter("to");
	String from = request.getParameter("from");
	// If message is sent from a user-info page this will be present
	String fromPage = request.getParameter("fromPage");
	
	
	if(content != null && subject != null && to != null && from != null) {
	    Connection conn = null;
	    try {
			Class.forName(Database.JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", Database.DATABASE_USERNAME);
			sysprops.put("password", Database.DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(Database.DATABASE_URL, sysprops);
			Statement stat = conn.createStatement();
			stat.executeUpdate("Insert into Message(Date, Subject, Content, Sender, Receiver) Values (NOW()	,'" + subject + "'	,'" + content + "'	," + from + "	," + to + ")");
			session.setAttribute(SessionConstants.MSG_RESPONSE, "Message sent!");
	    }
	    catch(Exception e) { session.setAttribute(SessionConstants.MSG_RESPONSE, "Error sending message");}
	    finally {
			try {
			    conn.close();
			}
			catch(Exception e) {}
	    }
	}
	else {
	    session.setAttribute(SessionConstants.MSG_RESPONSE, "Error sending message");
	}
	
	if(SessionConstants.USER_INFORMATION_LOCATION.equals(fromPage)) {
		session.setAttribute(SessionConstants.VIEW_USER, to);
		response.sendRedirect(SessionConstants.USER_INFORMATION_LOCATION);
	}
	else {
		response.sendRedirect(SessionConstants.MESSAGE_LOCATION);
	}
%>