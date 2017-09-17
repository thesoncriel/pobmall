package artn.common.interceptor;

import java.util.Map;

import artn.common.manager.AuthManager;
import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthProductInterceptor implements Interceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1058992030758403222L;

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		Map<String, Object> session = actInvo.getInvocationContext().getSession();
		User user = User.getInstanceFromSession(session);
		String sName = actInvo.getInvocationContext().getName();
		AuthManager auth = null;

		try{
			auth = new AuthManager(user);
			//TODO : 일반 회원이 list로 접속했을 시 grid로 변경 해주는 기능 필요 - 2013.11.08 by shkang  
			if(sName.equals("list") == true){
				if (auth.getIsAdmin() == false){
				}
			}
			else if	(sName.equals("write") || sName.equals("edit") || sName.equals("modify")){
				if(user == null) return "login";
				if (auth.getIsAdmin() == false) return "error_auth";
			}
			else if	(sName.equals("delete")){
				if(user == null) return "login";
				if (auth.getIsAdmin() == false) return "error_auth";
			}
			
		} catch(Exception e){}

		return actInvo.invoke();
	}
	
	 
}
