package constants;

/**
 * Used to hold onto all of the different keys used for storing variables in the session.
 * 
 * @author Jamie
 */
public class SessionConstants {
    
    // Used for differences in urls
    private static final String PRE = "/cse-305";
    //private static final String PRE = "";
    
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
    public static final String HOME_LOCATION = PRE + "/home.jsp";
    // Used for redirecting to the login page
    public static final String LOGIN_LOCATION = PRE + "/login.jsp";
    // Used for redirecting to the messages page
    public static final String MESSAGE_LOCATION = PRE + "/messages.jsp";
    // Used for redirecting to the search user page
    public static final String SEARCH_USER_LOCATION = PRE + "/search-user.jsp";
    // Used for redirecting to the user-information page
    public static final String USER_INFORMATION_LOCATION = PRE + "/user-information.jsp";
    // Used for redirecting to delete message scriptlet
    public static final String DELETE_MESSAGE_LOCATION = PRE + "/servlets/delete_message.jsp";
    // Used for redirecting to the invite circle scriptlet
    public static final String INVITE_CIRCLE_LOCATION = PRE + "/servlets/invite_circle.jsp";
    // Used for redirecting to the join circle scriptlet
    public static final String JOIN_CIRCLE_LOCATION = PRE + "/servlets/join_circle.jsp";
    // Used for redirecting to send message
    public static final String SEND_MESSAGE_LOCATION = PRE + "/servlets/send_message.jsp";
    // Used for redirecting to update user
    public static final String UPDATE_USER_LOCATION = PRE + "/servlets/update_user.jsp";
    // Used for redirecting to user login
    public static final String USER_LOGIN_LOCATION = PRE + "/servlets/user_login.jsp";
    // Used for redirecting to user_logout
    public static final String USER_LOGOUT_LOCATION = PRE + "/servlets/user_logout.jsp";
    // Used for redirecting to user signup
    public static final String USER_SIGNUP_LOCATION = PRE + "/servlets/user_signup.jsp";
    // Used for redirecting to decline circle invite
    public static final String DECLINE_CIRCLE_INVITE_LOCATION = PRE + "/servlets/decline_circle_invite.jsp";
    // Used for redirecting to decline circle join
    public static final String DECLINE_CIRCLE_JOIN_LOCATION = PRE + "/servlets/decline_circle_join.jsp";
    
}
