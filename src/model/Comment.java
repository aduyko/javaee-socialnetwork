package model;

import java.sql.Date;
import java.util.ArrayList;

/**
 * 
 * @author James C. Porcelli
 * 
 */
public class Comment {

	private int commentId;
	private Date date;
	private String content;
	private int postId;
	private int authorId;
	private ArrayList<CommentLike> likes;
	private int likeCount;
	private String authorName;
	private User author;
	private boolean currentUserLiked = false;

	/**
	 * 
	 * @param commentId
	 * @param date
	 * @param content
	 * @param postId
	 * @param authorId
	 */
	public Comment(int commentId, Date date, String content, int postId,
			int authorId) {
		this.commentId = commentId;
		this.date = date;
		this.content = content;
		this.postId = postId;
		this.authorId = authorId;
	}

	/**
	 * 
	 * @param commentId
	 * @param date
	 * @param content
	 * @param postId
	 * @param authorId
	 * @param likes
	 */
	public Comment(int commentId, Date date, String content, int postId,
			int authorId, ArrayList<CommentLike> likes) {

		this(commentId, date, content, postId, authorId);
		this.likes = likes;
	}

	/**
	 * 
	 * @param commentId
	 * @param date
	 * @param content
	 * @param postId
	 * @param authorId
	 * @param likes
	 * @param likeCount
	 * @param authorName
	 * @param author
	 */
	public Comment(int commentId, Date date, String content, int postId,
			int authorId, ArrayList<CommentLike> likes, int likeCount,
			String authorName, User author) {

		this(commentId, date, content, postId, authorId, likes);
		this.likeCount = likeCount;
		this.authorName = authorName;
		this.author = author;
	}

	public boolean isCurrentUserLiked() {
		return currentUserLiked;
	}

	public void setCurrentUserLiked(boolean currentUserLiked) {
		this.currentUserLiked = currentUserLiked;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public ArrayList<CommentLike> getLikes() {
		return likes;
	}

	public void setLikes(ArrayList<CommentLike> likes) {
		this.likes = likes;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
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

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}
}
