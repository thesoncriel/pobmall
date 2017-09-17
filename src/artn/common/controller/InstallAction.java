package artn.common.controller;

public class InstallAction extends AbsActionController {
	private static final long serialVersionUID = -2150227151727610830L;
	
	@Override
	public String execute() throws Exception {
		if (getParams().containsKey("step") == true){
			return getParams().get("step").toString();
		}
		return SUCCESS;
	}
	public String create() throws Exception {
		dbm().open();
		dbm().updateNonCommit("common-create-table", getParams());
		dbm().updateNonCommit("common-create-view", getParams());
		dbm().close();
		return SUCCESS;
	}
	public String update() throws Exception {
		return SUCCESS;
	}
	@Override
	public String list() throws Exception { return null; }
	@Override
	public String show() throws Exception { return null; }
	@Override
	public String edit() throws Exception { return null; }
	@Override
	public String write() throws Exception { return null; }
	@Override
	public String modify() throws Exception { return null; }
	@Override
	public String delete() throws Exception { return null; }
}