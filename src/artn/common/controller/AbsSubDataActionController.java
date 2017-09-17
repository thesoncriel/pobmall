package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.Const;

/**
 * 
 * @author shkang<br/>
 * 다중 쿼리를 수행해야 할경우 사용하는
 * 액션 클래스
 * @class
 */
public abstract class AbsSubDataActionController extends AbsUtilitySupportActionController {
	
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -5461558561872975236L;
	protected Map< String, List<Map<String, Object>> > subResult;
	protected Map<String, Integer> subRowCount;
	protected Map<String, Boolean> subIsNull;
	
	/**
	 * SubData에서 각 Key에 해당하는 ListData들을 Map형식으로 불러온다.
	 * @return
	 */
	public Map<String, List<Map<String, Object>> > getSubData(){
		if ((subResult == null) || (subIsNull == null)){
			subResult = new HashMap<String, List<Map<String, Object>> >();
			subRowCount = new HashMap<String, Integer>();
			subIsNull = new HashMap<String, Boolean>();
		}
		return subResult;
	}
	/**
	 * SubData에서 각 Key에 해당하는 List의 RowCount들을 Map형식으로 불러온다.
	 * @return
	 */
	public Map<String, Integer> getSubRowCount(){
		return subRowCount;
	}
	/**
	 * SubData에서 각 Key에 해당하는 List의 null 체크여부를 Map형식으로 불러온다.
	 * @return
	 */
	public Map<String, Boolean> getSubIsNull(){
		return subIsNull;
	}
	/**
	 * listData() 외에 list형식의 데이터가 필요할 경우 사용.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param subName list별 name key
	 * @param queryKey
	 */
	public void doShowSub(String subName, String queryKey){
		doShowSub(subName, queryKey, true);
	}
	
	/**
	 * listData() 외에 list형식의 데이터가 필요할 경우 사용.<br/>
	 * dbm().open(), dbm().close()가 선택적으로 이루어진다.
	 * @param subName list별 name key
	 * @param queryKey
	 * @param doOpen DB의 오픈 여부를 결정한다.(true, false)
	 */
	public void doShowSub(String subName, String queryKey, boolean doOpen){
		int iRowCount = 0;
		List<Map<String, Object>> lmResult;
		
		if (doOpen) dbm().open();
		
		lmResult = dbm().selectNonOpen(queryKey, getParams());
		getSubData().put(subName, lmResult);
		
		try{
			iRowCount = Integer.parseInt( lmResult.get(0).get(Const.KEY_ROW_COUNT).toString() );
			subRowCount.put(subName, iRowCount);
		}
		catch(Exception ex){
			err = ex.toString();
			subRowCount.put(subName, 0);
		}
		
		if (doOpen) dbm().close();
		
		subIsNull.put(subName, (lmResult == null) || (lmResult.size() == 0) );
	}
	/**
	 * listData() 외에 list형식의 데이터가 여러개 필요할 경우 사용.<br/>
	 * subNameQueryKeyPairs는 subName과 queryKey 짝수로 이루어져야한다.<br/>
	 * String subName, String queryKey, String subName, String queryKey ...<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param subNameQueryKeyPairs
	 */
	public void doShowSub(String... subNameQueryKeyPairs){
		int iRowCount = 0;
		int iLen = subNameQueryKeyPairs.length;
		String subName = "";
		
		getSubData().putAll( dbm().selectMulti(subNameQueryKeyPairs, getParams()) );
		
		for(int i = 0; i < iLen; i+=2){
			try{
				subName = subNameQueryKeyPairs[i];
				iRowCount = Integer.parseInt(subResult.get(subName).get(0).get(Const.KEY_ROW_COUNT).toString());
				subRowCount.put(subName, iRowCount);
			}
//			catch(NullPointerException ex){}
//			catch(IndexOutOfBoundsException ex){}
			catch(Exception ex){
				err = ex.toString();
				subRowCount.put(subName, 0);
			}
			subIsNull.put(subName, (subResult == null) || (subResult.get(subName).size() == 0) );
		}
	}
	/**
	 * listData() 외에 list형식의 데이터가 필요할 경우 사용.<br/>
	 * 배열Parameter에서 usingKey에 해당하는 Parameter를 불러오기위해 사용.<br/>
	 * dbm().open(), dbm().close()가 선택적으로 이루어진다.
	 * @param subName
	 * @param queryKey
	 * @param doOpen DB의 오픈 여부를 결정한다.(true, false)
	 * @param usingKeys "name","phone","id" 등과 같이 사용
	 */
	public void doShowSub(String subName, String queryKey, boolean doOpen, String... usingKeys){
		int iRowCount = 0;
		int iLen = getArrayParams().get( usingKeys[0] ).length;
		String sCurrSubName = "";
		List<Map<String, Object>> lmResult = null;
		
		if (doOpen) dbm().open();
		
		for(int i = 0; i < iLen; i++){
			sCurrSubName = subName + i;
			try{
				for(String key : usingKeys){
					getParams().put(key, getArrayParams().get(key)[i]);
				}
				
				lmResult = dbm().selectNonOpen(queryKey, getParams());
				getSubData().put(sCurrSubName, lmResult);
				iRowCount = Integer.parseInt(lmResult.get(0).get(Const.KEY_ROW_COUNT).toString());
				subRowCount.put(sCurrSubName, iRowCount);
			}
//			catch(NullPointerException ex){}
//			catch(IndexOutOfBoundsException ex){}
			catch(Exception ex){
				err = ex.toString();
				subRowCount.put(sCurrSubName, 0);
			}
			subIsNull.put(sCurrSubName, (lmResult == null) || (lmResult.size() == 0) );
		}
		
		if (doOpen) dbm().close();
	}
	/**
	 * doEdit 외에 입력,수정 할 경우 사용한다.<br/>
	 * 싱글Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param queryKey_SubData
	 */
	public void doEditSub(String queryKey_SubData){
		doEditSub(queryKey_SubData, "", "", true);
	}
	/**
	 * doEdit 외에 입력,수정 할 경우 사용한다.<br/>
	 * 싱글Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 선택적으로 이루어진다.
	 * @param queryKey_SubData
	 * @param doCommit
	 */
	public void doEditSub(String queryKey_SubData, boolean doCommit){
		doEditSub(queryKey_SubData, "", "", doCommit);
	}
	
