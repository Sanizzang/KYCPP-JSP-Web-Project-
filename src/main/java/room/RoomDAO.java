package room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class RoomDAO {
	private Connection conn = DatabaseUtil.getConnection();
	private ResultSet rs;
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public Room getRoom(int roomNum) {
		String SQL = "SELECT * FROM room WHERE roomNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Room room = new Room();
				room.setRoomNum(rs.getInt(1));
				room.setUserEmail(rs.getString(2));
				room.setUsageTime(rs.getInt(3));
				room.setNumberOfusers(rs.getInt(4));
				room.setPurposeOfuse(rs.getString(5));
				room.setRepresentative(rs.getString(6));
				room.setStartTime(rs.getString(7));
				return room;
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int reserve(int roomNum, String userEmail, int usageTime, int numberOfusers, String purposeOfuse, String representative) {
		String SQL = "INSERT INTO room(roomNum, userEmail, usageTime, numberOfusers, purposeOfuse, representative, startTime) VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNum);
			pstmt.setString(2, userEmail);
			pstmt.setInt(3, usageTime);
			pstmt.setInt(4, numberOfusers);
			pstmt.setString(5, purposeOfuse);
			pstmt.setString(6, representative);
			pstmt.setString(7, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int checkOut(String userEmail) {
		String SQL = "DELETE FROM room WHERE userEmail=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userEmail);
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public boolean isMyRoom(int roomNum, String userEmail) {
		String SQL = "SELECT userEmail FROM room WHERE roomNum=? AND userEmail=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNum);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next() && rs.getString(1).equals(userEmail)) {
				return true;
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
