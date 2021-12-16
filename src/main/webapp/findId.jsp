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
		String name = null;
    	String studentId = null;
		if(request.getParameter("name") != null){
			name = request.getParameter("name");
		}
		if(request.getParameter("studentId") != null){
			studentId = request.getParameter("studentId");
		}
	%>
	
	<%
		if(name == null && studentId == null){
	%>
	<div class="container">
			<ul id="nav2" class="nav justify-content-center">
				<li class="nav-item"><a class="nav-link text-gray-600" href="findId.jsp">아이디 찾기</a></li>
				<li class="nav-item"><a class="nav-link text-gray-600" href="findPassword.jsp">비밀번호 찾기</a></li>
			</ul>
	</div>

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
                                        <h1 class="h4 text-gray-900 mb-4">아이디 찾기</h1>
                                    </div>
                                    <form class="user" method="get" action="findId.jsp">
                                    	<div class="mb-2">이름</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="name" placeholder="Enter your Name">
                                        </div>
                                        <div class="mb-2">학번</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="studentId" placeholder="Enter your StudentId">
                                        </div>
                                        <input type="submit" class="btn btn-primary btn-user btn-block" value="찾기">
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
    <%
		} else if(ud.getEmail(name, studentId) == null){
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
                                        <h1 class="h4 text-gray-900 mb-4">아이디 찾기</h1>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-gray-900">아이디가 존재하지 않습니다.</p>
                                    </div>
                                    <div class="text-center mt-2">
                                    	<a href="findId.jsp">아이디 찾기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
		} else{
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
                                        <h1 class="h4 text-gray-900 mb-4">아이디 찾기</h1>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-gray-900">당신의 아이디는 <%= ud.getEmail(name, studentId) %> 입니다.</p>
                                    </div>
                                    <div class="text-center mt-2">
                                        <a href="login.jsp">로그인 하기</a>
                                    </div>
                                    <div class="text-center mt-2">
                                    	<a href="findPassword.jsp">비밀번호 찾기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<%
		}
	%>
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