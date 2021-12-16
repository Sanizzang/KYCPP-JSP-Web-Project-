<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="message.Message" %>
<%@ page import="message.MessageDAO" %>
<%@ page import="java.util.ArrayList" %>
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
	<%	
		String from_Email = null;
		if(request.getParameter("from_Email") != null){
			from_Email = request.getParameter("from_Email");
		}
	%>
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="p-3 mb-4">
				<div class="row mb-5">
					<h4 class="mr-5">Message</h4>
					<%
						if(from_Email != null){
					%>
					<a class="btn" data-toggle="modal" data-target="#messageModal"><i class="far fa-paper-plane fa-2x"></i></a>
					<%
						}
					%>
				</div>
				<div class="col overflow-auto" style="height: 500px; width=:600px; border:10px solid grey">
					<%
						MessageDAO md = new MessageDAO();
						ArrayList<Message> list = null;
						if(from_Email != null){
							list = md.getMessageByFrom_Email(from_Email, email);
						}
						else{
							list = md.getMessage(email);
						}
						 
						for(int i = 0;i < list.size();i++){
					%>
					<%
						if(from_Email != null){
					%>
					<div class="p-3">
					<% } else{ %>
					<div class="p-3 hover-zoom" onclick="location.href='message.jsp?from_Email=<%=list.get(i).getFrom_Email()%>'" style="cursor:pointer;">
					<% } %>
							<div class="col">
								<div class="row">
									<div>
										<h5>
										<%
											if (from_Email != null) {
										%>
											<%
												if(list.get(i).getTo_Email().equals(email)){
											%>
												받은 메세지
											<%
												} else{
											%>
												보낸 메세지
											<%
												}
											%>
										<%
											} else{
										%>
										<%= ud.getName(list.get(i).getFrom_Email()) %>
										<%
											}
										%>
										</h5>
									</div>
								</div>
								<div class="row mb-3">
									<div>
										<%= list.get(i).getTime().substring(5, 11) + list.get(i).getTime().substring(11, 16) %>
									</div>
								</div>
								<div class="row">
									<%= list.get(i).getContent() %>
								</div>
							</div>
							<hr>
					</div>
					
					<%
						}
					%>
					
				</div>
					<%
						if (from_Email != null) {
					%>
					<a href="message.jsp" class="btn btn-primary mt-3">목록</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%
		if(from_Email != null){
	%>
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
					<form action="messageAction.jsp?to_Email=<%=from_Email%>" method="post">
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
	<%
		}
	%>

	<%@ include file="./footer.jsp"%>
		
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>