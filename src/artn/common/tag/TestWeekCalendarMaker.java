package artn.common.tag;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;


public class TestWeekCalendarMaker extends AbsTagMaker {
	private String wrap = "span";
	private String sDate = "";
	private String sUri = "";
	private boolean bExtra = false;
	
	private int iDay = 0;
	private int[][] iaWeek = null;
	private int[] iaPreDay = null;
	private int iPreEndDay = 0;
	private int iEndDay = 0;
	private int iStartWeekDay = 1;
	private int iEndWeekDay = 0;
	
	
	// TODO Auto-generated method stub
	Calendar cal = Calendar.getInstance();
	//오늘 날짜 구하기
	private int iNowYear = cal.get(Calendar.YEAR);

	//월은 0부터 시작하므로 1월 표시를 위해 1을 더해 줍니다
	private int iNowMonth = cal.get(Calendar.MONTH)+1;

	private int iNowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	public TestWeekCalendarMaker(String id, String cssClass, String style, String date, String uri){
		super(id, cssClass, style);
		setDate(date);
		setUri(uri);
		setCssClass(cssClass);
	}
	@Override
	public StringBuilder make(StringBuilder sb) {

		
		//입력 날짜 나누기
		if(sDate != ""){
			iNowYear = Integer.parseInt( sDate.split("-")[0] ) ;
			iNowMonth = Integer.parseInt( sDate.split("-")[1] ) ;
			iNowDay = Integer.parseInt( sDate.split("-")[2] ) ;	
		}
		
		//표시할 전달 날짜
		cal.set(iNowYear, iNowMonth-2,1);//년,월,일
		iPreEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		//표시할 달력 세팅
		cal.set(iNowYear, iNowMonth-1,1);//년,월,일
		iEndDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
		//매주 첫번째 시작일구하기
		int week = cal.get(Calendar.DAY_OF_WEEK);
		
		String saDay[] = {"일","월","화","수","목","금","토"};
		int iSat = 0;
		int iSun = 0;
		
		
		tagStartCustom(wrap, sb, id, cssClass , style, true);
		
		tagStartCustom(wrap, sb, id, "monthCtr" , style, true);
		preMonth(sb, sUri);
		sb.append(iNowYear);
		sb.append("년");
		sb.append(iNowMonth);
		sb.append("월");
		sb.append(" ");
		sb.append("주차");
		nextMonth(sb, sUri);
		tagEnd(wrap, sb);
		
		
		
		iaPreDay = new int[week-1];
		for(int i = week-2; i >= 0 ; i--){
		 iaPreDay[i] = iPreEndDay;
		 iPreEndDay--;
		}
		 
		tagStartNonAttr("table", sb, true)
		.tagStartNonAttr("thead", sb, true)
		.tagStartNonAttr("tr", sb, true);
		
		iDay = 1;
		int iWeek = (iEndDay + (week-1))/7;
		iaWeek = new int[iWeek][7];

		for(int i = 0; i <= iWeek; i++){
			for(int j = 0; j < 7; j++){
				if(bExtra == true){
						iaWeek[i][j] = iDay;
						iDay++;
				}else{
					iaWeek[i][j] = iDay;
					iDay++;
				}
			}
		}
		
		System.out.println(iaWeek);
		
		
		//요일
		//1일 시작 전 까지 전달 날짜로 채우기
		 
		 if(bExtra == true){
			 
			 for(int i = 0; i < iaPreDay.length; i++){
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", "extra", sb);
				 sb.append(">");
				 tagEnd("td", sb.append(iaPreDay[i]));
			 }	 
		 }else{
			 for(int i = 1; i < week; i++){
				  tagStartNonAttr("td", sb, true)
				  .tagEnd("td", sb);
			 }
		 }
		 
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
		
		
		 //요일 카운트
		 int iNewLine = 0;
		 
		 tagStartNonAttr("tr", sb, true);
		 
		
		int iDay = iStartWeekDay;
		while((iNewLine < 7) && (iDay <= iEndDay)){
			if(iNewLine == (iSun)){
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", "sun", sb);
				 sb.append(">");
				 tagEnd("td", sb.append(iDay) );
			 }else if(iNewLine == (iSat)){
				 tagStartNonAttr("td", sb, false)
				 .tagAttr("class", "sat", sb);
				 sb.append(">");
				 tagEnd("td", sb.append(iDay) );
			 }else{
				 tagStartNonAttr("td", sb, true)
				 .tagEnd("td", sb.append(iDay) );
			 }
			 // 마지막 날 이후 달력 채우기
			 if(bExtra == true && iDay == iEndDay && iNewLine != 7){
				  for(int i = 1; i < (7-iNewLine); i++){
					  tagStartNonAttr("td", sb, false)
					  .tagAttr("class", "extra", sb);
					  sb.append(">");
					  tagEnd("td", sb.append(i) );
				  }
			 }
			 iDay++;
			 iNewLine++;
			 if(iNewLine == 6){
				 iEndWeekDay = iDay;
			 }
		}
		
		 tagEnd("tr", sb);
		
	tagEnd("tbody", sb);
	tagEnd("table", sb);
	tagEnd(wrap, sb);
	
	return sb;
		
	}

