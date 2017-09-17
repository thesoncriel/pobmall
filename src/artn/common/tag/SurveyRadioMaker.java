package artn.common.tag;

public class SurveyRadioMaker extends AbsInputListTagMaker {

	protected String wrap = "span";
	protected String subWrap;
	protected String name;
	protected String disabled;
	protected int offset;
	protected boolean unchecked = false;
	protected boolean wrapNone = false;
	protected boolean labelShow = true;
	
	
	public SurveyRadioMaker(){}
	public SurveyRadioMaker(String id, String cssClass, String style, String name, Integer value) {
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	
	public StringBuilder makeCheckList(StringBuilder sb){
		int iShift = 1 << this.offset;
		
		if (unchecked == true){
			addCheckbox("예", iShift, false, "y", sb);
			addCheckbox("아니오", 0, false, "n", sb);
			
			return sb;
		}
		
		if ((iValue & iShift) > 0 ){
			addCheckbox("예", iShift, true, "y", sb);
			addCheckbox("아니오", 0, false, "n", sb);
		}
		else{
			addCheckbox("예", iShift, false, "y", sb);
			addCheckbox("아니오", 0, true, "n", sb);
		}
		
		return sb;
	}
	
	protected StringBuilder addCheckbox(String label, int value, boolean checked, StringBuilder sb){
		return addCheckbox(label, this.name, value, checked, this.subWrap, "", sb);
	}
	protected StringBuilder addCheckbox(String label, int value, boolean checked, String idPostfix, StringBuilder sb){
		return addCheckbox(label, this.name, value, checked, this.subWrap, idPostfix, sb);
	}
	protected StringBuilder addCheckbox(String label, String name, int value, boolean checked, String subWrap, String idPostfix, StringBuilder sb){
		if (subWrap != null){
			tagStartNonAttr(subWrap, sb, false)
			.tagAttr("class","survey-radio",sb);
			sb.append("/>");
		}
		
		tagStartNonAttr("input", sb, false)
		.tagAttr("type", "radio", sb);
		
		sb.append(" name=\"").append(name).append(this.offset).append("\"");
		sb.append(" id=\"").append(name).append(this.offset).append(idPostfix).append("\"");
		tagAttr("value", value, sb);
		
		if (checked == true){
			tagAttr("checked", "checked", sb);
		}
		if (disabled.equals("disabled") == true){
			tagAttr("disabled","disabled",sb);
		}
		sb.append(" />");
		if (labelShow == true){
			tagStartNonAttr("label", sb, false);
			sb.append(" for=\"").append(name).append(this.offset).append(idPostfix).append("\"").append('>').append(label);
			tagEnd("label", sb);
		}
		
		if (subWrap != null){
			tagEnd(subWrap, sb);
		}
		return sb;
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		if (this.wrapNone == false){
			tagStart(wrap, sb, false);
			tagAttr("data-rule", "survey", sb);
			
			if (required == true){
				tagAttrClose("data-required", "required", sb);
			}
		}

		makeCheckList(sb);
		
		if (this.wrapNone == false){
			tagEnd(wrap, sb);
		}
		
		return sb;
	}

	public SurveyRadioMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	@Override
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? "survey-radio" + ' ' + cssClass : "survey-radio";
		return this;
	}
	
	public SurveyRadioMaker setWrap(String wrap){
		this.wrap = (wrap != null)? wrap : "span";
		if (wrap.equals("none") == true){
			this.wrapNone = true;
		}
		else{
			this.wrapNone = false;
		}
		return this;
	}
	
	public SurveyRadioMaker setName(String name){
		this.name = name;
		return this;
	}
	
	public SurveyRadioMaker setOffset(Integer offset){
		this.offset = (offset == null)? 0 : offset;
		return this;
	}
	
	public SurveyRadioMaker setSubWrap(String subWrap){
		this.subWrap = subWrap;
		return this;
	}
	
	public SurveyRadioMaker setUnchecked(Boolean unchecked){
		this.unchecked = (unchecked != null)? unchecked : false;
		return this;
	}
	
	public SurveyRadioMaker setLabelShow(Boolean labelShow){
		this.labelShow = (labelShow != null)? labelShow : true;
		return this;
	}
	
	public SurveyRadioMaker setDisabled(String disabled){
		this.disabled = (disabled != null)? disabled : "";
		return this;
	}
}
