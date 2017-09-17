package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainAction extends DefaultAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4853792307862272232L;
	
	public String miniBoard(String boardNo, int rowlimit) {
		String[] saBoardMiniNo = (boardNo != null)? boardNo.split(",") : new String[]{"1"};
		int iBoardMiniCount = saBoardMiniNo.length;
		
		getParams().put("rowlimit", rowlimit);
		
		if (subIsNull == null){
			subRowCount = new HashMap<String, Integer>();
			subIsNull = new HashMap<String, Boolean>();
			subResult = new HashMap< String, List<Map<String, Object>> >();
		}
		
		dbm().open();
		for(int i = 0; i < iBoardMiniCount; i++){
			getParams().put("board_no", saBoardMiniNo[i]);
			subResult.put("mini" + saBoardMiniNo[i], dbm().selectNonOpen("board-all-mini", getParams()));
		}
		dbm().close();
		
		return "";
	}
	
	public String execute() throws Exception{
		getParams().put("rowlimit", 100);
		
		doList("product-all");
		doShowSub("imgList", "product-img-all");
		return SUCCESS;
	}
	
}
