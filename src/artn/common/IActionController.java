package artn.common;

import java.util.List;
import java.util.Map;

import artn.database.IDBManager;

import com.opensymphony.xwork2.ModelDriven;

/**
 * 
 * @author shkang
 * 액션 컨트롤러 인터페이스
 * @interface
 */
public interface IActionController extends ModelDriven<Map<String, Object>>{
	public IDBManager dbm();
	public String list() throws Exception;
	public String show() throws Exception;
	public String edit() throws Exception;
	public String write() throws Exception;
	public String modify() throws Exception;
	public String delete() throws Exception;
	public Map<String, Object> getShowData();
	public List<Map<String, Object>> getListData();
	public Map<String, Object> getParams();
}
