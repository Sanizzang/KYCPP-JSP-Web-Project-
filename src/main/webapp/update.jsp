<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
		type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="./header.jsp" %>
    <%
    	if(email == null){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('로그인을 하세요.')");
    		script.println("location.href = 'login.jsp'");
    		script.println("</script>");
    	}
        int boardId = 0;
    	if(request.getParameter("id") != null){
    			boardId = Integer.parseInt(request.getParameter("id"));
    	}
    	if(boardId == 0){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('유효하지 않은 글입니다.')");
    		script.println("location.href = 'bbs.jsp'");
    		script.println("</script>");
    	}
    	Board board = new BoardDAO().getPost(boardId);
    	if(!email.equals(board.getEmail())){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('권한이 없습니다.')");
    		script.println("location.href = 'login.jsp'");
    		script.println("</script>");
    	}
    %>
    <div class="container">
    	<div class="row">
	    	<form class="col-12" method="post" action="updateAction.jsp?id=<%= boardId %>">
				<table class="table table-stripped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="<%= board.getTitle() %>">
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px"><%= board.getContent() %></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary mb-5" value="글수정">
			</form>
    	</div>	
    </div>
    
    <%@ include file="./footer.jsp" %>

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