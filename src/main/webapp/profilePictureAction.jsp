<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
</head>
<body>
	<% 
		MultipartRequest multi = new MultipartRequest(request, "C:/Users/KIM-001/git/KYCPP-JSP-Project-/.git/KYCCP/src/main/webapp/img", 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String name = (String) files.nextElement();
		
		String original = multi.getOriginalFileName(name);
		
		String email = null;
		if(session.getAttribute("email") != null){
			email = (String) session.getAttribute("email");
		}
		if(email == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 사용해주시기 바랍니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}

		UserDAO userDAO = new UserDAO();
		int result = userDAO.updatePicture(original, email);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('프로필 사진 변경을 실패했습니다.')");
			script.println("location.href = 'profile.jsp'");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사진만 업로드할 수 있습니다.')");
			script.println("location.href = 'profile.jsp'");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('프로필 사진을 수정하였습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>