package constants;

/**
 * Used to hold onto all of the different keys used for storing variables in the session.
 * 
 * @author Jamie
 */
public class SessionConstants {
    
    // Used for storing the userid of customer who is logged in
    public static final String USERID = "userid";
    // Used for storing the username of a customer who is logged in
    public static final String USERNAME = "username";
    // Used for storing an error message
    public static final String ERROR = "error";
    // Used for response to messages page;
    public static final String MSG_RESPONSE = "msgrsp";
    // Used for holding the id of the user that was being viewed on user-information page
    public static final String VIEW_USER = "viewuser";
    // Used for holding the name of the user that was being viewed on user-information page
    public static final String VIEW_USER_NAME = "viewusersname";
    // User for redirecting to the main page
    public static final String HOME_LOCATION = "/cse-305/messages.jsp";
    // Used for redirecting to the login page
    public static final String LOGIN_LOCATION = "/cse-305/login.jsp";
    
}
