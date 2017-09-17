package artn.common.controller;

import artn.common.tag.CalendarMaker;

public class PurchaseHistoryAction extends AbsUploadActionController{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6000279454283210079L;
	private CalendarMaker clm = new CalendarMaker();
	@Override
	public String list() throws Exception {
		if(user() == null){
			return LOGIN;
		}else if(getAuth().getIsAdmin() == false){
			return ERROR_AUTH;
		}
		
		getParams().put("order", "desc");
		
		if( getParams().containsKey("status") == true){
			getParams().put("search_status",getParams().get("status"));
			if(getParams().get("search_status").equals("") == true){
				getParams().remove("search_status");
			}
		}
		
		if(getParams().containsKey("date") && ( (getParams().get("date").equals("today") == true) || (getParams().get("date").equals("1week") == true)
				|| (getParams().get("date").equals("1month") == true) || (getParams().get("date").equals("3month") == true) || (getParams().get("date").equals("6month") == true)
				|| (getParams().get("date").equals("1year") == true)) ){
			getParams().put("date",clm.dateDiff(getParams(),getParams().get("date")));
		}
		doList("purchase-history-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		doShow("purchase-history-single");
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		doEdit("purchase-history-modify");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
