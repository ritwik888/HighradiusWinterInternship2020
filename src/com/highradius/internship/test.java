package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
/**
 * Servlet implementation class test
 */
@WebServlet("/test")
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(name+" "+password);
		try {
			Connection con  = DatabaseConnection.initializeDatabase();
			String qry = "SELECT * FROM user_details where username = ? and password = ?";
			
			PreparedStatement pstm = con.prepareStatement(qry);
			
			pstm.setString(1,name);
			pstm.setString(2, password);
			
			ResultSet set = pstm.executeQuery();
			System.out.print(set);
			if(set.next())
			{
				HttpSession s = request.getSession();
				s.setAttribute("username", name);
				s.setAttribute("pass", password);
				response.sendRedirect("dash.jsp");
			}
			else
			{
				System.out.println("Invalid user");
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
