<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="room.Room" %>
<%@ page import="user.UserDAO" %>
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
			RoomDAO roomDAO = new RoomDAO();
			UserDAO userDAO = new UserDAO();
			int result = roomDAO.checkOut(email);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('서버 오류')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('체크아웃 되었습니다.')");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>