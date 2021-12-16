<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="name" />
<jsp:setProperty name="user" property="major" />
<jsp:setProperty name="user" property="studentId" />
<jsp:setProperty name="user" property="email" />
<jsp:setProperty name="user" property="password" />
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
		if(email != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		if(user.getName() == null || user.getMajor() == null || user.getStudentId() == null || user.getEmail() == null || user.getPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (!user.getPassword().equals(request.getParameter("passwordConfirm"))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력한 비밀번호가 다릅니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.register(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입에 실패하셨습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				session.setAttribute("email", user.getEmail());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}
		}		
	%>
</body>
</html>