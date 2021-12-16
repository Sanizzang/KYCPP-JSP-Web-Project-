package room;

public class Room {
	private int roomNum;
	private String userEmail;
	private int usageTime;
	private int numberOfusers;
	private String purposeOfuse;
	private String representative;
	private String startTime;
	
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public int getUsageTime() {
		return usageTime;
	}
	public void setUsageTime (int usageTime) {
		this.usageTime = usageTime;
	}
	public int getNumberOfusers() {
		return numberOfusers;
	}
	public void setNumberOfusers(int numberOfusers) {
		this.numberOfusers = numberOfusers;
	}
	public String getPurposeOfuse() {
		return purposeOfuse;
	}
	public void setPurposeOfuse(String purposeOfuse) {
		this.purposeOfuse = purposeOfuse;
	}
	public String getRepresentative() {
		return representative;
	}
	public void setRepresentative(String representative) {
		this.representative = representative;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	
}
