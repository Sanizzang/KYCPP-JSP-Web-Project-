package message;

public class Message {
	private int id;
	private String from_Email;
	private String to_Email;
	private String content;
	private String time;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFrom_Email() {
		return from_Email;
	}
	public void setFrom_Email(String from_Email) {
		this.from_Email = from_Email;
	}
	public String getTo_Email() {
		return to_Email;
	}
	public void setTo_Email(String to_Email) {
		this.to_Email = to_Email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
