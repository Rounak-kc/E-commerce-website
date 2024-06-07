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
 * Servlet implementation class MSProduct
 */
@WebServlet("/MSProduct")
public class MSProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();
		    String name=request.getParameter("name");
		    DAO db=new DAO();
		    String	result=db.setMSProduct(name);
		    db.closeConnection();
		    session.setAttribute("msg", result);
		    response.sendRedirect("Product.jsp");
		    
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
