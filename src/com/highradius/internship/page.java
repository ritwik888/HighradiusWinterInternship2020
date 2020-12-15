package com.highradius.internship;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class page
 */
@WebServlet("/page")
public class page extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public page() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			System.out.println("in page");
			Connection con = DatabaseConnection.initializeDatabase();
			HttpSession s = request.getSession(false);
			User user = (User)s.getAttribute("currentUser");
			int page;
			if(request.getParameter("page") != null)
				page = Integer.parseInt((String)request.getParameter("page"));
			else
				page = user.getCurrentPage();
			System.out.println("page requested = "+page);
			// get max page
			String maxQry="";
			int level = user.getLevel();
			if(level == 1)
				maxQry = "SELECT COUNT(*) FROM order_details";
			else if(level == 2)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount BETWEEN 10001 AND 50000";
			else if(level == 3)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount > 50000";
			PreparedStatement p = con.prepareStatement(maxQry);
			ResultSet set1 = p.executeQuery();
			set1.next();
			int maxPage = (int)Math.ceil((set1.getInt(1))/5.0);
			System.out.println("Max no. pf page ="+maxPage);
			if(page>=0 && page< maxPage)
			user.setCurrentPage(page);
			if(page>=maxPage || page < 0)
			{
				page = maxPage-1;
				user.setCurrentPage(page);
			}
			int offset = page*5;
			String qry = user.getQry() + "offset ?";			
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setInt(1, offset);
			System.out.println(qry);
			ResultSet set = pstm.executeQuery();
			ArrayList<Entity> list = new ArrayList<>();
			while(set.next())
			{
				Integer orderId = set.getInt(1);
				String customerName = set.getString(2);
				Integer customerId = set.getInt(3);
				Integer orderAmount = set.getInt(4);
				String status = set.getString(5);
				String approvedBy = set.getString(6);
				String notes = set.getString(7);
				String date = set.getString(8);
				Entity e = new Entity(orderId, customerName, customerId, orderAmount, status, approvedBy, notes, date);
				list.add(e);
			}
			user.setEn(list);
			response.sendRedirect("dashboard1.jsp");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
