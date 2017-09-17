package artn.common;

import java.util.Map;

/**
 * 
 * @author shkang
 * 
 */
public abstract class FieldFormatter {
	public int tryParseInt(Object value, int defaultValue){
		try{
			if (value.toString().contains(".") == true){
				return (int)Double.parseDouble(value.toString());
			}
			return Integer.parseInt(value.toString());
		}
		catch(NumberFormatException ex){
			return defaultValue;
		}
	}
	
	public boolean isNullOrEmpty(Map<String, Object> params, String key){
		return (params.containsKey(key) == false) || (params.get(key).equals(""));
	}
	
	public int tryParseInt(Map<String, Object> params, String key, int defaultValue){
		if (isNullOrEmpty(params, key) == true){
			return defaultValue;
		}
		
		return tryParseInt(params.get(key), defaultValue);
	}
	
	public String convertToIntFormat(Map<String, Object> params, String key, int decPlace){
		int iParsedVal = tryParseInt(params, key, -1);
		
		if (iParsedVal == -1){
			return repeatChars('_', decPlace);
		}
		
		return String.format("%0" + decPlace + 'd', iParsedVal);
	}
	
	public String convertToUnderbarFormat(Map<String, Object> params, String key, int decPlace){
		if (isNullOrEmpty(params, key) == true){
			return repeatChars('_', decPlace);//String.format("%" + decPlace + "_s", "");//
		}
		
		return params.get(key).toString();
	}
	
	public String convertToEmptyFormat(Map<String, Object> params, String key){
		if (isNullOrEmpty(params, key) == true){
			return "";
		}
		
		return params.get(key).toString();
	}
	
	public String convertToZeroFormat(Map<String, Object> params, String key, int decPlace){
		if (isNullOrEmpty(params, key) == true){
			return repeatChars('0', decPlace);
		}
		
		return params.get(key).toString();
	}
	
	public String repeatChars(char c, int repeatCount){
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < repeatCount; ++i){
			sb.append(c);
		}
		return sb.toString();
	}
	
	public abstract String fillCategory(Map<String, Object> params, String categoryName);
}
