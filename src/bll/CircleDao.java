package bll;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import database.Database;
import model.Circle;
import model.CircleMember;
import model.Comment;
import model.CommentLike;
import model.Post;
import model.PostLike;
import model.User;

/**
 * DAO for Circle module
 * 
 * @author James C. Porcelli
 * 
 */
public class CircleDao {

	/**
	 * 
	 * @param userId
	 * @return
	 */
	public static ArrayList<Circle> getCirclesOwner(int userId) {
		ArrayList<Circle> circleOwner = new ArrayList<Circle>();

		Connection conn = database.Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining circles owned by user " + userId);

		String query = "select * from Circle where Owner_Of_Circle = ?;";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, userId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int circle_id = res.getInt("Circle_Id");
				String circle_name = res.getString("Circle_NAME");
				int circle_owner = res.getInt("Owner_Of_Circle");
				String circle_type = res.getString("type");

				Circle circle = new Circle(circle_id, circle_owner,
						circle_name, circle_type);

				System.out
						.println("Log: Adding circle to circles owned by current user");

				circleOwner.add(circle);
			}

			ps.close();
			conn.close();
			return circleOwner;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param userId
	 * @return
	 */
	public static ArrayList<CircleMember> getCircleMember(int userId) {
		ArrayList<CircleMember> circleMember = new ArrayList<CircleMember>();

		Connection conn = database.Database.getConnection();
		PreparedStatement ps;

		System.out
				.println("Log: Obtaining circles user is member of by userid = "
						+ userId);

		String query = "select * from addedto A, circle C where A.User_Id=? and C.Circle_Id=A.Circle_Id;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, userId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int circle_id = res.getInt("Circle_Id");
				int user_id = res.getInt("User_Id");
				String circle_name = res.getString("Circle_NAME");
				int ownerId = res.getInt("Owner_Of_Circle");
				String type = res.getString("Type");

				CircleMember member = new CircleMember(user_id, circle_id,
						circle_name, type, ownerId);

				System.out
						.println("Log: Adding circle to circles user is a member of");

				circleMember.add(member);
			}

			ps.close();
			conn.close();
			return circleMember;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param circleId
	 * @return
	 */
	public static ArrayList<Post> getPosts(int circleId, int curUserId) {
		ArrayList<Post> posts = new ArrayList<Post>();

		Connection conn = Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining posts associated with circle = "
				+ circleId);

		String query = "select * from post P, user U where Circle=? and P.Author=U.User_Id;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, circleId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				// Post meta data
				int postId = res.getInt("Post_Id");
				Date date = res.getDate("Date");
				String content = res.getString("Content");
				int commentCount = res.getInt("Comment_Count");
				int circle_id = res.getInt("Circle");
				int authorId = res.getInt("Author");

				// Post derived/external (FK) meta data
				ArrayList<Comment> comments = new ArrayList<Comment>();
				ArrayList<PostLike> likes_post = new ArrayList<PostLike>();

