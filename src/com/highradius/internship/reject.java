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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class reject
 */
@WebServlet("/reject")
public class reject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public reject() {
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
		HttpSession s = request.getSession(false);
		User user = (User)s.getAttribute("currentUser");
		String approvedBy = user.getUsername();
		String status = "Rejected";
		try {
			Connection con = DatabaseConnection.initializeDatabase();
			String qry = "UPDATE order_details SET Approval_Status = ?, Approved_By = ? WHERE Order_ID = ?";
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setString(1, status);
			pstm.setString(2, approvedBy);
			pstm.setInt(3, orderId);
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
