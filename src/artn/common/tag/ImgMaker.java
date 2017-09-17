package artn.common.tag;

public class ImgMaker extends AbsTagMaker {

	private String alt;
	private String altNone;
	private String src;
	private String srcNone;
	private int width;
	private int height;
	
	public ImgMaker(){}
	public ImgMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart("img", sb, false);
		
		if ((src == null) || (src.equals("") == true)){
			tagAttr("src", srcNone, sb)
			.tagAttr("alt", altNone, sb);
		}
		else{
			tagAttr("src", src, sb)
			.tagAttr("alt", alt, sb);
		}
		
		if (width > 0) tagAttr("width", width, sb);
		if (height > 0) tagAttr("height", height, sb);
		
		sb.append(" />");
		
		return sb;
	}

	public ImgMaker setAlt(String alt) {
		this.alt = alt;
		return this;
	}

	public ImgMaker setAltNone(String altNone) {
		this.altNone = altNone;
		return this;
	}

	public ImgMaker setSrc(String src) {
		if ((src == null) || (src.endsWith("/") == true) || (src.endsWith("fileName=") == true)){
			this.src = null;
		}
		else{
			this.src = src;
		}
		
		return this;
	}

	public ImgMaker setSrcNone(String srcNone) {
		this.srcNone = srcNone;
		return this;
	}

	public ImgMaker setWidth(Integer width) {
		this.width = (width != null)? width : 0;
		return this;
	}

	public ImgMaker setHeight(Integer height) {
		this.height = (height != null)? height : 0;
		return this;
	}

	
}
