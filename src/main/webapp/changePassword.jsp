<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<%@ include file="./header.jsp"%>
	<%
	String userEmail = ud.validateEmail(request.getParameter("email"), request.getParameter("password"));
	if (userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 접근입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	%>	
	<div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-5 col-lg-5 col-md-5">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">비밀번호 변경</h1>
                                    </div>
                                    <form class="user mt-5" method="post" action="changePasswordAction.jsp?email=<%=userEmail%>">
                                    	<div>새 비밀번호</div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="newPassword" placeholder="New Password">
                                        </div>
                                        <div>비밀번호 확인</div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="confirmPassword" placeholder="confirm Password">
                                        </div>
                                        <input type="submit" class="btn btn-primary btn-user btn-block" value="변경">
                                        <hr>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<!-- Footer-->
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