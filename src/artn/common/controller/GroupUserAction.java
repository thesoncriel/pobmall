package artn.common.controller;

import java.util.List;
import java.util.Map;

public class GroupUserAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3882586504659407537L;
	//private boolean hasAuthGroup = false;
	private String groupUserAuthId;
	private Integer modifiedId;

	public Integer getModifiedId(){
		return modifiedId;
	}
	
	@Override
	public String list() throws Exception {
		if (user() == null) return LOGIN;
		doList("group-user-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		if (user() == null) return LOGIN;
		doShow("group-user-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		//FIXME: 그룹 관리자가 아니면 이용 못하게 해야함. - 2013.08.06 by jhson
		//if (getAuth().getIsUserInfoEditable() == false) return ERROR_AUTH;
		if(getParams().containsKey("id_group") == false){
			show();	
		}
		/*if (getParams().containsKey("id_group") == true){
			getParams().put("id_group", getShowData().get("id_group"));
		}*/
		dbm().open();
		getParams().put("rowlimit", 100);
		if (getAuth().getIsAdmin() == true){
			doShowSub("groupList", "group-all", false);
			getParams().put("id_group", getShowData().get("id_group"));
			doShowSub("groupAuthList", "user-auth-all", false);
		}
		else if (getAuth().getIsGroupAdmin() || getAuth().getIsGroupManager()) {
			getParams().put("id_user", user().getId());
			doShowSub("groupUserList", "group-user-all", false);
			getParams().put("id_group", getShowData().get("id_group"));
			doShowSub("groupAuthList", "user-auth-all", false);
		}
		dbm().close();

		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		List<Map<String, Object>> lmGroupAuthList; 
		if(getAuth().getIsGroupAdmin() == true){
			getParams().put("id_user", user().getId());
		}
		doShowSub("groupUserList", "group-user-all","groupList", "group-all", "groupAuthList", "user-auth-all");
		
		if (getAuth().getIsGroupUser() == false){
			lmGroupAuthList = getSubData().get("groupAuthList");
			groupUserAuthId = lmGroupAuthList.get( lmGroupAuthList.size() - 1 ).get("id").toString();
		}
		
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if (user() == null) return LOGIN;
		//FIXME: 그룹 관리자가 아니면 이용 못하게 해야함. - 2013.08.06 by jhson
		//FIXME: 관리자가 회원 가입시킬 때 중복확인해야함. - 2013.08.08 by shkang
		if(getParams().containsKey("id_user") == false){
			valid.checkEmptyValue(getParams(), user().getId(), "id_user");	
		}
		valid.checkEmptyValue(getParams(), 0, "id_group", "auth_group_id");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_join");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "opt");
		valid.replaceCRLFToBRTags(getParams(), "comment");
		dbm().open();
		doEdit("group-user-modify");
		session().remove("newUserName");
		session().remove("newUserId");
		
		List<Map<String, Object>> lmAuthGroup;
		
		lmAuthGroup = dbm().selectNonOpen("group-user-all", getParams());
		modifiedId = dbm().selectOneInteger("common-inserted-id-int", getParams());
		getParams().put("modifiedId", modifiedId);
		//System.out.println(modifiedId + "그룹가입 아이디");
		dbm().close();
		
		user().putAuthGroup( lmAuthGroup );
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		doEdit("group-user-delete");
		return SUCCESS;
	}
	
	public String getGroupUserAuthId(){
		return groupUserAuthId;
	}
}