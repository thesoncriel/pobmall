package artn.common.interceptor;

import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;

public class AuthCartInterceptor extends AbsAuthInterceptor {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3837046738760174442L;
	private String[] loginOnlyActionNames = new String[]{
		"list"
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
		String sName = actInvo.getInvocationContext().getName();

		if ((user == null) && (getSession().containsKey("guest_name") == false)){
			for(String sLoginOnlyAction : loginOnlyActionNames){
				if (sName.equals(sLoginOnlyAction)){
					setBeforeRequest();//로그인으로 리절트 하기 전 요청 내역을 세션에 저장 한다.
					return "login_cart";
				}
			}

			return actInvo.invoke();
		}
		
		// 로그인 통과 후 요청 내역을 확인 한다.
		// 있다면 이전 요청 내역으로 재요청 한다.
		if (hasBeforeRequest()){
			return "before_request";
		}
		return actInvo.invoke();
	}
}
