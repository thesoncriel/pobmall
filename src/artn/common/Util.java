package artn.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 
 * @author shkang
 * 날짜 관련된 util 클래스
 * @class
 */
public class Util {
	private static Util _util;

	public static Util getInstance(){
		if (_util == null){
			_util = new Util();
		}
		return _util;
	}
	
	protected Util(){}
	
	/**
	 * Map 생성시 사용
	 * @return
	 */
	public Map<String, Object> createMap(){
		return new HashMap<String, Object>();
	}
	
	/**
	 * 현재 날짜를 "yyyy-MM-dd" 형식으로 변환
	 * @return
	 */
	public String today(){
		return getDateFormat().format(new Date());
	}
	
	/**
	 * 오늘 날짜를 출력하기 위해 사용
	 * "yyyy-MM-dd" 출력
	 * @return
	 */
	public String getToday(){
		return today();
	}
	
	/**
	 * 현재 날짜와 시간을<br/>
	 * "yyyy-MM-dd HH:mm:ss" 형식으로 출력
	 * @return
	 */
	public String getNow(){
		return getDateTimeFormat().format(new Date());
	}
	
	protected SimpleDateFormat getDateFormat(){
		return new SimpleDateFormat("yyyy-MM-dd"); 
	}
	
	protected SimpleDateFormat getDateTimeFormat(){
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	}
	
	/**
	 * 날짜 및 시간 형식을 "19900301223020" 과 같은 형식으로 출력
	 * @return
	 */
	public String getIdByNowDateTime(){
		return new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
	}
	
	/**
	 * 입력받은 date를 "yyyy-MM-dd" 형식으로 변경
	 * @param date
	 * @return
	 */
	public String formatDate(Date date){
		return getDateFormat().format(date);
	}
	
	/**
	 * 입력받은 date에 addVal을 추가한다.
	 * @param date
	 * @param addVal
	 * @return
	 */
	public String addDate(String date, int addVal){
		try{
			SimpleDateFormat datefmt = getDateFormat();
			Date dateFm = datefmt.parse(date);
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(dateFm);
			cal.add(Calendar.DATE, addVal);
			
			return datefmt.format(cal.getTime());
		}catch(Exception ex){}
		
		return "";
	}
	
	/**
	 * fromDate와 toDate간의 날짜 차이를 계산한다.
	 * @param fromDate
	 * @param toDate
	 * @return
	 */
	public int dateDiff(String fromDate, String toDate){
		try{
			SimpleDateFormat datefmt = getDateFormat();
			Date dateFm = datefmt.parse(fromDate);
			Date dateTo = datefmt.parse(toDate);
			long lDiffDate = dateTo.getTime() - dateFm.getTime();
			
			return (int)(lDiffDate / (24 * 60 * 60 * 1000) );
		}catch(Exception ex){}
		
		return 0;
	}
}
