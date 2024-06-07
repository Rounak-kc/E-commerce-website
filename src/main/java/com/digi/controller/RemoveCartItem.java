package com.digi.controller;
import com.digi.model.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/RemoveFromCart")
public class RemoveCartItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		PrintWriter out=response.getWriter();
		try {
			HttpSession session=request.getSession();
			String email=(String)session.getAttribute("email");
			String item=request.getParameter("item");
			DAO db=new DAO();
			db.removeCartItem(email,item);
			db.closeConnection();
			session.setAttribute("msg","Item Successfully Remove From Cart");
			response.sendRedirect("Cart.jsp");
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
