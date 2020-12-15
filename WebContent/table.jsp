<%@page import="java.util.*"%>
<%@page import="com.highradius.internship.*"%>
<tr>
	<th></th>
	<th>Order Date</th>
	<th>Order ID</th>
	<th>Customer Name</th>
	<th>Customer ID</th>
	<th>Order Amount</th>
	<th>Approval Status</th>
	<th>Approved By</th>
	<th>Notes</th>
</tr>
<%
	String inputPage = (String)request.getParameter("page");
	if(inputPage == null)
		inputPage = "0";
	Integer p = Integer.parseInt(inputPage);
	System.out.println("Page requested = "+p);
	String searchQry = (String)request.getParameter("searchQry");
	System.out.println("Search qry = "+ searchQry);
	User user = (User)session.getAttribute("currentUser");
	if(user == null)
	{
		response.sendRedirect("home.jsp");
	}
	ArrayList<Entity> en = null;
	if(searchQry != null){
		searchQry = searchQry+"%";
		user.setSearchQry(searchQry);
	}
	System.out.println("Search qry = "+ searchQry);
	if(user.searchQry == null)
		{
			en = user.getList(p);
		}
	else
	{
		en = user.getList(p,user.searchQry);
	}
	if(en != null)
	{
		for(Entity e : en)
		{
		
%>
<tr>
	<td><input type="checkbox" class="checkbox"
		value="<%= e.getOrederId() %>"></td>
	<td><%= e.getDate() %></td>
	<td><%= e.getOrederId() %></td>
	<td><%= e.getCustomerName() %></td>
	<td><%= e.getCustomerId() %></td>
	<td><%= e.getOrderAmount() %></td>
	<td><%= e.getStatus() %></td>
	<td><%= e.getApprovedBy() %></td>
	<td><%= e.getNotes() %></td>
</tr>
<%
		}
	}
%>
<input type="hidden" value="<%= user.maxPage %>" id="maxpage">