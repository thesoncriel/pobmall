<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
/* $(document).ready(function(){	
	$("input[name='tid']").val($(window.opener.document).find(".transaction_num").val());	
}); */



//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0><center>
<form name="ini" method="post" action="cancelOk"> 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="83" background="/img/payment/cancle_top.gif" style="padding:0 0 0 64">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%" valign="top"><img src="/img/payment/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>취소요청</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center" bgcolor="6095BC">
      <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:8 0 0 56"> <table width="530" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                  지불시에 얻게 되는 거래번호 (TID)를 입력하여 지불을 취소합니다. <br>                  
                  지불 취소 및 각종 조회는 <a href="https://iniweb.inicis.com" target="_blank"><font color="#336699"><strong>https://iniweb.inicis.com</strong></font></a>에서도 
                  이용하실수 있습니다. </td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7"><img src="/img/payment/life.gif" width="7" height="30"></td>
                <td background="/img/payment/center.gif"><img src="/img/payment/icon03.gif" width="12" height="10"> 
                  <b>정보를 기입하신 후 확인버튼을 눌러주십시오.</b></td>
                <td width="8"><img src="/img/payment/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="510" colspan="2"  style="padding:0 0 0 23"> <table width="470" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="83" height="25">거 래 번 호</td>
                      <td width="369"> <input type=text name=tid size=40 value="${params.transaction_num }"></td>
                    </tr>
                    <tr>
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr>
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="83" height="26">취 소 사 유</td>
                      <td width="369"><input type=text name=msg size=40 value=""></td>
                    </tr>
                    <tr>
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr valign="bottom"> 
                      <td height="40" colspan="3" align="center"><input type=image src="/img/payment/button_04.gif" width="63" height="25"></td>
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
<!-- 
상점아이디.
테스트를 마친 후, 발급받은 아이디로 바꾸어 주십시오.
-->
<input type="hidden" name="id_user" value="${params.id_user}"/>
<input type="hidden" name="id_payment" value="${params.id_payment}"/>
<input type="hidden" name="id_purchase" value="${params.id_purchase}"/>
<input type=hidden name=mid value=pobplay000>
</form>
</body>
</html>
