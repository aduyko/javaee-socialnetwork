package model;

import java.sql.Date;
import java.util.ArrayList;

/**
 * 
 * @author James Porcelli
 * 
 */
public class Post {

	private int postId;
	private Date date;
	private String content;
	private int commentCount;
	private int circleId;
	private int authorId;
	private String authorName;
	private User author;
	private ArrayList<PostLike> likes;
	private int likeCount;
	private ArrayList<Comment> comments;
	private boolean currentUserLiked = false;

	/**
	 * 
	 * @param postId
	 * @param date
	 * @param content
	 * @param commentCount
	 * @param circleId
	 * @param authorId
	 */
	public Post(int postId, Date date, String content, int commentCount,
			int circleId, int authorId) {
		this.postId = postId;
		this.date = date;
		this.content = content;
		this.commentCount = commentCount;
		this.circleId = circleId;
		this.authorId = authorId;
	}

	/**
	 * 
	 * @param postId
	 * @param date
	 * @param content
	 * @param commentCount
	 * @param circleId
	 * @param authorId
	 * @param authorName
	 */
	public Post(int postId, Date date, String content, int commentCount,
			int circleId, int authorId, String authorName) {
		this(postId, date, content, commentCount, circleId, authorId);
		this.authorName = authorName;
	}

	/**
	 * 
	 * @param postId
	 * @param date
	 * @param content
	 * @param commentCount
	 * @param circleId
	 * @param authorId
	 * @param authorName
	 * @param author
	 */
	public Post(int postId, Date date, String content, int commentCount,
			int circleId, int authorId, String authorName, User author) {
		this(postId, date, content, commentCount, circleId, authorId,
				authorName);
		this.author = author;
	}

	/**
	 * 
	 * @param postId
	 * @param date
	 * @param content
	 * @param commentCount
	 * @param circleId
	 * @param authorId
	 * @param authorName
	 * @param author
	 * @param comments
	 */
	public Post(int postId, Date date, String content, int commentCount,
			int circleId, int authorId, String authorName, User author,
			ArrayList<Comment> comments) {
		this(postId, date, content, commentCount, circleId, authorId,
				authorName, author);
		this.comments = comments;
	}

	/**
	 * 
	 * @param postId
	 * @param date
	 * @param content
	 * @param commentCount
	 * @param circleId
	 * @param authorId
	 * @param authorName
	 * @param author
	 * @param likes
	 * @param comments
	 */
	public Post(int postId, Date date, String content, int commentCount,
			int circleId, int authorId, String authorName, User author,
			ArrayList<PostLike> likes, ArrayList<Comment> comments) {

		this(postId, date, content, commentCount, circleId, authorId,
				authorName, author, comments);
		this.likes = likes;
	}

	public boolean isCurrentUserLiked() {
		return currentUserLiked;
	}

	public void setCurrentUserLiked(boolean currentUserLiked) {
		this.currentUserLiked = currentUserLiked;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public ArrayList<PostLike> getLikes() {
		return likes;
	}

	public void setLikes(ArrayList<PostLike> likes) {
		this.likes = likes;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public ArrayList<Comment> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Comment> comments) {
		this.comments = comments;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public int getCircleId() {
		return circleId;
	}

	public void setCircleId(int circleId) {
		this.circleId = circleId;
	}

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

}
