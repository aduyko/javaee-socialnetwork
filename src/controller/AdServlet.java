/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import bll.AdDao;
import constants.SessionConstants;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andy
 */
public class AdServlet extends HttpServlet {

	/**
	 * Processes requests for both HTTP
	 * <code>GET</code> and
	 * <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String view;
		RequestDispatcher dispatcher;
		String action = request.getParameter("action");
		
		if (action!=null){
			view = getView(action);
			request.setAttribute("action", action);
			request = updateRequest(request,action);
		} else {
			view = "/error.jsp";
		}
		dispatcher = getServletContext().getRequestDispatcher(view);
		dispatcher.include(request,response);
	}
	protected String getView(String action) {
		String view;
		if (action.equals("display")) {
			view = "/View/AdDisplay.jsp";
		} else {
			view = "/error.jsp";
		}
		return view;
	}
	protected HttpServletRequest updateRequest(HttpServletRequest request, String action) {
		if (action.equals("display")) {
			request = actionDisplay(request);
		}
		return request;
	}
	protected HttpServletRequest actionDisplay(HttpServletRequest request) {
		request.setAttribute("ads", AdDao.getRandomAds());
		return request;
	}
	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP
	 * <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP
	 * <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>
}
