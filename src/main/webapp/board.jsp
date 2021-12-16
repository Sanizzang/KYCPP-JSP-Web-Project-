<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.Board"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
</head>
<body>
	<%@ include file="./header.jsp" %>
	<%
		int pageNumber = 1;
		String searchType = null;
		String search = null;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		if(request.getParameter("searchType") != null){
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search") != null){
			search = request.getParameter("search");
		}
	%>	
    
    <div class="container p-5">
    	<div class="mb-2">
	    	<form class="form-inline my-2 my-lg-0" method="get" action="board.jsp">
				<select name="searchType" class="form-control my-2 my-sm-0 mr-2">
					<option value="title">제목</option>
					<option value="content">본문</option>
				</select> 
				<input type="text" class="form-control mr-sm-2" placeholder="검색할 내용" name="search" maxlength="20">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
	    	</form>
    	</div>
    	<div class="row"> 
    	
    		<table class="table table-stripped" style="text-align: center; border: 1px solid #dddddd">
    			<thead>
    				<tr>
    					<th style="background-color: #f8f9fd; text-align: center;">번호</th>
    					<th style="background-color: #f8f9fd; text-align: center;">제목</th>
    					<th style="background-color: #f8f9fd; text-align: center;">작성자</th>
    					<th style="background-color: #f8f9fd; text-align: center;">작성일</th>
    				</tr>
    			</thead>
    			<tbody>
    				<%
    					BoardDAO boardDAO = new BoardDAO();
    					ArrayList<Board> list = null;
    					if(searchType != null && search != null){
    						list = boardDAO.search(searchType, search, pageNumber);
    					}
    					else{
    						list = boardDAO.getList(pageNumber);
    					}
    					for(int i = 0;i < list.size();i++){
    				%>
    				<tr>
    					<td><%= list.get(i).getId() %></td>
    					<td><a href="view.jsp?id=<%= list.get(i).getId() %>"><%= list.get(i).getTitle() %></a></td>
    					<td><%= list.get(i).getEmail() %></td>
    					<td><%= list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13) + "시" + list.get(i).getDate().substring(14, 16) + "분" %></td>
    				</tr>
    				<%
    					}
    				%>
    			</tbody>
    		</table>
    		<%
    			if(pageNumber != 1){
    		%>
    		<a href="board.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left mr-2">이전</a>
    		<%
    			} if(boardDAO.nextPage(pageNumber + 1)){
    		%>
    		<a href="board.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
    		<%
    			}
    		%>
    		<a href="write.jsp" class="btn btn-primary ml-2">글쓰기</a>
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