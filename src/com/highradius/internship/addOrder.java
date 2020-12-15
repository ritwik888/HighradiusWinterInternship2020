package com.highradius.internship;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addOrder
 */
@WebServlet("/addOrder")
public class addOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int orderId = Integer.parseInt(request.getParameter("orderID"));
		String customerName = request.getParameter("customerName");
		System.out.println(customerName);
		int customerNumber = Integer.parseInt(request.getParameter("customerNumber"));
		int orderAmount = Integer.parseInt(request.getParameter("orderAmount"));
		String status = "Awaiting Approval";
		String approvedBy = null;
		String notes = request.getParameter("notes");
		String date = request.getParameter("orderDate");
		if(orderAmount <= 10000)
		{
			status = "Approved";
			approvedBy = "David Lee";
		}
		try {
			Connection con = DatabaseConnection.initializeDatabase();
			String qry = "INSERT INTO order_details VALUES(?,?,?,?,?,?,?,?)";
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setInt(1, orderId);
			pstm.setString(2, customerName);
			pstm.setInt(3, customerNumber);
			pstm.setInt(4, orderAmount);
			pstm.setString(5, status);
			pstm.setString(6, approvedBy);
			pstm.setString(7, notes);
			pstm.setString(8, date);
			int rowsInserted = pstm.executeUpdate();
			System.out.println("rows inserted = "+rowsInserted);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("table.jsp");
		rd.forward(request, response);
	}
}
