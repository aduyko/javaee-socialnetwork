package database;
import java.sql.Connection;


/**
 * A database object used to execute database queries.
 * 
 * @author Jamie Lapine
 */
public class Database {
    
    public static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    public static final String DATABASE_URL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/jlapine";
    public static final String DATABASE_USERNAME = "jlapine";
    public static final String DATABASE_PASSWORD = "108172577";

    /**
     * @return A connection to the database.
     */
    public static Connection getConnection(){
	    Connection conn = null;
	    try {
			// Connect to the jdbc driver and tell it your database credentials
			Class.forName(JDBC_DRIVER).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", DATABASE_USERNAME);
			sysprops.put("password", DATABASE_PASSWORD);
			conn = java.sql.DriverManager.getConnection(DATABASE_URL, sysprops);
	    }
	    catch(Exception e) {
		try {
		    conn.close();
		}
		catch(Exception f) {};
	    }
	    return conn;
    }
    
}
