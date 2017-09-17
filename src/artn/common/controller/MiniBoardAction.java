package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MiniBoardAction extends DefaultAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4418753896768414162L;
	
	public String miniBoard(String boardNo, int rowlimit) {
		return miniBoard("product-board-all", boardNo, rowlimit);
	}
	public String miniBoard(String boardQuery, String boardNo, int rowlimit) {
		String[] saBoardMiniNo = (boardNo != null)? boardNo.split(",") : new String[]{"1"};
		int iBoardMiniCount = saBoardMiniNo.length;
		if(user() == null){
			getParams().put("Guest", "Guest");
			getParams().put("id_user", "Guest");
			if(getArrayParams().containsKey("pay_phone") == true){
				valid.appendAndPutToMap(getParams(), getArrayParams(), "pay_phone", "-");
				valid.checkEmptyValue(getParams(), "", "pay_mail");
				session().put("pay_user_name", getParams().get("pay_user_name"));
				session().put("pay_phone", getParams().get("pay_phone"));
				session().put("pay_mail", getParams().get("pay_mail"));
			}
			
			if(session().containsKey("pay_user_name") == true){
				getParams().put("user_name", session().get("pay_user_name"));
				getParams().put("guest_phone", session().get("pay_phone"));
				getParams().put("guest_mail", session().get("pay_mail"));
			}
		}else if(getAuth().getIsAdmin() == false){
			getParams().put("id_user", user().getId());
		}
		getParams().put("rowlimit", rowlimit);
		
		if (subIsNull == null){
			subRowCount = new HashMap<String, Integer>();
			subIsNull = new HashMap<String, Boolean>();
			subResult = new HashMap< String, List<Map<String, Object>> >();
		}
		dbm().open();
		for(int i = 0; i < iBoardMiniCount; i++){
			getParams().put("board_no", saBoardMiniNo[i]);
			subResult.put("mini" + i, dbm().selectNonOpen(boardQuery, getParams(), true));
		}
		dbm().close();
		return "";
	}
	
}
