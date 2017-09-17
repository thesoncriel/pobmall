package artn.common.tag;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;


public class TestCalendarMaker_ver01 extends AbsTagMaker implements IListTagMaker { //TODO: extra:"fixed" 차후 필요시 구현 130620 by shkang;
	public static String CAL_NUM = "cal_num";
	public static String CAL_DATE = "cal_date";
	public static String CAL_NUM_CHECK = '{' + CAL_NUM + '}';
	public static String CAL_DATE_CHECK = '{' + CAL_DATE + '}';
	
	private String wrap = "div";
	private String date = "";
	private String sUri = "";
	private String extra = "";
	private boolean showBefore = false;
	private String[] saTemplate = null;//new String[]{"<span>", "-", "-", "</span>"};
	private String[] saKeyword = null;//new String[]{"title", "num", "name"};
	private List<Map<String, Object>> mapList;
	
	private int iPreEndDay = 0;
	private int iNextEndDay = 0;
	private String classWeek = "";
	private int iCalYear = 0;
	private int iCalMonth = 0;
	private int iCalDay = 0;
	private boolean hasCalNum;
	private boolean hasCalDate;
	private String saDay[] = {"일","월","화","수","목","금","토"};
	private int iSat = 0;
	private int iSun = 0;
	private int week = 0;
	private int iEndDay = 0;
	private int iNewLine = 0;
	private int iWeekCount = 1;
	
	
	public TestCalendarMaker_ver01(String id, String cssClass, String style, String date, String uri){
		super(id, cssClass, style);
		setDate(date);
		setUri(uri);
		setCssClass(cssClass);
	}
	@Override
	public StringBuilder make(StringBuilder sb) {
		Calendar cal = Calendar.getInstance();
		//오늘 날짜 구하기
		int iNowYear = cal.get(Calendar.YEAR);
		//월은 0부터 시작하므로 1월 표시를 위해 1을 더해 줍니다
		int iNowMonth = cal.get(Calendar.MONTH)+1;
		int iNowDay = cal.get(Calendar.DAY_OF_MONTH);
		iCalYear = iNowYear;
		iCalMonth = iNowMonth;
		iCalDay = iNowDay;
		
		//입력 날짜 나누기
		if(date != ""){
			iCalYear = Integer.parseInt( date.split("-")[0] ) ;
			iCalMonth = Integer.parseInt( date.split("-")[1] ) ;
			iCalDay = Integer.parseInt( date.split("-")[2] ) ;	
		}
		//표시할 전달 날짜
		cal.set(iCalYear, iCalMonth-2,1);//년,월,일
		iPreEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		//표시할 다음달 날짜
		cal.set(iCalYear, iCalMonth,1);//년,월,일
		iNextEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		//표시할 달력 세팅
		cal.set(iCalYear, iCalMonth-1,1);//년,월,일
		int iStartDay=1;//달의 첫 날
		iEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		if(iCalDay > iEndDay){
			iCalDay = 1;
		}
		//매년 해당월의 1일 구하기
		week = cal.get(Calendar.DAY_OF_WEEK);
		
		tagStartCustom(wrap, sb, id, cssClass , style, true);
		tagStartCustom(wrap, sb, id, "nav" , style, true);
		//월 네비
		monthNav(sb);
		tagEnd(wrap, sb);
		tagStartNonAttr("table", sb, true)
		.tagStartNonAttr("thead", sb, true)
		.tagStartNonAttr("tr", sb, true);
		
		//요일
		weekLabel(sb);
		tagEnd("tr", sb)
		.tagEnd("thead", sb)
		.tagStartNonAttr("tbody", sb, true);
		
		 //한주가 지나면 줄바꿈을 할 것이다.
		 tagStartNonAttr("tr", sb, true);
		 //1일 시작 전 까지 전달 날짜로 채우기
		 prevMonthDay(sb);
         //1일 부터 말일까지 반복
		 for(int iDay = iStartDay; iDay <= iEndDay; iDay++){
			 classWeek = "";
			 //주말 클래스 추가
			 if(iNewLine == (iSun)){
				 classWeek = "sun";
			 }else if(iNewLine == (iSat)){
				 classWeek = "sat";
			 }
			 //hidden클래스 추가
			 if( (showBefore == true) && (iCalYear <= iNowYear) && (iCalMonth <= iNowMonth) && (iDay < iNowDay) ){
				 if( (iNewLine == iSun) || (iNewLine == iSat) ){
					 classWeek += " ";
				 }
				 classWeek += "hidden";
			 }
			 //선택 클래스 추가
			 if(iCalDay == iDay){
				 if( (iNewLine == iSun) || (iNewLine == iSat) ){
					 classWeek += " ";
				 }
					 classWeek += "selected";
			 }
			 // 오늘 날짜 클래스 추가
			 if( (iCalYear == iNowYear) && (iCalMonth == iNowMonth) && (iDay == iNowDay) ){
				 if( (iNewLine == iSun) || (iNewLine == iSat) || (iCalDay == iDay)){
					 classWeek += " ";
				 }
				 classWeek = classWeek + "today";
			 }
			 // 달력 채우기
			 if(classWeek == ""){						// 클래스가 없는 날짜 추가
				 tagStartNonAttr("td", sb, true);
				 list(sb, saKeyword, saTemplate, iDay);
				 tagEnd("td",  sb);
			 }else{											// 클래스가 있는 날짜 추가
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", classWeek, sb);
				 sb.append(">");
				 list(sb, saKeyword, saTemplate, iDay);
				 tagEnd("td", sb );
			 }
		     // 마지막 날 이후 달력 채우기
		     nextMonthDay(sb, iDay);
			 iNewLine++;
			 //7일째거나 말일이 아니면 달력 줄바꿈이 일어난다.
			 if((iNewLine == 7) && (iDay != iEndDay) ){
				 tagEnd("tr", sb)
			     .tagStartNonAttr("tr", sb, true);
			     iNewLine=0;
			     iWeekCount++;
			 }
		 }
		 tagEnd("tr", sb);
	tagEnd("tbody", sb);
	tagEnd("table", sb);
	tagEnd(wrap, sb);
	
	return sb;
		
	}
	// 월 네비
	public StringBuilder monthNav(StringBuilder sb){
		this.preMonth(sb, sUri);
		sb.append(iCalYear);
		sb.append("년");
		sb.append(iCalMonth);
		sb.append("월");
		this.nextMonth(sb, sUri);
		return sb;
	}
	
