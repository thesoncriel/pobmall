package artn.common.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.Util;
import artn.common.manager.AuthManager;

/**
 * 
 * @author shkang<br/>
 * 유저 정보를 설정하는 모델클래스.
 * @class
 */
public class User {
	private String id;
	private String name;
	private String nick;
	private String email;
	private String phoneHome;
	private String phoneMobi;
	private String dateBirth;
	private String dateJoin;
	private String ip;
	private int authUser;
	private int opt;
	private String authUserKor;
	private int restrictMenu;
	private int restrictUserEdit;
	
	private String fileImg;
	
	private Integer authGroup;
	private String authGroupKor;
	
	private Map<String, Object> user;
	private Map<String, Object> selectedGroup = new HashMap<String, Object>();
	private Map<String, Map<String, Object>> groupList = new HashMap<String, Map<String, Object>>();
	
	public static User getInstanceFromSession(Map<String, Object> session){
		try{
			return (User)session.get("user");
		}
		catch(ClassCastException ex){
			session.remove("user");
			System.out.println("User.getInstanceFromSession():: 세션에 필요없는 객체가 포함 되어 있었음.");
		}
		
		return null;
	}
	
	public User(){
		this.id = "gt" + Util.getInstance().getIdByNowDateTime();
		this.name = "손님";
		this.nick = "손님";
		this.email = "";
		this.phoneHome = "";
		this.phoneMobi = "";
		this.dateBirth = "";
		this.dateJoin = Util.getInstance().getNow();
		this.authUser = 0;
		this.opt = 0;
		this.restrictMenu = 0;
		this.restrictUserEdit = 0;
		this.authUserKor = "손님";
		
		this.authGroup = 0;
		this.authGroupKor = "";
	}
	public User(Map<String, Object> user){
		Object oImgFile;
		
		this.id = user.get("id").toString();
		this.name = user.get("name").toString();
		this.nick = user.get("nick").toString();
		this.email = user.get("email").toString();
		this.phoneHome = user.get("phone_home").toString();
		this.phoneMobi = user.get("phone_mobi").toString();
		this.dateBirth = user.get("date_birth").toString();
		this.dateJoin = user.get("date_join").toString();
		this.authUser = Integer.parseInt(user.get("auth_user").toString());
		this.opt = Integer.parseInt(user.get("opt").toString());
		this.authUserKor = user.get("auth_user_kor").toString();
		this.restrictMenu = Integer.parseInt(user.get("restrict_menu").toString());
		this.restrictUserEdit = Integer.parseInt(user.get("restrict_user_edit").toString());
		
		oImgFile = user.get("file_img");
		if(oImgFile != null){
			this.fileImg = oImgFile.toString();
		}
		
		this.user = user;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getNick() {
		return nick;
	}

	public String getEmail() {
		return email;
	}

	public String getPhoneHome() {
		return phoneHome;
	}

	public String getPhoneMobi() {
		return phoneMobi;
	}

	public String getDateBirth() {
		return dateBirth;
	}

	public String getDateJoin() {
		return dateJoin;
	}

	public int getAuthUser() {
		return authUser;
	}

	public int getOpt() {
		return opt;
	}
	
	public String getIp(){
		return ip;
	}
	
	public Integer getAuthGroup(){
		if (authGroup == null){
			try{
				authGroup = Integer.parseInt( selectedGroup.get("auth_group").toString() );
			}
			catch(NullPointerException ex){
				authGroup = 0;
			}
		}
		return authGroup;
	}
	
	public int getAuthGroup(String idGroup){
		try{
			return Integer.parseInt( groupList.get( idGroup ).get("auth_group").toString() );
		}
		catch(NullPointerException ex){}
		return 0;
	}
	
	public String getAuthGroupKor(){
		if (authGroupKor == null){
			authGroupKor = selectedGroup.get("auth_group_kor").toString();
		}
		return authGroupKor;
	}
	
	
	public int getRestrictMenu(){
		return this.restrictMenu;
	}
	public int getRestrictUserEdit(){
		return this.restrictUserEdit;
	}
	
	public String getFileImg(){
		return this.fileImg;
	}
	
	public Map<String, Object> toMap(){
		if (this.user == null){
			this.user = new HashMap<String, Object>();
			
			this.user.put("id", this.id);
			this.user.put("name", this.name);
			this.user.put("nick", this.nick);
			this.user.put("email", this.email);
			this.user.put("phone_home", this.phoneHome);
			this.user.put("phone_mobi", this.phoneMobi);
			this.user.put("date_birth", this.dateBirth);
			this.user.put("date_join", this.dateJoin);
			this.user.put("auth_user", this.authUser);
			this.user.put("opt", this.opt);
			this.user.put("auth_user_kor", this.authUserKor);
			this.user.put("file_img", "");
		}

		return user;
	}
	
	public User setIp(Object ip){
		this.ip = ip.toString();
		this.user.put("ip", ip);
		return this;
	}
	
	public void setIdGroup(String idGroup){
		if (groupList.containsKey(idGroup) == true){
			this.selectedGroup = groupList.get(idGroup);
		}
		else{
			this.selectedGroup = new HashMap<String, Object>();
			this.selectedGroup.put("id_group", 0);
			this.selectedGroup.put("auth_group", 0);
			this.selectedGroup.put("auth_group_kor", "손님");
			this.selectedGroup.put("group_name", "없음");
		}
	}
	
	public void putAuthGroup(List<Map<String, Object>> groupList, String keyIdGroup){
		for(Map<String, Object> map : groupList){
			this.groupList.put(map.get(keyIdGroup).toString(), map);
		}
	}
	
	public void putAuthGroup(List<Map<String, Object>> groupList){
		putAuthGroup(groupList, "id_group");
	}
	
	public Map<String, Object> getGroupInfo(String idGroup){
		return this.groupList.get(idGroup);
	}
	
	public boolean getIsAdmin(){
		return this.authUser == 1610612736;
	}
	
	public boolean getHasAnyGroup(){
		return this.groupList.size() > 0;
	}
}
