<%@page import="artn.common.model.Environment"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Queue"%>
<%@page import="artn.common.Property"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" trimDirectiveWhitespaces="true" contentType=""%>
<%!
protected String extractContentType(String fileName){
	String contentType = "";
	
	if (fileName.endsWith(".ogg") == true){
		contentType = "audio/ogg";
	}
	else if (fileName.endsWith(".webm") == true){
		contentType = "video/webm";
	}
	else if (fileName.endsWith(".mp4") == true){
		contentType = "video/mp4";
	}
	else if (fileName.endsWith(".mp3") == true){
		contentType = "audio/mp3";
	}
	else if (fileName.endsWith(".jpg") == true){
		contentType = "image/jpeg";
	}
	else if (fileName.endsWith(".png") == true){
		contentType = "image/png";
	}
	
	return contentType;
}

protected String pushOriName(Object oOriName, String fileName){
	try{
		Queue<String> qOriName = (Queue<String>)oOriName;
		return qOriName.poll();
	}
	catch(Exception ex){
		return fileName;
	}
}

protected String pushFileName(Object oFileName, String defName){
	try{
		Queue<String> qFileName = (Queue<String>)oFileName;
		return qFileName.poll();
	}
	catch(Exception ex){
		return defName;
	}
}

protected String pushPath(Object oPath, String defPath){
	try{
		Queue<String> qPath = (Queue<String>)oPath;
		return qPath.poll();
	}
	catch(Exception ex){
		return defPath;
	}
}
protected String readParam(Map params, String key){
	try{
		return ((String[])params.get( key ))[0];
	}
	catch(Exception ex){
		return ((String[])params.get("amp;" + key))[0];
	}
}
protected String encodeFileName(String fileName, String browser){
	String sFileName = "";

	try{
		if(browser.indexOf("IE") != -1){
			sFileName = URLEncoder.encode(fileName, "UTF-8");
		} else if(browser.indexOf("Chrome") != -1){
			sFileName = encISO_8859_1(fileName);
		} else if(browser.indexOf("Opera") != -1){
			sFileName = encISO_8859_1(fileName);
		} else if(browser.indexOf("Safari") != -1){
			sFileName = encISO_8859_1(fileName);
		} else if(browser.indexOf("Firefox") != -1){
			sFileName = encISO_8859_1(fileName);
		} else {
			sFileName = encISO_8859_1(fileName);
		}
	}
	catch(Exception ex){
		return fileName;
	}
	
	return sFileName;
}
protected String encISO_8859_1(String value) throws Exception{
	return new String(value.getBytes("UTF-8"), "ISO-8859-1");
}
%><%
FileInputStream fis = null;
OutputStream os = null;

response.reset();

try{
	String browser = ( session.getAttribute("environment") != null)? ((Environment)session.getAttribute("environment")).getBrowserName() : "IE";
	Map mParams = request.getParameterMap();
	String sFileName = readParam(mParams, "fileName");
	String sOriName = pushOriName( session.getAttribute("oriNameQueue"), sFileName );
	String sPath = readParam(mParams, "path");
	String sDownloadPath = Property.getInstance().get("artn.common.downloadPath");
	File file = new File( sDownloadPath + "/" + sPath + "/" + sFileName );
	
	String sContentType = extractContentType(sFileName);
	
	fis = new FileInputStream(file);
	os = response.getOutputStream();

	byte[] byaData = new byte[1024];
	int iNum = 0;
	long longFileLength = file.length();

	sOriName = encodeFileName(sOriName, browser);
	
	response.setContentType(sContentType);
	response.addHeader("Content-Type", sContentType );
	response.addHeader("Content-Length", longFileLength + "");
	response.addHeader("Accept-Ranges", "bytes");
	response.addHeader("Content-Range", "bytes 0-" + (longFileLength) + "/" + longFileLength );
	response.addHeader("Content-Disposition", "attachment;filename=\"" + sOriName + "\"");

	while((iNum = fis.read(byaData)) > -1){
		os.write(byaData, 0, iNum);
	}
	
	os.flush();
	os.close();
	fis.close();
}catch(Exception ex){}


%>