	// 요일 표시
	public StringBuilder weekLabel(StringBuilder sb){
		
		for(int i = 0; i < saDay.length; i++){
			if(saDay[i]=="일"){
				iSun = i;
				tagStartNonAttr("th", sb, false)
				.tagAttr("class", "sun", sb);
				sb.append(">");
				tagEnd("th", sb.append(saDay[i]) );
			}else if(saDay[i] == "토"){
				iSat = i;
				tagStartNonAttr("th", sb, false)
				.tagAttr("class", "sat", sb);
				sb.append(">");
				tagEnd("th", sb.append(saDay[i]) );
			}else{
				tagStartNonAttr("th", sb, true)
				.tagEnd("th", sb.append(saDay[i]) );	
			}
		}
		
		return sb;
	}
	// 전달 날짜 채우기
	public StringBuilder prevMonthDay(StringBuilder sb){
		int iaPrevDay[] = new int[week-1];
		
		 if( (extra.equals("true") == true) || (extra.equals("fixed") == true) ){
			 for(int i = week-2; i >= 0 ; i--){
				 iaPrevDay[i] = iPreEndDay;
				 iPreEndDay--;
			 }
			 for(int i = 0; i < iaPrevDay.length; i++){
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", "extra", sb);
				 sb.append(">");
				 tagEnd("td", sb.append(iaPrevDay[i]));
				 iNewLine++;
			 }	 
		 }else{
			 for(int i = 1; i < week; i++){
				 
				  tagStartNonAttr("td", sb, true)
				  .tagEnd("td", sb);
				  iNewLine++;
			 }
		 }
		return sb;
	}
	// 다음달 날짜 채우기
	public StringBuilder nextMonthDay(StringBuilder sb, int iDay){
		if(iDay == iEndDay){
			 int iNextMountDaysCount = 6-iNewLine; 
			 int iNextMonthDays = iNextMountDaysCount;
			 
			 //extra가 fixed일 경우 이후 날짜 추가
			 if(extra == "fixed"){
				 if(iWeekCount == 4){	//4주 인경우 6주로 변경
						iNextMonthDays = iNextMonthDays + 14;	
					}else if(iWeekCount == 5){	//5주 인경우 6주로 변경
						iNextMonthDays = iNextMonthDays + 7;
					} 
			 }
			 if(iNewLine != 7){
				 int iWeekDays = 0;
				 if( (extra == "true") || (extra == "fixed") ){
					 for(int i = 1; i <= iNextMonthDays; i++){
						 if( (iWeekDays == iNextMountDaysCount) || (iWeekDays == (iNextMountDaysCount + 7)) ){
							  tagStartNonAttr("tr", sb, true)
							  .tagEnd("tr", sb);
						  }
						  tagStartNonAttr("td", sb, false)
						  .tagAttr("class", "extra", sb);
						  sb.append(">");
							 tagEnd("td", sb.append(i) );
						  iWeekDays++;
					 } 
				 }else{
					 for(int i = 1; i <= iNextMonthDays; i++){
						 if( (iWeekDays == iNextMountDaysCount) || (iWeekDays == (iNextMountDaysCount + 7)) ){
							  tagStartNonAttr("tr", sb, true)
							  .tagEnd("tr", sb);
						  }
						  tagStartNonAttr("td", sb, false)
						  .tagAttr("class", "extra", sb);
						  sb.append(">");
							 tagEnd("td", sb );
						  iWeekDays++;
					 }
				 }	 
			 } 
		 }
		return sb;
	}
	
