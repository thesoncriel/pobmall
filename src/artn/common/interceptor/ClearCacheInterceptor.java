package artn.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * @ignore
 * @author
 *
 */
public class ClearCacheInterceptor implements Interceptor {

	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -6628419135956960342L;
	@Override
	public void destroy() { }
	@Override
	public void init() { }
	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		String className = actInvo.getAction().getClass().getName();
        String result = actInvo.invoke();
        ActionContext context=(ActionContext)actInvo.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest)context.get(StrutsStatics.HTTP_REQUEST);
        HttpServletResponse response = (HttpServletResponse)context.get(StrutsStatics.HTTP_RESPONSE);

        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        return result;
	}

}
