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
    %>
    <div class="container">
    	<div class="row">
			<table class="table table-stripped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= board.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= board.getEmail() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= board.getDate().substring(0, 11) + board.getDate().substring(11, 13) + "시" + board.getDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="text-align: left; overflow-y: auto; width: auto; height: 300px"><%= board.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="board.jsp" class="btn btn-primary mr-3 mb-5">목록</a>
			<%
				if(email != null && email.equals(board.getEmail())){
					
			%>
				<a href="update.jsp?id=<%= boardId %>" class="btn btn-primary mr-1 mb-5">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?id=<%= boardId %>" class="btn btn-danger mb-5">삭제</a>
			<%
				}
			%>
		</div>	
    </div>
    
    <jsp:include page="comment.jsp">
		<jsp:param name="boardId" value="<%= boardId %>" />
		<jsp:param name="email" value="<%= email %>" />
	</jsp:include>
    
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