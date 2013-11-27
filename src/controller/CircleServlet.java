package controller;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.Circle;
import model.CircleMember;
import model.Post;
import bll.CircleDao;

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

				// Viewing posts
				request.setAttribute("view_post", true);

				// Circle owned by current user
				ArrayList<Circle> circleOwner = CircleDao
						.getCirclesOwner(userId);

				// Circles current user is a member of
				ArrayList<CircleMember> circleMember = CircleDao
						.getCircleMember(userId);

				// Posts of circle set as default initial circle
				ArrayList<Post> posts = null;

				if (circleOwner.size() > 0) {
					// Default initial circle is owned by current user
					request.setAttribute("circle_owner", true);

					// Initially list the posts for the first Circle owned
					// by the current user
					posts = CircleDao.getPosts(
							circleOwner.get(0).getCircleId(), userId);

					request.setAttribute("posts", posts);

					System.out.println("Log: Adding " + posts.size()
							+ " posts to circle home");

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

					request.setAttribute("posts", posts);

					System.out.println("Log: Adding " + posts.size()
							+ " posts to circle home");

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

				// Viewing posts
				request.setAttribute("view_post", true);

				// Circle owned by current user
				ArrayList<Circle> circleOwner = CircleDao
						.getCirclesOwner(userId);

				// Circles current user is a member of
				ArrayList<CircleMember> circleMember = CircleDao
						.getCircleMember(userId);

				// Posts of circle to view
				ArrayList<Post> posts = CircleDao.getPosts(circleId, userId);

				System.out.println("Log: Adding " + posts.size()
						+ " posts to circle home");

				request.setAttribute("current_circle_name", circleName);
				request.setAttribute("current_circle_id", circleId);

				// Posts for selected circle
				request.setAttribute("posts", posts);
				// Circles the current user is associated with through
				// ownership or membership
				request.setAttribute("owner", circleOwner);
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

			} else {

			}
		}

	}

}
