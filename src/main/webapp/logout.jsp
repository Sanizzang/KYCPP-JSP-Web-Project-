<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>KYCPP</title>
</head>
<body>
	<%	
		session.invalidate();
	%>
	<script>
		alert("로그아웃 했습니다.");
		location.href="index.jsp";
	</script>
</body>
</html>