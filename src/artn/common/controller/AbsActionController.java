package artn.common.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import artn.common.Const;
import artn.common.IActionController;
import artn.common.manager.AuthManager;
import artn.common.model.User;
import artn.database.IDBManager;
import artn.database.DBManager;

/**
 * 
 * @author shkang<br/>
 * 액션 컨트롤러의 최상위 클래스.<br/>
 * List 와 Show, Edit 3가지로 액션 수행 메서드를 구별 해 주며,
 * 이에 사용되는 공통적인 기능을 포함 한다.
 * @class
 */
public abstract class AbsActionController extends ActionSupport implements IActionController  {
	/**
	 * 액션 리절트 상수: 권한 에러에 대한 것.  
	 */
	public static final String ERROR_AUTH = "error_auth";
	/**
	 * 액션 리절트 상수: 메인 화면에 대한 것.
	 */
	public static final String MAIN = "main";
	/**
	 * 액션 리절트 상수: 최초 페이지(index)에 대한 것.
	 */
	public static final String INDEX = "index";
	public static final String MENU = "menu";
	public static final String JOIN = "join";
	public static final String GOTOBACK = "gotoback";
	public static final String JSONSHOW = "jsonshow";
	public static final String JSONLIST = "jsonlist";
	public static final String TEXT_RESPONSE = "text_response";
	public static final String BEFORE_REQUEST = "before_request";
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -4488248587753628803L;
	private IDBManager dbm;
	private Map<String, Object> session;
	private Map<String, Object> mParams;
	protected Map<String, Object> doShowResult;
	protected List<Map<String, Object>> doListResult;
	private int rowCount = 0;
	protected String err = "";
	private String actionURI;
	//private Map<String, String> singleParams = new HashMap<String, String>();
	private Map<String, File[]> fileParams = new HashMap<String, File[]>();
	private Map<String, String[]> arrayParams = new HashMap<String, String[]>();
	protected boolean showIsNull = true;
	private int multiParamArrayLength = 0;
	private boolean converted = false;
	protected AuthManager authMgr;
	private User user;
	private Map<String, String> error = null;

	/**
	 * 사용자 요청 파라메터 값을 Map Collection 형식의 모델로써 가져 온다.<br/>
	 * 내부에서 사용되는 메서드 이므로 직접적인 사용은 권장하지 않는다.<br/>
	 * 대신 getParams()를 사용하자.
	 * @deprecated
	 */
	public Map<String, Object> getModel() {
		mParams = new HashMap<String, Object>();
		return mParams;
	}

