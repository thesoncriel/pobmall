package artn.common.tag;

/**
 * 
 * @author shkang<br/>
 * 태그의 기본 정보를 입력 받기 위한 인터페이스
 */
public interface IInputTagMaker extends ITagMaker {
	public IInputTagMaker setName(String name);
	public IInputTagMaker setValue(String value);
	public IInputTagMaker setValue(Integer value);
	public IInputTagMaker setRequired(String required);
	public IInputTagMaker setRequired(boolean required);
}