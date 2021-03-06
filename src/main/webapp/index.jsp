<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>KYCPP</title>
	    <!-- Custom fonts for this template-->
	    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	    <link
	        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	        rel="stylesheet">
	
	    <!-- Custom styles for this template-->
	    <link href="css/sb-admin-2.min.css" rel="stylesheet">
	</head>
    <body>

        <!-- Responsive navbar-->
        <%@ include file="./header.jsp" %>
        
        <div class="p-5">
            <!-- Page Content-->
			<div class="container">
				<!-- Page Features-->
				<div class="row">
					<%
					for (int i = 1; i < 9; i++) {
					%>
					<jsp:include page="reservationBox.jsp">
						<jsp:param name="roomNum" value="<%=i%>" />
					</jsp:include>
					<%
					}
					%>
				</div>
			</div>
		</div>
        
        <!-- Footer-->
        <%@ include file="./footer.jsp" %>
        
	    <!-- Bootstrap core JavaScript-->
	    <script src="vendor/jquery/jquery.min.js"></script>
	    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	    <!-- Core plugin JavaScript-->
	    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	
	    <!-- Custom scripts for all pages-->
	    <script src="js/sb-admin-2.min.js"></script>	    
    </body>
</html>
