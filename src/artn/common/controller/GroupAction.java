package artn.common.controller;

import java.util.HashMap;
import java.util.Map;
import artn.common.Const;
import artn.common.FileNameChangeMode;

public class GroupAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1568950975487808157L;
	//private boolean hasAuthGroup = false;
	
	public String extractSrcFromDaumMap(String htmlContent, String width, String height) {
		String sTag = htmlContent;
		int iUrlStart = sTag.indexOf("\"");
		int iUrlEnd = sTag.indexOf("\"", iUrlStart + 1);
		int iWidthStart = sTag.indexOf("width=");
		int iWidthEnd = sTag.indexOf("&height");
		int iHeightStart = sTag.indexOf("height=");
		int iHeightEnd = sTag.indexOf("&", iWidthEnd + 1);
			
		String sWidth = sTag.substring(iWidthStart + 6, iWidthEnd);
		String sHeight = sTag.substring(iHeightStart+7, iHeightEnd);
		
		String sTagChange = sTag.replace("width=" + sWidth+"&height=" + sHeight, "width=" + width + "&height=" + height);
		String sUrl = sTagChange.substring(iUrlStart+1, iUrlEnd);
		
		return sUrl;
	}
	@Override
	public String list() throws Exception {
		if (getParams().containsKey("groupType") == true){
			getParams().put("group_type", getGroupTypeCode( getParams().get("groupType") ));
		}
		
		doList("group-all");
		if( (getAuth().getIsAdmin() == true) && 
			(getContentsCode().equals(Const.CONTENTS_ADMIN) == true) ){
			return "admin";
		}else{
			return SUCCESS;	
		}
		
	}
	
	protected int getGroupTypeCode(Object groupType){
		if (groupType.equals("service") == true) return 0x1;
		if (groupType.equals("seller") == true) return 0x2;
		if (groupType.equals("medical") == true) return 0x4;
		if (groupType.equals("pension") == true) return 0x8;
		if (groupType.equals("cafe") == true) return 0x10;
		
		return 0;
	}

	@Override
	public String show() throws Exception {
		// TODO: 그룹 공개 여부에 따라 권한 오류로 내보내는 기능 필요함 (먼 훗날...) - 2013.08.05 by jhson
		if (user() != null){
			user().setIdGroup( getParams().get("id").toString() );
		}
		
		doShow("group-single");
		
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if (user() == null) return LOGIN;
		Map<String, Object> mParam = getParams();
		Map<String, String[]> msaParam = getArrayParams();
		
		try{
			valid.checkEmptyValue(mParam, "", "homepage", "zipcode_group", "address_group_new", "address_group1", "address_group2", "date_estab");
			valid.mergeIntValuesToMap(mParam, msaParam, "group_type");
			valid.checkEmptyValue(mParam, util.getNow(), "date_create");
			valid.appendAndPutToMap(mParam, msaParam, "phone_group", "-");
			valid.appendAndPutToMap(mParam, msaParam, "phone_fax", "-");
			valid.checkFileExists(mParam, "file_img", "file_banner");
			makeDaumMapUrl(mParam, "map_coord", "map_url", "name");
			
			if (hasFileParams() == true){
				saveFileToAuto(getDownloadPath() + "/upload/group/", "", FileNameChangeMode.parentheses);
			}
			doEdit("group-modify");
			if (mParam.containsKey("id") == false){
				mParam.put( "id_group", dbm().selectOne("common-inserted-id", mParam).get("id") );
				mParam.put("insertValue", prop.get("artn.group.authMaking"));
				return "modifyForNew";
			}
		}catch(Exception ex){
			return ERROR_AUTH;
		}
		
		return SUCCESS;
	}
	
	protected void makeDaumMapUrl(Map<String, Object> destData, String keyMapCoord, String keyMapUrl, String keyLocationName){
		try{
			String sCoord = destData.get( keyMapCoord ).toString();
			String[] saCoord = sCoord.split(",");
			StringBuilder sbMapUrl = new StringBuilder("http://dna.daum.net/examples/maps/MissA/map_view.php?width=660&height=400&latitude=");
	
			sbMapUrl.append(saCoord[0].trim())
			.append("&longitude=").append(saCoord[1].trim())
			.append("&contents=").append(destData.get( keyLocationName ).toString())
			.append("&zoom=4");
	
			getParams().put( keyMapUrl, sbMapUrl.toString() );
		}
		catch(Exception ex){
			destData.put( keyMapCoord, /*"37.66175495311978,126.76981768345294"*/"");
			destData.put( keyMapUrl, "");
		}
	}
	
	public String companyList() throws Exception{
		doList("group-company-list");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("id", 0);
		map.put("name", "미등록 기업");
		
		getListData().add(map);
		
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		user().setIdGroup( getParams().get("id").toString() );
		show();
		return successOrAuth("GroupAdmin");
	}
	@Override
	public String write() throws Exception {
		if (user() == null) return LOGIN;
		return successOrAuth("GroupAdmin");
	}
	@Override
	public String delete() throws Exception {
		if (user() == null) return LOGIN;
		String sRet = successOrAuth("GroupAdmin");
		
		if (sRet.equals(SUCCESS) == true){
			doEdit("group-delete");
		}
		
		return sRet;
	}
	
	public boolean getIsGroupAdmin(){
		return getAuth().getIsGroupAdmin();
	}
}