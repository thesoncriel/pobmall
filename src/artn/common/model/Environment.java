package artn.common.model;

/**
 * 
 * @author shkang<br/>
 * 브라우저 정보를 확인하는 모델 클래스
 * @class
 */
public class Environment {	
		private String browserName;
		private String browserVersion;
		private String osName;
		private String osVersion;
		private String osPlatform;
		private String device;

		/**
		 * 브라우저 정보를 확인한다.
		 * @param userAgent
		 */
		public Environment(String userAgent){
			String sOsVer = "0";
			String sBrowser = "";
			int index = 0;
			if(userAgent.startsWith("Java")){
				browserName = "/******";
				browserVersion = "SERVER";
				osName = "STARTING";
				osVersion = "TIME";
				osPlatform = "Desktop";
				device = "******/";
				
				return;
			}
			//Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)
			if ( (index = userAgent.indexOf("Windows")) >= 0){
				sOsVer = userAgent.substring(index, userAgent.indexOf(".", index) + 2);				
				if 		(sOsVer.equals("Windows NT 5.1") == true) 	osName = "WinXP";
				else if (sOsVer.equals("Windows NT 6.0") == true) 	osName = "WinVista";
				else if (sOsVer.equals("Windows NT 6.1") == true) 	osName = "Win7";
				else if (sOsVer.equals("Windows NT 6.2") == true) 	osName = "Win8";
				else												osName = "Windows";
				
				osPlatform = "Desktop";
			}
			//Mozilla/5.0 (Linux; U; Android 2.3.6; ko-kr; SHW-M110S Build/GINGERBREAD) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1
			else if ( (index = userAgent.indexOf("Android")) >= 0){
				osName = "Android";
				sOsVer = userAgent.substring(index, userAgent.indexOf(".", index) + 2);				
				osPlatform = "Mobile";				
			}
			//Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1
			else if ( (index = userAgent.indexOf("Macintosh")) >= 0){
				index = userAgent.indexOf("Version");
				osName = "MacOSX";
				sOsVer = "MacOSX" + ' ' + userAgent.substring( userAgent.indexOf('/', index) + 1, userAgent.indexOf('.', index) + 2) ;				
				osPlatform = "Desktop";				
			}
			//Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25
			else if ( (userAgent.contains("iPhone") == true) ){
				index = userAgent.indexOf("Version");
				osName = "iOS";
				sOsVer = "iOS" + ' ' + userAgent.substring( userAgent.indexOf('/', index) + 1, userAgent.indexOf('.', index) + 2) ;				
				osPlatform = "Mobile";
				device = "iPhone";				
			}
			//Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25
			else if ( (userAgent.contains("iPad") == true) ){
				index = userAgent.indexOf("Version");
				osName = "iOS";
				sOsVer = "iOS" + ' ' + userAgent.substring( userAgent.indexOf('/', index) + 1, userAgent.indexOf('.', index) + 2) ;				
				osPlatform = "Mobile";
				device = "iPad";				
			}
			osVersion = sOsVer;
			
			
			if(osPlatform != null && osPlatform.equals("Desktop") == true){
			//Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)
				if( (index = userAgent.indexOf("MSIE")) >= 0){
					browserName = "IE";
					browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf(' ', index ) + 1, userAgent.indexOf(';', index));
					osPlatform = "Desktop";
				}
				//Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko
				else if( (index = userAgent.indexOf("Trident")) >= 0){
					browserName = "IE";
					browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf("rv:") + 3, userAgent.indexOf('.', userAgent.indexOf("rv")));
					osPlatform = "Desktop";
				}
				//Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0
				else if ( (index = userAgent.indexOf("Firefox")) >= 0){
					browserName = "Firefox";
					browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf('/', index ) + 1, userAgent.indexOf('.', index) + 2 );
					osPlatform = "Desktop";
				}
				//Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.72 Safari/537.36 OPR/15.0.1147.148
				else if ( (index = userAgent.indexOf("OPR")) >= 0){
					browserName = "Opera";
					browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf('/', index ) + 1, userAgent.indexOf('.', index) + 2 );
					osPlatform = "Desktop";
				}
				//Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36
				else if ( (index = userAgent.indexOf("Chrome")) >= 0){
					browserName = "Chrome";
					browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf('/', index ) + 1, userAgent.indexOf('.', index) + 2 );
					osPlatform = "Desktop";
				}
			} else {			
				if ( (index = userAgent.indexOf("Safari")) >= 0){
					//Mozilla/5.0 (Linux; U; Android 2.3.6; ko-kr; SHW-M110S Build/GINGERBREAD) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1
					//Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; SHW-M250S Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30
					if (osName.equals("Android") == true){
						browserName = "Android";
						browserVersion = sOsVer;
						osPlatform = "Mobile";
					}
					//Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25
					//Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1
					else if (osName.equals("iOS") || osName.equals("MacOSX")){
						index = userAgent.indexOf("Version");
						browserName = "Safari";
						browserVersion = browserName + " " + userAgent.substring( userAgent.indexOf('/', index ) + 1, userAgent.indexOf('.', index) + 2 );
						if(osName.equals("iOS")){osPlatform = "Mobile";}
						else if(osName.equals("MacOS")){osPlatform = "Desktop";}
						
					}
				}
				else if ( (index = userAgent.indexOf("Opera")) >= 0){
					browserName = "Opera";
					browserVersion = browserName + " " + "13.0";
					osPlatform = "Desktop";
				}
				
				else{
					browserName = "Unknown";
					browserVersion = browserName + " " + "0.0";
					osPlatform = "Desktop";
					// chrome:		Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36
					// firefox:		Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0
					// android2.3:	Mozilla/5.0 (Linux; U; Android 2.3.6; ko-kr; SHW-M110S Build/GINGERBREAD) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1				
				}
				
				if (osName == null){
					osName = "Unknown";
				}
			}
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
		 * osPlatform을 확인한다.
		 * @return
		 */
		public String getOsPlatform() {
			return osPlatform;
		}
		
		/**
		 * osPlatform을 설정한다.
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
	}
