<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
</head>
<body>
	<%
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		if(newPassword == null || confirmPassword == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (!newPassword.equals(confirmPassword)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력한 비밀번호가 다릅니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.changePassword(request.getParameter("email"), newPassword);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호 변경에 실패하셨습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호 변경에 성공하셨습니다.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
		}		
	%>
</body>
</html>