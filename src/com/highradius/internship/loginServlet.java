package com.highradius.internship;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// get username and password from the form
		System.out.println("At login servlet");
		String username = request.getParameter("user_name");
		String password = request.getParameter("password");
		
		//validation of username and password.
		Authenticator authenticator = new Authenticator();
		User user = authenticator.authenticate(username, password);
		
		// if we get a user object, that means login is success, then redirect to dashboard.
		// else if user is null, return to home.jsp
		if (user != null) {
			
			HttpSession s = request.getSession();
			s.setAttribute("currentUser", user);
			//int level = user.getLevel();
			response.sendRedirect("dashboard1.jsp");
			
		} else {
			String e = "<script> alert('Invalid Username/Password')</script>";
			HttpSession s = request.getSession();
			s.setAttribute("error", e);
			response.sendRedirect("home.jsp");
		}

	}

}
