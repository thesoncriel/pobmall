package artn.common.model;

public class BoardInfo{
	
	private int boardNo;
	private String name;
	private String contentsCode;
	private String view;
	private int authList;
	private int authShow;
	private int authModify;
	private int authDelete;
	private int rowLimit;
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContentsCode() {
		return contentsCode;
	}
	public void setContentsCode(String contentsCode) {
		this.contentsCode = contentsCode;
	}
	public String getView() {
		return view;
	}
	public void setView(String view) {
		this.view = view;
	}
	public int getAuthList() {
		return authList;
	}
	public void setAuthList(int authList) {
		this.authList = authList;
	}
	public int getAuthShow() {
		return authShow;
	}
	public void setAuthShow(int authShow) {
		this.authShow = authShow;
	}
	public int getAuthModify() {
		return authModify;
	}
	public void setAuthModify(int authModify) {
		this.authModify = authModify;
	}
	public int getAuthDelete() {
		return authDelete;
	}
	public void setAuthDelete(int authDelete) {
		this.authDelete = authDelete;
	}
	public int getRowLimit() {
		return rowLimit;
	}
	public void setRowLimit(int rowLimit) {
		this.rowLimit = rowLimit;
	}
		

		
}
