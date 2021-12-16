<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="message.MessageDAO"%>
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
			if(request.getParameter("to_Email") == null && request.getParameter("content") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(email.equals(request.getParameter("to_Email"))){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('본인에게는 메세지를 보내실 수 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				MessageDAO messageDAO = new MessageDAO();
				int result = messageDAO.send(email, request.getParameter("to_Email"), request.getParameter("content"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('메세지 전송에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('메세지 전송을 성공했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>