package artn.common.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

import artn.common.FileNameChangeMode;
import artn.common.manager.BoardManager;
import artn.common.model.BoardInfo;

public class BoardAction extends AbsUploadActionController {

	/**
	 * 
	 */	
	private static final long serialVersionUID = 4386826714292632394L;
	private InputStream attachDeleteResult;
	private BoardManager boardManager;
	private BoardInfo boardInfo;
	
	/**/		
	
	
	/**/
	@Override
	public String list() throws Exception {
		valid.checkEmptyValue(getParams(), 1, "board_no");
		getParams().put("rowlimit", getBoardInfo().getRowLimit());
		doList("board-all");
		
		if (getListData().size() > 0 && getBoardInfo().getView().equals("guest")){ 
			int iLen = getListData().size();			
			String[] saPassword = new String[ iLen ]; 
			Map<String, Object> mData = null;
			
			for(int i = 0; i < iLen; i++){
			mData = getListData().get(i);			
			saPassword[i] = mData.get("password").toString();
			}
			session().put("GuestPassword_list", saPassword);
		}
		return successOrView();
	}

	@Override
	public String show() throws Exception {
		/*if( (session().containsKey("GuestPassword_list") == false) && (getBoardInfo().getView().equals("guest")) ){
			return MAIN;
		}
		*/		
		doShow("board-single");
		
		try{
		if( (getAuth().getIsAdmin() == false) && (getBoardInfo().getView().equals("guest") == true) ){			
			if(session().get("check_list_password").equals(getShowData().get("password").toString()) == false){				
				session().remove("check_list_password");
				return MAIN;
			}
		}		
		}catch(Exception e){
			return MAIN;
		}
		session().put("GuestPassword",getShowData().get("password"));
		doShowSub("commentList", "board-comment-all", "fileList","board-attach-list");		
//		if(mParam.get("view").toString().equals("file") == true){
//			doList("board-attach-list");
//		}
		//FIXME:사용자가 같을 시 연속 카운팅 안되도록 구현해야 함. - 2013.08.08 by thkim
		doEdit("board-counting");
		return successOrView();
	}

	@Override
	public String edit() throws Exception {
		show();
		session().remove("GuestPassword_list");
		if((getBoardInfo().getView().equals("guest")) && (session().containsKey("check_list_password") == false) && (getAuth().getIsAdmin() == false)){
			return MAIN;
		}
		return successOrView();
	}

	@Override
	public String write() throws Exception {
		if (getParams().containsKey("re") == true){
			doShow("board-single");
			//getShowData().put("subject", "re::" + getParams().get("subject"));
			getShowData().put("contents", "<p><br/></p><hr/>" + getShowData().get("contents"));			
		}
		return successOrView();
	}

	@Override
	public String modify() throws Exception {
		Map<String, Object> mParam = getParams();		
		
		valid.checkEmptyValue(mParam, util.getNow(), "date_upload");		
		valid.checkEmptyValue(mParam, 0, "board_no", "view_count", "good_count", "bad_count", "comment_count", "depth", "size_file", "down_count");
		valid.checkEmptyValue(mParam, 1, "seq");		
		valid.checkEmptyValue(mParam, "", "keywords", "category", "password");
		valid.checkEmptyValue(mParam, "Guest", "id_user");
	
		valid.mergeIntValuesToMap(mParam, getArrayParams(), "status");
		//valid.checkFileExists(mParam, "file_img");
		
		valid.extractFirstImgSrc(mParam, "contents", "file_img");
		valid.removeMaliciousCode(mParam, "contents");
		/*mParam.put("contents", sContents);
		System.out.println("======="+sContents);*/
		valid.removeTags(mParam, "contents", "contents_summary");
		
		// 이미지 업로드 여부를 상태값에 저장 시 사용 (현재는 필요 없을 듯)
//		if (mParam.get("contents").toString().contains("<img")){
//			mParam.put("status", ((Integer)mParam.get("status")) | 0x10);
//		}
		
		dbm().open();
		
		if((mParam.containsKey("id") == true) && (mParam.containsKey("re") == false)){
			dbm().updateNonCommit("board-modify", mParam);
			attachFiles("board-attach-modify");
		} else if((mParam.containsKey("id") == false) && (mParam.containsKey("re") == false)){		
			dbm().updateNonCommit("board-write", mParam);
			attachFiles("board-attach-write");
		} else if(mParam.get("re").toString().equals("re")){
			if(Integer.parseInt(mParam.get("depth").toString()) > 0){
				dbm().updateNonCommit("board-reply-update", mParam);
				mParam.put("id_board", mParam.get("id"));
				mParam.putAll(dbm().selectOneNonOpen("board-reply-re", mParam));
				dbm().insertNonCommit("board-reply-sub", mParam);
				dbm().selectNonOpen("board-attach-list-sub", mParam);
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				list = dbm().selectNonOpen("board-attach-list-sub", mParam);
				for(int i=0 ; i < list.size(); i++){
					dbm().updateNonCommit("board-attach-re-modify", list.get(i));
				}
				attachFiles("board-attach-modify");
			}else{
			mParam.putAll(dbm().selectOneNonOpen("board-reply", mParam));
			dbm().insertNonCommit("board-reply-sub", mParam);
			}
		}
		
		dbm().commit();
		dbm().close();
		if( (getAuth().getIsAdmin() == false) && (getParams().get("board_no").equals("4") == true || getParams().get("board_no").equals("5") == true)){
			return MAIN;
		}
		return successOrView();
	}
	
