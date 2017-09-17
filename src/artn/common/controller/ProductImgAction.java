package artn.common.controller;

public class ProductImgAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8154155857901154255L;

	@Override
	public String list() throws Exception {
		doList("product-img-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		doShow("product-img-single");
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		doEdit("product-img-modify");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		doEdit("product-img-delete");
		return SUCCESS;
	}

}
