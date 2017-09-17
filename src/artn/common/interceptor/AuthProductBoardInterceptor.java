package artn.common.interceptor;

import java.util.Map;

import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthProductBoardInterceptor implements Interceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5290898130758798255L;
	
	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		Map<String, Object> session = actInvo.getInvocationContext().getSession();
		Map<String, Object> params = actInvo.getInvocationContext().getParameters();
		User user = User.getInstanceFromSession(session);
		String sName = actInvo.getInvocationContext().getName();

		try{
			if(sName.equals("myposts")){
				if(user == null){
					if( (params.containsKey("pay_user_name") == false) && (session.containsKey("pay_user_name") == false)){
						return "login_myposts";
					}
				}	
			}else if(sName.equals("list")){
				if(params.containsKey("myposts") && user == null && session.containsKey("pay_user_name") == false ){
					return "login";
				}	
			}
		} catch(Exception e){}

		return actInvo.invoke();
	}
	
	 
}
