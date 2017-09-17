package artn.common.controller;

public class DeliveryAction extends AbsSubDataActionController {

	@Override
	public String list() throws Exception {
		valid.checkEmptyValue(getParams(), 1, "id_group");
		doList("delivery_select");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		valid.checkEmptyValue(getParams(), 1, "id_group");
		doEdit("delivery_insert");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
