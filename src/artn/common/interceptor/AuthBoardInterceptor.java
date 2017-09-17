package artn.common.interceptor;

import java.util.Map;

import artn.common.manager.AuthManager;
import artn.common.manager.BoardManager;
import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthBoardInterceptor implements Interceptor {

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
		Object oBoardNo = params.get("board_no");
		String sName = actInvo.getInvocationContext().getName();
		BoardManager boardManager = BoardManager.getInstanceFromSession(session);

		try{
			if		(sName.equals("list")){
				if (boardManager.isAuthList(oBoardNo, user) == false) return "error_auth";
			}
			else if	(sName.equals("show")) {
				if (boardManager.isAuthShow(oBoardNo, user) == 	false)	return "error_auth";
			}
			else if	(sName.equals("write") || sName.equals("edit") || sName.equals("modify")){
				if (boardManager.isAuthModifiy(oBoardNo, user) == false) return "error_auth";
			}
			else if	(sName.equals("delete")){
				if (boardManager.isAuthDelete(oBoardNo, user) == false)	return "error_auth";
			}
			
		} catch(Exception e){}

		return actInvo.invoke();
	}
	
	 
}
