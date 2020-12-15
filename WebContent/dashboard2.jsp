<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.highradius.internship.*"%>
<%
    User user = (User)session.getAttribute("currentUser");
    if(user == null)
    {
    	response.sendRedirect("home.jsp");
    }

%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var i = <%= user.getCurrentPage() %>;
var max = <%= user.getMaxPage() %>;
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	height: 100%;
	margin: 0px;
	background-color : #D8D8D8;
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
button
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
form.search
{
	position : absolute;
	right : 20px;
	display : inline-block;
}
form.search input[type=text] {
  padding: 5px;
  font-size: 17px;
  border: 1px #EEFDFF;
  float: left;
  width: 70%;
  background: #EEFDFF;
}
form.search button {
  float: left;
  width: 15%;
  padding: 5px;
  background: #CFF4F9;
  color: white;
  font-size: 17px;
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

</style>
<title>Dashboard</title>
</head>
<body>
	<div class="header">
		<img src="images/hrc-logo.svg" style="padding-left: 10px; padding-top: 10px;" height="40px" width="200px">
		<img src="images/abc-logo.png" class="center" height="45px" width="200px">
	</div>
	<%-- Welcome! <%if(user != null) out.print(user.getUsername()); %> --%>
	<div class = "content">
		<div class = "modifier">
		<button>APPROVE</button>
		<button>REJECT</button>
		<form class="search" action="/action_page.php">
  		<button type="submit"><i class="fa fa-search"></i></button>
  		<input type="text" placeholder="Search..">
		</form>
		</div>
		<div class = "table">
		<table id = "tabledata">
		
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
		$(document).ready(function (e){
			$.ajax({
				url : "table.jsp",
				data : {page : i} ,
				success : function(data, textStatus, jqXHR){
					console.log(data);
					$("#tabledata").html(data);
				}
			})
			document.getElementById("pageNumber").innerHTML = "Page "+(i+1)+" of "+max;
		})
	</script>
	<script>
	function first()
	{
		i=0;
		$.ajax({
			url : "table.jsp",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				console.log(data);
				$("#tabledata").html(data);
			}
		})
		update();
	}
	function previous()
	{
		i--;
		if(i<0)
			i=0;
		$.ajax({
			url : "table.jsp",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				console.log(data);
				$("#tabledata").html(data);
			}
		})
		update();
	}
	function next()
	{
		i++;
		if(i >= max)
			i = max-1;
		$.ajax({
			url : "table.jsp",
			data : {page : i} ,
			success : function(data, textStatus, jqXHR){
				console.log(data);
				$("#tabledata").html(data);
			}
		})
		update();
	}
	function last()
	{
		i=max-1;
		$.ajax({
			url : "table.jsp",
			data : {page : '-1'} ,
			success : function(data, textStatus, jqXHR){
				console.log(data);
				$("#tabledata").html(data);
			}
		})
		update();
	}
	function update()
	{
		document.getElementById("pageNumber").innerHTML = "Page "+(i+1)+" of "+max;
	}
	</script>
</body>
</html>