	public TestCalendarMaker_ver01 setDate(String date) {
		this.date = date;
		return this;
	}
	
	public TestCalendarMaker_ver01 setUri(String uri) {
		this.sUri = uri;
		return this;
	}
	
	//전달 구하기
	private StringBuilder preMonth(StringBuilder sb, String uri){
		int preYear = iCalYear;
		int preMonth = iCalMonth-1;
		
		if(preMonth < 1){//1월 전달은 작년 12월 이니깐...
		 preYear = iCalYear -1;
		 preMonth = 12; 
		}
		String sPreMonth = zeroNum(preMonth);
		String sPreDay = zeroNum(iCalDay);
		
		sb.append("<a href=\"");
			sb.append(uri).append("?date=").append(preYear).append("-").append(sPreMonth).append("-").append(sPreDay).append("\"");
    	sb.append(">");
		sb.append("◀");
		sb.append("</a>");
		
		return sb;
	}
	//다음달 구하기	
	private StringBuilder nextMonth(StringBuilder sb, String uri){

				int nextYear = iCalYear;
				int nextMonth = iCalMonth +1;

				if(nextMonth > 12){//12월 다음달은 내년 1월 이므로...
				 nextYear = iCalYear +1;
				 nextMonth = 1;
				}
				
				String sNextMonth = zeroNum(nextMonth);
				String sNextDay = zeroNum(iCalDay);
				
				
				sb.append("<a href=\"");
		    		sb.append(uri).append("?date=").append(nextYear).append("-").append(sNextMonth).append("-").append(sNextDay).append("\"");
				sb.append(">");
				sb.append("▶");
				sb.append("</a>");
		return sb;
	}
	
