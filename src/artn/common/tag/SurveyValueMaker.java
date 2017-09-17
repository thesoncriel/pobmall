package artn.common.tag;

public class SurveyValueMaker extends AbsInputListTagMaker {

	protected String wrap = "span";
	protected String subWrap = "";
	protected boolean usingSubWrap = false;
	protected boolean dual = false;
	protected boolean radioShow = false;
	protected int offset;
	private String cssClassChecked = "yes";
	private String cssClassUnchecked = "no";
	
	public SurveyValueMaker(){}
	public SurveyValueMaker(String id, String cssClass, String style, String name, Integer value) {
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	
	public StringBuilder makeValuebox(StringBuilder sb){
		int iShift = 1 << this.offset;
		
		if (dual == true){
			addValuebox( (iValue & iShift) > 0, sb);
			addValuebox( (iValue & iShift) == 0, sb);
		}
		else{
			addValuebox( (iValue & iShift) > 0, sb);
		}
		
		return sb;
	}

	protected StringBuilder addValuebox(boolean checked, StringBuilder sb){
		if (usingSubWrap){
			tagStartNonAttr(subWrap, sb, true);
		}
		if (checked){
			tagStartNonAttr("span", sb, false).tagAttrClose("class", cssClassChecked, sb);
			if (radioShow){
				tagStartNonAttr("input", sb, false).tagAttr("type", "radio", sb).tagAttr("checked", "checked", sb);
				sb.append("/>");
			}
			else{
				sb.append("예");
			}
			tagEnd("span", sb);
		}
		else{
			tagStart("span", sb, false).tagAttrClose("class", cssClassUnchecked, sb);
			if (radioShow){
				tagStartNonAttr("input", sb, false).tagAttr("type", "radio", sb);
				sb.append("/>");
			}
			else{
				sb.append("아니오");
			}
			tagEnd("span", sb);
		}
		if (usingSubWrap){
			tagEnd(subWrap, sb);
		}
		return sb;
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart(wrap, sb, true);

		makeValuebox(sb);
		
		tagEnd(wrap, sb);
		return sb;
	}

	public SurveyValueMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	@Override
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? "survey-value" + ' ' + cssClass : "survey-value";
		return this;
	}
	
	public SurveyValueMaker setWrap(String wrap){
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	
	public SurveyValueMaker setOffset(Integer offset){
		this.offset = (offset == null)? 0 : offset;
		return this;
	}
	
	public SurveyValueMaker setDual(Boolean dual){
		this.dual = (dual == null)? false : dual;
		return this;
	}
	
	public SurveyValueMaker setSubWrap(String subWrap){
		this.subWrap = (subWrap == null)? "none" : subWrap;
		this.usingSubWrap = (this.subWrap.equals("none") == false);
		return this;
	}
	
	public SurveyValueMaker setCssClassChecked(String cssClassChecked){
		this.cssClassChecked  = (cssClassChecked == null)? "yes" : cssClassChecked;
		return this;
	}
	
	public SurveyValueMaker setCssClassUnchecked(String cssClassUnchecked){
		this.cssClassUnchecked  = (cssClassUnchecked == null)? "no" : cssClassUnchecked;
		return this;
	}
	
	public SurveyValueMaker setRadioShow(Boolean radioShow){
		this.radioShow = (radioShow == null)? false : radioShow;
		return this;
	}
}