	protected void attachFiles(String queryKey) throws Exception{
		if(hasFileParams() == true){
			saveFileToAuto(this.getDownloadPath() + "/upload/board/", "", FileNameChangeMode.parentheses);
			
			if (getArrayParams().containsKey("file_name") == true){
				doEditSub(queryKey, "", "file_name", false);
			}
			else{
				dbm().insertNonCommit(queryKey, getParams());
			}
		}
	}

	@Override
	public String delete() throws Exception {
		//FIXME:현재 다중 삭제 까지 가능하며, 댓글달린 문서 삭제 시 댓글 까지 삭제되도록 구현 해야함.		
		try{
			if(getAuth().getIsAdmin() == false){			
				if(session().containsKey("boardPasswordConfirm") == false ){				
					return MAIN;
				}
			}
		}catch(Exception e){
			return MAIN;
		}		
		doEditSub("board-delete", "board-delete", "id");		
		session().remove("boardPasswordConfirm");
		
		return successOrView();
	}
	
	public String commentDelete() throws Exception{
		doEdit("board-comment-delete");
		doEdit("board-comment-delete-count");
		return successOrView();
	}
	
	public String commentWrite() throws Exception{
		Map<String, Object> mParam = getParams();
		
		valid.checkEmptyValue(mParam, util.getNow(), "date_update");
		valid.checkEmptyValue(mParam, 0, "seq", "depth", "status", "good_count", "bad_count", "comment_id", "id" );
		valid.checkEmptyValue(mParam, "",  "user_img", "user_ip");
		valid.checkEmptyValue(mParam, "Guest","id_user");
		valid.replaceCRLFToBRTags(mParam, "comment");
		valid.removeMaliciousCode(mParam, "comment");
		
		dbm().open();
		
		mParam.putAll(dbm().selectOneNonOpen("board-comment-max", mParam));
		dbm().insertNonCommit("board-comment-write", mParam);
		dbm().updateNonCommit("board-comment-count", mParam);
		
		dbm().commit();
		dbm().close();
		
		return successOrView();
	}
	
	public String commentReply() throws Exception{
		Map<String, Object> mParam = getParams();
		
		valid.checkEmptyValue(mParam, util.getNow(), "date_update");
		valid.checkEmptyValue(mParam, 0, "seq", "depth", "status", "good_count", "bad_count", "id" );
		valid.checkEmptyValue(mParam, "",  "user_img", "user_ip");
		valid.checkEmptyValue(mParam, "guest",  "id_user");
		valid.replaceCRLFToBRTags(mParam, "comment");	
		valid.removeMaliciousCode(mParam, "comment");
		
		dbm().open();
		
		mParam.putAll(dbm().selectOneNonOpen("board-comment-reply", mParam));
		dbm().updateNonCommit("board-comment-update", mParam);		
		mParam.put("depth", Integer.parseInt(mParam.get("depth").toString())+1);
		dbm().insertNonCommit("board-comment-write", mParam);
		
		dbm().commit();
		dbm().close();
		
		return successOrView();
	}
	
