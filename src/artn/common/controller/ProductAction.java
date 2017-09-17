package artn.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.FileNameChangeMode;
import artn.common.model.Delivery;

public class ProductAction extends AbsUploadActionController {

	private static final long serialVersionUID = -5412412357657484930L;
	
	private Map<Integer, Delivery> deliveryInfo;
	private int pobRowCount = 0;

	@SuppressWarnings("unchecked")
	public Map<Integer, Delivery> getDeliveryInfo(){
		if(deliveryInfo == null){
			if(session().containsKey("deliveryInfo")){
				deliveryInfo = (Map<Integer, Delivery>)session().get("deliveryInfo");
			} else{
				List<Map<String, Object>> deliveryResult = null;
				
				deliveryResult = dbm().select("delivery_select", new HashMap<String, Object>());				
				
				deliveryInfo = new HashMap<Integer, Delivery>();
				
				for(Map<String, Object> map : deliveryResult ){
					deliveryInfo.put( (Integer) map.get("id_group"), new Delivery(map));
				}
				
				session().put("deliveryInfo", deliveryInfo);
			}
		}
		
		return deliveryInfo;
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
	
	@Override
	public String list() throws Exception {
		Map<String, Object> mParam = getParams();	
		boolean hasPob = mParam.containsKey("pob");
		boolean hasCategory = mParam.containsKey("category");		
		int iCategory = 0;
		
		if(hasCategory){
			try{
				iCategory = Integer.parseInt(mParam.get("category").toString());				
			} catch(Exception e){
				iCategory = 1;				
			}
			getParams().put("category", iCategory);
		}		
		if( ( getAuth().getIsAdmin() == true ) || (getParams().containsKey("id_group") && getAuth().isGroupAdmin(getParams().get("id_group"))) ){
			getParams().put("admin", "true");
		}else{
			getParams().put("admin", "false");
		}
		
		if(hasPob == false){
			getParams().put("rowlimit", 12);			
			doList("product-all");
			doShowSub("imgList", "product-img-all");
			
			pobRowCount = getRowCount();
			
			return "other";
		} else{			
			getParams().put("rowlimit", 6);
			if(iCategory == 131072 || iCategory == 1){
				getParams().put("category", 131072);
			}else{
				getParams().put("category", iCategory | 131072);
			}			
			doShowSub("productSpecialList", "product-all");
			if(iCategory == 65536 || iCategory == 1){
				getParams().put("category", 65536);
			}else{
				getParams().put("category", iCategory | 65536);
			}
			if( (getParams().containsKey("contents")) && (getParams().get("contents").toString().indexOf("adm") > 0) ){
				getParams().put("admin", "true");
			} else {
				getParams().put("admin", "false");
			}
			
			
			doShowSub("productPremiumList", "product-all");			
			doShowSub("imgList", "product-img-all");
			doShowSub("popupOpenList", "popup-open");			
			getParams().put("category", iCategory);
			
			int iSpecialCount = 0;
			int iPremiumCount = 0;
			
			try{ iSpecialCount = Integer.parseInt(getSubData().get("productSpecialList").get(0).get("row_count").toString()); }
			catch(Exception ex){ iSpecialCount = 0; }
			try{ iPremiumCount = Integer.parseInt(getSubData().get("productPremiumList").get(0).get("row_count").toString()); }
			catch(Exception ex){ iPremiumCount = 0; }
			
			if (iSpecialCount > iPremiumCount){
				pobRowCount = iSpecialCount;
			}
			else{
				pobRowCount = iPremiumCount;
			}
		}
		
		
		
		return successOrJsonList();
	}
	
	public int getPobRowCount(){
		return pobRowCount;
	}

	@Override
	public String show() throws Exception {
		doShow("product-single");
		if(getShowData().get("id_opt_group") == null || getShowData().get("id_group") == null){
			return "error";
		}
		getParams().put("id_opt_group", getShowData().get("id_opt_group").toString());
		getParams().put("id_product", getParams().get("id").toString());
		getParams().put("id_group", getShowData().get("id_group").toString());
		doShowSub("productOpt","product-opt-all","imgList", "product-img-all","productBoard", "product-board-all", "deliveryPrice", "delivery_select");
		ArrayList list = new ArrayList();
		String[] saShowImg = new String[4];
		if(session().containsKey("show_img") == true){
			list = (ArrayList)session().get("show_img");
		}
		saShowImg[0] = getShowData().get("file_img").toString();
		saShowImg[1] = getShowData().get("id").toString();
		saShowImg[2] = getShowData().get("name").toString();
		saShowImg[3] = getShowData().get("name_sub").toString();
		String[] saValue;
		if(session().containsKey("show_img") == true){
			int iListSize = list.size();
			int iCount = 0;
			for(int i = 0; i < iListSize; i++){
				saValue = (String[]) list.get(i);
				if(saValue[1].equals(saShowImg[1]) == true){
					iCount = 1;
					break;
				}
			}
			if(iCount == 0){
				list.add(0, saShowImg);
			}
		}else{
			list.add(0, saShowImg);	
		}
		
		if(list.size() == 5){
			list.remove(4);
		}
		session().put("show_img", list);
		
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
//		if(user() == null) return LOGIN;
		show();
		//getParams().remove("id_opt_group");
		doShowSub("itemList", "product-opt-group-sub");
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
//		if(user() == null) return LOGIN;
		//doShowSub("itemList", "product-opt-group-all");
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		boolean isNew = false;
		
//		if(user() == null) return LOGIN;
		getParams().put("date_update", util.getNow());
		valid.checkEmptyValue(getParams(), 1, "id_group", "category", "opt_terms_user" ,"product_count");
		// sales_min, sales_max 추가에 따른 기본값 설정 추가 - 2013.08.12 by jhson
		valid.checkEmptyValue(getParams(), "", "file_img" ,"name" ,"name_sub" ,"contents" ,"contents_summary", "desc");
		valid.checkEmptyValue(getParams(), 0, "id_opt_group" ,"price_before" ,"price_event" ,"price" , "pay_point", "sold_count", "rating_count", "rating_sum", "rating_avg", "sales_min", "sales_max");
		valid.checkEmptyValue(getParams(), 200,"file_img_width", "file_img_height");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload" ,"date_sales_start");
		valid.checkEmptyValue(getParams(), getParams().get("date_sales_start"), "date_sales_end");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "category");
		getParams().put("width", getParams().get("file_img_width"));
		getParams().put("height", getParams().get("file_img_height"));
		if (hasFileParams() == true){
			try {
				saveFileToAuto(getDownloadPath() + "/upload/product/", FileNameChangeMode.nowdatetime);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		getParams().put("contents",
				getParams().get("contents").toString().replaceAll("height=('|\\\")?[0-9]*('|\")?\"", "")
		);
		dbm().open();
		if( getArrayParams().get("file_img").length > 1){
			getParams().put("file_img", getArrayParams().get("file_img")[0]);
			dbm().updateNonCommit("product-modify", getParams());
			if((getParams().get("id") == null) || getParams().get("id") == ""){
				isNew = true;
				getParams().put("id_product", dbm().selectOneNonOpen("common-inserted-id", getParams()).get("id"));		
			}else{
				getParams().put("id_product",getParams().get("id").toString());
			}			
			doEditSub("product-img-modify", "product-img-delete", "seq", false);
			
		}else{
			dbm().updateNonCommit("product-modify", getParams());
		}
		dbm().commit();
		dbm().close();
		
		if (isNew == true){
			return INPUT;
		}
		return SUCCESS;
	}
	
	public String rating() throws Exception {
		doEdit("product-rating-update");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		
		return null;
	}
	
	public String check() throws Exception {
		int iLen = 1;
		if(getArrayParams().containsKey("id_product") == true){
			iLen = getArrayParams().get("id_product").length;
		}
		
		Map<String, Object> mParam = getParams();
		String sText = "";
		dbm().open();
		int iPurchCnt = 0;
		for(int i = 0; i < iLen; i++){
			getParams().put("id", getParams().get("id_product"));
			if(getArrayParams().containsKey("id_product") == true){
				iPurchCnt = Integer.parseInt(getArrayParams().get("product_count")[i].toString());
				getParams().put("id", getArrayParams().get("id_product")[i]);	
			}else{
				iPurchCnt = Integer.parseInt(getParams().get("product_count").toString());
			}
			mParam.putAll(dbm().selectOneNonOpen("product-single", getParams()));
			if((Integer.parseInt(mParam.get("product_count").toString())-iPurchCnt) < 0){
				sText += mParam.get("name") + "의 재고량 : " + mParam.get("product_count") + "개";
				if(i < iLen -1){
					sText += ",\n";
				}
				if(i == (iLen -1)){
					sText += "입니다.\n 주문 내용을 다시 확인 해주세요.";
				}
			}
		}
		dbm().commit();
		dbm().close();
		if(sText.equals("") == false){
			setResponse("0|"+sText);
			
			return TEXT_RESPONSE;
		}
		
		setResponse("1|구매가능.");
		return TEXT_RESPONSE;
	}
}
