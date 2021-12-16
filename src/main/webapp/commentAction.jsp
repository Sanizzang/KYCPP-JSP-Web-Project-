<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
</head>
<body>
	<%
		String email = null;
		if(session.getAttribute("email") != null){
			email = (String) session.getAttribute("email");
		}
		if(email == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		else{
			if(request.getParameter("comment") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 입력하세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				CommentDAO commentDAO = new CommentDAO();
				int result = commentDAO.write(Integer.parseInt(request.getParameter("boardId")), email, request.getParameter("comment"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>