	public String commentModify() throws Exception{
		Map<String, Object> mParam = getParams();
		
		valid.replaceCRLFToBRTags(mParam, "comment");
		
		doEdit("board-comment-modify");
		return successOrView();
	}
	
	public String attachDelete() throws Exception{
		try{
			doEdit("board-attach-delete");
//			dbm().open();
//			dbm().updateNonCommit("board-attach-delete", getParams());
			attachDeleteResult = new ByteArrayInputStream("1|삭제 성공".getBytes());
//			
//			if (getParams().containsKey("server_file_size") == true){
//				int iSize = Integer.parseInt( getParams().get("server_file_size").toString() );
//				
//				if (iSize < 2){
//					getParams().put("bitOper", "&");
//					getParams().put("bitValue", 0x8);
//					dbm().updateNonCommit("board-status-modify", getParams());
//				}
//			}
		}
		catch(Exception ex){
			attachDeleteResult = new ByteArrayInputStream("0|삭제 실패".getBytes());
		}
//		
//		dbm().commit();
//		dbm().close();
		
		return SUCCESS;
	}
	
	public InputStream getAttachDeleteResult(){
		return attachDeleteResult;
	}
	
	public boolean getHasRe() {
		return getParams().containsKey("re");
	}
	
	protected String successOrView(){
		String sRet = successOrJsonShow();
		String sView = getBoardInfo().getView();
		
		if (sRet.equals(JSONSHOW)){
			return JSONSHOW;
		}
		if (sView.isEmpty() == true){
			return SUCCESS;
		}		
		return sView;
	}
	
	public BoardInfo getBoardInfo(){
		if (boardInfo == null){
			boardInfo = getBoardManager().get(getParams().get("board_no"));
		}
		return this.boardInfo;
	}
	
	public BoardManager getBoardManager(){
		if (boardManager == null){
			boardManager = BoardManager.getInstanceFromSession(session());
		}
		
		return this.boardManager;
	}
	
	public String authBoardList() {		
			getParams().put("id_group", 0);
			doShowSub("userAuthList", "user-auth-all");
			Map<String, Object> mGuest = util.createMap();
			mGuest.put("auth_user", "0");
			mGuest.put("auth_user_kor", "손님");		
			getSubData().get("userAuthList").add(mGuest);
		if(getAuth().getIsAdmin() == true) {
			return SUCCESS;
		}		
		return ERROR_AUTH;
	}
	
	public String authBoardModify() {		
		// 게시판 수정 시 사이트의 게시판이 한가지 이하일 경우 발생될 수 있는 예외 처리 추가 - 2013.10.12 by jhson
		if (getArrayParams().containsKey("boardNo") == true){
			getBoardManager().xmlModify(getArrayParams().get("boardNo"),
					getArrayParams().get("name"),
					getArrayParams().get("view"),
					getArrayParams().get("contentsCode"),
					getArrayParams().get("authList"),
					getArrayParams().get("authShow"),
					getArrayParams().get("authModify"),
					getArrayParams().get("authDelete"),
					getArrayParams().get("rowLimit"));
		}
		else if (getParams().containsKey("boardNo") == true){
			getBoardManager().xmlModify(getParams());
		}
		return SUCCESS;
	}
	
	public String passwordCheck() throws Exception{
		if(getParams().get("password").equals(session().get("GuestPassword"))){
			setResponse("1|성공");
			session().remove("GuestPassword");
			session().put("boardPasswordConfirm", true);
			return TEXT_RESPONSE;
		} 
		setResponse("0|비밀번호가 맞지 않습니다.");
		return TEXT_RESPONSE;
	}
	
	public String passwordCheck_list() throws Exception{
		 String[] saPW = (String[])session().get("GuestPassword_list");
		 int rowIndex = Integer.parseInt(getParams().get("row_index").toString());
		 session().put("check_list_password",saPW[rowIndex]);
		 if(getParams().get("password_list").equals(saPW[rowIndex])){
			setResponse("1|성공");
			session().put("boardPasswordConfirmList", true);
			return TEXT_RESPONSE;
		 }
		 	setResponse("0|비밀번호가 맞지 않습니다.");
			return TEXT_RESPONSE;

	}
	
/*	public static String checkXSS(String value) {   
		Pattern.compile(regex, flags)
	}*/
	
	
	
}
