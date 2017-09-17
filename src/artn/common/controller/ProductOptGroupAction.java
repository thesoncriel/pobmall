package artn.common.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Map;

import artn.common.JSON;

public class ProductOptGroupAction extends AbsUploadActionController{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5340371951606766400L;
	
	private InputStream ajaxReturnInputStream;
	private InputStream ajaxDeleteReturnInputStream;

	@Override
	public String list() throws Exception {
		doList("product-opt-group-all");
		/*doShowSub("product-opt-item-all");*/
		return successOrJsonList();
	}
	/*
	public String optlist() throws Exception {
		doList("product-opt-rel-all");
		return successOrJsonList();
	}
	*/
	@Override
	public String show() throws Exception {
		///
		//asfdasf
		

		doList("product-opt-group-sub");
		if (getListIsNull() == false){
			getShowData().put("name", getListData().get(0).get("name").toString());
			getShowData().put("id_opt_group", getListData().get(0).get("id_opt_group").toString());
			getShowData().put("id_group", getListData().get(0).get("id_group").toString());
		}
		
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
		//valid.checkEmptyValue(getParams(), "", "")
		Map<String, Object> mParams = util.createMap();
		String sRet = successOrJsonShow();
		Integer iIdOptGroupMax = null;
		Object oIdOptGroup = getParams().get("id_opt_group");
		mParams.putAll(getParams());
		valid.checkEmptyValue(mParams, 1, "id_opt_item", "id_group", "required", "opt_type");
		valid.checkEmptyValue(mParams, "", "name", "opt_name");
		
		dbm().open();
		
		if ((oIdOptGroup == null) || (oIdOptGroup.equals("") == true) || (oIdOptGroup.equals("0") == true)){
			iIdOptGroupMax = dbm().selectOneInteger("product-opt-group-id-max", mParams);
			if (iIdOptGroupMax == null){
				iIdOptGroupMax = 1;
			}
			else{
				iIdOptGroupMax++;
			}
			getParams().put("id_opt_group", iIdOptGroupMax);
			mParams.put("id_opt_group", iIdOptGroupMax);
		}
		
		doEditSub("product-opt-group-modify", "product-opt-group-delete", "opt_seq", mParams, false);
		
		dbm().commit();
		dbm().close();
//		else{
//			getError().put("optList", "옵션은 최소한 한개 이상 설정 해야 합니다.");
//			return ERROR;
//		}
		//doEdit("product-opt-group-modify");
		if (sRet.equals(JSONSHOW) == true){
			getShowData().put("code", 1);
			getShowData().put("message", "상품 옵션 입력이 완료 되었습니다.");
			getShowData().put("id_opt_group", getParams().get("id_opt_group").toString());
		}

		return sRet;
	}
	/*
	public String optmodify() throws Exception {
		System.out.println(getParams());
		doEdit("product-opt-rel-delete");
		if(getArrayParams().isEmpty()){
			doEdit("product-opt-rel-modify");	
		}else{
			doEditSub("product-opt-rel-modify", "product-opt-rel-delete", "seq");
		}
		return SUCCESS;
	}*/
	@Override
	public String delete() throws Exception {
		doEdit("product-opt-group-delete");
		if(getParams().containsKey("ajaxPost") == true){
			ajaxDeleteReturnInputStream = new ByteArrayInputStream("1".getBytes());
			return "ajaxDeleteReturn";
		}
		return SUCCESS;
	}
	
	public InputStream getAjaxReturnInputStream() {
		return ajaxReturnInputStream;
	}
	
	public InputStream getAjaxDeleteReturnInputStream() {
		return ajaxDeleteReturnInputStream;
	}

}
