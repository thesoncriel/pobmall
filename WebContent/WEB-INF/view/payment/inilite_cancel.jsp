<%------------------------------------------------------------------------------
 FILE NAME : INIcancel.jsp
 AUTHOR : jwkim@inicis.com
 DATE : 2002/12
 USE WITH : INIcancel.html
 
 지불 취소 요청을 처리한다.
                                                          http://www.inicis.com
                                                      http://support.inicis.com
                                 Copyright 2002 Inicis, Co. All rights reserved.
------------------------------------------------------------------------------%>

<%@ page
	language = "java"
	contentType = "text/html; charset=utf-8"
	import = "com.inicis.inilite.client.*,
              com.inicis.inilite.util.*"
            
%>

<%
		request.setCharacterEncoding("utf-8");
    INIcancelLite inipay = new INIcancelLite("D:/test/tomcat/webapps/inilite/log");
    IniliteHashMap resultValue = new IniliteHashMap();
    String resultXML ="";

    try
    {
        resultXML = inipay.cancel(request.getParameter("mid"),request.getParameter("tid"),request.getParameter("msg"), "WFhNdXBGQlFnblVRMDlLRnVSZTdSQT09"/* "SU5JTElURV9UUklQTEVERVNfS0VZU1RS" */);
        System.out.println("page result --> " + resultXML);
    }
    catch (Exception e)
    {
        System.out.println(e.getMessage());
    }

    resultValue = inipay.parseXML(resultXML);

	String resultCode = (String) resultValue.get("resultcode");         // 결과코드 ("00"이면 지불 성공)
	String resultMsg = (String) resultValue.get("resultmessage");       // 결과내용 (지불결과에 대한 설명)
	String mid = (String) resultValue.get("mid");
        String tid = (String) resultValue.get("tid");                       // 거래번호
	String pgCancelDate = (String) resultValue.get("pgcanceldate");         // 이니시스 승인날짜
	String pgCancelTime = (String) resultValue.get("pgcanceltime");         // 이니시스 승인시각
	String rcash_cancel_noappl = (String) resultValue.get("rcash_cancel_noappl");                     // 상점 주문번호



%>
<html>
<head>
<title>관리자 취소페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/css/wellness/group.css" type="text/css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<style>
body, tr, td {font-size:9pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:굴림,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

$(document).ready(function(){
	var sResultCode = $("#resultCode").text();	
	if(sResultCode === "00"){
		$.post("/purchase/update",	{"id_user":$("input[name='id_user']").val(),
			                         "id_payment":$("input[name='id_payment']").val(),
			                         "id_purchase":$("input[name='id_purchase']").val(),
			                         "status":-2, "inicancel":"inicancel"
			                         },
			                         function(data){
			window.opener.location.reload();			
		});
	}
});
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0><center>
<input type="hidden" name="id_user" value="${params.id_user}"/>
<input type="hidden" name="id_payment" value="${params.id_payment}"/> 
<input type="hidden" name="id_purchase" value="${params.id_purchase}"/>
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="83" background="<% 
    					// 지불수단에 따라 상단 이미지가 변경 된다
    					
    				if(resultCode.equals("01")){
					out.println("/img/payment/spool_top.gif");
				}
				else{
					out.println("/img/payment/cancle_top.gif");
				}
				
				%>"style="padding:0 0 0 64">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%" valign="top"><img src="/img/payment/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>취소결과</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:0 0 0 56">
		  <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="/img/payment/life.gif" width="7" height="30"></td>
                <td background="/img/payment/center.gif"><img src="/img/payment/icon03.gif" width="12" height="10"> 
                  <b>고객님께서 이니페이를 통해 취소하신 내용입니다. </b></td>
                <td width="8"><img src="/img/payment/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="407"  style="padding:0 0 0 9"><img src="/img/payment/icon.gif" width="10" height="11"> 
                  <strong><font color="433F37">취소내역</font></strong></td>
                <td width="103">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2"  style="padding:0 0 0 23">
		  <table width="470" border="0" cellspacing="0" cellpadding="0">
                    
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="26">결 과 코 드</td>
                      <td width="343"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td id="resultCode"><%=resultCode%></td>
                            <td width='142' align='right'>&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">결 과 내 용</td>
                      <td width="343"><%=resultMsg%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">거 래 번 호</td>
                      <td width="343"><%=tid%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='/img/payment/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>취 소 날 짜</td>
                      <td width='343'><%=pgCancelDate%></td>
                    </tr>
                	    
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='/img/payment/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='/img/payment/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>취 소 시 각</td>
                      <td width='343'><%=pgCancelTime%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='/img/payment/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='/img/payment/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>현금영수증<br>취소승인번호</td>
                      <td width='343'><%=rcash_cancel_noappl%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='/img/payment/line.gif'></td>
                    </tr>
                    
                    
                  </table></td>
              </tr>
            </table>
            <br>
           </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><img src="/img/payment/bottom01.gif" width="632" height="13"></td>
  </tr>
</table>
</center></body>
</html>
