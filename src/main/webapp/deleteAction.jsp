<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.Board"%>
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
		else{
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.delete(boardId);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'board.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>