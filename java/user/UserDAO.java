package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;
import util.SHA256;

public class UserDAO {
	private Connection conn = DatabaseUtil.getConnection();
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public int login(String email, String password) {
		String SQL = "SELECT password FROM user WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(SHA256.encodeSHA256(password)))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int register(User user) {
		String SQL = "INSERT INTO user(name, major, studentId, email, password) VALUES(?, ?, ?, ?, ?)";
		try {
			String hash = SHA256.encodeSHA256(user.getPassword());
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getMajor());
			pstmt.setString(3, user.getStudentId());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, hash);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public User getUser(String email) {
		String SQL = "SELECT * FROM user WHERE email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setId(rs.getInt(1));
				user.setEmail(rs.getString(2));
				user.setPassword(rs.getString(3));
				user.setName(rs.getString(4));
				user.setMajor(rs.getString(5));
				user.setStudentId(rs.getString(6));
				user.setGender(rs.getString(7));
				user.setBiography(rs.getString(8));
				user.setProfilePicture(rs.getString(9));
				
				return user;
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getName(String email) {
		String SQL = "SELECT name FROM user WHERE email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getEmail(String name, String studentId) {
		String SQL = "SELECT email FROM user WHERE name = ? AND studentId = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, studentId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getProfilePicture(String email) {
		String SQL = "SELECT profilePicture FROM user WHERE email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String name, String major, String studentId, String gender, String biography, String profilePicture,String email) {
		String SQL = "UPDATE user SET name=?, major=?, studentId=?, gender=?, biography=?, profilePicture=? WHERE email=?";
		try {
			if(profilePicture != null) {
				String fileExt = profilePicture.substring(profilePicture.lastIndexOf('.') + 1).toLowerCase();
				
				Boolean checkResult = false;
				String allowExt[] = {"jpg", "gif", "png", "jpeg"};
				
				for(int i = 0; i< allowExt.length;i++) {
					if(allowExt[i].equals(fileExt)) {
						checkResult = true;
						break;
					}
				}
				
				if(profilePicture.contains(";")) {
					checkResult = false;
				}
				
				if(!checkResult) {
					return -2;
				}
			} else {
				profilePicture = getProfilePicture(email);
			}
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, major);
			pstmt.setString(3, studentId);
			pstmt.setString(4, gender);
			pstmt.setString(5, biography);
			pstmt.setString(6, profilePicture);
			pstmt.setString(7, email);
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int changePassword(String email, String newPassword) {
		String SQL = "UPDATE user SET password=? WHERE email=?";
		try {
			String hash = SHA256.encodeSHA256(newPassword);
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, hash);
			pstmt.setString(2, email);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String validateEmail(String email, String password) {
		String SQL = "SELECT email FROM user WHERE email=? AND password=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
