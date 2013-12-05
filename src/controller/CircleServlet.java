package controller;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Circle;
import model.CircleMember;
import model.Comment;
import model.Post;
import model.User;
import bll.CircleDao;

import com.google.gson.Gson;

/**
 * Servlet implementation class CircleServlet
 * 
 * Controller , Http request handler for Circle module
 * 
 * @author James C. Porcelli
 */
@WebServlet(name = "Circle", urlPatterns = "/Circle")
public class CircleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		if (request.getParameter("action").equals("Home")) {

			if ((request.getSession()) != null) {
				// Current userId from the session
				int userId = (Integer) request.getSession().getAttribute(
						"userid");

				// Circle owned by current user
				ArrayList<Circle> circleOwner = CircleDao
						.getCirclesOwner(userId);

				// Circles current user is a member of
				ArrayList<CircleMember> circleMember = CircleDao
						.getCircleMember(userId);

				// Posts of circle set as default initial circle
				ArrayList<Post> posts = null;

				// Members of circle set as default initial circle
				ArrayList<User> members = null;

				// The current circle
				Circle currentCircle = null;

				if (circleOwner.size() > 0) {

					// Default initial circle is owned by current user
					request.setAttribute("circle_owner", true);

					// Initially list the posts for the first Circle owned
					// by the current user
					posts = CircleDao.getPosts(
							circleOwner.get(0).getCircleId(), userId);

					// The members of the first circle owned by the current user
					members = CircleDao.circleMembers(circleOwner.get(0)
							.getCircleId());

					// The current circle
					currentCircle = CircleDao.getCircle(circleOwner.get(0)
							.getCircleId());

					// Log information
					System.out.println("Log: Adding " + posts.size()
							+ " posts to circle home");

					request.setAttribute("posts", posts);

					request.setAttribute("members", members);

					request.setAttribute("current_circle", currentCircle);

					request.setAttribute("current_circle_name", circleOwner
							.get(0).getName());

					request.setAttribute("current_circle_id", circleOwner
							.get(0).getCircleId());

				} else if (circleMember.size() > 0) {
					request.setAttribute("circle_owner", false);

					// Initially list the posts for the first Circle that
					// the current user is a member of
					posts = CircleDao.getPosts(circleMember.get(0)
							.getCircleId(), userId);

					// The members of the first circle the current user is a
					// member of
					members = CircleDao.circleMembers(circleMember.get(0)
							.getCircleId());

					// The current circle
					currentCircle = CircleDao.getCircle(circleMember.get(0)
							.getCircleId());

					// Logging information
					System.out.println("Log: Adding " + posts.size()
							+ " posts to circle home");

					request.setAttribute("posts", posts);

					request.setAttribute("members", members);

					request.setAttribute("current_circle", currentCircle);

					request.setAttribute("current_circle_name", circleMember
							.get(0).getCircleName());

					request.setAttribute("current_circle_id",
							circleMember.get(0).getCircleId());

				} else {
					// Current user is not an owner or member of any circles

				}

				// Circles the current user is associated with through ownership
				// or membership
				request.setAttribute("owner", circleOwner);

				request.setAttribute("member", circleMember);

				// Redirect back to circle.jsp, circle home
				request.getRequestDispatcher("/View/Circle.jsp").forward(
						request, response);
			} else {
				// Session has not been validated
			}

		} else if (request.getParameter("action").equals("ViewCircle")) {
			if ((request.getSession() != null)) {
				// Redirect back to Circle.jsp with circle specific content,
				// posts, members, likes, etc

				// Current userId from the session
				int userId = (Integer) request.getSession().getAttribute(
						"userid");

				// Circle id of circle to view
				int circleId = new Integer(request.getParameter("Id"));

				// Circle name of circle to view
				String circleName = request.getParameter("Name");

				// Circle owned by current user
				ArrayList<Circle> circleOwner = CircleDao
						.getCirclesOwner(userId);

				// Circles current user is a member of
				ArrayList<CircleMember> circleMember = CircleDao
						.getCircleMember(userId);

				// Posts of circle to view
				ArrayList<Post> posts = CircleDao.getPosts(circleId, userId);

				// Members of circle to view
				ArrayList<User> members = CircleDao.circleMembers(circleId);

				// Circle object for circle to view
				Circle currentCircle = CircleDao.getCircle(circleId);

				// Logging information
				System.out.println("Log: Adding " + posts.size()
						+ " posts to circle home");

				// The current circle
				request.setAttribute("current_circle", currentCircle);

				// Circle to view name
				request.setAttribute("current_circle_name", circleName);

				// Circle to view id
				request.setAttribute("current_circle_id", circleId);

				// Members of circle to view
				request.setAttribute("members", members);

				// Posts for selected circle
				request.setAttribute("posts", posts);

				// Circles the current user is associated with through
				// ownership
				request.setAttribute("owner", circleOwner);

				// Circles the current user is associated with through
				// membership
				request.setAttribute("member", circleMember);

				if (request.getParameter("Owner").equals("Yes")) {

					// Circle is owned by current user
					request.setAttribute("circle_owner", true);
				} else {

					// Circle is not owned by current user
					request.setAttribute("circle_owner", false);
				}

				// Redirect back to circle.jsp, circle home
				request.getRequestDispatcher("/View/Circle.jsp").forward(
						request, response);
			} else {
				// Session expired, redirect to login
			}
		} else if (request.getParameter("action").equals(
				"CircleAddMemberAutoComplete")) {
			if ((request.getSession()) != null) {
				String term = request.getParameter("term");

				ArrayList<User> results = CircleDao
						.autoCompleteUserSearch(term);

				String json = new Gson().toJson(results);

				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {
				// Session expired, redirect to login
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		if (request.getParameter("action").equals("likePost")) {
			if ((request.getSession()) != null) {
				// Add a like to the given post for the current user

				System.out.println("Log: New post like paremeter postId "
						+ request.getParameter("postId"));
				System.out.println("Log: New post like parameter userId "
						+ request.getParameter("userId"));

				int postId = new Integer(request.getParameter("postId"));

				int userId = new Integer(request.getParameter("userId"));

				boolean success = CircleDao.likePost(postId, userId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {
				// Session expired, redirect to login
			}
		} else if (request.getParameter("action").equals("makePost")) {
			if ((request.getSession()) != null) {

				System.out.println("Log: New post paremeter content "
						+ request.getParameter("content"));
				System.out.println("Log: New post parameter authorId "
						+ request.getParameter("authorId"));
				System.out.println("Log: New post parameter circleId "
						+ request.getParameter("circleId"));

				// Add new post to this circle from the current user
				String content = request.getParameter("content");
				int authorId = new Integer(request.getParameter("authorId"));
				int circleId = new Integer(request.getParameter("circleId"));

				Post post = CircleDao.makePost(circleId, authorId, content);
				String json = new Gson().toJson(post);

				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {
				// Session expired, redirect to login
			}
		} else if (request.getParameter("action").equals("makeComment")) {
			if ((request.getSession()) != null) {

				System.out.println("Log: New comment paremeter content "
						+ request.getParameter("content"));
				System.out.println("Log: New comment parameter authorId "
						+ request.getParameter("authorId"));
				System.out.println("Log: New comment parameter circleId "
						+ request.getParameter("postId"));

				// Add new post to this circle from the current user
				String content = request.getParameter("content");
				int authorId = new Integer(request.getParameter("authorId"));
				int postId = new Integer(request.getParameter("postId"));

				Comment comment = CircleDao.makeComment(postId, authorId,
						content);

				String json = new Gson().toJson(comment);

				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("likeComment")) {
			if ((request.getSession()) != null) {
				// Add a like to the given post for the current user

				System.out.println("Log: New comment like paremeter postId "
						+ request.getParameter("commentId"));
				System.out.println("Log: New comment like parameter userId "
						+ request.getParameter("userId"));

				int commentId = new Integer(request.getParameter("commentId"));
				int userId = new Integer(request.getParameter("userId"));

				boolean success = CircleDao.likeComment(commentId, userId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {
				// Session expired, redirect to login
			}
		} else if (request.getParameter("action").equals("updatePost")) {
			if ((request.getSession()) != null) {
				String content = request.getParameter("content");
				int postId = new Integer(request.getParameter("postId"));

				boolean success = CircleDao.updatePost(content, postId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("deletePost")) {
			if ((request.getSession()) != null) {
				int postId = new Integer(request.getParameter("postId"));

				boolean success = CircleDao.deletePost(postId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("unlikePost")) {
			if ((request.getSession()) != null) {
				int postId = new Integer(request.getParameter("postId"));
				int userId = new Integer(request.getParameter("userId"));

				boolean success = CircleDao.unlikePost(postId, userId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("unlikeComment")) {
			if ((request.getSession()) != null) {
				int commentId = new Integer(request.getParameter("commentId"));
				int userId = new Integer(request.getParameter("userId"));

				boolean success = CircleDao.unlikeComment(commentId, userId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("updateComment")) {
			if ((request.getSession()) != null) {

				String content = request.getParameter("content");
				int commentId = new Integer(request.getParameter("commentId"));

				boolean success = CircleDao.updateComment(content, commentId);
				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}

			} else {

			}
		} else if (request.getParameter("action").equals("NewCircle")) {
			if ((request.getSession()) != null) {

				if (request.getParameter("CreateCircle_Owner") != null) {

					String name = request.getParameter("CreateCircle_Name");
					String type = request.getParameter("CreateCircle_Type");
					int ownerId = new Integer(
							request.getParameter("CreateCircle_Owner"));

					// Create the new circle
					int circleId = CircleDao.createCircle(name, type, ownerId);

					// Current userId from the session
					int userId = (Integer) request.getSession().getAttribute(
							"userid");

					// Circle name of circle to view
					String circleName = name;

					// Circle owned by current user
					ArrayList<Circle> circleOwner = CircleDao
							.getCirclesOwner(userId);

					// Circles current user is a member of
					ArrayList<CircleMember> circleMember = CircleDao
							.getCircleMember(userId);

					// Posts of circle to view
					ArrayList<Post> posts = CircleDao
							.getPosts(circleId, userId);

					// Members of circle to view
					ArrayList<User> members = CircleDao.circleMembers(circleId);

					// Circle object for circle to view
					Circle currentCircle = CircleDao.getCircle(circleId);

					// Logging information
					System.out.println("Log: Adding " + posts.size()
							+ " posts to circle home");

					// The current circle
					request.setAttribute("current_circle", currentCircle);

					// Circle to view name
					request.setAttribute("current_circle_name", circleName);

					// Circle to view id
					request.setAttribute("current_circle_id", circleId);

					// Members of circle to view
					request.setAttribute("members", members);

					// Posts for selected circle
					request.setAttribute("posts", posts);

					// Circles the current user is associated with through
					// ownership
					request.setAttribute("owner", circleOwner);

					// Circles the current user is associated with through
					// membership
					request.setAttribute("member", circleMember);

					// Circle is owned by current user
					request.setAttribute("circle_owner", true);

					// Redirect back to circle.jsp, circle home
					request.getRequestDispatcher("/View/Circle.jsp").forward(
							request, response);
				} else {
					// Redirect back to circle.jsp, circle home
					request.getRequestDispatcher("home.jsp").forward(request,
							response);
				}

			} else {

			}
		} else if (request.getParameter("action").equals("DeleteCircle")) {
			if ((request.getSession()) != null) {

				int circleId = new Integer(request.getParameter("circleId"));

				boolean success = CircleDao.deleteCircle(circleId);

				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}
			} else {

			}
		} else if (request.getParameter("action").equals("RenameCircle")) {
			if ((request.getSession()) != null) {

				int circleId = new Integer(request.getParameter("circleId"));
				String name = request.getParameter("name");

				boolean success = CircleDao.renameCircle(circleId, name);

				String json;

				if (success) {
					json = new Gson().toJson(new Object() {
						boolean success = true;
					});
				} else {
					json = new Gson().toJson(new Object() {
						boolean success = false;
					});
				}
				// JSON response the postDO just committed
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				Writer writer = null;

				try {
					writer = response.getWriter();
					writer.write(json);
				} finally {
					writer.close();
				}
			} else {

			}
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @param view
	 * @throws ServletException
	 * @throws IOException
	 */
	public void render(HttpServletRequest request,
			HttpServletResponse response, String view) throws ServletException,
			IOException {

	}

}
