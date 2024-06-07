package com.digi.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.digi.model.DAO;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/OrderComplete")
public class ChangeOrderStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			String status = request.getParameter("status");
			String page = request.getParameter("page");
			if(email==null) {
				session.setAttribute("msg","Please Login First");
				response.sendRedirect("index.jsp");
			}else {
				DAO db = new DAO();
				db.changeOrderStatus(id, status);
				session.setAttribute("msg","Product Canceled Successfully");
				response.sendRedirect(page+".jsp");
			}
		}catch(Exception e) {
			
		}
	}

}