	public IDBManager dbm() {
		if (dbm == null){
			try {
				dbm = DBManager.getInstanceFromSession(session());
//				dbm = new DBManager();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return dbm;
	}
	/**
	 * 파일을 올렸을때 파일Parameter의 매개변수를 불러온다.
	 * @return
	 */
	public Map<String, File[]> getFileParams(){
		if (converted == false){
			getParams();
		}
		return fileParams;
	}
	/**
	 * 배열로 이루어진 parameter의 매개변수를 불러온다.
	 * @return
	 */
	public Map<String, String[]> getArrayParams(){
		if (converted == false){
			getParams();
		}
		return arrayParams;
	}
	/**
	 * 싱글Parameter의 매개변수를 불러온다.
	 */
	public Map<String, Object> getParams(){
		if (converted == false){
			this.convertSingleParamAtArray( mParams );
			ActionContext.getContext().getParameters().putAll(mParams);
			mParams = ActionContext.getContext().getParameters();
		}
		return mParams;
	}
	/**
	 * 저장된 session의 객체를 불러온다.
	 * @return
	 */
	public Map<String, Object> getSession(){
		return session();
	}
	protected Map<String, Object> session(){
		if (session == null){
			session = ActionContext.getContext().getSession();
		}
		return session;
	}
	@SuppressWarnings("unchecked")
	protected Map<String, Object> sessionToMap(String key){
		try{
			return (Map<String, Object>)session.get(key);
		}
		catch(ClassCastException ex){}
		catch(NullPointerException ex){}
		
		return null;
	}
	/**
	 * listData의 Row수를 가지고 온다.
	 * @return
	 */
	public int getRowCount(){
		return rowCount;
	}
	
	/**
	 * 에러메세지를 출력할때 사용한다.
	 * @deprecated
	 * @return
	 */
	public Map<String, String> getError(){
		if (this.error == null){
			this.error = new HashMap<String, String>();
		}
		return this.error;
	}

	/**
	 * 
	 * @param params 싱글 스트링으로 변환하고자 하는 대상 Map 데이터.
	 * @return
	 */
	private Map<String, Object> convertSingleParamAtArray(Map<String, Object> params){
		Iterator<Entry<String, Object>> entryIter = params.entrySet().iterator();
		Entry<String, Object> entry = null;
		String sKey = "";
		Object objValue = null;
		String[] saValues = null;
		File[] fileValues = null;
		this.multiParamArrayLength = 0;
		
		fileParams.clear();
		arrayParams.clear();

		while(entryIter.hasNext() == true){
			entry = entryIter.next();
			sKey = entry.getKey();
			objValue = entry.getValue();
			if (objValue instanceof java.lang.String[]){
				saValues = (String[])entry.getValue();
				if (saValues.length > 1){
					arrayParams.put(sKey, saValues);
					if (multiParamArrayLength == 0){
						multiParamArrayLength = saValues.length;
					}
				}
				else{
					params.put(sKey, saValues[0]);
				}
			}
			else if (objValue instanceof java.io.File[]){
				fileValues = ((File[])entry.getValue());
				fileParams.put(sKey, fileValues);
			}
		}
		converted = true;
		
		return params;
	}
	
	/**
	 * 처리된 Map 형식의 데이터를 출력한다. 
	 */
	public Map<String, Object> getShowData() {
		if (doShowResult == null){
			showIsNull = true;
			doShowResult = new HashMap<String, Object>();
		}
		return doShowResult;
	}

	/**
	 * 처리된 List 형식의 데이터를 출력한다. 
	 */
	public List<Map<String, Object>> getListData() {
		return doListResult;
	}
	
	/**
	 * Action이 이루어질 URI를 저장한다.
	 * @param uri
	 */
	public void setActionURI(String uri){
		this.actionURI = uri;
	}
	/**
	 * 저장된 Action의 URI를 불러온다.
	 * @return
	 */
	public String getActionURI(){
		return actionURI;
	}
	
	/**
	 * 파일을 올렸는지 여부를 체크한다.
	 * @return
	 */
	public boolean hasFileParams(){
		if(converted == false){
			getParams();
		}
		
		return this.fileParams.size() > 0;
	}
	/**
	 * ArrayParams의 유무를 판단한다.
	 * @return
	 */
	public boolean hasArrayParams(){
		return this.arrayParams.size() > 0;
	}
	
	/**
	 * queryKey를 이용하여 DB의 정보를 List형식으로 출력하기 위해 설정한다.<br/>
	 * getListData()를 이용하여 출력할수 있다.<br/>
	 * dbm().open() , dbm().close()가 이루어진다.
	 * @param queryKey
	 */
	public void doList(String queryKey){
		doListResult = dbm().select(queryKey, getParams());
		try{
			rowCount = Integer.parseInt(doListResult.get(0).get(Const.KEY_ROW_COUNT).toString());
		}
		catch(Exception ex){
			err = ex.toString();
			rowCount = 0;
		}
	}
	/**
	 * queryKey를 이용하여 DB의 정보를 Map형식으로 출력하기 위해 설정한다.<br/>
	 * getShowData()를 이용하여 출력할수 있다.<br/>
	 * dbm().open() , dbm().close()가 이루어진다.
	 * @param queryKey
	 */
	public void doShow(String queryKey){
		doShow(queryKey, true);
	}
	/**
	 * queryKey를 이용하여 DB의 정보를 Map형식으로 출력하기 위해 설정한다.<br/>
	 * getShowData()를 이용하여 출력할수 있다.<br/>
	 * dbm().open() , dbm().close()가 선택적으로 이루어진다.
	 * @param queryKey
	 * @param open DB의 오픈 여부를 결정한다.(true, false)
	 */
	public void doShow(String queryKey, boolean open){
		if ((getParams().containsKey("id") == true) &&
				(getParams().get("id").equals("") == false)){
			setActionURI("modify.action");
		}
		else{
			setActionURI("write.action");
		}
		if (open == true) dbm().open();
		doShowResult = dbm().selectOneNonOpen(queryKey, getParams());
		if (open == true) dbm().close();
		showIsNull = false;
	}
	
	/**
	 * queryKey를 이용하여 DB에 데이터를 입력,수정 처리 해준다.
	 * dbm().open(), dbm().commit(), dbm().close()가 이루어진다.
	 * @param queryKey
	 */
	public void doEdit(String queryKey){
		dbm().open();
		dbm().updateNonCommit(queryKey, getParams());
		dbm().commit();
		dbm().close();
	}
	
	/**
	 * queryKey를 이용하여 DB에 데이터를 입력,수정 처리 해준다.
	 * queryKey 수 만큼 수행한다.
	 * dbm().open(), dbm().commit(), dbm().close()가 이루어진다.
	 * @param queryKey
	 */
	public void doEdit(String... queryKey){
		dbm().open();
		for(String qryKey: queryKey){
			dbm().updateNonCommit(qryKey, getParams());
		}
		dbm().commit();
		dbm().close();
	}
	/**
	 * queryKey를 이용하여 DB에 데이터를 입력,수정 처리 해준다.
	 * dbm().open(), dbm().commit(), dbm().close()가 선택적으로 이루어진다.
	 * @param queryKey
	 * @param doCommit DB의 open,close 및 commit 여부를 결정 (true, false)
	 */
	public void doEdit(String queryKey, boolean doCommit){
		if (doCommit) dbm().open();
		dbm().updateNonCommit(queryKey, getParams());
		if (doCommit){
			dbm().commit();
			dbm().close();
		}
	}

	/**
	 * showData의 null 체크를 한다.
	 * @return
	 */
	public boolean getShowIsNull(){
		return showIsNull || (doShowResult == null);
	}
	/**
	 * listData의 null 체크를 한다.
	 * @return
	 */
	public boolean getListIsNull(){
		return (this.doListResult == null) || (this.doListResult.size() == 0);
	}
	/**
	 * Login 유무를 체크한다.
	 * @return
	 */
	public boolean getHasLogin(){
		return user() != null;
	}
	/**
	 * @ignore
	 * @return
	 */
	public int getMultiParamArrayLength(){
		return this.multiParamArrayLength;
	}
	/**
	 * @ignore
	 * @param key
	 */
	public void setMultiParamArrayLengthByKey(String key){
		try{
			this.multiParamArrayLength = this.arrayParams.get(key).length;
		}
		catch(NullPointerException ex){
			this.err = ex.toString();
			this.multiParamArrayLength = 0;
		}
	}
	/**
	 * Login 후 session에 저장된 user객체의 값을 불러온다.
	 * @return
	 */
	protected User user(){
		if (user == null){
			try{
				user = (User)session().get("user");
			}
			catch(NullPointerException ex){ }
		}
		return user;
	}
	/**
	 * session에 저장된 user 정보의 권한을 불러온다.
	 * @return
	 */
	public AuthManager getAuth(){
		if (authMgr == null){
			authMgr = new AuthManager(user());
		}
		return authMgr;
	}
	
	/**
	 * 싱글Parameter에 key가 존제 하는지 확인한다.
	 * @param key
	 * @return
	 */
	public boolean isNullParams(String key){
		return getParams().containsKey(key);
	}
		// TODO: 요청 URI 가져오는 로직 구현해야됨. - 2013.08.05 by jhson  
	/*
	public String getSaveRequestURI(){

		return ActionContext.getContext().get( "javax.servlet.forward.request_uri" ).toString() + "____";
		//return ActionContext.getContext().getValueStack().pop().toString();// .findValue( "javax.servlet.forward.request_uri" ).toString() + "ddd";
		//return ActionContext.getContext().getContextMap().get("javax.servlet.forward.request_uri").toString();
		//ActionContext.getContext(). request.getAttribute( "javax.servlet.forward.request_uri" )
	}*/

	public abstract String list() throws Exception;
	public abstract String show() throws Exception;
	public abstract String edit() throws Exception;
	public abstract String write() throws Exception;
	public abstract String modify() throws Exception;
	public abstract String delete() throws Exception;
}
