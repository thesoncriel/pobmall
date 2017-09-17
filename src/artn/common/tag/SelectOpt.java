package artn.common.tag;


public class SelectOpt extends AbsTagMaker {
	
	private String sName = "";
	private String sValue = "";
	private String[] saValue = null;
	private String sText = "";
	private String[] saText1 = null;
	private String[] saText2 = null;
	private int iSeq = 0;
	private String sSelected = "";
	private String sTextDiv = "";
	private String sSelectDiv = "";
	private String[] saSelected = null;
	
	public SelectOpt(){
		super();
	}
	@Override
	public StringBuilder make(StringBuilder sb) {
		saValue = splitText(sValue, sTextDiv);
		saText1 = splitText(sText, sTextDiv);
		saText2 = splitText(sValue, sTextDiv);
		int iSelected = 0;
		if(sSelected != ""){
			saSelected = splitText(sSelected, sSelectDiv);
			iSelected = Integer.parseInt(saSelected[iSeq-1]);
		}
		
		tagStartNonAttr("select", sb, false)
		.tagAttr("name", sName, sb);
		sb.append(">");
		tagStartNonAttr("option",sb,false)
		.tagAttr("value", "", sb)
		.tagAttr("seq", 1, sb);
		sb.append(">");
		sb.append("선택");
		tagEnd("option", sb);
		
		for(int i = 0; i < saValue.length; i++){
			String sOption = saText1[i] + ":" +saValue[i];
			
			tagStartNonAttr("option", sb, false)
//			.tagAttr("value", saText1[i] + ":" +saValue[i], sb)
			.tagAttr("value", sOption, sb)
			.tagAttr("seq", i+2, sb);
			if( (sSelected != "") && (iSelected == i+1) ){
				tagAttr("selected", "selected", sb);
			}
			sb.append(">");
			sb.append(sOption);
//			sb.append(saText1[i]);
//			if( !("".equals(saText2[i])) ){
//			sb.append(":"+saText2[i]);	
//			}
			tagEnd("option", sb);
		}
		
		tagEnd("select", sb);
		
		return sb;
	}
	
	public SelectOpt setValue(String strName, String strValue, String strText, String seq, String selected, String textDiv, String selectDiv){
		this.sName = strName;
		this.sValue = strValue;
		this.sText = strText;
		if(selected != null){
			this.iSeq = Integer.parseInt(seq);
			this.sSelected = selected;
			this.sSelectDiv = selectDiv;
		}
		this.sTextDiv = textDiv;
		return this;
	}
	
	public String[] splitText(String sText, String sDiv){
		String[] saText = null;
		try{
			saText = sText.split(sDiv);
		}catch(Exception e){
			saText[0] = sText;
		}
		return saText;
	}
}
