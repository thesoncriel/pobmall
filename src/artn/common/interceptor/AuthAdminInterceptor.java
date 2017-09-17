package artn.common.interceptor;

import artn.common.manager.AuthManager;
import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * 
 * @author shkang<br/>
 * 관리자 권한 정보에 접속할 경우
 * 권한을 확인 해주는 인터셉터 클래스
 * @class
 */
public class AuthAdminInterceptor implements Interceptor {
	
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -5835667482133677420L;
	
	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		try{
			User user = (User)actInvo.getInvocationContext().getSession().get("user");

			if (isAdmin(user) == false) return "error_auth";
		}
		catch(Exception ex){
			return "error_auth";
		}
		
		
		
		return actInvo.invoke();
	}
	
	protected boolean isAdmin(User user){
		return new AuthManager(user).getIsAdmin();
	}
}
