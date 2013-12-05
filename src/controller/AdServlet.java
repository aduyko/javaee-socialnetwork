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
import model.Advertisement;
import model.Transaction;

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
		if (!action.equals("display")){
			Integer employeeID = (Integer)request.getSession().getAttribute(SessionConstants.EMPLOYEE_ID);
			String employeeName = (String)request.getSession().getAttribute(SessionConstants.EMPLOYEE_NAME);
			String employeeType = (String)request.getSession().getAttribute(SessionConstants.EMPLOYEE_TYPE);
			if(employeeID == null || employeeName == null || employeeType == null) {
				dispatcher = getServletContext().getRequestDispatcher(SessionConstants.EMPLOYEE_LOGIN_PAGE_LOCATION);
				dispatcher.forward(request,response);
			}
		}
		if (action!=null){
			view = getView(action,request);
			request.setAttribute("action", action);
			request = updateRequest(request,action);
		} else {
			view = "/error.jsp";
		}
		if (action.equals("display")) {
			dispatcher = getServletContext().getRequestDispatcher(view);
			dispatcher.include(request,response);
		} else {
			dispatcher = getServletContext().getRequestDispatcher(view);
			dispatcher.forward(request,response);
		}
	}
	protected String getView(String action, HttpServletRequest request) {
		String view;
		if (action.equals("display")) {
			view = "/View/AdDisplay.jsp";
		} else if (action.equals("portal")) {
			if (request.getParameter("actor").equals("Manager")) {
				view = "/View/Manager.jsp";
			} else { 
				view = "/View/CustomerRep.jsp";
			}
		} else if (action.equals("newAd")) {
			view = "/View/NewAd.jsp";
		} else if (action.equals("newTransaction")) {
			view = "/View/NewTransaction.jsp";
		} else if (action.equals("postAd") || action.equals("deleteAd") || 
				action.equals("postTransaction")) {
			view = "/View/CustomerRep.jsp";
		} else {
			view = "/error.jsp";
		}
		return view;
	}
	protected HttpServletRequest updateRequest(HttpServletRequest request, String action) {
		if (action.equals("display")) {
			request = actionDisplay(request);
		} else if (action.equals("portal")) {
			if (request.getParameter("actor").equals("Manager")) {
				request = managerDisplay(request);
			} else { 
				request = customerDisplay(request);
			}
		} else if (action.equals("postAd")){
			request = postAdDisplay(request);
			request = customerDisplay(request);
		} else if (action.equals("deleteAd")){
			request = deleteAdDisplay(request);
			request = customerDisplay(request);
		} else if (action.equals("postTransaction")){
			request = postTransactionDisplay(request);
			request = customerDisplay(request);
		}
		return request;
	}
	protected HttpServletRequest actionDisplay(HttpServletRequest request) {
		request.setAttribute("ads", AdDao.getRandomAds(3));
		return request;
	}
	protected HttpServletRequest customerDisplay(HttpServletRequest request) {
		request.setAttribute("repAds", AdDao.getEmployeeAds((Integer)request.getSession().getAttribute("employeeid")));
		return request;
	}
	protected HttpServletRequest managerDisplay(HttpServletRequest request) {

		request.setAttribute("", AdDao.getRandomAds(3));
		return request;
	}
	protected HttpServletRequest postAdDisplay(HttpServletRequest request) {
		Advertisement newAd = new Advertisement();
		newAd.setAdId(Integer.parseInt(request.getParameter("adId")));
		newAd.setAvailableUnits(Integer.parseInt(request.getParameter("availableUnits")));
		newAd.setCompany(request.getParameter("company"));
		newAd.setContent(request.getParameter("content"));
		newAd.setEmployee(Integer.parseInt(request.getParameter("employee")));
		newAd.setItemName(request.getParameter("itemName"));
		newAd.setType(request.getParameter("type"));
		newAd.setUnitPrice(Integer.parseInt(request.getParameter("unitPrice")));
		AdDao.newAd(newAd);
		return request;
	}
	protected HttpServletRequest deleteAdDisplay(HttpServletRequest request) {
		AdDao.deleteAd(Integer.parseInt(request.getParameter("deleteId")));
		request.setAttribute("message", "Ad " + Integer.parseInt(request.getParameter("deleteId")) + " Deleted");
		return request;
	}
	protected HttpServletRequest postTransactionDisplay(HttpServletRequest request) {
		Transaction newTr = new Transaction();
		newTr.setTranId(Integer.parseInt(request.getParameter("tranId")));
		newTr.setAd(Integer.parseInt(request.getParameter("adId")));
		newTr.setNumUnits(Integer.parseInt(request.getParameter("numUnits")));
		newTr.setAccount(Integer.parseInt(request.getParameter("account")));
		AdDao.newTransaction(newTr);
		request.setAttribute("message", "Transaction Recorded");
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
