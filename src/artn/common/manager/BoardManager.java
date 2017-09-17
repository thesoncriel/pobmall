package artn.common.manager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.jdom2.Document;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.jdom2.Element;

import artn.common.Const;
import artn.common.Property;
import artn.common.controller.AbsUploadActionController;
import artn.common.model.BoardInfo;
import artn.common.model.User;

public class BoardManager {
	
	private Map<String, BoardInfo> boardInfoMap = null;
	ArrayList<BoardInfo> boardInfoList = null;	
	private String xmlPath;
	
	public static BoardManager getInstanceFromSession(Map<String, Object> session){
		BoardManager boardManager;
		
		if (session.containsKey("boardManager") == false){
			boardManager = new BoardManager();
			session.put("boardManager", boardManager);
		}
		else{
			boardManager = (BoardManager)session.get("boardManager");
		}
		
		return boardManager;
	}
	
	public BoardManager(){
		/// board config 파일 경로를 root 외곽에 두는 것으로 설정 - 2013.12.05 by jhson [시작]
		this(Const.getRootPath() + Property.getInstance().get("artn.board.configPath") );
		//this( Property.getInstance().get("artn.board.configPath") );
		/// board config 파일 경로를 root 외곽에 두는 것으로 설정 - 2013.12.05 by jhson [종료]
	}
	public BoardManager(String filePath){
		xmlPath = filePath;
		try {
			load( xmlPath );
		} catch (IOException e) {
		} catch (JDOMException e) {
		}
	}
	
	public void load(String filePath) throws IOException, JDOMException{
		File fileName =  new File(filePath);
		SAXBuilder builder = new SAXBuilder();			
		Document doc = (Document)builder.build(fileName);			
		Element rootNote = doc.getRootElement();			
		List<Element> elements = rootNote.getChildren("board");			
		
		boardInfoMap = new HashMap<String, BoardInfo>();
		
		for(Element element : elements){
			loadBoardInfo(element);
		}
	}

	protected void loadBoardInfo(Element boardElement){
		BoardInfo boardInfo = new BoardInfo();
		String sBoardNo = boardElement.getAttributeValue("boardNo");
		String sElemName = "";
		List<Element> elements = boardElement.getChildren();
		
		boardInfo.setBoardNo(Integer.parseInt(sBoardNo));		
		
		for(Element element : elements){
			sElemName = element.getName(); 
			
			if(sElemName.compareTo("name") == 0){
				boardInfo.setName(element.getValue());
			}
			else if(sElemName.compareTo("contentsCode") == 0){
				boardInfo.setContentsCode(element.getValue());
			}
			else if(sElemName.compareTo("view") == 0){
				boardInfo.setView(element.getValue());
			}
			else if(sElemName.compareTo("authList") == 0){
				boardInfo.setAuthList(Integer.parseInt(element.getValue()));
			}
			else if(sElemName.compareTo("authShow") == 0){
				boardInfo.setAuthShow(Integer.parseInt(element.getValue()));		
			}
			else if(sElemName.compareTo("authModify") == 0){
				boardInfo.setAuthModify(Integer.parseInt(element.getValue()));
			}
			else if(sElemName.compareTo("authDelete") == 0){
				boardInfo.setAuthDelete(Integer.parseInt(element.getValue()));
			}
			else if(sElemName.compareTo("rowLimit") == 0){
				boardInfo.setRowLimit(Integer.parseInt(element.getValue()));
			}	
		}
		
		boardInfoMap.put(sBoardNo, boardInfo);
	}
	
	protected String convertToSingleValue(Object value){
		if (value instanceof java.lang.String[]){
			return ( (String[])value )[0];
		}
		
		return value.toString();
	}
	
	public BoardInfo get(Object boardNo){ return this.boardInfoMap.get(boardNo); }
	
