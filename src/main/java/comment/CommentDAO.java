package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.UserDAO;
import util.DatabaseUtil;

public class CommentDAO {
	private Connection conn = DatabaseUtil.getConnection();
	private ResultSet rs;
	
	public ArrayList<Comment> getComments(int boardId, int pageNumber) {
		String SQL = "SELECT * FROM comment WHERE id <= ? AND boardId=? ORDER BY id DESC LIMIT 10";
		ArrayList<Comment> list = new ArrayList<Comment>();
		UserDAO ud = new UserDAO();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getCommentPosition(boardId) - (pageNumber - 1) * 10);
			pstmt.setInt(2, boardId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setId(rs.getInt(1));
				comment.setBoardId(rs.getInt(2));
				comment.setUserEmail(rs.getString(3));
				comment.setUserName(ud.getName(rs.getString(3)));
				comment.setComment(rs.getString(4));
				comment.setDate(rs.getString(5));
				list.add(comment);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Comment> getUserComments(String email){
		String SQL = "SELECT boardId, comment, date FROM comment WHERE userEmail = ?";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setBoardId(rs.getInt(1));
				comment.setComment(rs.getString(2));
				comment.setDate(rs.getString(3));
				list.add(comment);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public int write(int boardId, String userEmail, String comment) {
		String SQL = "INSERT INTO comment(boardId, userEmail, comment, date) VALUES(?, ?, ?, ?)";
		try {
			String sComment = comment.replaceAll("<", "&lt;");
			sComment = sComment.replaceAll(">", "&gt;");
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, sComment);
			pstmt.setString(4, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int commentId) {
		String SQL = "DELETE FROM comment WHERE id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentId);
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		try {
			Statement stmt = conn.createStatement();
			SQL = "SET @cnt = 0";
			stmt.executeUpdate(SQL);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			Statement stmt = conn.createStatement();
			SQL = "UPDATE comment SET comment.id = @cnt:=@cnt+1";
			stmt.executeUpdate(SQL);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			SQL = "ALTER TABLE comment Auto_increment=?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getCommentNum() + 1);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public boolean nextPage(int boardId, int pageNumber) {
		String SQL = "SELECT * FROM comment WHERE id < ? AND boardId = ? ORDER BY id DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getCommentPosition(boardId) - (pageNumber - 1) * 10);
			pstmt.setInt(2, boardId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int getCommentNum() {
		String SQL = "SELECT COUNT(*) as cnt FROM comment";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int getCommentPosition(int boardId) {
		String SQL = "SELECT id FROM comment WHERE boardId=? ORDER BY id DESC LIMIT 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
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
		return "";
	}
}
