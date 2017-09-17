package artn.common.controller;

public class ProductOptItemAction extends AbsUploadActionController{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5340371951606766400L;

	@Override
	public String list() throws Exception {
		doList("product-opt-item-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		doShow("product-opt-item-single");
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		Integer iOptItemMax = null;
		dbm().open();
		if ((getParams().containsKey("id_opt_item") == false) || (getParams().get("id_opt_item").equals("") == true) || (getParams().get("id_opt_item").equals("0") == true)){
			iOptItemMax = dbm().selectOneInteger("product-opt-item-id-max", getParams());
			if (iOptItemMax == null){
				iOptItemMax = 1;
			}
			else{
				iOptItemMax++;
			}
			getParams().put("id_opt_item", iOptItemMax);
		}
//		else if (getArrayParams().containsKey("item_seq") == true){
//			getParams().put("id_opt_item", getArrayParams().get("id_opt_item")[0]);
//		}

		valid.checkEmptyValue(getParams(), 0, "id_group");

		doEditSub("product-opt-item-modify", "product-opt-item-delete", "item_seq", false);
		
		dbm().commit();
		dbm().close();

		getShowData().put("code", 1);
		getShowData().put("message", "상품 옵션 목록 입력에 성공 하였습니다.");
		getShowData().put("id_opt_item", getParams().get("id_opt_item").toString());
		//setResponse("1|상품 옵션 목록 입력에 성공 하였습니다.|" + getParams().get("id_opt_item"));
		
		return JSONSHOW;
	}

	@Override
	public String delete() throws Exception {
		doEdit("product-opt-item-delete");
		return SUCCESS;
	}

}
