<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />
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
			if(board.getTitle() == null || board.getContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.write(board.getTitle(), email, board.getContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기를 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>