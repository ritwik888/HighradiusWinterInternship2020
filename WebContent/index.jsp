<%@page import="java.sql.*" %>
<%@page import="com.highradius.internship.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Highradius Winter Recruitment</title>
<link rel="stylesheet" href="css/index.css">
</head>
<body>
<h1>Hello world</h1>
<%
	Connection con = DatabaseConnection.initializeDatabase();
	out.print("<h1>hi</h1>");
%>
<%= con %>
<h1>this is index.jsp</h1>
<script src="js/index.js"></script>
<script>
$(document).ready(function (e){
	alert("loading")
})
</script>
</body>
</html>