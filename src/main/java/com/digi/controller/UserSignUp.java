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
@WebServlet("/UserSignUp")
public class UserSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		PrintWriter out=response.getWriter();
		try {
			//String address=" ";
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String phone=request.getParameter("phone");
			String password=request.getParameter("password");
			String re_password=request.getParameter("re-password");
			HttpSession session=request.getSession();//Create session
			if(re_password.equals(password)) {
				DAO db=new DAO();
				String result=db.addUser(name,email,phone,password);
				String result2=db.addUserToCurrentAddress(email);
				db.closeConnection();
				
				if(result.equalsIgnoreCase("success")){
					session.setAttribute("email",email);
					session.setAttribute("name",name);
					response.sendRedirect("User.jsp");
				}else {
					session.setAttribute("msg",result);
					response.sendRedirect("index.jsp");
				}
			}else {
				session.setAttribute("msg","Different Password");
				response.sendRedirect("index.jsp");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
		}
	}

}
