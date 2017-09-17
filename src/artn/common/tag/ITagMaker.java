package artn.common.tag;

/**
 * 
 * @author shkang<br/>
 * 태그를 생성하기 위한 인터페이스
 */
public interface ITagMaker {
	public ITagMaker setCssClass(String cssClass);
	public ITagMaker setId(String id);
	public ITagMaker setStyle(String style);
	public ITagMaker setTitle(String title);
	public ITagMaker tagStart(String tagName, StringBuilder sb, boolean tagEnd);
	public ITagMaker tagStartCustom(String tagName, StringBuilder sb, String id, String cssClass, String style, boolean tagEnd);
	public ITagMaker tagStartNonAttr(String tagName, StringBuilder sb, boolean tagEnd);
	public ITagMaker tagAttr(String attrName, String value, StringBuilder sb);
	public ITagMaker tagAttr(String attrName, int value, StringBuilder sb);
	public ITagMaker tagAttrClose(String attrName, String value, StringBuilder sb);
	public ITagMaker tagAttrEnd(String attrName, String value, StringBuilder sb);
	public ITagMaker tagEnd(String tagName, StringBuilder sb);
	public StringBuilder make();
	public StringBuilder make(StringBuilder sb);
}
