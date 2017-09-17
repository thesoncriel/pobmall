package artn.common.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import artn.common.tag.CalendarMaker;

public class PurchaseAction extends AbsUploadActionController {

	private Logger logger = Logger.getLogger(getClass());
	private static final long serialVersionUID = 5940742690269350317L;
	CalendarMaker clm;
	private int boardNo;
	Calendar cal = Calendar.getInstance();
	@Override
	public String list() throws Exception {
		if(user() == null){
			getParams().put("Guest", "Guest");
			if( (getParams().containsKey("pay_user_name") == false) && (session().containsKey("pay_user_name") == false)){
				return LOGIN;
			}
			getParams().put("id_user", "Guest");
			if(getArrayParams().containsKey("pay_phone") == true){
				valid.appendAndPutToMap(getParams(), getArrayParams(), "pay_phone", "-");
				valid.checkEmptyValue(getParams(), "", "pay_mail");
				session().put("pay_user_name", getParams().get("pay_user_name"));
				session().put("pay_phone", getParams().get("pay_phone"));
				session().put("pay_mail", getParams().get("pay_mail"));
			}
			
			if(session().containsKey("pay_user_name") == true){
				getParams().put("pay_user_name", session().get("pay_user_name"));
				getParams().put("pay_phone", session().get("pay_phone"));
			}
			
		}else{
			if( (getAuth().getIsAdmin() == false) && ((getParams().containsKey("id_group") == false) || getParams().get("id_group") == "") ){
				getParams().put("id_user", user().getId());
			}
		}
		
		if(getParams().get("status") == ""){
			getParams().remove("status");
		}
		if(getParams().get("id_group") == ""){
			getParams().remove("id_group");			
		}
		if(getParams().containsKey("date") && ( (getParams().get("date").equals("today") == true) || (getParams().get("date").equals("1week") == true)
				|| (getParams().get("date").equals("1month") == true) || (getParams().get("date").equals("3month") == true) || (getParams().get("date").equals("6month") == true)
				|| (getParams().get("date").equals("1year") == true)) ){
			getParams().put("date",clm.dateDiff(getParams(),getParams().get("date")));
		}
		if( (getParams().containsKey("search_div") == true) && (getParams().get("search_div").equals("") == true) ){
			getParams().put("search_text", "");
		}
		doList("purchase-all");

		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		if(user() == null){
			getParams().put("id_user", "Guest");
			if(session().get("pay_user_name") != null){
				getParams().put("pay_user_name",session().get("pay_user_name"));
				getParams().put("pay_phone",session().get("pay_phone"));
			}
		}
//		dbm().open();
		doShow("purchase-single");
		if( (user() == null ) && (session().containsKey("pay_user_name") == false) ){
			return LOGIN;
		}else if( (user() == null ) && ( session().get("pay_user_name").equals(getShowData().get("pay_user_name")) == false )
					&& (session().get("pay_phone").equals(getShowData().get("pay_phone")) == false ) ){
			return "error_auth";
		}else if( (user() != null) && (getAuth().getIsAdmin() == false) && ( getShowData().get("id_user").equals(user().getId()) == false) ){
			return "error_auth";
		}
		getParams().putAll(getShowData());
		doShowSub("paymentSingle","payment-single","purchaseHistory","purchase-history-all");
		getShowData().putAll(getSubData().get("paymentSingle").get(0));
		return SUCCESS;
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
		List<Map<String, Object>> lmResult = null;
		Map<String,Object> mParams = util.createMap();
		String saParams[] = null;
		valid.checkEmptyValue(getParams(), "", "delivery_num","coupon_detail", "coupon_downcost", "subject", "opt_detail"
				, "file_img", "pay_user_name", "pay_phone","opt_indices");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_start");
		valid.checkEmptyValue(getParams(), util.addDate(util.getNow(), 7), "date_end");
		valid.checkEmptyValue(getParams(), 0, "price", "price_opt", "product_count", "amount");
		valid.checkEmptyValue(getParams(), 1, "status");		
		mParams.putAll(getParams());		
		dbm().open();
		if(getArrayParams().containsKey("purchase_seq")){
			doEditSub("purchase-modify", "purchase-delete", "purchase_seq", false);	
		}else{
//			doEdit("purchase-modify");
			dbm().updateNonCommit("purchase-modify", mParams);
		}
		
		lmResult = dbm().selectNonOpen("purchase-all", mParams);
		saParams = new String[lmResult.size()];
		//상품 개수 조정		
		if(getArrayParams().containsKey("id_product")){
			
			for(int i = 0; i < lmResult.size(); i++){
				dbm().updateNonCommit("product-update", lmResult.get(i));
				saParams[i] = lmResult.get(i).get("id_purchase").toString();
				//상품 옵션 개수 조정
				optDetail( getParams(), getArrayParams(), i );		
			}
			getArrayParams().put("id_purchase", saParams);
		}else{
			optDetail( getParams(), getArrayParams(), 0 );
			getParams().put("id_purchase", lmResult.get(0).get("id_purchase"));
			dbm().updateNonCommit("product-update", mParams);
		}
		dbm().commit();
		dbm().close();
		update();
		if( (getParams().containsKey("pay_type") == true) && (getParams().get("pay_type").equals("1")) ){
			getShowData().put("pay_bank_name", getParams().get("pay_bank_name"));
			getShowData().put("pay_bank_account", getParams().get("pay_bank_account"));
			return "account";
		}
		return SUCCESS;
	}
	public void optDetail(Map<String, Object> mParams, Map<String, String[]> maParams, int iSeq ) throws Exception{
		optDetail( mParams, maParams, iSeq, false);
	}
	