	public TestWeekCalendarMaker setDate(String date) {
		this.sDate = date;
		return this;
	}
	
	public TestWeekCalendarMaker setUri(String uri) {
		this.sUri = uri;
		return this;
	}
	
	//전달 구하기
	private StringBuilder preMonth(StringBuilder sb, String uri){
		
		int preYear = iNowYear;
		int preMonth = iNowMonth;
		int preDay = iStartWeekDay;
		if(preDay < 1){
			preDay = iPreEndDay;
			preMonth = preMonth - 1;
			if(preMonth < 1){//1월 전달은 작년 12월 이니깐...
				 preYear = iNowYear -1;
				 preMonth = 12; 
			}
		}
		
		
		String sPreMonth = Integer.toString(preMonth);
		
		if(preMonth < 10){
			sPreMonth = "0" + sPreMonth;
		}
		
		sb.append("<a href=\"");
		if (uri.equals("#") == true){
    		sb.append('#');
    	}
    	else{
    		sb.append(uri).append("?date=").append(preYear).append("-").append(sPreMonth).append("-").append(preDay).append("\"");
    	}
		sb.append("style=\"text-decoration : none\">");
		sb.append("◀");
		sb.append("</a>");
		
		return sb;
	}
	//다음달 구하기	
	private StringBuilder nextMonth(StringBuilder sb, String uri){

				int nextYear = iNowYear;
				int nextMonth = iNowMonth;
				int nextDay = iEndWeekDay;
				if(nextDay > iEndDay){
					nextMonth = nextMonth + 1;
					if(nextMonth > 12){//12월 다음달은 내년 1월 이므로...
						 nextYear = iNowYear +1;
						 nextMonth = 1;
					}
				}
				
				String sNextMonth = Integer.toString(nextMonth);
				
				if(nextMonth < 10){
					sNextMonth = "0" + sNextMonth;
				}
				
				sb.append("<a href=\"");
				if (uri.equals("#") == true){
		    		sb.append('#');
		    	}
		    	else{
		    		sb.append(uri).append("?date=").append(nextYear).append("-").append(sNextMonth).append("-").append(nextDay).append("\"");
		    	}
				sb.append("style=\"text-decoration : none\">");
				sb.append("▶");
				sb.append("</a>");
		return sb;
	}
	
	public TestWeekCalendarMaker setCssClass(String cssClass){
		this.cssClass = (cssClass != null)? "calendar" + ' ' + cssClass : "calendar";
		//new StringBuilder().append("calendar").append(' ').append(cssClass)
		return this;
	}
	
	public TestWeekCalendarMaker setExtra(String sExtra){
		if(sExtra == "true"){
			this.bExtra = true;
		}
		return this;
	}
}
