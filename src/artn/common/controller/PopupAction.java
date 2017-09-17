package artn.common.controller;

import java.util.HashMap;
import java.util.Map;

import artn.common.FileNameChangeMode;

public class PopupAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5944290827268057424L;

	@Override
	public String list() throws Exception {
		doList("popup-all");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		doShow("popup-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		valid.checkEmptyValue(getParams(), 200, "width", "height");		
		getShowData().put("popup_opt", 0x1 + 0x2 + 0x1000);
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		valid.checkEmptyValue(getParams(), 0, "popup_seq", "id_group", "id_event", "id_product", "location_x", "location_y");
		valid.checkEmptyValue(getParams(), 200, "width", "height");
		valid.checkEmptyValue(getParams(), "", "goto_url", "outer_popup_url");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload", "date_update", "date_start", "date_end");
		valid.checkEmptyValue(getParams(), "이름 없는 팝업 : " + util.getToday(), "title");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "popup_opt");
		valid.checkFileExists(getParams(), "file_img_popup");
		
		/*if (hasFileParams() == true){
			saveFileToAuto( this.getDownloadPath() + "/upload/popup/" ,FileNameChangeMode.parentheses );
		}*/
		
		doEdit("popup-modify");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		doEdit("popup-delete");
		return SUCCESS;
	}
	//artn.common.popupMax
	public String popup() throws Exception {
		
		return SUCCESS;
	}
	
	public String nonOpen() throws Exception {		
		Map<Integer, Boolean> mNonOpen = getNonOpen();
		
		mNonOpen.put(Integer.parseInt(getParams().get("id").toString()), true);		
		session().put("nonOpen", mNonOpen);
		
		return successOrJsonShow();
	}
	
	@SuppressWarnings("unchecked")
	public Map<Integer, Boolean> getNonOpen() {
		Map<Integer, Boolean> mNonOpen = null;	
		
		if(session().containsKey("nonOpen") == true){
			return (Map<Integer, Boolean>)session().get("nonOpen");
		} else{
			mNonOpen = new HashMap<Integer, Boolean>();
			session().put("nonOpen", mNonOpen);
			return mNonOpen;
		}
		
	}
}