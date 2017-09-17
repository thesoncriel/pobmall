package artn.common.tag;

import java.util.Map;


public class CheckboxListMaker extends AbsInputListTagMaker {

	protected String wrap = "span";
	protected String subWrap;
	protected String name;
	protected Integer offset;
	protected String type = "checkbox";
	
	public CheckboxListMaker(){}
	public CheckboxListMaker(String id, String cssClass, String style, String name, Integer value) {
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	
	public StringBuilder makeCheckList(StringBuilder sb){
		int iShift = 1 << offset;
		
		if (sArray != null){
			for(String sLabel : sArray){
				if ((iValue & iShift) > 0 ){
					addCheckbox(sLabel, iShift, true, sb);
				}
				else{
					addCheckbox(sLabel, iShift, false, sb);
				}
				iShift <<= 1;
			}
		}
		else if (mapList != null){
			for(Map<String, Object> map : mapList){
				if ((iValue & iShift) > 0 ){
					addCheckbox(map.get(listKey).toString(), iShift, true, sb);
				}
				else{
					addCheckbox(map.get(listKey).toString(), iShift, false, sb);
				}
				iShift <<= 1;
			}
		}
		
		return sb;
	}
	
	protected StringBuilder addCheckbox(String label, int value, boolean checked, StringBuilder sb){
		return addCheckbox(label, this.name, value, checked, this.subWrap, sb);
	}
	
	protected StringBuilder addCheckbox(String label, String name, int value, boolean checked, String subWrap, StringBuilder sb){
		if (subWrap != null){
			tagStartNonAttr(subWrap, sb, true);
		}
		
		tagStartNonAttr("input", sb, false)
		.tagAttr("type", this.type, sb)
		.tagAttr("name", name, sb);
		sb.append(" id=\"").append(name).append(value).append("\"");
		sb.append(" value=\"").append(value).append("\"");
		if (checked == true){
			tagAttr("checked", "checked", sb);
		}
		sb.append(" />");
		tagStartNonAttr("label", sb, false);
		sb.append(" for=\"").append(name).append(value).append("\"").append('>').append(label);
		tagEnd("label", sb);
		
		if (subWrap != null){
			tagEnd(subWrap, sb);
		}
		return sb;
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart(wrap, sb, true);

		makeCheckList(sb);
		
		tagEnd(wrap, sb);
		return sb;
	}

	public CheckboxListMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	@Override
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? "checkboxlist" + ' ' + cssClass : "checkboxlist";
		return this;
	}
	
	public CheckboxListMaker setWrap(String wrap){
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	
	public CheckboxListMaker setName(String name){
		this.name = name;
		return this;
	}
	
	public CheckboxListMaker setOffset(Integer offset){
		this.offset = (offset == null)? 0 : offset;
		return this;
	}
	
	public CheckboxListMaker setSubWrap(String subWrap){
		this.subWrap = subWrap;
		return this;
	}
	
	public CheckboxListMaker setType(String type){
		this.type = (type == null)? this.type : type;
		return this;
	}
}
