<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.highradius.internship.*"%>
<!-- Check if user is logged in or not -->
<%
    User user = (User)session.getAttribute("currentUser");
    if(user == null)
    {
    	response.sendRedirect("home.jsp");
    }
    user.searchQry = null;
    user.setCurrentPage(0);
%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
/* Script variable to keep count of current and max page */
var i = <%= user.getCurrentPage() %>;
var max = <%= user.getMaxPage() %>;
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	height: 100%;
	margin: 0px;
	background-color : #D8D8D8;
	overflow : hidden;
	font-family: Century Gothic;
}

.center {
	display: inline;
	margin-left: 27%;
}

.header {
	width: 100%;
	background-color: white;
	height: 12%;
	display : block;
}
.content
{
height: 85%;
display : block;
margin : 10px;
border-radius: 5px;
}
.modifier
{
	padding-top : 10px;
	padding-left : 10px;
	background-color : white;
	height : 10%
}
.table
{
	background-color : white;
	height : 80%;
}
.pageing
{
	background-color : white;
	height : 10%;
	padding-left : 12px;
}
.button
{
 background-color: #FC7500;
 color : white;
 border-radius: 5px;
 height : 38px;
 border : none;
 width: 100px;
 font-size : 18px;
 font-family : Century Gothic;
 font-weight: 900;
}
.closeButton
{
	background-color : white;
	border : none;
	float : right;
	font-size: 23px;
}
form.search
{
	margin-left : 900px;
	right : 20px;
	display : inline-block;
}
form.search input[type=number] {
  padding: 9px;
  font-size: 17px;
  border: 1px #EEFDFF;
  float: left;
  width: 70%;
  background: #EEFDFF;
}
.searchButton {
  float: left;
  width: 15%;
  padding: 5px;
  background: #CFF4F9;
  color: white;
  font-size: 23px;
  border: 1px #CFF4F9;
  border-left: none;
  cursor: pointer;
}

form.search button:hover {
  background: #CFF4F9;
}
table{
width : 100%;
padding : 5px;
}
td{
text-align: left;
padding: 10px;
}
th{
border-bottom : 2px #FC7500 solid;
text-align: left;
padding: 10px;
}
tr:nth-child(even) {
  background-color: #EFF9FD;
}
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
  border-radius: 2px;
}

a:hover {
  background-color: #ddd;
  color: black;
}

.previous {
  background-color: #EFF9FD;
  color: blue;
}

