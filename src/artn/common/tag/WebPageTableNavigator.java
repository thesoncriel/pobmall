package artn.common.tag;

public class WebPageTableNavigator extends WebPageInlineNavigator {
	private String classFirst = "page-first";
	private String classPrev = "page-prev";
	private String classNext = "page-next";
	private String classLast = "page-last";

	public WebPageTableNavigator(String id, String cssClass, String style){
		super(id, cssClass, style);
	}

	@Override
	public StringBuilder make(StringBuilder sb) {
		StringBuilder sbUriAppd = new StringBuilder(uri);
		String sUriAppd;
		
		if (sb == null) sb = new StringBuilder();
		if (cssClass == null) cssClass = "pagenav";
		
		tagStart("table", sb, true).tagStartNonAttr("tbody", sb, true).tagStartNonAttr("tr", sb, true);
		
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
        tagTableStructurePageSelector(sUriAppd, sb);
        tagAnchor(this.classNext, sUriAppd, ((page < lastPage)? Integer.toString(page + 1) : "#"), this.fontNext, sb);
        tagAnchor(this.classLast, sUriAppd, Integer.toString(lastPage), this.fontLast, sb);
        
        tagEnd("tr", sb).tagEnd("tbody", sb).tagEnd("table", sb);
		return sb;
	}
	@Override
	protected StringBuilder tagAnchor(String cssClass, String uriAppd, String page, String content, StringBuilder sb){
		return super.tagAnchor("", uriAppd, page, content, sb.append("<td class=\"").append(cssClass).append("\">")).append("</td>");
    }
	@Override
	protected StringBuilder tagPageNav(String uriAppd, int pageNumber, StringBuilder sb){
		return super.tagPageNav(uriAppd, pageNumber, sb.append("<td class=\"page-num\">")).append("</td>");
	}

	protected StringBuilder tagTableStructurePageSelector(String uriAppd, StringBuilder sb){
        int[] iaPageNums = getPageSelectorNumbers();
        int i = 0;
        
        for(; i < iaPageNums.length; ++i){
        	if ((iaPageNums[i] == page)){
        		tagStartCustom("td", sb, null, "page-num selected", null, true)
        		.tagStartNonAttr("span", sb, true)
        		.tagEnd("span", sb.append(iaPageNums[i]))
        		.tagEnd("td", sb);
        		continue;
        	}
        	tagPageNav(uriAppd, iaPageNums[i], sb);
        }
        
        for(; i < iaPageNums.length; ++i){
        	tagPageNav(uriAppd, iaPageNums[i], sb);
        }


        return sb;
    }
	
}
