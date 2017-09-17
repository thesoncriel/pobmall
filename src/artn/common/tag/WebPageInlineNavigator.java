package artn.common.tag;

public class WebPageInlineNavigator extends WebPageNavigator {
	private String classFirst = CSS_FIRST;
	private String classPrev = CSS_PREV;
	private String classNext = CSS_NEXT;
	private String classLast = CSS_LAST;
	
	public WebPageInlineNavigator(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
    
	@Override
	public StringBuilder make(StringBuilder sb) {
		StringBuilder sbUriAppd = new StringBuilder(uri);
		String sUriAppd;
		
		if (sb == null) sb = new StringBuilder();
		if (cssClass == null) cssClass = "pagenav";
		
		tagStart("div", sb, true);
		
		if (uri.contains("?") == true){
            sbUriAppd.append('&');
        }
        else{
        	sbUriAppd.append('?');
        }
		
		sbUriAppd.append(params).append(KEY_PAGE).append('=');
		sUriAppd = sbUriAppd.toString();
		initLastPage();
        
        tagAnchor(this.classFirst, sUriAppd, "1", this.fontFirst, sb);
        tagAnchor(this.classPrev, sUriAppd, ((page > 1)? Integer.toString(page - 1) : "#"), this.fontPrev, sb);
        tagInlinePageSelector(sUriAppd, sb);
        tagAnchor(this.classNext, sUriAppd, ((page < lastPage)? Integer.toString(page + 1) : "#"), this.fontNext, sb);
        tagAnchor(this.classLast, sUriAppd, Integer.toString(lastPage), this.fontLast, sb);
        
        tagEnd("div", sb);
		return sb; 
	}
	
	   
    protected StringBuilder tagAnchor(String cssClass, String uriAppd, String page, String content, StringBuilder sb){
    	sb.append("<a class=\"").append(cssClass).append("\" href=\"");
    	
    	if (page.equals("#") == true){
    		sb.append('#');
    	}
    	else{
    		sb.append(uriAppd).append(page);
    	}
    	
    	return sb.append("\">").append(content).append("</a> ");
    }
    protected StringBuilder tagInlinePageSelector(String uriAppd, StringBuilder sb){
        int[] iaPageNums = getPageSelectorNumbers();
        int i = 0;
        
        tagStartNonAttr("span", sb, true);
        
        for(; i < iaPageNums.length; ++i){
        	if ((iaPageNums[i] == page)){
        		tagStartCustom("span", sb, null, "page-num selected", null, true).tagEnd("span", sb.append(iaPageNums[i]));
        		sb.append(' ');
        		continue;
        	}
        	tagPageNav(uriAppd, iaPageNums[i], sb);
        }
        
        for(; i < iaPageNums.length; ++i){
        	tagPageNav(uriAppd, iaPageNums[i], sb);
        }
        
        tagEnd("span", sb);

        return sb;
    }


	protected StringBuilder tagPageNav(String uriAppd, int pageNumber, StringBuilder sb){
		return sb.append("<a href=\"")
                .append(uriAppd)
                .append(pageNumber)
                .append('\"')
                .append(" class=\"page-num\"")
                .append('>')
                .append(String.format(this.pageNumFormat, pageNumber))
                .append("</a> ");
	}
}
