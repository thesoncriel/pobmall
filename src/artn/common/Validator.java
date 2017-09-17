package artn.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * @author shkang
 * 유효성 검사를 하는 클래스
 * @class
 */
public class Validator {
	private static Validator field = null;
	private static final String SIMPLE_XSS_REGEX = "(?i)(.)*(<(/)?(script|xmp|iframe|body|object|applet|embed|form))(/)?(.)*>?(.)*";
	private static final Pattern[] XSS_PATTERNS = new Pattern[] {
		Pattern.compile(SIMPLE_XSS_REGEX),
		// Script fragments
		Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
		// src='...'
		Pattern.compile(SIMPLE_XSS_REGEX + "(.*?)src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile(SIMPLE_XSS_REGEX + "(.*?)src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// lonely script tags
		Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
		Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// eval(...)
		Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// alert(...)
		Pattern.compile("alert\\((.*?)\\)\\;", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("alert\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// expression(...)
		Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// javascript:...
		Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
		// vbscript:...
		Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
			
			// onload(...)=...
		Pattern.compile("onload(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),		
		Pattern.compile("onmousewheel(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onclick(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeydown(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeypress(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onchange(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("ondblclick(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeyup(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onsubmit(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onblur(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("refresh(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onfocus(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onerror(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onmouseover(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("style(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	};
	
	public static Validator getInstance(){
		if (field == null){
			field = new Validator();
		}
		return field;
	}
	
	protected Validator(){}
	
	/**
	 * @ignore
	 * @param data
	 * @param key
	 * @param delimiter
	 * @return
	 */
	public Map<String, Object> splitAndPutToMap(Map<String, Object> data, String key, String delimiter){
		return splitAndPutToMap(data, key, delimiter, 0);
	}
	
	/**
	 * @ignore
	 * @param data
	 * @param key
	 * @param delimiter
	 * @param numLimit
	 * @return
	 */
	public Map<String, Object> splitAndPutToMap(Map<String, Object> data, String key, String delimiter, int numLimit){
		try{
			String[] saValue = data.get(key).toString().split(delimiter);
			int inc = 0;
			
			if ((numLimit > 0) && (saValue.length != numLimit)){
				while(inc < numLimit){
					++inc;
					data.put(key + inc, "");
				}
				return data;
			}
			for(String sValue : saValue){
				++inc;
				data.put(key + inc, sValue);
			}
		}
		catch(NullPointerException ex){}
		
		return data;
	}
	/**
	 * Map Data에 현재 날짜를 Key로 저장한다.
	 * @param data
	 * @param key
	 * @return
	 */
	public Map<String, Object> insertNowToMap(Map<String, Object> data, String key){
		data.put(key, Util.getInstance().getNow());
		return data;
	}
	
	/**
	 * dataSrc에 key에 해당하는 값을 추출하여<br/>
	 * delimiter로 연결하여 dataDest에 저장한다.
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @param delimiter
	 * @return
	 */
	public Map<String, Object> appendAndPutToMap(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, String delimiter){
		try{
			StringBuilder sb = new StringBuilder();
			String[] sList = dataSrc.get(key);
			
			for(String sItem : sList){
				sb.append(sItem)
				.append(delimiter);
			}
			sb.deleteCharAt(sb.length() - 1);
			
			dataDest.put(key, sb.toString());
		}
		catch(NullPointerException ex){
			dataDest.put(key, "");
		}
		
		return dataDest;
	}
	
	/**
	 * params를 체크하여 keywords에 해당하는
	 * parameter에 defValue 값을 넣어준다. 
	 * @param params
	 * @param defValue
	 * @param keywords
	 */
	public void checkEmptyValue(Map<String, Object> params, Object defValue, String... keywords){
		boolean isNumericField = (defValue instanceof Integer) || (defValue instanceof Double);
		String sValue = null;
		
		if (isNumericField == false){
//			if (defValue == null){
//				for(String key : keywords){
//					if ((params.containsKey(key) == false) ||
//							(params.get(key).equals("") == true)){
//						params.remove(key);
//					}
//				}
//			}
//			else{
				for(String key : keywords){
					if ((params.containsKey(key) == false) ||
							(params.get(key).equals("") == true)){
						params.put(key, defValue);
					}
				}
//			}
		}
		else{
			for(String key : keywords){
				if (params.containsKey(key) == true){
					if ( (sValue = params.get(key).toString() ).equals("") == true ){
						params.put(key, defValue);
					}
					else if (sValue.length() > 1){
						if (sValue.startsWith(".") == true){
							params.put(key, '0' + sValue);
						}
						else if (sValue.endsWith(".") == true){
							params.put(key, sValue + '0');
						}
					}
				}
				else{
					params.put(key, defValue);
				}
			}
		}
	}
	
	/**
	 * params를 체크하여 key에 해당하는
	 * parameter에 defValue 값을 넣어준다.
	 * @param params
	 * @param defValue
	 * @param key
	 */
	public void checkEmptyValue(Map<String, Object> params, Object defValue, String key){
		if ((params.containsKey(key) == false) ||
				(params.get(key).equals("") == true)){
			params.put(key, defValue);
		}
	}
	
	/**
	 * arrayParams를 체크하여 keyword에 해당하는
	 * parameter에 defValue 값을 lengthCriteriaKey의
	 * length 만큼 넣어준다.
	 * @param arrayParams
	 * @param defValue
	 * @param keyword
	 * @param lengthCriteriaKey
	 */
	public void checkEmptyValues(Map<String, String[]> arrayParams, String defValue, String keyword, String lengthCriteriaKey){
		try{
			int iLen = arrayParams.get(lengthCriteriaKey).length;
			String[] saValues = arrayParams.get(keyword);
			String[] saTemp;
			int i = 0;
			
			if (saValues.length < iLen){
				saTemp = saValues;
				saValues = new String[iLen];
				
				for(; i < saTemp.length; i++){
					if ((saTemp[i] == null) || (saTemp[i].equals("") == true)){
						saValues[i] = defValue;
					}
					else{
						saValues[i] = saTemp[i];
					}
				}
			}
			
			for(; i < iLen; i++){
				if ((saValues[i] == null) || (saValues[i].equals("") == true)){
					saValues[i] = defValue;
				}
			}
		}
		catch(Exception ex){
			arrayParams.remove(keyword);
		}
	}
	public void checkFileExists(Map<String, Object> params, String key){
		String sFileExists = "";
		Object oFileName = params.get(key);
		
		if ( (oFileName instanceof java.lang.String != false) &&
			 (params.containsKey(key) == false) &&
			 (params.containsKey(key + "FileName") == false) && 
			 (params.containsKey(sFileExists = key + "_exists") == true) &&
			 (params.get(sFileExists).equals("") == false) ){
			params.put(key, params.get(sFileExists).toString());
		}
	}
	
	public void checkFileExists(Map<String, Object> params, String... keywords){
		String sFileExists = "";
		Object oFileName = null;
		
		for(String key : keywords){
			oFileName = params.get(key);
			
			if ( (oFileName instanceof java.lang.String != false) &&
				 (params.containsKey(key) == false) &&
				 (params.containsKey(key + "FileName") == false) && 
				 (params.containsKey(sFileExists = key + "_exists") == true) &&
				 (params.get(sFileExists).equals("") == false) ){
				params.put(key, params.get(sFileExists).toString());
			}
		}
	}
	
	/**
	 * @ignore
	 * @param params
	 * @param arrayParams
	 * @param fileParams
	 * @param fileKey
	 * @param followKeys
	 */
	public void checkFileArrayAdjusting(Map<String, Object> params, Map<String, String[]> arrayParams, Map<String, File[]> fileParams, String fileKey, String... followKeys ){
		String[] saFileExists;
		String sFileExistsKey, sValue;
		Map<String, String[]> msaFollowData = new HashMap<String, String[]>();
		int iNewIdx = 0, iOldIndex = 0, iLenFile, iLenExists;
		
		
		if (fileParams.containsKey(fileKey) == true){
			sFileExistsKey = fileKey + "_exists";
			iLenFile = fileParams.get(fileKey).length;
			
			// 배열 파라메터로 만들기 위해 맵에 스트링 배열 생성
			for(String sFollowKey : followKeys){
				msaFollowData.put(sFollowKey, new String[iLenFile]);
			}
						
			if ((arrayParams.containsKey(sFileExistsKey) == true)){
				saFileExists = arrayParams.get(sFileExistsKey);
				iLenExists = saFileExists.length;
				
				for(int i = 0; i < iLenExists; i++){
					if (saFileExists[i].equals("") == true){
						for(String sFollowKey : followKeys){
							sValue = arrayParams.get(sFollowKey)[i];
							
							if (sValue.equals("") == true){
								msaFollowData.get(sFollowKey)[iNewIdx] = null;
							}
							else{
								msaFollowData.get(sFollowKey)[iNewIdx] = sValue;
							}
						}
						iNewIdx++;
					}
				}
			}
			else{
				String sFileExists = params.get(sFileExistsKey).toString();
				
				if (sFileExists.equals("") == true){
					for(String sFollowKey : followKeys){
						if (params.get(sFollowKey) == null){
							msaFollowData.remove(sFollowKey);
						}
						else{
							msaFollowData.get(sFollowKey)[0] = params.get(sFollowKey).toString();
						}
					}
				}
			}
		}
		
		arrayParams.putAll(msaFollowData);
	}
	
	/**
	 * dataSrc에서 key에 해당하는
	 * 값을 추출한 후 싱글Parameter에 비트연산을 하여
	 * 삽입한 후 비트연산값을 리턴한다. 
	 * @param dataDest 싱글Parameter
	 * @param dataSrc 배열Parameter
	 * @param key
	 * @return
	 */
	public int mergeIntValuesToMap(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String[] saValue = dataSrc.get(key);
		int iSum = 0;
		
		if (saValue != null){
			for(String sVal : saValue){
				iSum = iSum | Integer.parseInt(sVal);
			}
		}
		else if (dataDest.containsKey(key) == true){
			iSum = Integer.parseInt(dataDest.get(key).toString());
		}
		
		dataDest.put(key, iSum);
		
		return iSum;
	}
	
	/**
	 * @ignore
	 * @param value
	 * @return
	 */
	public List<Integer> convertToCheckboxListValues(int value){
		return convertToCheckboxListValues(value, 31);
	}
	
	/**
	 * @ignore
	 * @param value
	 * @param size
	 * @return
	 */
	public List<Integer> convertToCheckboxListValues(int value, int size){
		List<Integer> list = new ArrayList<Integer>();
		int iShift = 1;
		
		for(int i = 1; i <= size; i++){
			if ((value & iShift) > 0){
				list.add(i);
			}
			iShift <<= 1;
		}
		
		return list;
	}
	
	/**
	 * textarea로 작성된 text에서
	 * "\r\n"을 "<br/>"로 변경한다.
	 * @param dataDest
	 * @param key
	 */
	public void replaceCRLFToBRTags(Map<String, Object> dataDest, String key){
		String sContent = " ";
		
		try{
			sContent = dataDest.get(key).toString();
		}
		catch(NullPointerException ex){
			dataDest.put(key, sContent);
			return;
		}
		
		if (sContent.contains("<br") == false){
			dataDest.put(key, sContent.replaceAll("\r\n", "<br/>"));
		}
	}
	
	/**
	 * 입력된 text 중 "<br/>"을
	 * "\r\n"로 변경한다.
	 * @param dataDest
	 * @param key
	 */
	public void replaceBRTagsToCRLF(Map<String, Object> dataDest, String key){
		String sContent = "";
		
		try{
			sContent = dataDest.get(key).toString();
		}
		catch(NullPointerException ex){}
		
		dataDest.put(key, sContent.replaceAll("<br(/)>", "\r\n"));
	}
	
	/**
	 * @ignore
	 * @param data
	 * @param keys
	 */
	public void trim(Map<String, Object> data, String... keys){
		for(String sKey : keys){
			if (data.containsKey(sKey) == true) data.put(sKey, data.get(sKey).toString().trim());
		}
	}
	
	/**
	 * @ignore
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @param decPlace
	 */
	public void appendParamValueByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int decPlace){
		String[] saValue = dataSrc.get(key);
		StringBuilder sb = new StringBuilder();
		
		if (saValue != null){
			for(String sValue : saValue){
				sb.append( String.format("%0" + decPlace + "d", Integer.parseInt(sValue)) );
			}
			dataDest.put(key, sb.toString());
		}
		else{
			dataDest.put(key, "");
		}
	}
	
	/**
	 * @ignore
	 * @param dataDest
	 * @param srcVal
	 * @param destkey
	 * @param useLength
	 * @param shift
	 */
	public void mergeValueToOtherKey(Map<String, Object> dataDest, int srcVal, String destkey, int useLength, int shift){
		int iSum = 0;
		int iShift = 0;
		int iMax = useLength * shift;
		
		for(iShift = 0; iShift < iMax; iShift += shift){
			iSum |= srcVal << iShift;
		}
		
		dataDest.put(destkey, iSum);
	}
	/**
	 * @ignore
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 */
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		mergeMultiValuesByKey(dataDest, dataSrc, key, 0, 0);
	}
	/**
	 * @ignore
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @param shift
	 */
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int shift){
		mergeMultiValuesByKey(dataDest, dataSrc, key, 0, shift);
	}
	/**
	 * @ignore
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @param useLength
	 * @param shift
	 */
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int useLength, int shift){
		Map<String, String[]> params = dataSrc;
		
		if (params.containsKey(key) == false) return;
		
		String[] saValue = params.get(key);
		int iLen = (useLength > 0)? useLength : saValue.length;
		int iSum = 0;
		
		for(int i = 0; i < iLen; ++i){
			iSum |= Integer.parseInt(saValue[i]) << (shift * i);
		}
		
		dataDest.put(key, iSum);
	}
	
	/**
	 * keyFrom의 내용중 태그 내용을 삭제 후<br/>
	 * keyTo에 저장한다.
	 * @param data
	 * @param keyFrom
	 * @param keyTo
	 */
	public void removeTags(Map<String, Object> data, String keyFrom, String keyTo){
		String sValue = data.get(keyFrom).toString();
		
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>"); 
	    Matcher m = p.matcher(sValue); 
	    sValue = m.replaceAll("");		 
		
		data.put(keyTo, sValue);
	}
	
	/**
	 * keyFrom의 내용중 태그 내용을 삭제 후<br/>
	 * keyTo에 저장한다.
	 * @param data
	 * @param keyFrom
	 * @param keyTo
	 */
	public void removeTags(Map<String, Object> data, String keyFrom, String keyTo, int lengthLimit){
		String sValue = data.get(keyFrom).toString();
		
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>"); 
	    Matcher m = p.matcher(sValue); 
	    sValue = m.replaceAll("").substring(0, lengthLimit);	 
		
		data.put(keyTo, sValue);
	}
	/**
	 * text중 이미지태그의 링크속성 중 "&amp;"를 "&"로 
	 * 변경하여 이미지만 따로 저장한다.<br/>
	 * 이미지가 없을경우 공백으로 저장한다.
	 * @param data
	 * @param keyFrom text가 들어간 parameter key
	 * @param keyTo
	 */
	public void extractFirstImgSrc(Map<String, Object> data, String keyFrom, String keyTo){
		try{
			String sValue = data.get(keyFrom).toString();
			int indexImgBegin = sValue.indexOf("<img");
			//int indexImgEnd = sValue.indexOf(">", indexImgBegin);
			int indexSrcBegin = 0, indexSrcEnd = 0;
			
			if (indexImgBegin < 0){
				data.put(keyTo, "");
				return;
			}
			
			//sValue = sValue.substring(indexImgBegin, indexImgEnd);
			indexSrcBegin = sValue.indexOf("src=", indexImgBegin) + 5;
			indexSrcEnd = sValue.indexOf("\"", indexSrcBegin);
			
			sValue = sValue.substring(indexSrcBegin, indexSrcEnd).replace("&amp;", "&");
			data.put(keyTo, sValue);
		}
		catch(Exception ex){
			data.put(keyTo, "");
		}
	}
	
	/**
	 * 배열Parameter중 이메일을<br/>
	 * "1234@gmail.com" 형식으로 변경한다.
	 * @param data
	 * @param key
	 * @return
	 */
	public String toEmail(Map<String, String[]> data, String key){
		String[] saEmail = data.get(key);
		
		try{
			if (saEmail.length < 2){
				return "";
			}
			
			return saEmail[0] + '@' + saEmail[1];
		}
		catch(Exception ex){}
		return "";
	}
	
	/**
	 * 배열Parameter중 이메일을<br/>
	 * "1234@gmail.com" 형식으로 변경하여<br/>
	 * 싱글Parameter에 넣어준다.
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @return
	 */
	public String toEmail(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String sEmail = toEmail(dataSrc, key);
		dataDest.put(key, sEmail);
		return sEmail;
	}
	
	/**
	 * 배열Parameter중 전화번호를<br/>
	 * "010-0000-0000"형식으로 변경한다.
	 * @param data
	 * @param key
	 * @return
	 */
	public String toPhone(Map<String, String[]> data, String key){
		String[] saPhone = data.get(key);
		
		try{
			switch(saPhone.length){
				case 2: return saPhone[0] + '-' + saPhone[1];
				case 3: return saPhone[0] + '-' + saPhone[1] + '-' + saPhone[2];
				case 4: return saPhone[0] + '-' + saPhone[1] + '-' + saPhone[2] + '-' + saPhone[3];
				default : return "";
			}
		}
		catch(Exception ex){}
		return "";
	}
	
	/**
	 * 배열Parameter중 전화번호를<br/>
	 * "010-0000-0000"형식으로 변경하여<br/>
	 * 싱글Parameter에 넣어준다.
	 * @param dataDest
	 * @param dataSrc
	 * @param key
	 * @return
	 */
	public String toPhone(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String sPhone = toPhone(dataSrc, key);
		dataDest.put(key, sPhone);
		return sPhone;
	}
	
	/**
	 * @ignore
	 * @param dataDest
	 * @param key
	 */
	public void surveyToOne(Map<String, Object> dataDest, String key){
		int i = 0;
		int iSum = 0;
		String sName = "";
		
		while(dataDest.containsKey(sName = key + i) == true){
			iSum |= Integer.parseInt( dataDest.get( sName ).toString() );
			i++;
		}
		
		dataDest.put(key, iSum);
	}
	
	/**
	 * @ignore
	 * @param dataDest
	 * @param key
	 * @param maxCount
	 */
	public void surveyToOne(Map<String, Object> dataDest, String key, int maxCount){
		int i = 0;
		int iSum = 0;
		String sName = "";
		
		while(i < maxCount){
			if (dataDest.containsKey(sName = key + i) == true){
				iSum |= Integer.parseInt( dataDest.get( sName ).toString() );
			}
			
			i++;
		}
		
		dataDest.put(key, iSum);
	}
	
	/**
	 * 싱글Parameter에서 keywords에 해당하는<br/>
	 * 값의 text의 내용 중 악의적인 코드를 삭제한다.
	 * @param params
	 * @param keywords
	 */
	public void removeMaliciousCode(Map<String, Object> params, String... keywords) {
		Matcher matcher = null;
		String sContents = "";
		for(String key : keywords){
			if (params.containsKey(key) == true){
				sContents = params.get(key).toString();
				
				for (Pattern pattern : XSS_PATTERNS) {
					matcher = pattern.matcher(sContents);
					sContents = matcher.replaceAll("");
				}
				
				params.put(key, sContents);
			} else {
				params.put(key, sContents);
			}
		}
    }
}
