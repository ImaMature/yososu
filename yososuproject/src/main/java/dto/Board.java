package dto;

public class Board {

	private int b_no;
    private String b_password;
    private String b_title;
    private String b_contents;
    private String b_writer;
    private String b_createdDate;
    private int b_count;
    
    public Board() {}
    
	public Board(int b_no, String b_password, String b_title, String b_contents, String b_writer, String b_createdDate,
			int b_count) {
		this.b_no = b_no;
		this.b_password = b_password;
		this.b_title = b_title;
		this.b_contents = b_contents;
		this.b_writer = b_writer;
		this.b_createdDate = b_createdDate;
		this.b_count = b_count;
	}

	//글 쓰기
	public Board(String b_title, String b_password , String b_contents, String b_writer) {
		this.b_password = b_password;
		this.b_title = b_title;
		this.b_contents = b_contents;
		this.b_writer = b_writer;
	}
	
	
	

	public int getB_no() {
		return b_no;
	}



	public void setB_no(int b_no) {
		this.b_no = b_no;
	}


	public String getB_password() {
		return b_password;
	}


	public void setB_password(String b_password) {
		this.b_password = b_password;
	}


	public String getB_title() {
		return b_title;
	}


	public void setB_title(String b_title) {
		this.b_title = b_title;
	}


	public String getB_contents() {
		return b_contents;
	}


	public void setB_contents(String b_contents) {
		this.b_contents = b_contents;
	}


	public String getB_writer() {
		return b_writer;
	}


	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}


	public String getB_createdDate() {
		return b_createdDate;
	}


	public void setB_createdDate(String b_createdDate) {
		this.b_createdDate = b_createdDate;
	}


	public int getB_count() {
		return b_count;
	}


	public void setB_count(int b_count) {
		this.b_count = b_count;
	}
    
	
    
}