				// It may be a good idea to get this data when the DOM loads
				// in the browser asynchronously then in one request
				// synchronously
				query = "select * from comment C, user U where C.Post=? and C.Author=U.User_Id;";
				ps = conn.prepareStatement(query);
				ps.setInt(1, postId);
				ResultSet post_comments = ps.executeQuery();
				while (post_comments.next()) {
					// Comment meta data
					int comment_commentId = post_comments.getInt("Comment_Id");
					Date comment_date = post_comments.getDate("Date");
					String comment_content = post_comments.getString("Content");
					int comment_postId = post_comments.getInt("Post");
					int comment_author = post_comments.getInt("Author");

					// User meta data
					int comment_userId = post_comments.getInt("User_Id");
					String comment_firstName = post_comments
							.getString("First_Name");
					String comment_lastName = post_comments
							.getString("Last_Name");
					String comment_emailAddress = post_comments
							.getString("Email_Address");
					String comment_password = post_comments
							.getString("Password");
					String comment_address = post_comments.getString("Address");
					String comment_city = post_comments.getString("City");
					String comment_state = post_comments.getString("State");
					String comment_zipCode = post_comments
							.getString("Zip_Code");
					String comment_telephone = post_comments
							.getString("Telephone");
					String comment_gender = post_comments.getString("Gender");
					Date comment_dateOfBirth = post_comments
							.getDate("Date_Of_Birth");
					int comment_rating = post_comments.getInt("Rating");

					// Derived meta data
					String comment_authorName = comment_firstName + " "
							+ comment_lastName;

					// Author of this post as User DO
					User comment_authorUser = new User(comment_userId,
							comment_firstName, comment_lastName,
							comment_emailAddress, comment_password,
							comment_address, comment_city, comment_state,
							comment_zipCode, comment_telephone, comment_gender,
							comment_dateOfBirth, comment_rating);

					ArrayList<CommentLike> likes_comments = new ArrayList<CommentLike>();

					// It may be a good idea to get this data when the DOM loads
					// in the browser asynchronously then in one request
					// synchronously
					query = "select * from user_likes_comment where Comment=?;";
					ps = conn.prepareStatement(query);
					ps.setInt(1, comment_commentId);
					ResultSet commentLikes = ps.executeQuery();
					while (commentLikes.next()) {
						int commentlikes_userId = commentLikes.getInt("User");
						int commentlikes_commentId = commentLikes
								.getInt("Comment");

						CommentLike commentLike = new CommentLike(
								commentlikes_userId, commentlikes_commentId);

						likes_comments.add(commentLike);
					}

					Comment comment = new Comment(comment_commentId,
							comment_date, comment_content, comment_postId,
							comment_author, likes_comments,
							likes_comments.size(), comment_authorName,
							comment_authorUser);

					Iterator<CommentLike> commentLikeIterator = likes_comments
							.iterator();
					while (commentLikeIterator.hasNext()) {
						if (curUserId == commentLikeIterator.next().getUserId()) {
							comment.setCurrentUserLiked(true);
						}
					}

					comments.add(comment);
				}

				// It may be a good idea to get this data when the DOM loads
				// in the browser asynchronously then in one request
				// synchronously
				query = "select * from user_likes_post where Post=?;";
				ps = conn.prepareStatement(query);
				ps.setInt(1, postId);
				ResultSet postLikes = ps.executeQuery();
				while (postLikes.next()) {
					int postlike_userId = postLikes.getInt("User");
					int postlike_postId = postLikes.getInt("Post");

					PostLike postLike = new PostLike(postlike_userId,
							postlike_postId);

					likes_post.add(postLike);
				}

				// User meta data
				int userId = res.getInt("User_Id");
				String firstName = res.getString("First_Name");
				String lastName = res.getString("Last_Name");
				String emailAddress = res.getString("Email_Address");
				String password = res.getString("Password");
				String address = res.getString("Address");
				String city = res.getString("City");
				String state = res.getString("State");
				String zipCode = res.getString("Zip_Code");
				String telephone = res.getString("Telephone");
				String gender = res.getString("Gender");
				Date dateOfBirth = res.getDate("Date_Of_Birth");
				int rating = res.getInt("Rating");

				// Author of this post as User DO
				User author = new User(userId, firstName, lastName,
						emailAddress, password, address, city, state, zipCode,
						telephone, gender, dateOfBirth, rating);

				// Derived meta data
				String authorName = firstName + " " + lastName;

				Post post = new Post(postId, date, content, commentCount,
						circle_id, authorId, authorName, author, likes_post,
						comments);

				post.setLikeCount(likes_post.size());

				System.out
						.println("Log: Adding post to posts associated with this circle");

				// Set the post like by current user flag if the current user
				// liked a given post
				Iterator<PostLike> postLikeIterator = likes_post.iterator();
				while (postLikeIterator.hasNext()) {
					if (curUserId == postLikeIterator.next().getUserId()) {
						post.setCurrentUserLiked(true);
					}
				}

