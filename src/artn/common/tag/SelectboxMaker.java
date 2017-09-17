package artn.common.tag;


public class SelectboxMaker extends ValueboxMaker {
	
	private int min = 1;
	private int max = 10;
	private int step = 1;
	private String[] customList;
	private boolean keyValuePair;
	private String name;
	
	public SelectboxMaker(){}
	public SelectboxMaker(String id, String cssClass, String style,
			String name, String value) {
		super(id, cssClass, style, value);
		setName(name);
	}
	
	public SelectboxMaker createNumericOptions(StringBuilder sb){
		int iValue = 0;
		try{
			iValue = Integer.parseInt(value);
		}
		catch(Exception ex){}
		return createNumericOptions(iValue, sb);
	}
	public SelectboxMaker createNumericOptions(int iValue, StringBuilder sb){
		int i;
		
		for(i = min; i <= max; i+=step){
			sb.append("<option value=\"").append(i).append('\"');
			
			if (i == iValue){
				sb.append(" selected=\"selected\"");
			}
			sb.append('>').append(i).append(unit).append("</option>");
		}
		
		return this;
	}

	public SelectboxMaker createCustomOptions(StringBuilder sb){
		int iLen = (customList != null)? customList.length : 0;
		int iIncVal = (keyValuePair)? 2: 1;
		int iPairVal = (keyValuePair)? 1: 0;
		
		if (keyValuePair && ((iLen & 1) == 1)) return this;
		
		for(int i = 0; i < iLen; i+=iIncVal){
			sb.append("<option value=\"").append(customList[i]).append('\"');
			
			if (value.equals(customList[i]) == true){
				sb.append(" selected=\"selected\"");
			}
			sb.append('>').append(customList[i + iPairVal]).append(unit).append("</option>");
		}
		
		return this;
	}
	
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		int iMinBak = min;
		
		tagStart("select", sb, false).tagAttr("name", name, sb);
		sb.append('>');
		
		if (zero != null){
			sb.append("<option value=\"0\">").append(zero).append("</option>");
			min = 1;
		}
		
		if (value == null) value = "";
		
		if ((type == null) ||
			(type.equals("numeric") == true) || 
			(type.equals("split") == true) || 
			(type.equals("shift") == true))				createNumericOptions(extractValueByType(), sb);
		
		else if ((type.equals("phone") == true)) 		loadPhoneData().createCustomOptions(sb);
		else if ((type.equals("phone_mobi") == true))	loadPhoneMobiData().createCustomOptions(sb);
		else if ((type.equals("email") == true))		loadEmailData().createCustomOptions(sb);
		else 											createCustomOptions(sb);
		
		tagEnd("select", sb);
		
		min = iMinBak;
		return sb;
	}

	public SelectboxMaker setMin(Integer min) {
		this.min = (min != null)? min : 0;
		return this;
	}
	public SelectboxMaker setMax(Integer max) {
		this.max = (max != null)? max : 10;
		return this;
	}
	public SelectboxMaker setStep(Integer step) {
		this.step = (step != null)? ((step > 0)? step: 1) : 1;
		return this;
	}

	public SelectboxMaker setCustomList(String... sList){
		return setCustomList(true, sList);
	}
	public SelectboxMaker setCustomList(boolean keyValuePair, String... sList){
		this.keyValuePair = keyValuePair;
		this.customList = sList;
		return this;
	}
	public SelectboxMaker setName(String name) {
		this.name = (name != null)? name : this.name;
		return this;
	}
	
	
	
	
	
	
	
	protected SelectboxMaker loadPhoneData(){
		return setCustomList(false, 
			"02",
			"031",
			"032", 
			"033",
			"041",
			"042",
			"043",
			"044",
			"051",
			"052",
			"053", 
			"054", 
			"055", 
			"061",
			"062", 
			"063",
			"064",
			"----",
			"060",
			"070",
			"080",
			"1577",
			"----",
			"010",
			"011",
			"016", 
			"017", 
			"018", 
			"019");
	}
	protected SelectboxMaker loadPhoneMobiData(){
		return setCustomList(false, 
			"010",
			"011",
			"016", 
			"017", 
			"018", 
			"019");
	}
	protected SelectboxMaker loadEmailData(){
		return setCustomList(false,
			"직접작성",
			"gmail.com", 
			"hanmail.net", 
			"daum.net", 
			"hotmail.com",
			"naver.com", 
			"nate.com", 
			"paran.com",
			"yahoo.com",
			"lycos.com"
			);
	}
}
