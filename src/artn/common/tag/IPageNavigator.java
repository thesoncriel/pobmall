package artn.common.tag;

/**
 * 
 * @author shkang<br/>
 * 페이지네비게이터를 생성하기 위한 인터페이스
 */
public interface IPageNavigator extends ITagMaker{
	public IPageNavigator setUri(String uri);
	public IPageNavigator setPage(Integer page);
	public IPageNavigator setRowLimit(Integer rowLimit);
	public IPageNavigator setNavCount(Integer navCount);
	public IPageNavigator setRowCount(Integer rowCount);
	public IPageNavigator setFont(String font);
	public IPageNavigator setParams(Object params);
}