				posts.add(post);
			}

			ps.close();
			conn.close();
			return posts;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param circleId
	 * @return
	 */
	public static Circle getCircle(int circleId) {
		Circle circle = null;

		Connection conn = Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining circle by id = " + circleId);

		String query = "select * from circle where Circle_Id=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, circleId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int circle_id = res.getInt("Circle_Id");
				String circle_name = res.getString("Circle_NAME");
				int circle_owner = res.getInt("Owner_Of_Circle");
				String circle_type = res.getString("type");

				circle = new Circle(circle_id, circle_owner, circle_name,
						circle_type);
			}

			return circle;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param circleId
	 * @return
	 */
	public static ArrayList<User> getCircleMembers(int circleId) {
		ArrayList<User> members = new ArrayList<User>();

		Connection conn = Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining members of circle = " + circleId);

		String query = "select * from user U, addedto T where T.Circle_Id = ? and U.User_Id=T.User_Id;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, circleId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int userId = res.getInt("User_Id");
				String firstName = res.getString("First_Name");
				String lastName = res.getString("Last_Name");
				String emailAddress = res.getString("Email_Address");
				String password = res.getString("Password");
				String address = res.getString("Address");
				String city = res.getString("City");
				String state = res.getString("State");
				String zipCode = res.getString("Zip_Code");
				String telephone = res.getString("Telephone");
				String gender = res.getString("Gender");
				Date dateOfBirth = res.getDate("Date_Of_Birth");
				int rating = res.getInt("Rating");

				User user = new User(userId, firstName, lastName, emailAddress,
						password, address, city, state, zipCode, telephone,
						gender, dateOfBirth, rating);

				members.add(user);
			}

			ps.close();
			conn.close();
			return members;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param commentId
	 * @param authorId
	 * @return
	 */
	public static boolean likeComment(int commentId, int authorId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "insert into user_likes_comment values(?,?);";
		try {
			ps = conn.prepareStatement(query);

			ps.setInt(1, authorId);
			ps.setInt(2, commentId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param postId
	 * @param authorId
	 */
	public static boolean likePost(int postId, int authorId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "insert into user_likes_post values(?,?);";
		try {
			ps = conn.prepareStatement(query);

			ps.setInt(1, authorId);
			ps.setInt(2, postId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param circleId
	 * @param authorId
	 * @param content
	 * @return
	 */
	public static Post makePost(int circleId, int authorId, String content) {
		// Post - Date, Content, Comment_Count, Circle, Author
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "insert into post(Date, Content, Comment_Count, Circle, Author) values(?, ?, ?, ?, ?);";

		// Now() for mysql Date
		Date date = new Date(System.currentTimeMillis());

		// initially no comments => should be a default value
		int commentCount = 0;
		try {
			ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

			ps.setDate(1, date);
			ps.setString(2, content);
			ps.setInt(3, commentCount);
			ps.setInt(4, circleId);
			ps.setInt(5, authorId);

			ps.execute();

			long postId = 0;
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			postId = res.getLong(1);

			System.out.println("Log: Generted Post PK = " + postId);

			// conn.commit();

			Post post = new Post((int) postId, date, content, 0, circleId,
					authorId);

			ps.close();
			conn.close();
			return post;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param postId
	 * @param authorId
	 * @param content
	 * @return
	 */
	public static Comment makeComment(int postId, int authorId, String content) {
		// Comment - Date, Content, Post, Author
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "insert into comment(Date, Content, Post, Author) values(?, ?, ?, ?);";

		// Now() for mysql Date
		Date date = new Date(System.currentTimeMillis());

		try {
			ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

			ps.setDate(1, date);
			ps.setString(2, content);
			ps.setInt(3, postId);
			ps.setInt(4, authorId);

			ps.execute();

			long commentId = 0;
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			commentId = res.getLong(1);

			System.out.println("Log: Generted comment PK = " + commentId);

			Comment comment = new Comment((int) commentId, date.toString(),
					content, postId, authorId);

			// If auto-commit OFF
			// conn.commit();

			ps.close();
			conn.close();
			return comment;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param circleId
	 * @return
	 */
	public static ArrayList<User> circleMembers(int circleId) {
		ArrayList<User> members = new ArrayList<User>();

		Connection conn = Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining circle members");

		String query = "select * from addedto a, user u where Circle_Id=? and a.User_Id=u.User_Id;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, circleId);

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int userId = res.getInt("User_Id");
				String firstName = res.getString("First_Name");
				String lastName = res.getString("Last_Name");
				String emailAddress = res.getString("Email_Address");
				String password = res.getString("Password");
				String address = res.getString("Address");
				String city = res.getString("City");
				String state = res.getString("State");
				String zipCode = res.getString("Zip_Code");
				String telephone = res.getString("Telephone");
				String gender = res.getString("Gender");
				Date dateOfBirth = res.getDate("Date_Of_Birth");
				int rating = res.getInt("Rating");

				User user = new User(userId, firstName, lastName, emailAddress,
						password, address, city, state, zipCode, telephone,
						gender, dateOfBirth, rating);

				members.add(user);
			}

			ps.close();
			conn.close();
			return members;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param term
	 * @return
	 */
	public static ArrayList<User> autoCompleteUserSearch(String term) {
		ArrayList<User> results = new ArrayList<User>();

		Connection conn = Database.getConnection();
		PreparedStatement ps;

		System.out.println("Log: Obtaining circle members");

		String query = "select * from user where First_Name LIKE ?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, "%" + term + "%");

			ResultSet res = ps.executeQuery();

			while (res.next()) {
				int userId = res.getInt("User_Id");
				String firstName = res.getString("First_Name");
				String lastName = res.getString("Last_Name");
				String emailAddress = res.getString("Email_Address");
				String password = res.getString("Password");
				String address = res.getString("Address");
				String city = res.getString("City");
				String state = res.getString("State");
				String zipCode = res.getString("Zip_Code");
				String telephone = res.getString("Telephone");
				String gender = res.getString("Gender");
				Date dateOfBirth = res.getDate("Date_Of_Birth");
				int rating = res.getInt("Rating");

				User user = new User(userId, firstName, lastName, emailAddress,
						password, address, city, state, zipCode, telephone,
						gender, dateOfBirth, rating);

				results.add(user);
			}

			ps.close();
			conn.close();
			return results;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 
	 * @param content
	 * @param postId
	 * @return
	 */
	public static boolean updatePost(String content, int postId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "update post set Content=? where Post_Id=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, content);
			ps.setInt(2, postId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param content
	 * @param postId
	 * @return
	 */
	public static boolean updateComment(String content, int commentId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "update comment set Content=? where Comment_Id=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, content);
			ps.setInt(2, commentId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public static int createCircle(String name, String type, int ownerId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "insert into circle(Circle_NAME, Owner_Of_Circle, Type) values(?, ?, ?);";

		try {
			ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, name);
			ps.setInt(2, ownerId);
			ps.setString(3, type);

			ps.execute();
			
			long circleId = 0;
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			circleId = res.getLong(1);

			query = "insert into addedto values(?, ?);";
			ps = conn.prepareStatement(query);
			ps.setInt(1, ownerId);
			ps.setInt(2, (int) circleId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return (int) circleId;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	/**
	 * 
	 * @param postId
	 * @return
	 */
	public static boolean deletePost(int postId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "delete from post where Post_Id=?;";

		// Can delete likes and comments as well

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, postId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param postId
	 * @return
	 */
	public static boolean unlikePost(int postId, int userId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "delete from user_likes_post where User=? and Post=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setInt(2, postId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * @param postId
	 * @return
	 */
	public static boolean unlikeComment(int commentId, int userId) {
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "delete from user_likes_comment where User=? and Comment=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setInt(2, commentId);

			ps.execute();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 
	 * @param circleId
	 */
	public static boolean deleteCircle(int circleId){
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "delete from circle where Circle_Id=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, circleId);

			ps.execute();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 
	 * @param circleId
	 * @param name
	 * @return
	 */
	public static boolean renameCircle(int circleId, String name){
		Connection conn = Database.getConnection();
		PreparedStatement ps;

		String query = "update circle set Circle_NAME=? where Circle_Id=?;";

		try {
			ps = conn.prepareStatement(query);
			ps.setString(1, name);
			ps.setInt(2, circleId);

			ps.executeUpdate();

			ps.close();
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}