	public TestCalendarMaker_ver01 setCssClass(String cssClass){
		this.cssClass = ((cssClass != null) && (cssClass.isEmpty() == false))? "calendar" + ' ' + cssClass : "calendar";
		//new StringBuilder().append("calendar").append(' ').append(cssClass)
		return this;
	}
	
	public TestCalendarMaker_ver01 setExtra(String sExtra){
		if(sExtra == "true"){
			this.extra = "true";
		}else if(sExtra == "fixed"){
			this.extra = "fixed";
		}
		return this;
	}
	
	public TestCalendarMaker_ver01 setShowBefore(String sShowBefore){
		if(sShowBefore == "true"){
			this.showBefore = true;
		}
		return this;
	}
	
	public TestCalendarMaker_ver01 setTemplateToken(String sTemplate){
		StringTokenizer st = new StringTokenizer(sTemplate,"{}");
		int i = 0;
		int j = 0;
		int count = st.countTokens();
		this.saKeyword = new String[count/2];
		this.saTemplate = new String[count/2+1];
		
		hasCalNum = sTemplate.contains(CAL_NUM_CHECK);
		hasCalDate = sTemplate.contains(CAL_DATE_CHECK);
		while(st.hasMoreTokens()){
			if(i%2 == 1){
				this.saKeyword[j-1] = st.nextToken();
			}else{
				this.saTemplate[j] = st.nextToken();
				j++;
			}
			i++;
		}
		return this;
	}
	
	public StringBuilder list(StringBuilder sb, String[] saKeyword, String[] saTemplate, int iDay){
		String sMonth = zeroNum(iCalMonth);
		String sDay = zeroNum(iDay);
		String sDate = iCalYear + "-" + sMonth + "-" + sDay;
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		
		if(hasCalNum == false){
			sb.append(iDay);
		}
		
		if(hasCalDate == true){
			map = setListMap(sDate);
		}else{
			map = mapList;
		}
		
		if(map != null){
			for(int i = 0; i < map.size(); i++ ){
				//if(map.get(i).containsValue(sDate) == true){
					for(int j = 0; j < saKeyword.length; j++){
						sb.append(saTemplate[j]);
							if(saKeyword[j].equals(CAL_NUM) == true){
								sb.append(iDay);
							}else{
								sb.append(map.get(i).get(saKeyword[j]));
							}
						if(j == saKeyword.length-1){
							sb.append(saTemplate[j+1]);	
						}
					}
				//}
			}
		}else if(hasCalNum == true){
			//TODO: emptyTemplate 속성 구현 (리스트 데이터에 특정 날짜가 비어있을 때 이를 템플릿으로 삽입 할지의 여부) - by shkang
			sb.append(saTemplate[0]);
			sb.append(iDay);
			sb.append(saTemplate[saTemplate.length - 1]);
		}
		return sb;
		
	}
	
	//mapList => 해당 날짜로 추려내기
	public List<Map<String, Object>> setListMap(String sDate) {
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		
		if(map != null){
			for(int i = 0; i < mapList.size(); i++){
				if(mapList.get(i).containsValue(sDate) == true ){
					map.add(mapList.get(i));
				}
			}
			if(map.size() == 0){
				map = null;
			}
		}
		return map;
	}
	
	@SuppressWarnings("unchecked")
	public IListTagMaker setList(Object list) {
		if (list != null){
			if (list instanceof java.lang.String){
				this.mapList = null;
			}else if (list instanceof java.util.List){
				this.mapList = (List<Map<String, Object>>)list;
			}
		}else{
			this.mapList = null;
		}
		return this;
	}
	public IListTagMaker setList(List<Map<String, Object>> list) {
		this.mapList = list;
		return this;
	}
	public IListTagMaker setList(String... list) {
		// TODO Auto-generated method stub
		return this;
	}
	public IListTagMaker setListKey(String listKey) {
		// TODO Auto-generated method stub
		return this;
	}
	
	//숫자 10 미만은 0 붙혀주기
	public String zeroNum(int number){
		String sNumber = String.format("%02d", number);
		return sNumber;
	}
}
