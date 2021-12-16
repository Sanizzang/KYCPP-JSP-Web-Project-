package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import util.DatabaseUtil;

public class BoardDAO {
	private Connection conn = DatabaseUtil.getConnection();
	private ResultSet rs;
	
	public ArrayList<Board> getList(int pageNumber){
		String SQL = "SELECT * FROM board WHERE id <= ? ORDER BY id DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getPostNum() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setDate(rs.getString(4));
				board.setContent(rs.getString(5));
				list.add(board);
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Board> search(String searchType, String search, int pageNumber){
		String SQL = "";
		if(searchType.equals("title")) {
			SQL = "SELECT * FROM board WHERE id <= ? AND title LIKE ? ORDER BY id DESC LIMIT 10";
		}else {
			SQL = "SELECT * FROM board WHERE id <= ? AND content LIKE ? ORDER BY id DESC LIMIT 10";
		}
		
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getPostNum() - (pageNumber - 1) * 10);
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setDate(rs.getString(4));
				board.setContent(rs.getString(5));
				list.add(board);
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Board getPost(int boardId) {
		String SQL = "SELECT * FROM board WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setDate(rs.getString(4));
				board.setContent(rs.getString(5));
				return board;
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int write(String title, String email, String content) {
		String SQL = "INSERT INTO board(title, email, Date, content) VALUES(?, ?, ?, ?)";
		try {
			String sContent = content.replaceAll("<", "&lt;");
			sContent = sContent.replaceAll(">", "&gt;");
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, email);
			pstmt.setString(3, getDate());
			pstmt.setString(4, sContent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int update(int boardId, String title, String content) {
		String SQL = "UPDATE board SET title=?, content=? WHERE id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, boardId);
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int boardId) {
		String SQL = "DELETE FROM board WHERE id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			pstmt.executeUpdate();
		}
		catch (Exception e){
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
			SQL = "UPDATE board SET board.id = @cnt:=@cnt+1";
			stmt.executeUpdate(SQL);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			SQL = "ALTER TABLE board Auto_increment=?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getPostNum() + 1);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
	
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM board WHERE id < ? ORDER BY id DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getPostNum() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int getPostNum() {
		String SQL = "SELECT COUNT(*) as cnt FROM board";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0; // 데이터베이스 오류
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
		return ""; // 데이터베이스 오류
	}
}
