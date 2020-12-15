package com.highradius.internship;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.http.HttpSession;
public class User {
	private String username;
	
	public Integer level;
	public String qry;
	public String range;
	public Integer currentPage;
	public Integer maxPage;
	public String searchQry;
	public User()
	{
	}
	
	public User(String username, Integer level, String qry) {
		super();
		this.username = username;
		this.level = level;
		this.qry = qry;
		this.getList(0);
	}

	public String getUsername() {
		return username;
	}
 
	public void setUsername(String username) {
		this.username = username;
	}
	

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
	public String getQry() {
		return qry;
	}

	public void setQry(String qry) {
		this.qry = qry;
	}

	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}


	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	
	public String getSearchQry() {
		return searchQry;
	}

	public void setSearchQry(String searchQry) {
		this.searchQry = searchQry;
	}

	public ArrayList<Entity> getList(int page)
	{
		ArrayList<Entity> list =null;
		try {
			Connection con = DatabaseConnection.initializeDatabase();
			
			// get max page
			String maxQry="";
			int level = this.getLevel();
			if(level == 1)
				maxQry = "SELECT COUNT(*) FROM order_details";
			else if(level == 2)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount BETWEEN 10001 AND 50000";
			else if(level == 3)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount > 50000";
			PreparedStatement p = con.prepareStatement(maxQry);
			ResultSet set1 = p.executeQuery();
			set1.next();
			int maxPage = (int)Math.ceil((set1.getInt(1))/10.0);
			this.maxPage = maxPage;
			System.out.println("Max no. pf page ="+maxPage);
			
			if(page>=0 && page< maxPage)
			this.setCurrentPage(page);
			if(page>=maxPage || page < 0)
			{
				page = maxPage-1;
				this.setCurrentPage(page);
			}
			int offset = page*10;
			String qry = this.getQry() + "LIMIT 10 offset ?";			
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setInt(1, offset);
			ResultSet set = pstm.executeQuery();
			
			list = new ArrayList<>();
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
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Entity> getList(int page, String search)
	{
		ArrayList<Entity> list =null;
		try {
			Connection con = DatabaseConnection.initializeDatabase();
			
			String maxQry="";
			int level = this.getLevel();
			if(level == 1)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_ID LIKE ?";
			else if(level == 2)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount BETWEEN 10001 AND 50000 AND Order_ID LIKE ?";
			else if(level == 3)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount > 50000 AND Order_ID LIKE ?";
			System.out.println(maxQry);
			PreparedStatement p = con.prepareStatement(maxQry);
			p.setString(1, search);
			ResultSet set1 = p.executeQuery();
			set1.next();
			int maxPage = (int)Math.ceil((set1.getInt(1))/10.0);
			this.maxPage = maxPage;
			System.out.println("Max no. pf page for search qry = "+maxPage);
			if(maxPage == 0)
				return list;
			if(page>=0 && page< maxPage)
			this.setCurrentPage(page);
			if(page>=maxPage || page < 0)
			{
				page = maxPage-1;
				this.setCurrentPage(page);
			}
			int offset = page*10;
			System.out.println("offset = "+offset);
			String qry = this.getQry() + "AND Order_ID LIKE ? LIMIT 10 offset ?";	
			if(this.getLevel() == 1)
				qry = this.getQry() + "WHERE Order_ID LIKE ? LIMIT 10 offset ?";
			PreparedStatement pstm = con.prepareStatement(qry);
			pstm.setInt(2, offset);
			pstm.setString(1, search);
			System.out.println(qry);
			ResultSet set = pstm.executeQuery();
			list = new ArrayList<>();
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
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public Integer getMaxPage() {
		
		try {
			Connection con = DatabaseConnection.initializeDatabase();
			// get max page
			String maxQry="";
			int level = this.getLevel();
			if(level == 1)
				maxQry = "SELECT COUNT(*) FROM order_details";
			else if(level == 2)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount BETWEEN 10001 AND 50000";
			else if(level == 3)
				maxQry = "SELECT COUNT(*) FROM order_details where Order_Amount > 50000";
			PreparedStatement p = con.prepareStatement(maxQry);
			ResultSet set1 = p.executeQuery();
			set1.next();
			int maxPage = (int)Math.ceil((set1.getInt(1))/10.0);
			this.maxPage = maxPage;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return maxPage;
	}

	public void setMaxPage(Integer maxPage) {
		this.maxPage = maxPage;
	}
	public void setMaxPage() {
		this.maxPage = getMaxPage();
	}
	
	
}
