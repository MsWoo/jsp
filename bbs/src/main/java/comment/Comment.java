package comment;

public class Comment {
	private int id;
	private int bbsID;
	private String writer;
	private String content;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBbsId() {
		return bbsID;
	}
	public void setBbsId(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}