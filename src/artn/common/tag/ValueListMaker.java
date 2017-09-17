package artn.common.tag;

import java.util.Map;


public class ValueListMaker extends AbsInputListTagMaker {

	protected String wrap = "span";
	protected String zero;
	protected int offset;
	
	protected boolean icon;
	protected String cssCheckedClass = "artn-icon-16 checked";
	protected String cssUncheckedClass = "artn-icon-16 unchecked";
	
	public ValueListMaker(){}
	public ValueListMaker(String id, String cssClass, String style, Integer value) {
		super(id, cssClass, style);
		setValue(value);
	}

	public StringBuilder makeCheckedValues(StringBuilder sb){
		int iShift = 1;
		
		if (sArray != null){
			for(String sLabel : sArray){
				if ((iValue & iShift) > 0 ){
					sb.append(sLabel).append(" / ");
				}
				iShift <<= 1;
			}
		}
		else if (mapList != null){
			for(Map<String, Object> map : mapList){
				if ((iValue & iShift) > 0 ){
					sb.append(map.get(listKey)).append(" / ");
				}
				iShift <<= 1;
			}
		}
		
		return sb;
	}
	
	public StringBuilder makeCheckedValuesWithIcon(StringBuilder sb){
		int iShift = 1 << offset;
		
		if (sArray != null){
			for(String sLabel : sArray){
				if ((iValue & iShift) > 0 ){
					aroundSpanTags(sLabel, true, sb);
				}
				else{
					aroundSpanTags(sLabel, false, sb);
				}
				iShift <<= 1;
			}
		}
		else if (mapList != null){
			for(Map<String, Object> map : mapList){
				if ((iValue & iShift) > 0 ){
					aroundSpanTags(map.get(listKey).toString(), true, sb);
				}
				else{
					aroundSpanTags(map.get(listKey).toString(), false, sb);
				}
				iShift <<= 1;
			}
		}
		
		return sb;
	}
	
	protected StringBuilder aroundSpanTags(String label, boolean checked, StringBuilder sb){
		tagStartNonAttr("span", sb, false);
		if (checked == true){
			tagAttrClose("class", "item checked", sb)
			.tagStartNonAttr("span", sb, false)
			.tagAttrClose("class", cssCheckedClass, sb).tagEnd("span", sb);
		}
		else{
			tagAttrClose("class", "item", sb)
			.tagStartNonAttr("span", sb, false)
			.tagAttrClose("class", cssUncheckedClass, sb).tagEnd("span", sb);
		}
		
		tagStartNonAttr("span", sb, true).tagEnd("span", sb.append(label))
		.tagEnd("span", sb);
		return sb.append(" <span class=\"slash\">/</span> ");
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart(wrap, sb, true);
		
		if (iValue == 0){
			if (zero != null){
				tagStartNonAttr("span", sb, false).tagAttrClose("class", "zero", sb).tagEnd("span", sb.append(zero));
			}
		}
		else if (icon == true){
			makeCheckedValuesWithIcon(sb);
		}
		else{
			makeCheckedValues(sb);
		}
		
		tagEnd(wrap, sb);
		return sb;
	}
	public ValueListMaker setZero(String zero) {
		this.zero = zero;
		return this;
	}
	
	@Override
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? "shiftlist" + ' ' + cssClass : "shiftlist";
		return this;
	}

	public ValueListMaker setIcon(Boolean icon){
		this.icon = (icon != null)? icon : false;
		return this;
	}
	
	public ValueListMaker setWrap(String wrap){
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	
	public ValueListMaker setCssCheckedClass(String cssCheckedClass){
		this.cssCheckedClass = (cssCheckedClass != null)? cssCheckedClass : "artn-icon-16 checked";
		return this;
	}
	public ValueListMaker setCssUncheckedClass(String cssUncheckedClass){
		this.cssUncheckedClass = (cssUncheckedClass != null)? cssUncheckedClass : "artn-icon-16 unchecked";
		return this;
	}
	public ValueListMaker setOffset(Integer offset){
		this.offset = (offset != null)? offset : 0;
		return this;
	}
}
