package artn.common.model;

import java.io.IOException;
import java.util.Map;

import artn.common.Util;
import artn.database.DBManager;

/**
 * 
 * @author shkang<br/>
 * 접속 정보를 확인하는 모델 클래스
 * @class
 */
public class Visitor {
	private String ip;
	private String ipv6;
	private String dateVisit;
	private String urlInflow;
	private String urlInflowShort;
	private String browserName;
	private String browserVersion;
	private String osName;
	private String osVersion;
	private String osPlatform;
	private String device;
	private String idUser;
	
//	public static Visitor parseVisitor(Map<String, Object> session){
//		Visitor visitor = new Visitor();
//		
//		String s
//	}
	
	/**
	 * 접속 아이피 정보를 저장하고,
	 * 접속한 날짜 및 시간을 저장한다.<br/>
	 * 접속 경로를 저장한다.
	 * @param referer
	 * @param ip
	 */
	public Visitor(String referer, String ip){
		String[] saInflow;
		Util util = Util.getInstance();
		
		
		if (ip.contains(".") == true){
			this.ip = ip;
			this.ipv6 = "";
		}
		else{
			this.ip = "";
			this.ipv6 = ip;
		}
		
		dateVisit = util.getNow();
		if(referer == null){
			urlInflow= "";
			urlInflowShort = "";
		} else{
			urlInflow = referer.toString();
			saInflow = urlInflow.split("/");
			urlInflowShort = saInflow[0] + "//" + saInflow[2];
		}		
	}
	
	/**
	 * 접속한 브라우저 정보를 저장한다.
	 * @param env
	 */
	public void readEnvironment(Environment env){
		this.browserName = env.getBrowserName();
		this.browserVersion = env.getBrowserVersion();
		this.osName = env.getOsName();
		this.osPlatform = env.getOsPlatform();
		this.osVersion = env.getOsVersion();
		this.device = env.getDevice();
	}

	/**
	 * 접속 정보를 DB에 추가한다.
	 * @param dbm
	 */
	public void doInsert(DBManager dbm){
		if(device == null){
			this.setDevice("");
		}		
		if(browserVersion.equals("SERVER")){
			this.setIdUser("SERVER");
		}
		if(this.getIdUser() == null){
			this.setIdUser("Guest");
		}
		dbm.insert("user-stats", this);
	}
	/**
	 * 접속 정보를 DB에 추가한다.
	 * @param session
	 */
	public void doInsert(Map<String, Object> session){
		try {
			this.doInsert(DBManager.getInstanceFromSession(session));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 자신이 접속한 IP를 확인온다.
	 * @return
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * 자신이 접속한 IP를 설정한다.
	 * @param ip
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	/**
	 * 자신이 접속한 IP6를 확인한다.
	 * @return
	 */
	public String getIpv6() {
		return ipv6;
	}
	
	/**
	 * 자신이 접속한 IP6를 설정한다.
	 * @param ipv6
	 */
	public void setIpv6(String ipv6) {
		this.ipv6 = ipv6;
	}
	
	/**
	 * 자신이 접속한 날짜 및 시간을 확인한다.
	 * @return
	 */
	public String getDateVisit() {
		return dateVisit;
	}
	
	/**
	 * 자신이 접속한 날짜 및 시간을 설정한다.
	 * @param dateVisit
	 */
	public void setDateVisit(String dateVisit) {
		this.dateVisit = dateVisit;
	}
	
	/**
	 * 접속한 주소 경로를 확인한다.
	 * @return
	 */
	public String getUrlInflow() {
		return urlInflow;
	}
	
	/**
	 * 접속한 주소 경로를 설정한다.
	 * @param urlInflow
	 */
	public void setUrlInflow(String urlInflow) {
		this.urlInflow = urlInflow;
	}
	
	/**
	 * 접속한 도메인을 확인한다.
	 * @return
	 */
	public String getUrlInflowShort() {
		return urlInflowShort;
	}
	
	/**
	 * 접속한 도메인을 설정한다.
	 * @param urlInflowShort
	 */
	public void setUrlInflowShort(String urlInflowShort) {
		this.urlInflowShort = urlInflowShort;
	}
	
	/**
	 * 브라우저명을 확인한다.
	 * @return
	 */
	public String getBrowserName() {
		return browserName;
	}
	
	/**
	 * 브라우저명을 설정한다.
	 * @param browserName
	 */
	public void setBrowserName(String browserName) {
		this.browserName = browserName;
	}
	
	/**
	 * 브라우저 버전을 확인한다.
	 * @return
	 */
	public String getBrowserVersion() {
		return browserVersion;
	}
	
	/**
	 * 브라우저 버전을 설정한다.
	 * @param browserVersion
	 */
	public void setBrowserVersion(String browserVersion) {
		this.browserVersion = browserVersion;
	}
	
	/**
	 * os명을 확인한다.
	 * @return
	 */
	public String getOsName() {
		return osName;
	}
	
	/**
	 * os명을 설정한다.
	 * @param osName
	 */
	public void setOsName(String osName) {
		this.osName = osName;
	}
	
	/**
	 * os버전을 확인한다.
	 * @return
	 */
	public String getOsVersion() {
		return osVersion;
	}
	
	/**
	 * os버전을 설정한다.
	 * @param osVersion
	 */
	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}
	
	/**
	 * osPlatform의 정보를 확인한다.
	 * @return
	 */
	public String getOsPlatform() {
		return osPlatform;
	}
	
	/**
	 * osPlatform의 정보를 설정한다.
	 * @param osPlatform
	 */
	public void setOsPlatform(String osPlatform) {
		this.osPlatform = osPlatform;
	}
	
	/**
	 * 접속한 장치의 정보를 확인한다.
	 * @return
	 */
	public String getDevice() {
		return device;
	}
	
	/**
	 * 접속한 장치의 정보를 설정한다.
	 * @param device
	 */
	public void setDevice(String device) {
		this.device = device;
	}
	
	/**
	 * 접속한 유저ID를 확인한다.
	 * @return
	 */
	public String getIdUser() {
		return idUser;
	}
	
	/**
	 * 접속한 유저ID를 설정한다.
	 * @param idUser
	 */
	public void setIdUser(String idUser) {
		this.idUser = idUser;
	}
}

