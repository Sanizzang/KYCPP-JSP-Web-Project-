<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DatabaseUtil"%>
<%@ page import="room.Room" %>
<%@ page import="room.RoomDAO" %>
<%@ page import="user.UserDAO" %>
<html>
<head>
	<title>KYCPP</title>
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
		type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>
	<%
	   Connection conn = DatabaseUtil.getConnection();
	   Statement stmt = null;
	   try {
	      String SQL = "DELETE from room WHERE startTime < DATE_SUB(now(), interval (usageTime) HOUR);";
	      stmt = conn.createStatement();
	      stmt.execute(SQL);
	   } catch(Exception e) {
	      e.printStackTrace();
	   } finally {
	      if (stmt != null)
	         stmt.close();
	      if(conn != null)
	         conn.close();
	   }
		String email = null;
		if(session.getAttribute("email") != null){
			email = (String) session.getAttribute("email");
		}
		int roomNum = Integer.parseInt(request.getParameter("roomNum"));	
		RoomDAO rd = new RoomDAO();
		Room room = rd.getRoom(roomNum);
		UserDAO ud = new UserDAO();
	%>
	<div class="col-3 p-5 col-lg-3 col-md-6 col-sm-12">
		<div class="card">
			<div class="card-header">
				[Room<%=roomNum%>]
			</div>
			<div class="card-body">
				<div class="card-text">
					<%
						if(room != null){
					%>
					<p>대표자: <a href="viewProfile.jsp?userEmail=<%= room.getUserEmail() %>"><%= room.getRepresentative() %></a></p>
					<p>퇴실 시간: <% out.println((Integer.parseInt(room.getStartTime().substring(11, 13)) + room.getUsageTime()) + " : " + room.getStartTime().substring(14, 16)); %></p>
					<p>사용 인원: <%=room.getNumberOfusers()%></p>
					<p>사용 목적: <%=room.getPurposeOfuse()%></p>
					<%
						}
					%>
				</div>
				<div class="row">
					<%
						if(room == null){
					%>
					<a class="btn btn-primary" data-toggle="modal" data-target="#reservationModal">사용</a>
					<%
						}
					%>
					
					<%
						if(email != null && room != null && rd.isMyRoom(room.getRoomNum(), email)){
					%>
					<a onclick="return confirm('퇴실하시겠습니까?')" class="btn btn-danger" href="checkoutAction.jsp">퇴실</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reservationModal" tabindex="-1" role="dialog" aria-labelledby="reservationModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">사용하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body overflow-auto ">
					<form action="reservationAction.jsp" method="post">
						<div class="form">
							<div class="form-group">
								<label>방 번호</label>
								<select name="roomNum" class="form-control">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
								</select>
							</div>
							<div class="form-group">
								<label>사용시간</label>
								<select name="usageTime" class="form-control">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
								</select>
							</div>
							<div class="form-group">
								<label>사용인원</label>
								<select name="numberOfusers" class="form-control">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
								</select>
							</div>
							<div class="form-group">
								<label>사용목적</label>
								<select name="purposeOfuse" class="form-control">
									<option value="공부">공부</option>
									<option value="회의">회의</option>
									<option value="프로젝트">프로젝트</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">사용하기</button>
						</div>
					</form>	
				</div>
			</div>	
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>
</body>
</html>

