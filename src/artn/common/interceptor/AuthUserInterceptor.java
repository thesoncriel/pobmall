package artn.common.interceptor;

import java.util.Map;
import artn.common.manager.AuthManager;
import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;

/**
 * 
 * @author shkang<br/>
 * 유저 정보에 접속 할경우
 * 로그인 여부 및 권한 확인 하는 인터셉터 클래스
 * @class
 */
public class AuthUserInterceptor extends AbsAuthInterceptor {
	
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -3837046738760174442L;
	private String[] loginOnlyActionNames = new String[]{
		"menu", "list", "write", "edit", "delete", "modify", "leave"
	};
	

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		setSession(actInvo.getInvocationContext().getSession());
		setParams(actInvo.getInvocationContext().getParameters());
		
		User user = User.getInstanceFromSession(getSession());
		String sParamUserId = "";
		String sName = actInvo.getInvocationContext().getName();
		AuthManager auth = null;

		if (user == null){
			for(String sLoginOnlyAction : loginOnlyActionNames){
				if (sName.equals(sLoginOnlyAction)){
					setBeforeRequest();//로그인으로 리절트 하기 전 요청 내역을 세션에 저장 한다.
					return "login";
				}
			}

			return actInvo.invoke();
		}
		
		// 로그인 통과 후 요청 내역을 확인 한다.
		// 있다면 이전 요청 내역으로 재요청 한다.
		if (hasBeforeRequest()){
			return "before_request";
		}

		
		if (user.getIsAdmin() == true){
			if (sName.equals("edit") == true){
				if (getParams().containsKey("pw_checked") == false) return "password";
			}
			return actInvo.invoke();
		}

		try{
			auth = new AuthManager(user);
			sParamUserId = extractUserId(getParams());
			
			if		(sName.equals("menu")){
				if (user.getRestrictMenu() <= 0) return "error_auth";
			}
			else if	(sName.equals("list")){
				if (auth.getIsGroupStaff() == false) return "error_auth";
			}
			else if	(sName.equals("show")) {
//				if (user.getId().equals(params.get("id")) == false){
//					if ()
//					return "error_auth";
//				}
				if ((auth.getIsGroupAdmin() == false) && sParamUserId.equals(user.getId()) == false) return "error_auth";
			}
			else if	(sName.equals("write")){
				return "error_auth";
			}
			else if (sName.equals("edit")){
				if ((auth.getIsGroupAdmin() == false) && sParamUserId.equals(user.getId()) == false) return "error_auth";
				if (getParams().containsKey("pw_checked") == false) return "password";
			}
			else if	(sName.equals("delete") || sName.equals("modify")){
				
				if (user.getId().equals(sParamUserId) == false){
					return "error_auth";
				}
			}else if (sName.equals("leave")){
				if ((auth.getIsGroupAdmin() == false) && sParamUserId.equals(user.getId()) == false) return "error_auth";
			}
			
		} catch(Exception e){}

		return actInvo.invoke();
	}
	
	protected String extractUserId(Map<String, Object> params){
		if (params.containsKey("id") == true){
			Object oId = params.get("id");
			
			if (oId instanceof String){
				return oId.toString();
			}
			else if (oId instanceof String[]){
				return ((String[])oId)[0];
			}
		}
		return "";
	}
}
