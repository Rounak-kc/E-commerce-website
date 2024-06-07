package com.digi.controller;

import com.digi.model.DAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CurrentAddress
 */
@WebServlet("/AddOrderInfo")
public class addOrderInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();//Create session
			String email=(String)session.getAttribute("email");
			String address=request.getParameter("crtAddress");
			DAO db=new DAO();
			if(address==null) {
				session.setAttribute("msg","Address Is Not Filled");
				response.sendRedirect("placeOrder.jsp");
			}
			db.setorderInfo(email,address);
			db.closeConnection();
			//session.setAttribute("msg","Successfully ");
			response.sendRedirect("ConfirmOrder.jsp");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
