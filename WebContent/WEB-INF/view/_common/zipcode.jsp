<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%--
<%@page import="org.xml.sax.SAXParseException"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.joox.Match"%>
<%@page import="org.joox.JOOX"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="org.joox.JOOX.*"%>
--%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
URL url = null;
URLConnection urlConn = null;
InputStreamReader isr = null;
BufferedReader br = null;

//http://openapi.epost.go.kr/
String sPage = request.getParameter("page");
String sKeyword = request.getParameter("keyword");
String sRowLimit = request.getParameter("rowlimit");

String sUrlInc = URLEncoder.encode(((sKeyword == null)? "장항동" : sKeyword), "UTF-8");
String sUrl = "http://www.juso.go.kr/support/AddressMainSearch.do?currentPage=" + ((sPage == null)? "1" : sPage) + "&countPerPage=" + ((sRowLimit == null)? "10" : sRowLimit) + "&searchType=location_newaddr&searchKeyword=" + sUrlInc + "&lang=&sortType=acc";

boolean isRoadDataNear = false;
boolean isTableDataStarted = false;
boolean hasPassedFirstRow = false;
boolean hasTdTag = false;
int iTdCount = 0;

String sBuf = null;
StringBuilder sb = new StringBuilder();
StringBuilder sbOutput = new StringBuilder();

try{
	url = new URL(sUrl);
	urlConn = url.openConnection();
	urlConn.addRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; InfoPath, 1)");
	
	isr = new InputStreamReader(urlConn.getInputStream());
	br = new BufferedReader(isr);
	
	// 1차: 데이터가 있는 테이블 근처를 찾는다: 현재는 tab1c2 라는 id 값을 찾으면 됨.
	while(true){
		sBuf = br.readLine();

		if (sBuf == null) break;
		if (sBuf.contains("id=\"tab1c2\"") == true){
			isRoadDataNear = true;
			break;
		}
	}
	// 2차: 테이블 태그가 있는 위치를 찾고, 이 곳을 XML 시작위치로 잡는다 -> xml 시작 태그 삽입 
	while(isRoadDataNear){
		sBuf = br.readLine();

		if (sBuf == null) break;
		if (sBuf.trim().contains("<table") == true) {
			sb.append("<?xml version=\"1.0\"?>");
			sb.append(sBuf);
			isTableDataStarted = true;
			break;
		}
	}
	// 3차: 중간의 colgroup과 첫 tr은 제외 한다
	while(isTableDataStarted){
		sBuf = br.readLine();
		
		if (sBuf == null) break;
		if (sBuf.endsWith("</tr>") == true) {
			hasPassedFirstRow = true;
			break;
		}
	}
	// 4차: 테이블이 끝나는 지점까지 StringBuilder에 append 한다. 단, 5번째 열은 제외 한다 - 쓸데없는 태그가 많고 덕분에 XML parsing할 때 죽음이다 -_-;
	// 덤으로 필요없는 img, br 태그나 자꾸 parsing 에러 내는 onclick 이벤트, 그리고 특수기호 (&nbsp;)를 제거 한다.
	while(hasPassedFirstRow){
		sBuf = br.readLine();
		
		if (sBuf == null) break;
		sBuf = sBuf.trim();

		if (sBuf.endsWith("</table>")){
			sb.append(sBuf);
			break;
		}
		if (sBuf.startsWith("<td") == true){
			iTdCount++;
		}
		if ((iTdCount == 5) && (sBuf.endsWith("</tr>"))){
			iTdCount = 0;
		}
		
		if (iTdCount > 4) continue;
		
		// TODO: 아래의 정규식을 한번에 처리할 수 있도록 할 것 
		
		//sBuf = sBuf.replaceAll("<img.*(관련지번).*>", "(관련지번)");
		//sBuf = sBuf.replaceAll("<br/>|onclick=\".*\"| href\\=.*\"|※보안시설물로 지도서비스는 불가함| style\\=.*\"|<a >,상세주소보기</font></a>|&nbsp;", "");
		/**/
		sBuf = sBuf.replaceAll("<br/>", "");
		sBuf = sBuf.replaceAll("onclick=\".*\"", "");
		sBuf = sBuf.replaceAll(" href\\=.*\"", "");
		sBuf = sBuf.replaceAll("※보안시설물로 지도서비스는 불가함", "");
		sBuf = sBuf.replaceAll(" style\\=.*\"", "");
		sBuf = sBuf.replaceAll("<a >,상세주소보기</font></a>", "");
		sb.append(sBuf.replaceAll("&nbsp;", ""));
		
		//sb.append(sBuf);
		//System.out.println(sBuf);
	}
	br.close();
	
	out.println(sb.toString());
/*
	
	// 5차: 따 온 table 태그 구조를 XML 파싱
	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	ByteArrayInputStream is = new ByteArrayInputStream(sb.toString().getBytes());
	Document doc = docBuilder.parse(is);
	
	// 6차 jQuery로 넣고 tr만 따로 빼기
	Match matchTable = JOOX.$(doc).find("tr").filter(JOOX.even()); // 짝수행은 그냥 테두리 이미지 채우기 위한 것임 -_-; 그래서 패스 하려고 even 사용
	Match matchTd = null;
	Match matchNewAddr = null;
	int iCol = 0;
	String sDong, sNewAddr;

	// 7차: JSON 으로 작성한다.
	sbOutput.append("[\r\n");
	
	for(int i = 0; i < matchTable.size(); i++){
		matchTd = matchTable.eq(i).find("td");
		sDong = matchTd.eq(1).find("b").text();
		sNewAddr = matchTd.eq(1).find("a").text();

		if ((sDong == null) || (sNewAddr == null)) break;

		sbOutput.append("{\r\n");

		for(iCol = 0; iCol < 4; iCol++){
			switch(iCol){
			case 0: sbOutput.append("\"row_num\": \""); break;
			case 1: sbOutput.append("\"address_new\": \""); break;
			case 2: sbOutput.append("\"address\": \""); break;
			case 3: sbOutput.append("\"zipcode\": \""); break;
			}

			switch(iCol){
			case 1: sbOutput.append(sNewAddr.trim());
				if (sDong != null) sbOutput.append(" (").append(sDong).append(')'); break;
			default: sbOutput.append(matchTd.eq(iCol).text());
			}

			sbOutput.append("\",\r\n");
		}

		sbOutput.deleteCharAt(sbOutput.length() - 3).append("},\r\n");
	}
	sbOutput.deleteCharAt(sbOutput.length() - 3).append("]");
	out.println(sbOutput.toString());
	
}
catch(SAXParseException ex){
	out.println(sb.toString());*/
}
catch(Exception ex){
	out.println(ex);
	out.println(sb.toString());
}
%>