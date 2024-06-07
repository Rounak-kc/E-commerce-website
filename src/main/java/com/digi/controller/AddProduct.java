package com.digi.controller;
import com.digi.model.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/Add_Product")
@MultipartConfig    //This annotation receive file from stream
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//PrintWriter out=response.getWriter();
		try {
			String name=request.getParameter("p_name");
			int price=Integer.parseInt(request.getParameter("p_price"));
			String company=request.getParameter("p_company");
			String category=request.getParameter("p_category");
			String info=request.getParameter("p_info");
			String quantity=request.getParameter("p_quantity");
			///////////////To receive input stream file for image//////////////////////
			Part part=request.getPart("p_image");
			InputStream img=part.getInputStream();
			////////////////////Create HashMap to put all key into one variable/////////////////////////
			HashMap<String,Object> product=new HashMap<>();
			product.put("name", name);
			product.put("price", price);
			product.put("company", company);
			product.put("category", category);
			product.put("info",info);
			product.put("quantity", quantity);
			product.put("image", img);
			DAO db=new DAO();
			String result=db.addProduct(product);
			db.closeConnection();
			HttpSession session=request.getSession();//Create session
			session.setAttribute("msg",result);
			response.sendRedirect("Product.jsp");
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
