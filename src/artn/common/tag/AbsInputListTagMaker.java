package artn.common.tag;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author shkang<br/>
 * 여러개의 값을 입력 받기 위한 클래스
 * @class
 */
public abstract class AbsInputListTagMaker extends AbsInputTagMaker implements
		IListTagMaker {

	protected List<Map<String, Object>> mapList;
	protected String[] sArray;
	protected String listKey = "key";
	
	public AbsInputListTagMaker(){}
	public AbsInputListTagMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	public AbsInputListTagMaker(String id, String cssClass, String style, String name, String value){
		super(id, cssClass, style, name, value);
	}
	
	@SuppressWarnings("unchecked")
	public IListTagMaker setList(Object list){
		if (list != null){
			if (list instanceof java.lang.String){
				this.sArray = list.toString().split(",");
				this.mapList = null;
			}
			else if (list instanceof java.util.List){
				this.sArray = null;
				this.mapList = (List<Map<String, Object>>)list;
			}
		}
		else{
			this.mapList = null;
			this.sArray = null;
		}
		
		return this;
	}

	public IListTagMaker setList(List<Map<String, Object>> list) {
		this.sArray = null;
		this.mapList = list;
		return this;
	}

	public IListTagMaker setList(String... list){
		this.sArray = list;
		this.mapList = null;
		return this;
	}
	/**
	 * List를 구별해줄 Key를 설정한다.
	 */
	public IListTagMaker setListKey(String listKey){
		this.listKey = listKey;
		return this;
	}
}
