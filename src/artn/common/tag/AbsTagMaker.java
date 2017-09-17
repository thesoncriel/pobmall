package artn.common.tag;

/**
 * 
 * @author shkang<br/>
 * 태그 생성의 최상위 클래스<br/>
 * 기본 ID, cssClass, style, title 의 정보를 받아
 * 태그를 생성해준다.
 * @class
 */
public abstract class AbsTagMaker implements ITagMaker {
	
	protected String cssClass;
	protected String id;
	protected String style;
	protected String title;
	
	public AbsTagMaker(){}
	public AbsTagMaker(String id, String cssClass, String style){
		setId(id).setCssClass(cssClass).setStyle(style);
	}
	
	/**
	 * css를 적용시킬 class를 설정한다.
	 */
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? cssClass : this.cssClass;
		return this;
	}

	/**
	 * 태그의 ID를 설정한다.
	 */
	public ITagMaker setId(String id) {
		this.id = (id != null)? id : this.id;
		return this;
	}

	/**
	 * 태그의 Style을 설정한다.
	 */
	public ITagMaker setStyle(String style) {
		this.style = (style != null)? style : this.style;
		return this;
	}
	
	/**
	 * 태그의 title을 설정한다.
	 */
	public ITagMaker setTitle(String title) {
		this.title = (title != null)? title : this.title;
		return this;
	}
	
	/**
	 * 속성을 가진 태그를 시작한다.<br/>
	 * 태그의 close 여부를 결정할수 있다.
	 */
	public ITagMaker tagStart(String tagName, StringBuilder sb, boolean tagEnd){
		return tagStartCustom(tagName, sb, id, cssClass, style, tagEnd);
	}
	/**
	 * 속성을 가진 태그를 시작한다.<br/>
	 * 태그의 close 여부를 결정할수 있다.<br/>
	 * tagEnd = true<br/>
	 * &lt;a id="" class="" title="" style=""><br/>
	 * tagEnd = false<br/>
	 * &lt;a id="" class="" title="" style=""
	 */
	public ITagMaker tagStartCustom(String tagName, StringBuilder sb, String id, String cssClass, String style, boolean tagEnd){
		sb.append('<').append(tagName);
		
		if (id != null) 		sb.append(" id=\"").append(id).append("\"");
		if (cssClass != null) 	sb.append(" class=\"").append(cssClass).append("\"");
		if (title != null) 		sb.append(" title=\"").append(title).append("\"");
		if (style != null) 		sb.append(" style=\"").append(style).append("\"");
		if (tagEnd == true)		sb.append('>');
		
		return this;
	}
	
	/**
	 * 속성을 가지지 않은 태그를 시작한다.<br/>
	 * 태그의 close 여부를 결정할수 있다.<br/>
	 * tagEnd = true<br/>
	 * &lt;a><br/>
	 * tagEnd = false<br/>
	 * &lt;a
	 */
	public ITagMaker tagStartNonAttr(String tagName, StringBuilder sb, boolean tagEnd){
		sb.append('<').append(tagName);

		if (tagEnd == true)		sb.append('>');
		
		return this;
	}
	
	/**
	 * 태그를 종료한다.<br/>
	 * &lt;/a>
	 */
	public ITagMaker tagEnd(String tagName, StringBuilder sb){
		sb.append("</").append(tagName).append('>');
		return this;
	}
	
	/**
	 * 태그의 String형 속성을 설정한다.
	 */
	public ITagMaker tagAttr(String attrName, String value, StringBuilder sb){
		if (value == null) return this;
		sb.append(' ').append(attrName).append("=\"").append(value).append("\"");
		return this;
	}
	/**
	 * 태그의 int형 속성을 설정한다.
	 */
	public ITagMaker tagAttr(String attrName, int value, StringBuilder sb){
		return tagAttr(attrName, Integer.toString(value), sb);
	}
	
	/**
	 * 속성태그를 닫아준다.
	 * >
	 */
	public ITagMaker tagAttrClose(String attrName, String value, StringBuilder sb){
		tagAttr(attrName, value, sb);
		sb.append('>');
		return this;
	}
	/**
	 * 속성태그를 닫아주면서 끝낸다.
	 * @example
	 * "/>"
	 */
	public ITagMaker tagAttrEnd(String attrName, String value, StringBuilder sb){
		tagAttr(attrName, value, sb);
		sb.append(" />");
		return this;
	}
	
	protected int checkZero(Integer value, int defValue){
		if (value == null) return defValue;
		if (value == 0) return defValue;
		
		return value;
	}
	
	public StringBuilder make(){
		return make(new StringBuilder());
	}
	public abstract StringBuilder make(StringBuilder sb);
}
