<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
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
</head>
<body>
    <%
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		int boardId = Integer.parseInt(request.getParameter("boardId"));
	%>	
    
    <div class="container p-5" id="comment">
    	<div class="row">
    		<table class="table table-stripped" style="text-align: center; border: 1px solid #dddddd">
    			<thead>
    				<tr>
    					<th colspan="4" style="text-align: left;">댓글</th>
    				</tr>
    			</thead>
    			<tbody>
    				<%
    					CommentDAO commentDAO = new CommentDAO();
    					ArrayList<Comment> list = commentDAO.getComments(boardId, pageNumber);
    					for(int i = 0;i < list.size();i++){
    				%>
    				<tr>
    					<td><a href="viewProfile.jsp?userEmail=<%=list.get(i).getUserEmail()%>"><%= list.get(i).getUserName() %></a></td>
    					<td><%= list.get(i).getComment() %></td>
    					<td>
    						<%= list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13) + "시" + list.get(i).getDate().substring(14, 16) + "분" %>
    					</td>
    					<td>
    					    <%
    							if(list.get(i).getUserEmail().equals(request.getParameter("email"))){
    						%>
    						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?id=<%= list.get(i).getId() %>" class="btn btn-danger">삭제</a>
    						<%
    							}
    						%>
    					</td>
    				</tr>
    				<%
    					}
    				%>
    			</tbody>
    		</table>
    		<%
    			if(pageNumber != 1){
    		%>
    		<a href="comment.jsp?pageNumber=<%=pageNumber - 1%>&&boardId=<%= boardId %>" class="btn btn-success btn-arraw-left mr-2">이전</a>
    		<%
    			} if(commentDAO.nextPage(boardId, pageNumber + 1)){
    		%>
    		<a href="comment.jsp?pageNumber=<%=pageNumber + 1%>&&boardId=<%= boardId %>" class="btn btn-success btn-arraw-left mr-2">다음</a>
    		<%
    			} 
    		%>
			<a href="view.jsp?id=<%= boardId %>" class="btn btn-primary btn-arraw-left mr-2">게시판 보기</a>
    	</div>
    	
    	<form class="row mt-3" method="post" action="commentAction.jsp?boardId=<%= boardId%>">
    			<input type="text" class="form-control col-md-11" placeholder="댓글 입력" name="comment" maxlength="50">
    			<input type="submit" class="btn btn-primary col-md-1" value="등록">
    	</form> 
    </div>


</body>
</html>