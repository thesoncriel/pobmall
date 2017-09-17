package artn.common.tag;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author shkang<br/>
 * 여러개의 값을 받기 위한 클래스.
 * @class
 */
public class AbsListTagMaker extends AbsTagMaker implements IListTagMaker {

	public IListTagMaker setList(Object list) {
		// TODO Auto-generated method stub
		return this;
	}

	public IListTagMaker setList(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		return this;
	}

	public IListTagMaker setList(String... list) {
		// TODO Auto-generated method stub
		return this;
	}
	
	/**
	 * List를 구별해줄 Key를 설정한다.
	 */
	public IListTagMaker setListKey(String key) {
		// TODO Auto-generated method stub
		return this;
	}

	@Override
	public StringBuilder make(StringBuilder sb) {
		// TODO Auto-generated method stub
		return sb;
	}

}
