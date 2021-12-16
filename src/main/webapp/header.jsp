<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>
	<%
	String email = null;
    UserDAO ud = new UserDAO();
	User user = null;
	if (session.getAttribute("email") != null) {
		email = (String) session.getAttribute("email");
		user = ud.getUser(email);
	}
	%>
	<nav
		class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
		<a class="navbar-brand text-gray-600 small" href="index.jsp"><img src="img/KYCPP.png" width="200"></a>

		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">
			<li class="nav-item pr-0"><a class="nav-link" aria-current="page"href="board.jsp">게시판</a></li>
			<!-- Nav Item - User Information -->
			<li class="nav-item dropdown no-arrow">
				<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
				<% 
					if(email == null || user.getProfilePicture() == null){
				%>
				<img class="img-fluid rounded-circle" src="img/undraw_profile.svg" alt="..." width="35">
				<%
					} else{
				%>
				<img class="img-fluid rounded-circle" src="img/<%=user.getProfilePicture() %>" alt="..." width="35">
				<%
					}
				%>
				</a> 
			<!-- Dropdown - User Information -->
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
					aria-labelledby="userDropdown">
 
					<%
						if(email == null){
					%>
					<a class="dropdown-item" href="login.jsp"> 
						<i	class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i> Login
					</a> 
					<a class="dropdown-item" href="register.jsp"> 
						<i class="fas fa-file-signature fa-sm fa-fw mr-2 text-gray-400"></i> Register
					</a>
					<%
						}
						else{
					%>
					<a class="dropdown-item" href="profile.jsp"> 
						<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
					</a>
					<a class="dropdown-item" href="message.jsp"> 
						<i class="fas fa-envelope fa-sm fa-fw mr-2 text-gray-400"></i> Message
					</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="logout.jsp"> 
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Logout
					</a>
					<%
						}
					%>
				</div></li>

		</ul>

	</nav>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>
</body>
</html>