package artn.common.tag;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;


public abstract class WebPageNavigator extends AbsTagMaker implements IPageNavigator{
	public final static String KEY_PAGE = "page";
	public final static String KEY_ROW_LIMIT = "rowlimit";
	public final static String KEY_OFFSET = "offset";
	public final static String TYPE_INLINE = "inline";
	public final static String TYPE_TABLE = "table";
	public final static String CSS_FIRST = "artn-icon-32 page-first";
	public final static String CSS_PREV = "artn-icon-32 page-prev";
	public final static String CSS_NEXT = "artn-icon-32 page-next";
	public final static String CSS_LAST = "artn-icon-32 page-last";
	public static final String CSS_NAV = "page-nav";
	
	public final static String FONT_ENG_FIRST = "First";
	public final static String FONT_ENG_PREV = "Prev";
	public final static String FONT_ENG_NEXT = "Next";
	public final static String FONT_ENG_LAST = "Last";
	public final static String FONT_KOR_FIRST = "처음";
	public final static String FONT_KOR_PREV = "이전";
	public final static String FONT_KOR_NEXT = "다음";
	public final static String FONT_KOR_LAST = "맨끝";
	public final static String FONT_SYMBOL_FIRST = "&#171;";
	public final static String FONT_SYMBOL_PREV = "&#8249;";
	public final static String FONT_SYMBOL_NEXT = "&#8250;";
	public final static String FONT_SYMBOL_LAST = "&#187;";

    protected String uri = "";
    protected int page = 1;
    protected int rowLimit = 10;
    protected int navCount = 10;
    protected int rowCount = 0;
    protected int lastPage = 1;
    protected String pageNumFormat = "%1$d";
    protected String params = "";
    
    protected String fontFirst = FONT_ENG_FIRST;
    protected String fontPrev = FONT_ENG_PREV;
    protected String fontNext = FONT_ENG_NEXT;
    protected String fontLast = FONT_ENG_LAST;
    

	public WebPageNavigator(String id, String cssClass, String style){
		super(id, cssClass, style);
	}

    public IPageNavigator setPage(Integer page) {
        this.page = checkZero(page, this.page);
        return this;
    }
    
    public IPageNavigator setRowLimit(Integer rowLimit) {
        this.rowLimit = checkZero(rowLimit, this.rowLimit);
        return this;
    }
    
    public IPageNavigator setNavCount(Integer navCount) {
        this.navCount = checkZero(navCount, this.navCount);
        return this;
    }
    public IPageNavigator setUri(String uri) {
		this.uri = (uri != null)? uri : this.uri;
		return this;
	}

	public IPageNavigator setRowCount(Integer rowCount) {
		this.rowCount = checkZero(rowCount, this.rowCount);
		return this;
	}
	
	public IPageNavigator setFont(String font){
		if (font == null) return this;
		
		if (font.equals("kor") == true){
			this.fontFirst = FONT_KOR_FIRST;
			this.fontPrev = FONT_KOR_PREV;
			this.fontNext = FONT_KOR_NEXT;
			this.fontLast = FONT_KOR_LAST;
		}
		else if (font.equals("symbol") == true){
			this.fontFirst = FONT_SYMBOL_FIRST;
			this.fontPrev = FONT_SYMBOL_PREV;
			this.fontNext = FONT_SYMBOL_NEXT;
			this.fontLast = FONT_SYMBOL_LAST;
		}
		else{
			try{
				String[] saFont = font.split(",");
				this.fontFirst = saFont[0];
				this.fontPrev = saFont[1];
				this.fontNext = saFont[2];
				this.fontLast = saFont[3];
			}
			catch(Exception ex){}
		}
		
		return this;
	}

	@SuppressWarnings("unchecked")
	public IPageNavigator setParams(Object params) {
		if (params instanceof Map<?, ?>){
			this.params = appendParams( (Map<String, Object>) params );
		}
		else if (params instanceof String){
			this.params = (String)params;
		}
		
		if (this.params.length() > 2) this.params += '&';
		
		return this;
	}
	
	protected String appendParams(Map<String, Object> params){
		if (params.size() == 0) return "";
		
		Iterator<Entry<String, Object>> entries = params.entrySet().iterator();
        Entry<String, Object> entry = null;
        StringBuilder sb = new StringBuilder();
        String sKey;
		
		while(entries.hasNext() == true){
            entry = entries.next();
            sKey = entry.getKey();
            
            if (sKey.equals(KEY_PAGE) == true) continue;
            if (sKey.equals(KEY_OFFSET) == true) continue;
            if (sKey.equals(KEY_ROW_LIMIT) == true){
            	this.setRowLimit( Integer.parseInt(entry.getValue().toString()) );
            }
            
            sb.append(sKey);
            sb.append('=');
            try {
                sb.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8"));
            } catch (UnsupportedEncodingException e) { e.printStackTrace(); }
            sb.append('&');
        }
		
		if (sb.length() > 0){
			sb.setLength(sb.length() - 1);
		}
        
        return sb.toString();
	}
	
	protected void initLastPage(){
		lastPage = (rowCount / rowLimit) + ( ((rowCount % rowLimit) > 0)? 1 : 0);
		if (lastPage < 1) lastPage = 1;
        if (page > lastPage) page = lastPage;
	}
	protected int[] getPageSelectorNumbers(){
        int iBegin = ((((page - 1) / navCount) * navCount) + 1);
        int iMaxCount = ((lastPage - page) < (lastPage % navCount))? lastPage % navCount : navCount;
        int iCurrent = iBegin;
        int[] iaRet = new int[iMaxCount];
        
        for(int i = 0; i < iMaxCount; ++i){
            iaRet[i] = iCurrent;
            ++iCurrent;
        }
        
        return iaRet;
    }
	
	public abstract StringBuilder make(StringBuilder sb);
}
