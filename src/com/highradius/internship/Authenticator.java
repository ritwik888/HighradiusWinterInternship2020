package com.highradius.internship;

import java.sql.*;

class Authenticator {
	public User authenticate(String username, String password)
	{
		User user = null;
		try {
			// get connection object
			Connection con = DatabaseConnection.initializeDatabase();
			
			// query to fetch user with input username and password.
			String qry = "SELECT * FROM user_details WHERE username = ? and password = ?";
			System.out.println("At authenticate\n");
			
			//prepare the query.
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setString(1, username);
			pstm.setString(2,password);
			
			//execute the query/
			ResultSet set = pstm.executeQuery();
			
			//if we find a user, return its object, else return null.
			if(set.next())
			{
				System.out.println("Login in progress..\n");
				user = new User();
				user.setCurrentPage(new Integer(0));
				user.setUsername(set.getString("username"));
				int level = set.getInt(1);
				user.setLevel(level);
				String range = set.getString(5);
				user.setRange(range);
				if(level == 1)
					qry = "SELECT * FROM order_details ";
				else if(level == 2)
					qry = "SELECT * FROM order_details where Order_Amount BETWEEN 10000 AND 50000 ";
				else if(level == 3)
					qry = "SELECT * FROM order_details where Order_Amount > 50000 ";
				user.setQry(qry);
				System.out.println("Login in Completed\n");
			}
			else
			{
				System.out.println("Login failed\n");
				user = null;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return user;
		
	}
}
