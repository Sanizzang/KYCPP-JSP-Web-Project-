package message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class MessageDAO {
	private Connection conn = DatabaseUtil.getConnection();
	private ResultSet rs;
	
	public ArrayList<Message> getMessage(String to_Email) {
		String SQL = "SELECT * FROM message WHERE(from_Email, time) in (SELECT from_Email, max(time) as time FROM message WHERE to_Email=? GROUP BY from_Email) ORDER BY time DESC";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, to_Email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Message message = new Message();
				message.setId(rs.getInt(1));
				message.setFrom_Email(rs.getString(2));
				message.setTo_Email(rs.getString(3));
				message.setContent(rs.getString(4));
				message.setTime(rs.getString(5));
				list.add(message);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Message> getMessageByFrom_Email(String from_Email, String to_Email){
		String SQL = "SELECT * FROM message WHERE((from_Email = ? AND to_Email = ?) OR (from_Email = ? AND to_Email = ?)) ORDER BY time DESC";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, from_Email);
			pstmt.setString(2, to_Email);
			pstmt.setString(3, to_Email);
			pstmt.setString(4, from_Email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Message message = new Message();
				message.setId(rs.getInt(1));
				message.setFrom_Email(rs.getString(2));
				message.setTo_Email(rs.getString(3));
				message.setContent(rs.getString(4));
				message.setTime(rs.getString(5));
				list.add(message);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int send(String from_Email, String to_Email, String content) {
		String SQL = "INSERT INTO message(from_Email, to_Email, content, time) VALUES(?, ?, ?, NOW())";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, from_Email);
			pstmt.setString(2, to_Email);
			pstmt.setString(3, content);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
