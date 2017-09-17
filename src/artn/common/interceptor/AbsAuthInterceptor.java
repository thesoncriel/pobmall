package artn.common.interceptor;

import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * 
 * @author shkang<br/>
 * 권한 정보를 확인 해주는 인터셉터 클래스
 * @class
 */
public abstract class AbsAuthInterceptor implements Interceptor {

	/**
	 * @ignore
	 */
	private static final long serialVersionUID = 4364666295138827072L;
	private Map<String, Object> session;
	private Map<String, Object> params;
	
	protected Map<String, Object> getSession(){
		if (session == null){
			session = ActionContext.getContext().getSession();
		}
		return session;
	}
	protected Map<String, Object> getParams(){
		if (params == null){
			params = ActionContext.getContext().getParameters();
		}
		return params;
	}
	protected void setSession(Map<String, Object> session){
		this.session = session;
	}
	protected void setParams(Map<String, Object> params){
		this.params = params;
	}
	
	protected StringBuilder serializeParams(){
		Set<String> keySet = getParams().keySet();
		StringBuilder sb = new StringBuilder();
		Object oVal = null;
		
		for(String key : keySet){
			oVal = params.get(key);
			sb
			.append(key)
			.append('=');
			
			if (oVal instanceof String[]){
				sb.append( ((String[])oVal)[0] );
			}
			else if (oVal instanceof java.lang.String){
				sb.append( oVal.toString() );
			}
			
			sb.append('&');
		}
		
		if (sb.length() > 0){
			sb.setLength(sb.length() - 1);
		}
		
		return sb;
	}
	
	protected void setBeforeRequest(){
		StringBuilder sb = serializeParams();
		getSession().put("hasBeforeRequest", true);
		if (sb.length() > 2){
			getSession().put("beforeRequest", sb.insert(0, '?').insert(0, ServletActionContext.getRequest().getServletPath()).toString());
		}
		else{
			getSession().put("beforeRequest", ServletActionContext.getRequest().getServletPath().toString());
		}
	}
	
	protected boolean hasBeforeRequest(){
		boolean bRet = getSession().containsKey("hasBeforeRequest");
		if (bRet){
			getSession().remove("hasBeforeRequest");
		}
		
		return bRet;
	}
}
