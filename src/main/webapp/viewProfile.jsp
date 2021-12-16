<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("utf-8");
%>
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
		user = ud.getUser(request.getParameter("userEmail"));
	%>
	<div class="container p-5">
		<div class="col" style="text-align: center">
			<img class="img-fluid rounded-circle text-center" src="img/<%= user.getProfilePicture() %>" alt="..." width="180">
			<div class="pt-2">
				이름: <%= user.getName() %>
			</div>
			<div class="pt-2">
				전공: <%= user.getMajor() %>
			</div>
			<div class="pt-2">
				학번: <%= user.getStudentId() %>
			</div>
			<div class="pt-2">
				성별: <%= user.getGender() %>
			</div>
			<div class="pt-2">
				소개: <%= user.getBiography() %>
			</div>
			<div class="pt-2">
				이메일: <%= user.getEmail() %>
			</div>
			<a class="btn btn-success mt-5" data-toggle="modal" data-target="#commentModal">댓글 보기</a>
			<%
				if(!email.equals(user.getEmail())){
			%>
			<a class="btn btn-success mt-5" data-toggle="modal" data-target="#messageModal">메세지 보내기</a>
			<%
				}
			%>
		</div>
	</div>
	
	
	
	<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="reservationModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal"><%=user.getName()%>님의 댓글</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="col">
						<table class="table table-stripped" style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th>게시물 번호</th>
									<th>댓글</th>
									<th>날짜</th>
								</tr>
							</thead>
							<tbody>
							<% 
								CommentDAO cd = new CommentDAO(); 
								ArrayList<Comment> list = cd.getUserComments(user.getEmail());
								for(int i = 0;i < list.size();i++){
							%>
								<tr>
									<td>
										<a href="view.jsp?id=<%=list.get(i).getBoardId()%>"><%= list.get(i).getBoardId() %></a>
									</td>
									<td>
										<%= list.get(i).getComment() %>
									</td>
									<td>
										<%= list.get(i).getDate().substring(0, 11) %>
									</td>
								</tr>
							<%
								}
							%>
							<tbody>
						</table>
					</div>
				</div>
			</div>	
		</div>
	</div>
	
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">메세지 전송</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body overflow-auto ">
					<form action="messageAction.jsp?to_Email=<%=user.getEmail()%>" method="post">
						<div class="form">
							<div class="form-group">
								<textarea class="form-control" name="content" rows="10"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">보내기</button>
						</div>
					</form>	
				</div>
			</div>	
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