	public void optDetail(Map<String, Object> mParams, Map<String, String[]> maParams, int iSeq, boolean isAdd) throws Exception{
		String[] saOptSeq;
		int iSign = (isAdd == true)? -1 : 1;		
		if(maParams.containsKey("id_product") == true){
			mParams.put("id_product", Integer.parseInt(maParams.get("id_product")[iSeq].toString()));
			mParams.put("product_count", iSign * Integer.parseInt(maParams.get("product_count")[iSeq]));
			saOptSeq = maParams.get("opt_indices")[iSeq].split("/");
		} else{			
			mParams.put("id_product", Integer.parseInt(mParams.get("id_product").toString()));
			mParams.put("product_count", iSign * Integer.parseInt(mParams.get("product_count").toString()));
			saOptSeq = mParams.get("opt_indices").toString().split("/");
		}	
		getParams().putAll( mParams );
		doList("product-opt-id");
		for(int j = 0; j < getListData().size(); j ++){
			mParams.put("id_opt_item", getListData().get(j).get("id_opt_item"));
			mParams.put("item_seq", Integer.parseInt(saOptSeq[j]));		
			dbm().updateNonCommit("product-opt-count-update", mParams);
		}
	}
	
	public void optIndices() throws Exception{
		String sOptDetailValue = "";
		String sOptDetailSeqValue = "";
		StringBuilder sb = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();
		
		if(getArrayParams().containsKey("opt_detail") == true){
			int optLengt = getArrayParams().get("opt_detail").length;
			for(int i = 0 ; i < optLengt ; i++){
				String saOptDetail[] = getArrayParams().get("opt_detail")[i].toString().split(":");
				sb2.append(String.format("%03d", Integer.parseInt(saOptDetail[2]))).append("/");		
				sb.append(saOptDetail[0]+":"+saOptDetail[1]).append("/");
			}
			if(sb.length() > 0 || sb2.length() > 0){
				sb.setLength(sb.length() -1);
				sb2.setLength(sb2.length() -1);
				sOptDetailValue = sb.toString();
				sOptDetailSeqValue = sb2.toString();
			}else{
				sOptDetailValue="";
				sOptDetailSeqValue="";
			}
		}else if(getParams().containsKey("opt_detail") == true ){
			String saOptDetail[] = getParams().get("opt_detail").toString().split(":");
			sb2.append(String.format("%03d", Integer.parseInt(saOptDetail[2]))).append("/");		
			sb.append(saOptDetail[0]+":"+saOptDetail[1]).append("/");
			if(sb.length() > 0 || sb2.length() > 0){
				sb.setLength(sb.length() -1);
				sb2.setLength(sb2.length() -1);
				sOptDetailValue = sb.toString();
				sOptDetailSeqValue = sb2.toString();
			}else{
				sOptDetailValue="";
				sOptDetailSeqValue="";
			}
			sOptDetailValue = getParams().get("opt_detail").toString();
		}
		
		getParams().put("opt_detail", sOptDetailValue);
		getParams().put("opt_indices", sOptDetailSeqValue);
	}
	
	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	public String update() throws Exception {
		List<Map<String, Object>> lmResult = null;
		Map<String, Object> mResult = util.createMap();
		mResult.putAll(getParams());
		valid.checkEmptyValue(mResult, "", "delivery_num");
		valid.checkEmptyValue(mResult, util.getNow(), "date_upload");
		dbm().open();
		
		lmResult = dbm().selectNonOpen("purchase-all", mResult);
		if( (getArrayParams().size() < 1) || (getParams().get("status").equals("-9") == true) ){
			mResult.putAll(dbm().selectOneNonOpen("purchase-single", mResult));
			mResult.put("status", getParams().get("status"));
			if( (getParams().containsKey("delivery_num") == true) && (getParams().get("delivery_num").equals("") == false) ){
				mResult.put("delivery_num", getParams().get("delivery_num"));	
			}
		}
		
		if(getParams().get("status").equals("-2")){			
			int iPurchaseCnt = 0;
				iPurchaseCnt = Integer.parseInt(mResult.get("product_count").toString())*-1;								
				optDetail( mResult, getArrayParams(), 0, true);
				mResult.put("product_count", iPurchaseCnt);
				dbm().updateNonCommit("product-update", mResult);
		}
		else if(getParams().get("status").equals("2")){
			mResult.put("date_confirm", util.getNow());
			dbm().updateNonCommit("purchase-modify", mResult);
		}
		if(getParams().containsKey("inicancel") == true){
			for(int i = 0; i < lmResult.size(); i++){
				mResult.put("id_purchase", lmResult.get(i).get("id_purchase").toString());
				dbm().insertNonCommit("purchase-history-modify", mResult);
				dbm().updateNonCommit("purchase-update", mResult);
			}
			dbm().commit();
			dbm().close();
			return SUCCESS;
		}
		mResult.remove("id");
		if(getArrayParams().containsKey("id_purchase") == true){
			doEditSub("purchase-history-modify","","id_purchase",false);
		}else{
			dbm().insertNonCommit("purchase-history-modify", mResult);	
		}
		if(getParams().containsKey("id_purchase") == true){
			dbm().updateNonCommit("purchase-update", mResult);
			dbm().updateNonCommit("payment-update", mResult);	
		}
		if( (getParams().get("status").equals("-9") == true) && (getParams().containsKey("opt_detail") == true) ){
			optDetail( mResult, getArrayParams(), 0, true);
			optIndices();
			mResult.put("opt_detail", getParams().get("opt_detail"));
			mResult.put("opt_indices", getParams().get("opt_indices"));
			optDetail( mResult, getArrayParams(), 0, true);
			dbm().updateNonCommit("purchase-modify", mResult);
		}
		if(getParams().get("status").equals("-10") == true){
			optDetail( mResult, getArrayParams(), 0, true);
		}
		if(getParams().get("status").equals("10") == true){
			mResult.putAll(dbm().selectOneNonOpen("purchase-single", mResult));
			getShowData().put("id_product", mResult.get("id_product"));
			getShowData().put("id_user", mResult.get("id_user"));
			getShowData().put("pay_user_name", mResult.get("pay_user_name"));
			dbm().commit();
			dbm().close();
			return "complete";
		}
		dbm().commit();
		dbm().close();
		
		getParams().remove("status");
		return SUCCESS;
	}
	
