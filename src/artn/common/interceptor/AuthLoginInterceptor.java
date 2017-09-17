package artn.common.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * 
 * @author shkang<br/>
 * 로그인 여부를 확인 해주는 인터셉터 클래스
 * @class
 */
public class AuthLoginInterceptor implements Interceptor {

	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -6832072409966600120L;

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		try{
			if (actInvo.getInvocationContext().getSession().containsKey("user") == false){
				return "login";
			}
		} catch(Exception e){}

		return actInvo.invoke();
	}
}
