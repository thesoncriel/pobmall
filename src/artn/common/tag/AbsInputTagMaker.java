package artn.common.tag;

/**
 * 
 * @author shkang<br/>
 * 태그 생성시 기본적인 정보를 입력 받기 위한 클래스
 * @class
 */
public abstract class AbsInputTagMaker extends AbsTagMaker implements IInputTagMaker {
	protected String name;
	protected String value;
	protected int iValue;
	protected boolean required;
	
	public AbsInputTagMaker(){}
	public AbsInputTagMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	public AbsInputTagMaker(String id, String cssClass, String style, String name, String value){
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	/**
	 * 태그 name을 설정한다.
	 */
	public AbsInputTagMaker setName(String name) {
		this.name = (name != null)? name : this.name;
		return this;
	}

	/**
	 * 태그 String형 value를 설정한다.
	 */
	public AbsInputTagMaker setValue(String value) {
		this.value = (value != null)? value : this.value;
		return this;
	}
	
	/**
	 * 태그 Integer형 value를 설정한다.
	 */
	public AbsInputTagMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	/**
	 * 태그의 필수 여부를 String형으로 설정한다.
	 */
	public AbsInputTagMaker setRequired(String required){
		this.required = ((required != null) && (required.equals("required") == true));
		return this;
	}
	
	/**
	 * 태그의 필수 여부를 boolean형으로 설정한다.
	 */
	public AbsInputTagMaker setRequired(boolean required){
		this.required = required;
		return this;
	}
	
//	@Override
//	protected StringBuilder tagStart(String tagName, StringBuilder sb, boolean tagEnd){
//		sb.append('<').append(tagName);
//		
//		if (id != null) 		sb.append(" id=\"").append(id).append("\"");
//		if (cssClass != null) 	sb.append(" class=\"").append(cssClass).append("\"");
//		if (name != null) 		sb.append(" name=\"").append(name).append("\"");
//		if (value != null) 		sb.append(" value=\"").append(value).append("\"");
//		if (style != null) 		sb.append(" style=\"").append(style).append("\"");
//		if (tagEnd == true)		sb.append('>');
//		
//		return sb;
//	}

}