	public String stats() throws Exception {
		
		if(user() == null){
			return LOGIN;
		}
		if(getAuth().getIsAdmin() == false){
			return ERROR_AUTH;
		}
		if(getParams().containsKey("date_sales_start") == false){
			getParams().put("date", "1month");
			getParams().put("date",dateDiff(getParams(),getParams().get("date")));
		}
		doList("purchase-stats");
		doShowSub("purchaseStatsUser","purchase-stats-user","purchasestatsbrowser","purchase-stats-browser");
		return SUCCESS;
	}
	
	public String optList(){
		Map<String, Object> mParam = getParams();
		dbm().open();
		getParams().putAll(dbm().selectOneNonOpen("product-single", mParam));
//		mParam.putAll(dbm().selectOneNonOpen("product-single", mParam));
//		getListData().addAll(dbm().selectNonOpen("product-opt-all", mParam));
		dbm().commit();
		dbm().close();
		doList("product-opt-all");
		return successOrJsonList();
	}
	
	public int getBoardNo(){
		return this.boardNo;
	}
	
	public String dateDiff(Map<String, Object> params, Object date){
		
		int iNowYear = cal.get(Calendar.YEAR);
		//월은 0부터 시작하므로 1월 표시를 위해 1을 더해 줍니다
		int iNowMonth = cal.get(Calendar.MONTH)+1;
		int iNowDay = cal.get(Calendar.DAY_OF_MONTH);
		String sToday = "";
		String sNowMonth = "";
		String sNowDay = "";
		if(date.equals("1week")){
			if( (iNowDay-7) < 1 ){
				if( (iNowMonth-1) < 1){
					iNowYear = iNowYear - 1;
					iNowMonth = 12;
					iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay) + (iNowDay-7);
				}else{
					iNowMonth -= 1;
					iNowDay = lastDay(params,iNowYear, iNowMonth, iNowDay) + (iNowDay-7);
				}
			}else{
				iNowDay = iNowDay-7;
			}
		}else if(date.equals("1month")){
			if( (iNowMonth-1) < 1){
				iNowYear = iNowYear - 1;
				iNowMonth = 12;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 1;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("3month")){
			if( (iNowMonth-3) < 1){
				iNowYear = iNowYear -1;
				iNowMonth = 12 + (iNowMonth-3);
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 3;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("6month")){
			if( (iNowMonth-6) < 1){
				iNowYear = iNowYear -1;
				iNowMonth = 12 + (iNowMonth-6);
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 6;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("1year")){
			iNowYear = iNowYear -1;
			iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
		}
		
		if(iNowMonth < 10){
			sNowMonth = "0"+iNowMonth; 
		}else{
			sNowMonth = ""+ iNowMonth;
		}
		
		if(iNowDay < 10){
			sNowDay = "0"+iNowDay; 
		}else{
			sNowDay = ""+ iNowDay;
		}
		sToday = iNowYear + "-" + sNowMonth + "-" + sNowDay;
		System.out.println("sToday : "+sToday);
		return sToday;
	}
	
	public int lastDay(Map<String, Object> params, int iNowYear, int iNowMonth, int iNowDay){
		cal.set(iNowYear, iNowMonth-1, 1);
		int iPrevDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	 	
		if( ((iPrevDay - iNowDay) < 0) || (params.get("date").equals("1week"))){
			iNowDay = iPrevDay;
		}
		System.out.println("iNowDay : " + iNowDay);
		return iNowDay;
	}
}
