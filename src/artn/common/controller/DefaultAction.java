package artn.common.controller;

import java.io.File;

import artn.common.Const;

/**
 * 
 * @author shkang<br/>
 *	상위 4개의 클래스를 상속받아 재정의 해서 사용한다.
 * @class
 */
public class DefaultAction extends AbsUploadActionController {
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = 9052582141472461151L;


	@Override
	public String list() throws Exception { return SUCCESS; }
	@Override
	public String show() throws Exception { return SUCCESS; }
	@Override
	public String edit() throws Exception { return SUCCESS; }
	@Override
	public String write() throws Exception { return SUCCESS; }
	@Override
	public String modify() throws Exception { return SUCCESS; }
	@Override
	public String delete() throws Exception { return SUCCESS; }
	/**
	 * 파일명이 contentsCode인 htmlpart파일의 유무 체크
	 * @param contentsCode
	 * @return
	 */
	public boolean hasContents(String contentsCode){
		File file = new File( Const.getRootPath() + "/WEB-INF/include/contents/" + contentsCode + ".htmlpart" );

		return file.exists();
	}
}
