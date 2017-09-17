package artn.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayDeque;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Queue;

import artn.common.FileNameChangeMode;
import artn.common.model.Environment;

public class FileAction extends DefaultAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7685406445252191609L;
	private InputStream fileInputStream;
	private InputStream resultInputStream;
//	private String fileName;
//	
//	public String getFileName(){
//		return fileName;
//	}
	
	public InputStream getFileInputStream() {
		return fileInputStream;
	}
	
	public InputStream getResultInputStream(){
		return resultInputStream;
	}
		
	@Override
	public String execute() throws Exception {		
//		String browser = (session().containsKey("environment") == true)? ((Environment) session().get("environment")).getBrowserName() : "IE";
//		String sFileName = "";
//		
//		try{
//			sFileName = getParams().get("fileName").toString();
//		}
//		catch(Exception ex){
//			sFileName = getParams().get("amp;fileName").toString();
//		}
//
//		String sOriName = (getParams().containsKey("oriName") == true)? getParams().get("oriName").toString() : sFileName;
//		
//		setQueueData( "oriNameQueue", sOriName );
//        
//		if(browser.indexOf("IE") != -1){
//			sFileName = URLEncoder.encode(sOriName, "UTF-8");
//			getParams().put("fileName", sFileName);
//		} else if(browser.indexOf("Chrome") != -1){
//			sFileName = encISO_8859_1(sOriName);
//			getParams().put("fileName", sFileName);
//		} else if(browser.indexOf("Opera") != -1){
//			sFileName = encISO_8859_1(sOriName);
//			getParams().put("fileName", sFileName);
//		} else if(browser.indexOf("Safari") != -1){
//			sFileName = encISO_8859_1(sOriName);
//			getParams().put("fileName", sFileName);
//		} else if(browser.indexOf("Firefox") != -1){
//			sFileName = encISO_8859_1(sOriName);
//			getParams().put("fileName", sFileName);
//		} else {
//			sFileName = encISO_8859_1(sOriName);
//			getParams().put("fileName", sFileName);
//		}
		
		
		//fileName = getParams().get("fileName").toString();
		//getArrayParams().get(sOriName);
		/*
		try{			
			Enumeration<Object> enumeration = properties.keys();
			while(enumeration.hasMoreElements()){
				String key = (String)enumeration.nextElement();
				String value = properties.getProperty(key);
				
				//sFilePath = getParams().get("filePath").toString();
				sFileName = getParams().get("fileName").toString();
				
				fileInputStream = new FileInputStream(new File(value + sFileName));
			}
		} catch(IOException e){}
		*/	
				
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	protected void setQueueData(String queueKey, String value){
		Queue<String> qOriName = null;
		
		if (session().containsKey( queueKey ) == false){
			qOriName = new ArrayDeque<String>();
			session().put( queueKey, qOriName);
		}
		else{
			qOriName = (Queue<String>)session().get( queueKey );
		}
		
		qOriName.add( value );
	}
	
	protected String encISO_8859_1(String value) throws Exception{
		return new String(value.getBytes("UTF-8"), "ISO-8859-1");
	}

	public String upload() throws Exception {
		String sResult;
		String sPath = "";
		Object[] oaSubDirName = getFileParams().keySet().toArray();
		if(oaSubDirName == null || oaSubDirName.length < 1){
			resultInputStream = new ByteArrayInputStream("".getBytes());
			return "success";
		}
		String sSubDirName = oaSubDirName[0].toString();
		String sFileName;
		boolean hasPathKey = getParams().containsKey("path");

		if (hasPathKey == false){
			sPath = "/upload/board/";
		}
		else{
			sPath = getParams().get("path").toString();
			
			if (sPath.endsWith("/") == false){
				sPath = sPath + '/';
			}
		}
		
		if(hasFileParams() == true){
			saveFileToAuto(this.getDownloadPath() + sPath,"",FileNameChangeMode.underbar);
		}
		
		sFileName = getParams().get( sSubDirName ).toString();
		
		sResult = "1|/download?path=" + sPath + sSubDirName.replace("file_", "") + "/&fileName=" + sFileName + "|" + getParams().get( sSubDirName.replace("file_", "ori_") ) + "|";
		resultInputStream = new ByteArrayInputStream(sResult.getBytes());
		
		return "success";
	}
	
	public String uploadImage() throws Exception {
		String sResult;
		
		if(hasFileParams() == true){
			saveFileToAuto(this.getDownloadPath() + "/upload/image/","",FileNameChangeMode.underbar);
		}
		
		sResult = "1|/download?path=/upload/image/file_img/&fileName=" + getParams().get("file_img") + "||";
		resultInputStream = new ByteArrayInputStream(sResult.getBytes());
		
		setResponse("");
		return TEXT_RESPONSE;
	}
	
	public String exceldown() throws Exception {		
		List<Map<String, Object>> listParam;
		List<Map<String, Object>> subParam;
		
		listParam = (List<Map<String, Object>>) session().get("listParam");
		subParam = (List<Map<String, Object>>) session().get("subParam");
		
		session().remove("listParam");
		session().remove("subParam");
		
		fileInputStream = makeExcel(listParam, subParam);
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyy-MM-dd", Locale.KOREA);
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format ( currentTime );
		getParams().put("fileName", getParams().get("fileName").toString()+mTime+".xls");
		
		
		return SUCCESS;
	}
}