	/**
	 * doEdit 외에 입력,수정 할 경우 사용한다.<br/>
	 * 배열Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param queryKey_SubData
	 * @param lengthCriteriaKey 배열의 길이를 구할 수 있도록 구분할 key 
	 */
	public void doEditSub(String queryKey_SubData, String lengthCriteriaKey){
		doEditSub(queryKey_SubData, "", lengthCriteriaKey, true);
	}
	
	/**
	 * doEdit 외에 삭제후 입력,수정 할 경우 사용한다.<br/>
	 * 배열Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param queryKey_SubData
	 * @param queryKey_DeleteDuplicate 삭제가 이루어질 queryKey
	 * @param lengthCriteriaKey 배열의 길이를 구할 수 있도록 구분할 key 
	 */
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, true);
	}
	/**
	 * doEdit 외에 삭제후 입력,수정 할 경우 사용한다.<br/>
	 * 배열Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param queryKey_SubData
	 * @param queryKey_DeleteDuplicate 삭제가 이루어질 queryKey
	 * @param lengthCriteriaKey 배열의 길이를 구할 수 있도록 구분할 key 
	 * @param doCommit DB의 open,close 및 commit 여부를 결정 (true, false)
	 */
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, boolean doCommit){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, getParams(), doCommit);
	}
//	/**
//	 * 
//	 * @param queryKey_SubData			반복할 쿼리키
//	 * @param queryKey_DeleteDuplicate	삭제 기능을 수행할 쿼리키. 수행전 삭제가 필요하다면 사용한다.
//	 * @param lengthCriteriaKey			배열 파라매터 중 그 배열 길이의 기준이 되는 파라메터키
//	 * @param doCommit					수행 후 곧바로 커밋을 할지의 여부
//	 */
	/**
	 * doEdit 외에 삭제후 입력,수정 할 경우 사용한다.<br/>
	 * 배열Parameter일 경우 사용한다.<br/>
	 * dbm().open(), dbm().close()가 이루어진다.
	 * @param queryKey_SubData
	 * @param queryKey_DeleteDuplicate 삭제가 이루어질 queryKey
	 * @param lengthCriteriaKey 배열의 길이를 구할 수 있도록 구분할 key 
	 * @param mParams 배열Parameter외에 반복적으로 들어갈 싱글Parameter
	 * @param doCommit DB의 open,close 및 commit 여부를 결정 (true, false)
	 */
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, Map<String, Object> mParams, boolean doCommit){
		try{
			Map<String, String[]> mArrParams = getArrayParams();
			String[] keys = mArrParams.keySet().toArray(new String[0]);
			String key = "";
			String[] saValues;
			int iLen = 0;
			
			if (lengthCriteriaKey.equals("") == true){
				iLen = getMultiParamArrayLength();
			}
			else if (mArrParams.containsKey(lengthCriteriaKey) == true){
				iLen = mArrParams.get(lengthCriteriaKey).length;
			}
			
			if (doCommit == true) dbm().open();
			
			if (queryKey_DeleteDuplicate.equals("") == false){
				dbm().deleteNonCommit(queryKey_DeleteDuplicate, mParams);
			}
			
			if (iLen == 0){
				if (mParams.containsKey(lengthCriteriaKey) == true){
					dbm().updateNonCommit(queryKey_SubData, mParams);
				}
			}
			else{
				for(int iDataIdx = 0; iDataIdx < iLen; ++iDataIdx){
					for(int iKeyIdx = 0; iKeyIdx < keys.length; ++iKeyIdx){
						key = keys[iKeyIdx];
						saValues = mArrParams.get(key);

						if (saValues.length < iLen) continue;

						mParams.put(key, saValues[iDataIdx]);
					}
					dbm().updateNonCommit(queryKey_SubData, mParams);
				}
			}
			
			
			if (doCommit == true){
				dbm().commit();
				dbm().close();
			}
		}
		catch(NullPointerException ex){}
		catch(Exception ex){
			System.out.println(ex);
			dbm().close();
		}
	}
}
