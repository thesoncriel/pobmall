package artn.common.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.model.Delivery;
import artn.common.model.User;

public class UserCartAction extends AbsUploadActionController{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1884994913652020344L;
	private InputStream ajaxReturnInputStream;
	private ArrayList<Map<String, Object>> guestCart;
	
	private Map<Integer, Delivery> deliveryInfo;

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
	public ArrayList<Map<String, Object>> getGuestCart(){
		if (guestCart == null){
			try{
				guestCart = (ArrayList<Map<String, Object>>)session().get("guestCart");
			}
			catch(Exception ex){}
			
			if (guestCart == null){
				guestCart = new ArrayList<Map<String, Object>>();
			}
		}
		return guestCart;
	}
	public void saveGuestCart(){
		session().put("guestCart", guestCart);
	}
	public void removeGuestCart(){
		session().remove("guestCart");
	}
	public boolean hasGuestCart(){
		return session().containsKey("guestCart");
	}

	public String login() throws Exception{
		if(getParams().get("guest_name") == null || getParams().get("guest_name") == ""){
			return "login_cart";
		}else{
			session().put("guest_name", getParams().get("guest_name").toString());
		}
		return SUCCESS;
	}
	
	@Override
	public String list() throws Exception {		
		if (user() == null) {
			doListResult = getGuestCart();
			return SUCCESS;
		}
		else if ((getGuestCart() != null) && (getGuestCart().size() > 0)){
			getParams().put("id_user", user().getId());
			
			dbm().open();
			for(Map<String, Object> cart : getGuestCart()){
				getParams().putAll(cart);
				doEdit("user-cart-modify", false);
			}
			dbm().commit();
			dbm().close();
			
			removeGuestCart();
		}
		if(getAuth().getIsAdmin() == true){
			getParams().put("isAdmin", "isAdmin");
		}
		getParams().put("id_user", user().getId());
		doList("user-cart-all");
		return SUCCESS;
	}
	
	protected void setGuestCartToArrayParams(){
		
	}

	@Override
	public String show() throws Exception {
		if (user() == null) {
			System.out.println(session().keySet().iterator());
		}
		doShow("user-cart-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		show();
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		//int iPriceOptValue = 0;
		String sOptDetailValue = "";
		String sOptDetailSeqValue = "";
		StringBuilder sb = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();
		
		if(getParams().containsKey("json") == false){
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
				sOptDetailValue = getParams().get("opt_detail").toString();
			}	
		}
		getParams().put("opt_detail", sOptDetailValue);
		getParams().put("opt_indices", sOptDetailSeqValue);
		valid.checkEmptyValue(getParams(), 1, "product_count", "opt", "opt_detail_seq");
		valid.checkEmptyValue(getParams(), "선택안함:0", "opt_detail");
		valid.checkEmptyValue(getParams(), "000/000/000", "opt_indices");
		valid.checkEmptyValue(getParams(), 0, "price_opt");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		
		if (user() == null) {
			if(getParams().containsKey("product_count_modify") == true){
				System.out.println(getParams().get("product_count").toString());
				getGuestCart().get(Integer.parseInt(getParams().get("id_cart").toString())).put("product_count", getParams().get("product_count").toString());
			} else{			
				if(hasGuestCart() == false){
					getGuestCart().add(getParams());
					saveGuestCart();
				}else{
					getGuestCart().add(getParams());
					saveGuestCart();
				}
			}
		} else {
			getParams().put("id_user", user().getId());
			
			doEdit("user-cart-modify");
			if(getParams().containsKey("json") == true){
				setResponse("{ \"code\" : 1}");
				return TEXT_RESPONSE;
			}		
		}		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {		
		if(user() == null){
			getGuestCart().remove(Integer.parseInt(getParams().get("id_cart").toString()));			
		} else{
			getParams().put("id_user", user().getId());
			if(getAuth().getIsAdmin() == true){
				getParams().put("isAdmin", "isAdmin");
			}
			doEdit("user-cart-delete");
		}		
		
		if(getParams().containsKey("ajaxPost") == true){
			ajaxReturnInputStream = new ByteArrayInputStream("1".getBytes());
			return "ajaxReturn";
		}
		return SUCCESS;
	}
	
	public InputStream getAjaxReturnInputStream() {
		return ajaxReturnInputStream;
	}

}
