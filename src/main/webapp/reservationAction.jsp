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
			int result = roomDAO.reserve(Integer.parseInt(request.getParameter("roomNum")), email, Integer.parseInt(request.getParameter("usageTime")), Integer.parseInt(request.getParameter("numberOfusers")), request.getParameter("purposeOfuse"), userDAO.getName(email));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('예약에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('예약하셨습니다.')");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>