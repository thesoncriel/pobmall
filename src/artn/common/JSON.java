package artn.common;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class JSON {

	public static StringBuilder encode(List<Map<String, Object>> mapList){
		return encode(new StringBuilder(), mapList);
	}
	public static StringBuilder encode(List<Map<String, Object>> mapList, String keys){
		return encode(new StringBuilder(), mapList, keys);
	}
	public static StringBuilder encode(List<Map<String, Object>> mapList, Object keys){
		if (keys == null || keys.equals("")) return encode(new StringBuilder(), mapList);
		
		if (keys instanceof String[]){
			return encode(new StringBuilder(), mapList, (String[])keys);
		}
		else{
			return encode(new StringBuilder(), mapList, keys.toString());
		}
	}
	public static StringBuilder encode(Map<String, Object> map, Object keys){
		if (keys == null || keys.equals("")) return encode(new StringBuilder(), map);
		
		if (keys instanceof String[]){
			return encode(new StringBuilder(), map, (String[])keys);
		}
		else{
			return encode(new StringBuilder(), map, keys.toString().split(","));
		}
	}
	
	public static StringBuilder encode(StringBuilder sb, List<Map<String, Object>> mapList){
		sb.append("[  \r\n");
		
		for(Map<String, Object> map : mapList){
			encode(sb, map).append(",\r\n");
		}
		if (mapList.size() > 0) sb.deleteCharAt(sb.length() - 3);
		
		return sb.append("]\r\n");
	}
	public static StringBuilder encode(StringBuilder sb, List<Map<String, Object>> mapList, String keys){
		return encode(sb, mapList, keys.split(","));
	}
	public static StringBuilder encode(StringBuilder sb, List<Map<String, Object>> mapList, String[] saKeys){
		sb.append("[  \r\n");
		
		for(Map<String, Object> map : mapList){
			encode(sb, map, saKeys).append(",\r\n");
		}
		if (mapList.size() > 0) sb.deleteCharAt(sb.length() - 3);
		
		return sb.append("]\r\n");
	}
	
	public static StringBuilder encode(StringBuilder sb, Map<String, Object> map){
		Iterator<Entry<String, Object>> entryIter = null;
		Entry<String, Object> entry = null;
		int iLenInit;
		
		sb.append("{\r\n");
		
		if (map.size() > 0){
			entryIter = map.entrySet().iterator();
			iLenInit = sb.length();
			
			while(entryIter.hasNext() == true){
				entry = entryIter.next();
				sb.append('\"')
				.append(entry.getKey())
				.append("\" : ")
				.append('\"')
				.append(entry.getValue().toString().replaceAll("\"", "\\\\\""))
				.append("\",\r\n");
			}
			if (iLenInit < sb.length()){
				sb.deleteCharAt(sb.length() - 3);
			}
		}
		
		return sb.append('}');
	}

	public static StringBuilder encode(StringBuilder sb, Map<String, Object> map, String[] keys){
		int iLenInit;

		sb.append("{\r\n");
		
		if (map.size() > 0){
			iLenInit = sb.length();
			for(String key : keys){
				sb.append('\"')
				.append(key)
				.append("\" : ")
				.append('\"')
				.append(map.get(key).toString().replaceAll("\"", "\\\\\""))
				.append("\",\r\n");
			}
	
			if (iLenInit < sb.length()){
				sb.deleteCharAt(sb.length() - 3);
			}
		}
		
		return sb.append('}');
	}
}
