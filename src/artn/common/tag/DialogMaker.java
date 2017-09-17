package artn.common.tag;

public class DialogMaker extends AbsTagMaker {	
	private boolean useNewWindow = false;
	private boolean isTitle = false;
	private boolean modal = false;
	private boolean usePopupZone = false;
	private boolean useOuterURL = false;
	//private boolean todayNonOpen = false;
	private String onceOpen = "none";
	private int width;
	private int height;
	private int positionX;
	private int positionY;
	private String popupContent;
	private int index;
	private String title;
	
	public DialogMaker(){}
	public DialogMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart("div", sb, false);
		tagAttr("data-auto-open", true + "", sb);
		tagAttr("data-new-window", useNewWindow + "", sb);
		tagAttr("data-title", isTitle + "", sb);
		tagAttr("data-modal", modal + "", sb);
		tagAttr("data-popup-zone", usePopupZone + "", sb);
		/*tagAttr("data-contents", isContent + "", sb);*/
		tagAttr("data-outer-url", useOuterURL + "", sb);
		/*tagAttr("data-close", todayNonOpen + "", sb);*/
		tagAttr("data-once-open", onceOpen, sb);
		tagAttr("data-index", index, sb);
		if ( isTitle == true || useNewWindow == true ) tagAttr("title", title, sb); 
		if ( width > 0 ) tagAttr("data-width", width, sb);
		if ( height > 0 ) tagAttr("data-height", height, sb);
		if ( positionX >= 0 ) tagAttr("data-position-x", positionX, sb);
		if ( positionY >= 0 ) tagAttr("data-position-y", positionY, sb);
		sb.append(">");
		
			tagStartNonAttr("div", sb, true);
				sb.append(popupContent);
			sb.append("</div>");
		if(onceOpen.equals("none") == false){	
			tagStartNonAttr("input", sb, false);
			tagAttr("id", "close_checkbox" + index, sb);
			tagAttr("name", "checkbox", sb);
			tagAttr("type", "checkbox", sb);
			sb.append("/>");
			
			tagStartNonAttr("label", sb, false);
			tagAttr("id", "label_close_checkbox" + index, sb);
			tagAttr("for", "close_checkbox" + index, sb);
			sb.append(">");
				tagStartNonAttr("span", sb, true);
				if(onceOpen.equals("today")){
					sb.append("오늘 하루 열지 않기");
				} else if(onceOpen.equals("session")){
					sb.append("지금은 보지 않기");
				}
				sb.append("</span>");
			sb.append("</label>");
		}
		sb.append("</div>");
		return sb;
	}
	
	public DialogMaker setPopupOpt( Integer popupOpt ){
		this.useNewWindow = 	(popupOpt & 2) > 0;
		this.isTitle = 			(popupOpt & 4) > 0;
		this.modal = 			(popupOpt & 8) > 0;
		this.usePopupZone = 	(popupOpt & 16) > 0;
		/*this.isContent = 		(popupOpt & 256) > 0;*/
		this.useOuterURL = 		(popupOpt & 512) > 0;
		if( (popupOpt & 4096) > 0 ) {
			this.onceOpen = "today";
		}
		if( (popupOpt & 8192) > 0 ) {
			this.onceOpen = "session";
		}
		
		return this;
	}
	
	public DialogMaker setWidth(Integer width) {
		this.width = (width != null)? width : 0;
		return this;
	}

	public DialogMaker setHeight(Integer height) {
		this.height = (height != null)? height : 0;
		return this;
	}
	
	public DialogMaker setPositionX(Integer positionX) {
		this.positionX = (positionX != null)? positionX : 0;
		return this;
	}

	public DialogMaker setPositionY(Integer positionY) {
		this.positionY = (positionY != null)? positionY : 0;
		return this;
	}
	
	public DialogMaker setPopupContent(String popupContent){
		this.popupContent = popupContent;
		return this;
	}
	public DialogMaker setIndex(Integer index) {
		this.index = (index != null)? index : 0;
		return this;
	}
	
	public DialogMaker setTitle(String title){
		this.title = title;
		return this;
	}
}
