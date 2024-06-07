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
@WebServlet("/AddCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();
			String email=(String)session.getAttribute("email");
			if(email==null) {
				session.setAttribute("msg","Please Login First");
				response.sendRedirect("UserProduct.jsp");
			}else {
				String name=request.getParameter("name");
				String search=request.getParameter("search");
				DAO db=new DAO();
				db.addCart(email,name);
				db.closeConnection();
				
				session.setAttribute("msg", "Product Added To Cart Sucessfully");
				response.sendRedirect("UserProduct.jsp?p_name="+search);
			}
		}catch(Exception e) {
			
		}
	}

}
