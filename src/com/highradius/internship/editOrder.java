package com.highradius.internship;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class editOrder
 */
@WebServlet("/editOrder")
public class editOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editOrder() {
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
		int orderAmount = Integer.parseInt(request.getParameter("orderAmount"));
		String status = "Awaiting Approval";
		String approvedBy = null;
		String notes = request.getParameter("notes");
		if(orderAmount <= 10000)
		{
			status = "Approved";
			approvedBy = "David Lee";
		}
		try {
			System.out.println("Updating data");
			Connection con = DatabaseConnection.initializeDatabase();
			String qry = "UPDATE order_details SET Order_Amount = ?, Notes = ?, Approval_Status = ?, Approved_By = ? WHERE Order_ID = ?";
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setInt(1, orderAmount);
			pstm.setString(2, notes);
			pstm.setString(3, status);
			pstm.setString(4, approvedBy);
			pstm.setInt(5, orderId);
			int rowsUpdated = pstm.executeUpdate();
			System.out.println("rows updated = "+ rowsUpdated);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("table.jsp");
		rd.forward(request, response);
	}

}