.next {
  background-color: #EFF9FD;
  color: blue;
}
.popup{
	background : rgba(0,0,0,0.6);
	width : 100%;
	height : 100%;
	position : absolute;
	top : 0;
	display : none;
	justify-content: center;
	align-items: center;
}
.popup-content{
	height : 400px;
	width : 800px;
	background : #fff;
	padding : 15px;
	border-radius : 5px;
	position : relative;
}
.heading
{
	font-family: Century Gothic;
	color : #666666;
	margin : 0 0 0 0;
	border-bottom: 4px #FC7500 solid;
	width : 200px;
	display : inline;
	float : left;
}
.popUpForm
{
	color : #D8D8D8;
	margin-top: 70px;
}
form.popUpForm input
{
	border : none;
	border-bottom: 2px solid #D8D8D8;
}
form.popUpForm label
{
	font-size : 25px;
	padding : 5px;
	display : inline-grid;
}
form.popUpForm input[type=submit]
{
	background-color: #FC7500;
	color : white;
	border-radius: 5px;
	height : 38px;
	border : none;
	width: 100px;
	font-size : 18px;
	font-family : Century Gothic;
	font-weight: 900;
	text-align:center;
	margin-top : 20px;;
	margin-left: 350px;
}
.grid
{
	margin-left : 100px;
	margin-right: 100px;
	display: grid;
  	grid-template-columns: 40% 60%;
}
</style>
<title>Dashboard</title>
</head>
<body>
		<%
		/* If level 1 user is logged him, include the ADD and EDIT popups */
		if(user.getLevel() == 1)
		{
		%>
		
		<!-- Add popup form -->
		
		<div class = "popup" id="addPopup">
			<div class = "popup-content">
			<h1 class = "heading">ADD ORDER</h1><button class = "closeButton" onclick="toggleAdd()"><i class="fa fa-close"></i></button>
				<form class ="popUpForm" id = "addPopUpForm">
				<div class = "grid">
				<label> Order ID </label><input type = "number" name = "orderID" required>
				<label> Order Date </label><input type = "date" name = "orderDate" required>
				<label> Customer Name </label><input type = "text" name = "customerName" required>
				<label> Customer Number </label><input type = "number" name = "customerNumber" required>
				<label> Order Amount </label><input type = "number" name = "orderAmount" required>
				<label> Notes </label><input type = "text" name = "notes">
				</div>
				<input type = "hidden" name = "page" value="0">
				<input type = "submit" value="ADD">
				</form>
			</div>
		</div>
		
		<!-- Edit popup form -->
		
		<div class = "popup" id="editPopup">
			<div class = "popup-content">
			<h1 class = "heading">EDIT ORDER</h1><button class = "closeButton" onclick="toggleEdit()"><i class="fa fa-close"></i></button>
				<form class ="popUpForm" id = "editPopUpForm">
				<div class = "grid">
				<label> Order ID </label><input type = "number" name = "orderID" id="orderID" readonly>
				<label> Order Amount </label><input type = "number" name = "orderAmount" required>
				<label> Notes </label><input type = "text" name = "notes">
				<label> Approved By </label><input type = "text" name = "approvedBy">
				</div>
				<input type = "hidden" name = "page" value="0">
				<input type = "submit" value="ADD">
				</form>
			</div>
		</div>
		<%
		}
		%>
	<div class="header">
		<img src="images/hrc-logo.svg" style="padding-left: 10px; padding-top: 10px;" height="40px" width="200px">
		<img src="images/abc-logo.png" class="center" height="45px" width="200px">
	</div>
	<%-- Welcome! <%if(user != null) out.print(user.getUsername()); %> --%>
	<div class = "content">
		<div class = "modifier">
		<%
			/* If level 1 user is logged in show the ADD and Edit buttons */
			if(user.getLevel() == 1)
			{
		%>
		<button class = "button" onclick="toggleAdd()">ADD</button>
		<button class = "button" onclick="toggleEdit()">EDIT</button>
		<%
			}
			else
			{
				/* If level 2 or level 3 user is logged in show the APPROVE and REJECT buttons */
		%>
		<form>
		<input type = "hidden" id = "orderID">
		</form>
		<button class = "button" onclick="approveOrder()">APPROVE</button>
		<button class = "button" onclick="rejectOrder()">REJECT</button>
		<%
			}
		%>
		<form class="search" id = "searchForm">
  		<button type="submit" class = "searchButton"><i class="fa fa-search"></i></button>
  		<input type="number" placeholder="Search.." name = "searchQry">
  		<input type = "hidden" value = "0" name = "page">
		</form>
		</div>
		
		<div class = "table">
		<table id = "tabledata">
		<!-- data from ajax comes here -->
		</table>
		</div>
		
		<div class = "pageing">
		<a href="javascript:first()" class="previous">&laquo;</a>
		<a href="javascript:previous()" class="previous">&#8249;</a>
		<span id ="pageNumber">Page <script>document.write(i+1)</script> of <script>document.write(max)</script></span>
		<a href="javascript:next()" class="next">&#8250;</a>
		<a href="javascript:last()" class="next">&raquo;</a>
		</div>
	</div>
	
	<script>
		/* When document is ready, get the first set of values of the table by makin ajax call. */
		$(document).ready(function (e){			
			$.ajax({
				url : "table.jsp",
				type : "post",
				data : {page : i} ,
				success : function(data, textStatus, jqXHR){
					//update table data
					$("#tabledata").html(data);
					//call function to make checkbox behave as radio button
					makeCheckBoxRadio();
				}
			})
		})
	</script>
	<script>
	/* Javascript function which makes checkbox behave as radio box */
	function makeCheckBoxRadio()
	{
		$(".checkbox").change(function() {
			var orderId =$(this).val();
			document.getElementById("orderID").value = orderId;
			  $(".checkbox").prop('checked', false);
			  $(this).prop('checked', true);
			});
	}
	/* Function to go to first page */
	function first()
	{
		i=0;
		$.ajax({
			url : "table.jsp",
			type : "post",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Function to go to previous page */
	function previous()
	{
		i--;
		if(i<0)
			i=0;
		$.ajax({
			url : "table.jsp",
			type : "post",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				//console.log(data);
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Function to go to next page */
	function next()
	{
		i++;
		if(i >= max)
			i = max-1;
		$.ajax({
			url : "table.jsp",
			type : "post",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				//console.log(data);
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Function to go to last page */
	function last()
	{
		i=max-1;
		$.ajax({
			url : "table.jsp",
			type : "post",
			data : {page : '-1'} ,
			success : function(data, textStatus, jqXHR){
				//console.log(data);
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Implementation of search */
	$("#searchForm").submit(function(e){
		e.preventDefault();
		console.log("submiting search form");
		var form = $(this);
		$.ajax({
			type : "post",
			url : "table.jsp",
			data : form.serialize(),
			success : function(data)
			{
				$("#tabledata").html(data);
				i=0;
				max = document.getElementById("maxpage").value;
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
				update();
			}
		})
		
	})
	/* Function which update pagenumber after each pagenation call */
	function update()
	{
		document.getElementById("pageNumber").innerHTML = "Page "+(i+1)+" of "+max;
	}
	/* Toggle display of add popup */
	function toggleAdd() {
		  var x = document.getElementById("addPopup");
		  console.log(x.style.display)
		  if (x.style.display === "flex") {
		    x.style.display = "none";
		  } else {
		    x.style.display = "flex";
		  }
		}
	/* Implementation of add functionality */
	$("#addPopUpForm").submit(function(e){
		e.preventDefault();
		console.log("submiting add form");
		var form = $(this);
		$.ajax({
			type : "post",
			url : "addOrder",
			data : form.serialize(),
			success : function(data)
			{
				$("#tabledata").html(data);
				i=0;
				max = document.getElementById("maxpage").value;
				update();
				console.log("success of add form");
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
				toggleAdd();
			}
		})
		
	})
	/* Fucntion to toggle view of edit popup */
	function toggleEdit() {
		  var x = document.getElementById("editPopup");
		  console.log(x.style.display)
		  if (x.style.display === "flex") {
		    x.style.display = "none";
		  } else {
		    x.style.display = "flex";
		  }
		}
	/* Implementation of Approve functionality */
	function approveOrder()
	{
		var orderID = document.getElementById("orderID").value;
		$.ajax({
			url : "approve",
			type : "post",
			data : {orderID : orderID} ,
			success : function(data, textStatus, jqXHR){
				//console.log(data);
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Implementaion of Rekect functionality */
	function rejectOrder()
	{
		var orderID = document.getElementById("orderID").value;
		$.ajax({
			url : "reject",
			type : "post",
			data : {orderID : orderID} ,
			success : function(data, textStatus, jqXHR){
				//console.log(data);
				$("#tabledata").html(data);
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		update();
	}
	/* Implementation of Edit functionality */
	$("#editPopUpForm").submit(function(e){
		e.preventDefault();
		console.log("submiting edit form");
		var form = $(this);
		$.ajax({
			type : "post",
			url : "editOrder",
			data : form.serialize(),
			success : function(data)
			{
				$("#tabledata").html(data);
				i=0;
				max = document.getElementById("maxpage").value;
				update();
				console.log("success of edit form")
				toggleEdit();
				//call function to make checkbox behave as radio button
				makeCheckBoxRadio();
			}
		})
		
	})
	</script>
</body>
</html>