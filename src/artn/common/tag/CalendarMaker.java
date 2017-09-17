package artn.common.tag;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;


public class CalendarMaker extends AbsTagMaker { //TODO: extra:"fixed" 차후 필요시 구현 130620 by shkang;
	private String wrap = "span";
	private String date = "";
	private String sUri = "";
	private String extra = "";
	private boolean showBefore = false;
	
	private int iPreEndDay = 0;
	private int iNextEndDay = 0;
	private int[] iaPrevDay = null;
	private String classWeek = "";
	// TODO Auto-generated method stub
	Calendar cal = Calendar.getInstance();
	//오늘 날짜 구하기
	private int iNowYear = cal.get(Calendar.YEAR);
	//월은 0부터 시작하므로 1월 표시를 위해 1을 더해 줍니다
	private int iNowMonth = cal.get(Calendar.MONTH)+1;
	private int iNowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	private int iCalYear = iNowYear;
	private int iCalMonth = iNowMonth;
	private int iCalDay = iNowDay;
	
	public CalendarMaker(String id, String cssClass, String style, String date, String uri){
		super(id, cssClass, style);
		setDate(date);
		setUri(uri);
		setCssClass(cssClass);
	}
	public CalendarMaker(){
		
	}
	@Override
	public StringBuilder make(StringBuilder sb) {
		
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
		int iEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
		if(iCalDay > iEndDay){
			iCalDay = 1;
		}
		//매년 해당월의 1일 구하기
		int week =cal.get(Calendar.DAY_OF_WEEK);
		
		String saDay[] = {"일","월","화","수","목","금","토"};
		int iSat = 0;
		int iSun = 0;
		
		
		tagStartCustom(wrap, sb, id, cssClass , style, true);
		
		tagStartCustom(wrap, sb, id, "nav" , style, true);
		preMonth(sb, sUri);
		sb.append(iCalYear);
		sb.append("년");
		sb.append(iCalMonth);
		sb.append("월");
		nextMonth(sb, sUri);
		tagEnd(wrap, sb);
		
		
		tagStartNonAttr("table", sb, true)
		.tagStartNonAttr("thead", sb, true)
		.tagStartNonAttr("tr", sb, true);
		
		//요일
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
		tagEnd("tr", sb)
		.tagEnd("thead", sb)
		.tagStartNonAttr("tbody", sb, true);
		
		
		 //한주가 지나면 줄바꿈을 할 것이다.
		 int iNewLine = 0;
		 tagStartNonAttr("tr", sb, true);
		 
		 //1일 시작 전 까지 전달 날짜로 채우기
		 iaPrevDay = new int[week-1];
		 if( (extra == "true") || (extra == "fixed") ){
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
		 
		 
		//1일 부터 말일까지 반복
		 int iWeekCount = 1; 
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
				 tagStartNonAttr("td", sb, true)
				 .tagEnd("td", sb.append(iDay) );
			 }else{											// 클래스가 있는 날짜 추가
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", classWeek, sb);
				 sb.append(">");
				 tagEnd("td", sb.append(iDay) );
			 }
			 
			 
		   
		     // 마지막 날 이후 달력 채우기
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

	public CalendarMaker setDate(String date) {
		this.date = date;
		return this;
	}
	
	public CalendarMaker setUri(String uri) {
		this.sUri = uri;
		return this;
	}
	
	//전달 구하기
	private StringBuilder preMonth(StringBuilder sb, String uri){
		int preYear = iCalYear;
		int preMonth = iCalMonth-1;
		
		/*if (iCalDay > iPreEndDay){
			iCalDay = 1;
		}*/
		String sPreDay = Integer.toString(iCalDay);
		
		if(preMonth < 1){//1월 전달은 작년 12월 이니깐...
		 preYear = iCalYear -1;
		 preMonth = 12; 
		}
		String sPreMonth = Integer.toString(preMonth);
		
		if(preMonth < 10){
			sPreMonth = "0" + sPreMonth;
		}
		if(iCalDay < 10){
			sPreDay = "0" + iCalDay;
		}
		
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

				/*if (iCalDay > iNextEndDay){
					iCalDay = 1;
				}*/
				String sNextDay = Integer.toString(iCalDay);
				
				
				if(nextMonth > 12){//12월 다음달은 내년 1월 이므로...
				 nextYear = iCalYear +1;
				 nextMonth = 1;
				}
				
				String sNextMonth = Integer.toString(nextMonth);
				
				if(nextMonth < 10){
					sNextMonth = "0" + sNextMonth;
				}
				if(iCalDay < 10){
					sNextDay = "0" + iCalDay;
				}
				
				sb.append("<a href=\"");
		    		sb.append(uri).append("?date=").append(nextYear).append("-").append(sNextMonth).append("-").append(sNextDay).append("\"");
				sb.append(">");
				sb.append("▶");
				sb.append("</a>");
		return sb;
	}
	
	public CalendarMaker setCssClass(String cssClass){
		this.cssClass = ((cssClass != null) && (cssClass.isEmpty() == false))? "calendar" + ' ' + cssClass : "calendar";
		//new StringBuilder().append("calendar").append(' ').append(cssClass)
		return this;
	}
	
	public CalendarMaker setExtra(String sExtra){
		if(sExtra == "true"){
			this.extra = "true";
		}else if(sExtra == "fixed"){
			this.extra = "fixed";
		}
		return this;
	}
	
	public CalendarMaker setShowBefore(String sShowBefore){
		if(sShowBefore == "true"){
			this.showBefore = true;
		}
		return this;
	}
	
	public String dateDiff(Map<String, Object> params, Object date){
		int iNowYear = cal.get(Calendar.YEAR);
		//월은 0부터 시작하므로 1월 표시를 위해 1을 더해 줍니다
		int iNowMonth = cal.get(Calendar.MONTH)+1;
		int iNowDay = cal.get(Calendar.DAY_OF_MONTH);
		String sToday = "";
		String sNowMonth = "";
		String sNowDay = "";
		if(date.equals("1week")){
			if( (iNowDay-7) < 1 ){
				if( (iNowMonth-1) < 1){
					iNowYear = iNowYear - 1;
					iNowMonth = 12;
					iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay) + (iNowDay-7);
				}else{
					iNowMonth -= 1;
					iNowDay = lastDay(params,iNowYear, iNowMonth, iNowDay) + (iNowDay-7);
				}
			}else{
				iNowDay = iNowDay-7;
			}
		}else if(date.equals("1month")){
			if( (iNowMonth-1) < 1){
				iNowYear = iNowYear - 1;
				iNowMonth = 12;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 1;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("3month")){
			if( (iNowMonth-3) < 1){
				iNowYear = iNowYear -1;
				iNowMonth = 12 + (iNowMonth-3);
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 3;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("6month")){
			if( (iNowMonth-6) < 1){
				iNowYear = iNowYear -1;
				iNowMonth = 12 + (iNowMonth-6);
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}else{
				iNowMonth -= 6;
				iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
			}
		}else if(date.equals("1year")){
			iNowYear = iNowYear -1;
			iNowDay = lastDay(params, iNowYear, iNowMonth, iNowDay);
		}
		
		if(iNowMonth < 10){
			sNowMonth = "0"+iNowMonth; 
		}else{
			sNowMonth = ""+ iNowMonth;
		}
		
		if(iNowDay < 10){
			sNowDay = "0"+iNowDay; 
		}else{
			sNowDay = ""+ iNowDay;
		}
		sToday = iNowYear + "-" + sNowMonth + "-" + sNowDay;
		return sToday;
	}
	
	public int lastDay(Map<String, Object> params, int iNowYear, int iNowMonth, int iNowDay){
		cal.set(iNowYear, iNowMonth-1, 1);
		int iPrevDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	 	
		if( ((iPrevDay - iNowDay) < 0) || (params.get("date").equals("1week"))){
			iNowDay = iPrevDay;
		}
		return iNowDay;
	}

}