	public boolean isAuthList(Object boardNo, User user){
		int iAuthList = boardInfoMap.get( convertToSingleValue(boardNo) ).getAuthList();
		return (user != null)? iAuthList <= user.getAuthUser() : iAuthList <= 0;
	}
	public boolean isAuthShow(Object boardNo, User user){
		int iAuthShow = boardInfoMap.get( convertToSingleValue(boardNo) ).getAuthShow();
		return (user != null)? iAuthShow <= user.getAuthUser() : iAuthShow <= 0;
	}
	public boolean isAuthModifiy(Object boardNo, User user){
		int iAuthModify = boardInfoMap.get( convertToSingleValue(boardNo) ).getAuthModify();
		return (user != null)? iAuthModify <= user.getAuthUser() : iAuthModify <= 0;
	}
	public boolean isAuthDelete(Object boardNo, User user){
		int iAuthDelete = boardInfoMap.get( convertToSingleValue(boardNo) ).getAuthDelete();
		return (user != null)? iAuthDelete <= user.getAuthUser() : iAuthDelete <= 0;
	}
	
	public List<BoardInfo> getList(){
		if (boardInfoList == null){
			boardInfoList = new ArrayList<BoardInfo>();
			
			for(int i = 1; i <= boardInfoMap.size(); i++){
				boardInfoList.add(boardInfoMap.get(i + ""));
			}
		}
		
		return boardInfoList;
	}
	
	public void xmlModify(Map<String, Object> params){
		xmlModify(
				new String[]{ params.get("boardNo").toString() },
				new String[]{ params.get("name").toString() },
				new String[]{ params.get("view").toString() },
				new String[]{ params.get("contentsCode").toString() },
				new String[]{ params.get("authList").toString() },
				new String[]{ params.get("authShow").toString() },
				new String[]{ params.get("authModify").toString() },
				new String[]{ params.get("authDelete").toString() },
				new String[]{ params.get("rowLimit").toString() }
				);
	}
	
	public void xmlModify(String[] boardNo,
							String[] name,
							String[] view,
							String[] contentsCode,
							String[] authList,
							String[] authShow,
							String[] authModify,
							String[] authDelete,
							String[] rowLimit) {		
		
		
		Document document = new Document();		
		//root 노드 
		Element eBoardList = new Element("boardList");
		//document.setRootElement(eBoardList);
		
		
//		System.out.println("boardNo.length.........."+boardNo.length);
		boardInfoMap.clear();
		boardInfoList = null;		
		
		
		for(int i=0; i<boardNo.length; i++){
			BoardInfo boardInfo = new BoardInfo();
			//하위 노드
			Element eBoard = new Element("board");
			
			eBoard.setAttribute("boardNo", boardNo[i]);
			//값
			boardInfo.setBoardNo(Integer.parseInt(boardNo[i]));
			boardInfo.setName(name[i]);
			boardInfo.setView(view[i]);
			boardInfo.setContentsCode(contentsCode[i]);
			boardInfo.setAuthList(Integer.parseInt(authList[i]));
			boardInfo.setAuthShow(Integer.parseInt(authShow[i]));
			boardInfo.setAuthModify(Integer.parseInt(authModify[i]));
			boardInfo.setAuthDelete(Integer.parseInt(authDelete[i]));
			boardInfo.setRowLimit(Integer.parseInt(rowLimit[i]));
			
			boardInfoMap.put(boardNo[i], boardInfo);
			
			eBoard.addContent(new Element("boardNo").setText(boardNo[i]));
			eBoard.addContent(new Element("name").setText(name[i]));
			eBoard.addContent(new Element("view").setText(view[i]));
			eBoard.addContent(new Element("contentsCode").setText(contentsCode[i]));
			eBoard.addContent(new Element("authList").setText(authList[i]));
			eBoard.addContent(new Element("authShow").setText(authShow[i]));
			eBoard.addContent(new Element("authModify").setText(authModify[i]));
			eBoard.addContent(new Element("authDelete").setText(authDelete[i]));
			eBoard.addContent(new Element("rowLimit").setText(rowLimit[i]));			
			
			eBoardList.addContent(eBoard);
		}
		
		document.addContent(eBoardList);
		
		XMLOutputter xmlOutputter = new XMLOutputter();
		
		Format format = Format.getPrettyFormat();
		format.setEncoding("UTF-8");
		format.setIndent(" ");
		format.setLineSeparator("\r\n");
		format.setTextMode(Format.TextMode.TRIM);
		
		xmlOutputter.setFormat(format);
				
		try {
			//xmlOutputter.output(document, System.out);
			xmlOutputter.output(document, new FileOutputStream(xmlPath));
			//load();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}