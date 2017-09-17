package artn.common.tag;

public class EmailboxMaker extends AbsInputTagMaker {
	private String wrap = "span";
	private SelectboxMaker selectbox  = new SelectboxMaker();
	private String valueLeft;
	private String valueRight;
	
	public EmailboxMaker(){}
	public EmailboxMaker(String id, String cssClass, String style, String name,
			String value) {
		super(id, cssClass, style, name, value);
	}

	@Override
	public StringBuilder make(StringBuilder sb) {
		selectbox.setType("email").setValue(valueRight).setCssClass("selectbox_email");
		tagStartCustom(wrap, sb, id, null, style, false);
		sb.append(" class=\"valid-group email");
		
		if (cssClass != null) sb.append(' ').append(cssClass);
		
		sb.append('\"');
		tagAttr("data-rule", "email", sb);
		if (required) tagAttr("data-required", "required", sb);
		sb.append('>');
		
		sb.append("<input type=\"text\"");
		sb.append(" id=\"").append(name).append("1\"");
		tagAttr("maxlength", "24", sb).tagAttr("name", name, sb).tagAttrEnd("value", valueLeft, sb);
		sb.append("<span class=\"at\">@</span>");
		sb.append("<input type=\"text\"");
		sb.append(" id=\"").append(name).append("2\"");
		tagAttr("maxlength", "24", sb).tagAttr("name", name, sb).tagAttrEnd("value", valueRight, sb);	
		selectbox.make(sb);

		tagEnd(wrap, sb);
		return sb;
	}
	
	public EmailboxMaker setWrap(String wrap) {
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	@Override
	public EmailboxMaker setValue(String value) {
		this.value = value;
		
		try{
			String[] saValue = value.split("@");
			
			this.valueRight = saValue[1];
			this.valueLeft = saValue[0];
		}
		catch(Exception ex){
			this.valueRight = "";
			this.valueLeft = "";
		}
		
		return this;
	}
}
