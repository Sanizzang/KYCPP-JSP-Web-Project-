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
	<%@ include file="./header.jsp" %>

	<div class="container">
		<div class="row justify-content-center p-5">
			<form class="align-self-center" method="post" enctype="multipart/form-data" action="profileAction.jsp">
				<div class="form-group" style="text-align: center;">
					<%
						if(user.getProfilePicture() == null){
					%>
					<img class="img-fluid rounded-circle" src="img/undraw_profile.svg" alt="..." width="180">
					<%
						} else{
					%>
					<img class="img-fluid rounded-circle" src="img/<%= user.getProfilePicture() %>" alt="..." width="180" height="180">
					<%
						}
					%>
					<div class="text-white">
						<div class="card-body" style="text-align: left;">
							<div class="custom-file pmd-custom-file">
								<input type="file" class="custom-file-input" id="profilePicture" name="profilePicture">
								<label class="custom-file-label" for="customFile">프로필 사진 변경</label>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					이름: <input type="text" class="form-control" id="name" name="name" value="<%= user.getName()%>">
				</div>
				<div class="form-group">
					전공: <input type="text" class="form-control" id="major" name="major" value="<%= user.getMajor()%>">
				</div>
				<div class="form-group">
					학번: <input type="text" class="form-control" id="studentId" name="studentId" value="<%= user.getStudentId()%>">
				</div>
				<div class="form-group">
					성별: <input type="text" class="form-control" id="gender" name="gender" value="<%= user.getGender()%>">
				</div>
				<div class="form-group">
					소개: <textarea class="form-control" name="biography" maxlength="1000" style="height: 100px"><%= user.getBiography()%></textarea>
				</div>
				<input type="submit" class="btn btn-primary" value="수정">
			</form>
		</div>
	</div>

	<%@ include file="./footer.jsp"%>
		
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