package artn.common;

import java.io.IOException;

import org.apache.ibatis.io.Resources;

/**
 * 
 * @author shkang
 * 프레임 워크 내에서 쓰이는 상수들 모음 클래스
 * @class
 */
public final class Const {
	public static final String KEY_ROW_COUNT = "row_count";
	public static final String KEY_ROW_NUMBER = "row_number";
	public static final String KEY_ROW_NUMBER_ASCENDING = "rnum_asc";
	public static final String KEY_PAGE = "page";
	public static final String KEY_ROW_LIMIT = "rowlimit";
	public static final String KEY_OFFSET = "offset";
	public static final String PATH_CONFIG = "artn/common/common.properties";
	public static final String CONTENTS_ADMIN = "sub100";
	public static final String CONTENTS_SITE_STAFF = "sub101";
	public static final String CONTENTS_GROUP_MANAGER = "sub102";
	public static final String CONTENTS_USER = "sub103";
	
	private static String rootPath;
	/**
	 * 파일의 실주소
	 * @return
	 */
	public static String getRootPath(){ return rootPath; }
	
	static {
		try {
			rootPath = Resources.getResourceAsFile(Const.PATH_CONFIG)
					.getParentFile() // common
					.getParentFile() // artn
					.getParentFile() // classes
					.getParentFile() // WEB-INF
					.getParentFile() // ROOT
					.getCanonicalPath().toString().replace("%20", " ");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
