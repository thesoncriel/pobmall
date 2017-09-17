package artn.common.tag;

public class PhoneboxMaker extends AbsInputTagMaker {
	
	private String wrap = "span";
	private String type = "phone";
	private SelectboxMaker selectbox  = new SelectboxMaker();
	private String value1;
	private String value2;
	private String value3;
	
	public PhoneboxMaker(){}
	public PhoneboxMaker(String id, String cssClass, String style, String name,
			String value) {
		super(id, cssClass, style, name, value);
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		selectbox.setName(name).setValue(value1).setType(type).setCssClass("selectbox_phone");

		tagStartCustom(wrap, sb, id, null, style, false);
		sb.append(" class=\"valid-group phone");
		
		if (cssClass != null) sb.append(' ').append(cssClass);
		
		sb.append('\"');
		tagAttr("data-rule", "phone", sb);
		if (required) tagAttr("data-required", "required", sb);
		sb.append('>');
		
		selectbox.make(sb)
		.append("<span class=\"bar\">-</span>")
		.append("<input type=\"text\"");
		sb.append(" id=\"").append(name).append("1\"");
		tagAttr("maxlength", "4", sb).tagAttr("name", name, sb).tagAttrEnd("value", value2, sb);
		sb.append("<span class=\"bar\">-</span>")
		.append("<input type=\"text\"");
		sb.append(" id=\"").append(name).append("2\"");
		tagAttr("maxlength", "4", sb).tagAttr("name", name, sb).tagAttrEnd("value", value3, sb);
		
		tagEnd(wrap, sb);
		
		return sb;
	}

	public PhoneboxMaker setWrap(String wrap) {
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	public PhoneboxMaker setType(String type) {
		this.type = (type != null)? type : "phone";
		return this;
	}
	@Override
	public PhoneboxMaker setValue(String value){
		this.value = value;
		
		try{
			String[] saValue = value.split("-");
			
			this.value3 = saValue[2];
			this.value2 = saValue[1];
			this.value1 = saValue[0];
		}
		catch(Exception ex){}
		
		return this;
	}
}
