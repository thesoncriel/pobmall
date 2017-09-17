package artn.common.manager;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.model.User;
/**
 * 
 * @author shkang<br/>
 * 권한 정보 매니저 클래스
 * @class
 */
public class AuthManager{
	private final static int SUPER_ADMIN = 0x60000000;
	private final static int SEMI_ADMIN = 0x20000000;
	private final static int USER_INFO_EDITABLE = 0x8000000;
	
	private final static int GROUP_ADMIN = 0xC000000;
	private final static int GROUP_MANAGER_L3 = 0x4000000;
	private final static int GROUP_MANAGER_L2 = 0x2000000;
	private final static int GROUP_MANAGER_L1 = 0x1000000;
	
	private final static int SEMI_STAFF_L4 = 0x800000;
	private final static int SEMI_STAFF_L3 = 0x400000;
	private final static int SEMI_STAFF_L2 = 0x200000;
	
	private final static int GROUP_USER = 0x40000;
	private final static int NORMAL_USER = 0x20000;
	
	private User user = null;
	private int authUser = 0;
	
	/**
	 * 권한 정보에 유저 정보를 설정한다.
	 * @param user
	 */
	public AuthManager(User user){
		this.user = user;
		try{
			authUser = user.getAuthUser();
		}
		catch(NullPointerException ex){
			authUser = 0;
			this.user = new User();
		}
	}
	
	protected User user(){ return user; }
	protected int getAuthUser(){ return authUser; }
	
	/**
	 * 로그인 하지 않은 유저의 정보를 확인한다.
	 * @return
	 */
	public boolean getIsGuest(){
		return authUser == 0;
	}
	
	/**
	 * 관리자 여부를 확인한다.
	 * @return
	 */
	public boolean getIsAdmin(){
		return (authUser & SEMI_ADMIN) == SEMI_ADMIN;
	}
	
	/**
	 * 최고 관리자 여부를 확인한다.
	 * @return
	 */
	public boolean getIsSuperAdmin(){
		return (authUser & SUPER_ADMIN) == SUPER_ADMIN;
	}
	
	/**
	 * 유저 정보의 수정 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsUserInfoEditable(){
		return getIsAdmin() || ((authUser & USER_INFO_EDITABLE) == USER_INFO_EDITABLE);
	}
	
	/**
	 * 그룹관리자 여부를 확인한다.
	 * @return
	 */
	public boolean getIsGroupAdmin(){
		return getIsAdmin() || ((user.getAuthGroup() & GROUP_ADMIN) == GROUP_ADMIN);
	}
	
	/**
	 * idGroup에 해당하는 그룹관리자인지 확인한다.
	 * @param idGroup 그룹ID
	 * @return
	 */
	public boolean isGroupAdmin(Object idGroup){
		return getIsAdmin() || ((user.getAuthGroup(idGroup.toString()) & GROUP_ADMIN) == GROUP_ADMIN);
	}
	
	/**
	 * 그룹관계자L3 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsGroupManagerL3(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L3) == GROUP_MANAGER_L3;
	}
	
	/**
	 * 그룹관계자L2 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsGroupManagerL2(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L2) == GROUP_MANAGER_L2;
	}
	
	/**
	 * 그룹관계자L1 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsGroupManagerL1(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L1) == GROUP_MANAGER_L1;
	}
	
	/**
	 * 그룹관계자L1~3 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsGroupManager(){
		return getIsAdmin() || (user.getAuthGroup() & (GROUP_MANAGER_L1 | GROUP_MANAGER_L2 | GROUP_MANAGER_L3)) != 0;
	}
	
	/**
	 * 그룹 준 관계자L4 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsSemiStaffL4(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L4) == SEMI_STAFF_L4;
	}
	/**
	 * 그룹 준 관계자L3 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsSemiStaffL3(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L3) == SEMI_STAFF_L3;
	}
	/**
	 * 그룹 준 관계자L2 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsSemiStaffL2(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L2) == SEMI_STAFF_L2;
	}
	/**
	 * 그룹 유저 권한이 있는지 확인한다.
	 * @return
	 */
	public boolean getIsGroupUser(){
		return getIsAdmin() || (user.getAuthGroup() >= GROUP_USER) || ( (user.getAuthGroup() & GROUP_USER) == GROUP_USER);
	}
	
	/**
	 * idGroup에 해당하는 유저인지 확인한다.
	 * @param idGroup
	 * @return
	 */
	public boolean isGroupUser(Object idGroup){
		return (user.getAuthGroup(idGroup.toString()) >= GROUP_USER) || ( (user.getAuthGroup(idGroup.toString()) & GROUP_USER) == GROUP_USER);
	}
	
	/**
	 * 그룹유저 이상의 권한인지 확인한다.
	 * @return
	 */
	public boolean getIsHighGroupUser(){
		return getIsAdmin() || (user.getAuthGroup() >= GROUP_USER);
	}
	
	/**
	 * 사용자권한이 일반유저인지 확인한다.
	 * @return
	 */
	public boolean getIsSiteUser(){
		return  (authUser & NORMAL_USER) == NORMAL_USER;
	}
	
	/**
	 * 사용자권한이 일반유저 이상인지 확인한다.
	 * @return
	 */
	public boolean getIsHighSiteUser(){
		return  (authUser >= NORMAL_USER);
	}
	
	/**
	 * 그룹관리자 이상의 권한인지 확인한다.
	 * @return
	 */
	public boolean getIsGroupStaff(){
		return (user.getAuthGroup() & 0x7000000) > 0;
	}
	
	/**
	 * 사용자 권한이 일반 유저보다 높은지 확인한다.
	 * @return
	 */
	public boolean getIsSiteStaff(){
		return getIsAdmin() || (user.getAuthUser() & 0x7000000) > 0;
	}
	public boolean isAuthByName(String name){
		try {
			return (Boolean)this.getClass().getMethod("getIs" + name).invoke(this);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	/**
	 * 메뉴 권한을 확인한다.
	 * @param place
	 * @return
	 */
	public boolean menu(int place){
		return ( (this.user.getRestrictMenu() >> (place - 1)) & 1  ) > 0;
	}
	
	/**
	 * 유저 정보 수정 및 입력 권한을 확인한다.
	 * @param place
	 * @return
	 */
	public boolean userEdit(int place){
		return ( (this.user.getRestrictUserEdit() >> (place - 1)) & 1  ) > 0;
	}
}
