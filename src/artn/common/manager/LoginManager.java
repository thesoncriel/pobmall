package artn.common.manager;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.swing.text.View;

import artn.common.Property;
import artn.common.model.Environment;
import artn.common.model.User;
import artn.common.model.Visitor;
import artn.database.DBManager;

/**
 * 
 * @author shkang<br/>
 * 로그인 매니저 클래스
 * @class
 */
public class LoginManager implements HttpSessionBindingListener {
//	private HttpSession session;
	private static LoginManager loginManager = null;
	private Map<String, User> loginUser = new Hashtable<String, User>();
	private Map<String, Map<String, Object>> usingList = new HashMap<String, Map<String, Object>>();
	
	private DBManager dbm = null;
	
	public static synchronized LoginManager getInstance(){
		if (loginManager == null){
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	protected LoginManager(){
		super();
		try {
			dbm = new DBManager();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}

	/**
	 * 로그인을 하기위한 아이디와 패스워드를 확인하고,
	 * 중복 로그인 가능 여부를 체크한다.
	 * @param params
	 * @param session
	 * @return
	 */
	public String login(Map<String, Object> params, Map<String, Object> session){
		Map<String, Object> mUser;
		List<Map<String, Object>> lmAuthGroup;
		Map<String, Object> sessionOther;
		User user;
		DBManager dbm = null;
		
		if ((session.containsKey("visitor") == false) || (session.containsKey("environment") == false)){
			return "죄송합니다. 다시한번 로그인 하여 주십시요.";
		}
		
		try {
			dbm = DBManager.getInstanceFromSession(session);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		dbm.open();
		
		try{
			mUser = dbm.selectOneNonOpen("user-single", params);
		}
		catch(Exception ex){
			dbm.close();
			return "서버 오류 입니다. 로그인을 다시 수행 하시길 바랍니다."; 
		}
		
		if ((mUser == null) || (mUser.size() == 0)){
			dbm.close();
			return "아이디가 존재하지 않습니다.";
		}
		else if (mUser.get("pw").equals(params.get("pw")) == false){
			dbm.close();
			return "비밀번호가 일치하지 않습니다.";
		}
		
		params.put("id_user", mUser.get("id"));
		lmAuthGroup = dbm.selectNonOpen("group-user-all", params);
		dbm.close();
		
		user = new User( mUser );
		user.putAuthGroup( lmAuthGroup );
		session.put( "user",  user);
		loginUser.put( session.get("sessionId").toString(), user);		
		
		try{
			if (Property.getInstance().getBoolean("artn.user.multiLogin") == false){
				if (isUsing(user.getId()) == true){
					sessionOther = usingList.get(user.getId());
					sessionOther.remove("user");
				}
			}
		}
		catch(Exception ex){}
		
		usingList.put(user.getId(), session);
		
		Visitor visitor = (Visitor)session.get("visitor");
		Environment environment = (Environment)session.get("environment");
		visitor.setIdUser(user.getId());
		visitor.doInsert(dbm);
		
		return "";
	}
	
	/**
	 * 아이디가 사용되고 있는지 확인한다.
	 * @param id
	 * @return
	 */
	public boolean isUsing(String id){
		return usingList.containsKey(id);			
	}	
	
	/**
	 * 현재 로그인되어있는 유저정보 세션을 제거하고,
	 * 로그아웃 한다.
	 * @param session
	 */
	public void logout(Map<String, Object> session){
		try{
			loginUser.remove(session.get("sessionId").toString());
			usingList.remove( ((User)session.get("user")).getId() );
			//session.remove("user");
			session.clear();
		}
		catch(NullPointerException ex){}
	}
	/**
	 * 세션에 값을 저장할때 사용된다.
	 */
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		//System.out.println(session.getId());
		session.setAttribute("sessionId", session.getId());
		
		try{
			loginUser.remove(session.getId());
		}
		catch(Exception ex){}
	}

	/**
	 * 세션에 값을 제거할때 사용된다.
	 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		User user = null;
		
		try{
			user = (User)event.getSession().getAttribute("user");
		}
		catch(Exception ex){}
		
		if (user != null){
			loginUser.remove(event.getSession().getId());
		}
	}
	/**
	 * 접속한 유저의 수를 확인한다.
	 * @return
	 */
	public int getUserCount() {
		return loginUser.size();
	}

}
