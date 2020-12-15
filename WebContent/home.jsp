<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="ISO-8859-1">
<title>WinterInternship</title>
<style>
* body {margin = 0;padiing = 0;
	background-image: url("images/human-machine-hand-homepage.jpg");
	background-repeat: no-repeat;
	background-position: center 20%;
	background-size: 100%;
	height: 100%;
	overflow-y : hidden;
	font-family: Century Gothic;
}

.ptext {
	margin-top: 190px;
	padding-top : 10px;
	padding-bottom : 10px;
	background-color: #8FD163;
	color: white;
	font-size: 28px;
	padding-left: 30px;
	border-radius: 0px 25px 25px 0px;
}

.myform {
	margin : 40px 0px 0px 210px;
}
.mylable{
color:#666666;
font-size : 15px;
}
.myinput{
margin-top : 10px;
margin-bottom: 15px;
border: none;
border-bottom: 2px solid #F4B400;
background-color: #F3FBFE;
width : 50%;
font-size : 20px;
}
.submit
{
margin-left : 210px;
margin-top : 45px;
height : 30px;
width : 18%;
border-radius: 5px;
color : white;
font-size : 18px;
background-color : #BDBDBD;
border : 0px;
}
</style>
</head>
<body>
	<div style="height: 100%">
		<div style="height: 35%;">
			<img src="images/hrc-logo.svg" style="padding-left: 20px; padding-top: 20px;" height = "40px" width = "200px">
		</div>
		<div style="height: 65%">
			<div style="width: 40%; display: inline-block">
				<p class="ptext">ORDER MANAGEMENT APPLICATION</p>
			</div>
			<div
				style="width: 60%; position: absolute; right: 0px; display: inline-block">
				<form class=  "myform" action="loginServlet" method="post">
				<p style="color:#BDBDBD; font-size : 25px;">Sign in</p>
					<label class = "mylable">Username</label><br>
					<input class = "myinput" type="text" name="user_name" required><br>
					<label class= "mylable">Password</label><br>
					<input class = "myinput" type="password" name="password" required><br>
					<input class = "submit" type="submit" value="Sign in">
				</form>
			</div>
		</div>
	</div>
	<!-- Script to show error message if login failed -->
<%
	String s = (String)session.getAttribute("error");
	if(s != null)
	{
		out.println(s);
		session.removeAttribute("error");
	}
%>
</body>
</html>