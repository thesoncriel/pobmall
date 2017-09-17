package artn.common.controller;

import java.util.Map;

public class ProductBoardAction extends AbsUploadActionController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5129509561584417744L;
	@Override
	public String list() throws Exception {
		getParams().put("rowlimit", 15);
		if(user() == null && session().containsKey("pay_user_name") && getParams().containsKey("myposts") == true){
			getParams().put("Guest", "Guest");
			getParams().put("id_user", "Guest");
			getParams().put("user_name", session().get("pay_user_name"));
			getParams().put("guest_phone", session().get("pay_phone"));
			getParams().put("guest_mail", session().get("pay_mail"));
		}else if(user() != null && getAuth().getIsAdmin() == false  && getParams().containsKey("myposts") == true){
			getParams().put("id_user", user().getId());
		}
		doList("product-board-all");
		if( getParams().containsKey("myposts") == true ){
			return "exchange";
		}
		return successOrJsonList("row_number", "id", "id_user", "user_name", "subject", "category", "date_upload_fmt");
	}
	
	@Override
	public String show() throws Exception {
		doShow("product-board-single");
//		if(user() != null && getShowData().get("id_user").equals(user().getId()) == false){
		doEdit("product-board-counting");	
//		}
		return successOrJsonShow("id", "id_user", "user_name", "subject", "date_upload_fmt", "id_seller", "seller_name", "");
	}

	@Override
	public String edit() throws Exception {
		if(user() == null){
			return LOGIN;
		}
		getParams().put("aaa", "aaa");
		show();
		valid.replaceBRTagsToCRLF(getShowData(), "contents");
		valid.replaceBRTagsToCRLF(getShowData(), "contents_reply");
		if( (getParams().containsKey("myposts") == true) || (getParams().get("board_no").equals("3") == true) || (getParams().get("board_no").equals("4") == true)){
			return "exchange";
		}
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		if(getParams().containsKey("status") == true){
			if( getParams().get("status").equals("-3") == true){
				getShowData().putAll(getParams());
				getShowData().put("board_no", 3);
			}else if(getParams().get("status").equals("-4") == true){
				getShowData().putAll(getParams());
				getShowData().put("board_no", 4);
			}
			return "exchange";
		}
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if( (getParams().containsKey("contents_reply") == true) && (getParams().get("contents_reply").toString().length() > 1) == true){
			getParams().put("status", 0x40);
		}
		if(getParams().containsKey("guest_mail")){
			valid.toEmail(getParams(), getArrayParams(), "guest_mail");
		}
		valid.checkEmptyValue(getParams(), "", "contents_reply", "id_seller", "seller_name", "password", "category", "guest_phone", "guest_mail", "contents", "contents_reply");
		valid.checkEmptyValue(getParams(), 0, "view_count", "good_count", "bad_count", "status", "rating", "id_group", "id_product");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		valid.checkEmptyValue(getParams(), "Guest", "id_user");
		valid.replaceCRLFToBRTags(getParams(), "contents");
		valid.replaceCRLFToBRTags(getParams(), "contents_reply");
		dbm().open();
		dbm().updateNonCommit("product-board-modify", getParams());
//		doEdit("product-board-modify");
		if( getParams().containsKey("complete") == true ){
			getParams().put("id", getParams().get("id_product"));
			dbm().updateNonCommit("product-rating-update", getParams());
			dbm().commit();
			dbm().close();
			return MAIN;
		}
		dbm().commit();
		dbm().close();
		if( (getParams().get("board_no").equals("3") == true) || (getParams().get("board_no").equals("4") == true) ){
			return "exchange";
		}
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		doEditSub("product-board-delete","product-board-delete","id");
		if( (getParams().containsKey("myposts") == true) ){
			return "exchange";
		}
		return SUCCESS;
	}
	public String contentsReply() throws Exception{
		Map<String, Object> mParams = util.createMap();
		dbm().open();
		mParams.putAll(dbm().selectOneNonOpen("product-board-single", getParams()));
		mParams.put("contents_reply", getParams().get("contents_reply"));
		dbm().updateNonCommit("product-board-modify", mParams);
		dbm().commit();
		dbm().close();
		return SUCCESS;
	}
}
