package artn.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ComboboxDataMaker {
	public ArrayList<Map<String, String>> getNumberList(String max, String step){
		ArrayList<Map<String, String>> mList = new ArrayList<Map<String, String>>();
		Map<String, String> map = null;
		int iMax = Integer.parseInt(max);
		int iStep = Integer.parseInt(step);
		
		for(int i = 0; i <= iMax; i+=iStep ){
			map = new HashMap<String, String>();
			map.put("key", i + "");
			map.put("value", i + "");
			mList.add(map);
		}
		
		return mList;
	}

	public String subStrValue(String val, int index){
		try{
			return Integer.parseInt(val.substring((index * 3), (index * 3) + 3)) + "";
		}catch(Exception ex){
			return "";
		}
	}
	
	public ArrayList<Map<String, String>> getWeeklyCombData(int index, int max, String zeroLabel, String numLabel){
		ArrayList<Map<String, String>> mList = new ArrayList<Map<String, String>>();
		Map<String, String> map = null;
		int iMax = max;
		
		map = new HashMap<String, String>();
		map.put("key", "0");
		map.put("value", zeroLabel);
		mList.add(map);
		for(int i = 1; i <= iMax; ++i){
			map = new HashMap<String, String>();
			map.put("key", i + "");
			map.put("value", i + numLabel);
			mList.add(map);
		}
		
		return mList;
	}
	
	public boolean isDaily(String val){
		int iVal = Integer.parseInt(val);
		boolean bRet = true;
		
		for(int i = 0 ; i < 7; ++i){
			bRet = bRet && ( (iVal & 0xF) > 0 );
			iVal = iVal >> 4;
		}
		
		return bRet;
	}
	
	public int extractWeeklyData(int index, String val){
		int iVal = Integer.parseInt(val);
		
		return (iVal >> (index << 2) ) & 0xF;
	}


	public String getTest(){
		return "하하하";
	}
}
