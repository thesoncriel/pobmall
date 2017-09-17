package artn.common.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import artn.common.Const;
import artn.common.JSON;
import artn.common.Property;
import artn.common.Util;
import artn.common.Validator;

/**
 * 
 * @author shkang<br/>
 * Json처리, util객체, 유효성검사, struts-property에 정의된
 * 기능을 사용하기 위한 액션 클래스
 * @class
 */
public abstract class AbsUtilitySupportActionController extends AbsActionController {
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = -8221988525151833202L;

	private String contents = null;
	private String responseText = "";
	
	protected Util util = Util.getInstance();
	protected Validator valid = Validator.getInstance();
	protected Property prop = Property.getInstance();
	
	protected String successOrJsonList(){ return (getParams().containsKey("json"))? JSONLIST : SUCCESS; }
	protected String successOrJsonShow(){ return (getParams().containsKey("json"))? JSONSHOW : SUCCESS; }
	protected String successOrJsonList(String... keys){ getParams().put("keys", keys); return successOrJsonList(); }
	protected String successOrJsonShow(String... keys){ getParams().put("keys", keys); return successOrJsonShow(); }
	protected String successOrLogin(){ return returnBeforeCheckLogin(SUCCESS); }
	protected String successOrAuth(String authName){ return returnBeforeCheckAuth(SUCCESS, authName); }
	protected String returnBeforeCheckLogin(String retStr){ return (user() != null)? retStr : LOGIN; }
	protected String returnBeforeCheckAuth(String retStr, String authName){
		return (getAuth().isAuthByName(authName) == true)? retStr : ERROR_AUTH; 
	}
	
	public Util getUtil(){
		return util;
	}
	/**
	 * listData를 Json 형식으로 출력	
	 * @return
	 */
	public String getJsonList(){
		return JSON.encode(getListData(), getParams().get("keys")).toString();
	}
	/**
	 * showData를 Json 형식으로 출력
	 * @return
	 */
	public String getJsonShow(){
		return JSON.encode(getShowData(), getParams().get("keys")).toString();
	}
	/**
	 * JsonShow를 통해 Json데이터를 클라이언트에 스트림 방식으로 전달하기 위한 InputStream을 가져온다.
	 * @return
	 */
	public InputStream getJsonShowStream(){
		try {
			return new ByteArrayInputStream( getJsonShow().getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * JsonList를 통해 Json데이터를 클라이언트에 스트림 방식으로 전달하기 위한 InputStream을 가져온다.
	 * @return
	 */
	public InputStream getJsonListStream(){
		try {
			return new ByteArrayInputStream( getJsonList().getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 싱글Parameter에서 page번호를 받아오기 위해 사용.
	 * @return
	 */
	public int getPage(){
		Map<String, Object> mapParams = getParams();
		if ((mapParams.containsKey(Const.KEY_PAGE) == true)){
			return Integer.parseInt(mapParams.get(Const.KEY_PAGE).toString());
		}
		return 1;
	}
	/**
	 * 싱글Parameter에서 ContentsCode를 불러온다.
	 */
	// FIXME: 다양한 컨텐츠 코드로 변환할 수 있게 변경 할 것 - 2013.09.06 by jhson
	public String getContentsCode(){
		if (contents == null){
			if (getParams().containsKey("contents") == true){
				contents = getParams().get("contents").toString();
				if (contents.equals("") == false){
					return contents;
				}
					
			}
			if (getAuth().getIsAdmin() == true) 			contents = Const.CONTENTS_ADMIN;
			else if (getAuth().getIsSiteStaff() == true ) 	contents = Const.CONTENTS_SITE_STAFF;
			else if (user().getHasAnyGroup() == true) 		contents = Const.CONTENTS_GROUP_MANAGER;
			else 											contents = Const.CONTENTS_USER;
		}
		return contents;
	}
	/**
	 * responseText를 통해 text를 클라이언트에 스트림 방식으로 전달하기 위한 InputStream을 가져온다.
	 * @return
	 */
	public InputStream getResponseStream(){
		try {
			return new ByteArrayInputStream( responseText.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * getResponse()로 전송할 text를 설정한다.
	 * @param text
	 */
	public void setResponse(String text){
		this.responseText = text;
	}
	/**
	 * serResponse()로 설정한 text를 출력한다.
	 * @return
	 */
	public String getResponse(){
		return this.responseText;
	}
	/**
	 * 엑셀 파일 생성을 위해 listData와 subData를 설정한다.
	 * @param listKey
	 * @param subKey
	 * @author yjyun
	 */
	public void InsertQueryKey(String listKey, String subKey){
		List<Map<String, Object>> listParam;
		List<Map<String, Object>> subParam;
		
		dbm().open();
			listParam =	dbm().selectNonOpen(listKey, util.createMap());
			session().put("listParam", listParam);
		if(subKey != null || subKey != ""){
			subParam = dbm().selectNonOpen(subKey, util.createMap());
			session().put("subParam", subParam);
		}
		dbm().close();
	}
	/**
	 * listData의 인수로 엑셀 파일을 생성한다.
	 * @param Data
	 * @return
	 */
	public ByteArrayInputStream makeExcel(List<Map<String, Object>>... Data) {
		
		HSSFWorkbook createExcel = new HSSFWorkbook();
		ByteArrayOutputStream baos = null;
		
		for(int i =0 ; i < Data.length ; i++){
			HSSFSheet createSheet = createExcel.createSheet("sheet"+(i+1));
			HSSFCell createCellname;
			HSSFRow createRow;
			HSSFCell createCell;
			String sKey = "";
			
			Map<String, Object> nameMap =  Data[i].get(0);
			Map<String, Object> createCellMap;
			HSSFRow createRowName = createSheet.createRow(0);
			Iterator<String> iterKeys = nameMap.keySet().iterator();
			
			int iDataSize = Data[i].size();
			int iNameSize = nameMap.size();
			int nameCellNum = 0;
			
			String[] createKeyset = new String[ iNameSize ];
			
	
			while (iterKeys.hasNext()) {
				sKey = iterKeys.next();
	
				createCellname = createRowName.createCell(nameCellNum);
				createCellname.setCellValue( sKey );
				createKeyset[nameCellNum] = sKey;
				nameCellNum++;
			}
			for (int rowNum = 1; rowNum <= iDataSize; rowNum++) {
				createRow = createSheet.createRow(rowNum);
				createCellMap = Data[i].get(rowNum - 1);
	
				for (int cellNum = 0; cellNum < iNameSize; cellNum++) {
					createCell = createRow.createCell(cellNum);
					createCell.setCellValue( createCellMap.get(createKeyset[cellNum]).toString() );
				}
			}
		}
		try {	
			baos = new ByteArrayOutputStream();
			createExcel.write(baos);

			return new ByteArrayInputStream(baos.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
			return null; 
		}
	}
}
