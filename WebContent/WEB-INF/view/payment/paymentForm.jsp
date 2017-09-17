<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>    
<head>
<title>구매화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>

<link rel="stylesheet" href="/css/wellness/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
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

<!------------------------------------------------------------------------------- 
* 웹SITE 가 https를 이용하면 https://plugin.inicis.com/pay61_secunissl_cross.js를 사용 
* 웹SITE 가 Unicode(UTF-8)를 이용하면 http://plugin.inicis.com/pay61_secuni_cross.js를 사용 
* 웹SITE 가 https, unicode를 이용하면 https://plugin.inicis.com/pay61_secunissl_cross.js 사용 
--------------------------------------------------------------------------------> 
<script language=javascript src="http://plugin.inicis.com/pay61_uni_cross.js"></script>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>


<script language=javascript>
StartSmartUpdate();
</script>

<!---------------------------------------------------------------------------------- 
※ 주의 ※
 상단 자바스크립트는 지불페이지를 실제 적용하실때 지불페이지 맨위에 위치시켜 
 적용하여야 만일에 발생할수 있는 플러그인 오류를 미연에 방지할 수 있습니다.
 
  <script language=javascript src="http://plugin.inicis.com/pay61_uni_cross.js"></script>
  <script language=javascript>
  StartSmartUpdate();	// 플러그인 설치(확인)
  </script>
-----------------------------------------------------------------------------------> 


<script language=javascript>
$(document).ready(function(){
	
});
var openwin;

function pay(frm)
{
	var param = dialogArguments;
	document.ini.goodname.value = param["subject"];
	document.ini.price.value = param["amount"];
	document.ini.buyername.value = param["pay_user_name"];
	document.ini.buyeremail.value = param["pay_mail"];
	document.ini.buyertel.value = param["pay_phone"];
	document.ini.gopaymethod.value = param["paymethod"];
	// MakePayMessage()를 호출함으로써 플러그인이 화면에 나타나며, Hidden Field
	// 에 값들이 채워지게 됩니다. 일반적인 경우, 플러그인은 결제처리를 직접하는 것이
	// 아니라, 중요한 정보를 암호화 하여 Hidden Field의 값들을 채우고 종료하며,
	// 다음 페이지인 INIsecurepay.php로 데이터가 포스트 되어 결제 처리됨을 유의하시기 바랍니다.
	if(document.ini.clickcontrol.value == "enable")
	{
		if(document.ini.goodname.value == "")  // 필수항목 체크 (상품명, 상품가격, 구매자명, 구매자 이메일주소, 구매자 전화번호)
		{
			alert("상품명이 빠졌습니다. 필수항목입니다.");
			return false;
		}
		else if(document.ini.price.value == "")
		{
			alert("상품가격이 빠졌습니다. 필수항목입니다.");
			return false;
		}
		else if(document.ini.buyername.value == "")
		{
			alert("구매자명이 빠졌습니다. 필수항목입니다.");
			return false;
		} 
		else if(document.ini.buyeremail.value == "")
		{
			alert("구매자 이메일주소가 빠졌습니다. 필수항목입니다.");
			return false;
		}
		else if(document.ini.buyertel.value == "")
		{
			alert("구매자 전화번호가 빠졌습니다. 필수항목입니다.");
			return false;
		}
		else if(( navigator.userAgent.indexOf("MSIE") >= 0 || navigator.appName == 'Microsoft Internet Explorer' ) &&  (document.INIpay == null || document.INIpay.object == null))  // 플러그인 설치유무 체크
		{
			alert("\n이니페이 플러그인 128이 설치되지 않았습니다. \n\n안전한 결제를 위하여 이니페이 플러그인 128의 설치가 필요합니다. \n\n다시 설치하시려면 Ctrl + F5키를 누르시거나 메뉴의 [보기/새로고침]을 선택하여 주십시오.");
			return false;
		}
		else
		{ 
			if (MakePayMessage(frm))
			{
				disable_click();
				openwin = window.open("/payment/childwin.html","childwin","width=299,height=149");
				document.ini.action="/payment/paymentOk";
				document.ini.submit();
				return true;
			}
			else
			{
				if(IsPluginModule()) {
					alert("결제를 취소하셨습니다.");
					window.close();
				}
				return false;
			}
		}
	}
	else
	{
		return false;
	}
}

function success(transaction_num){
	window.returnValue = transaction_num;
	window.close();
}

function enable_click()
{
	document.ini.clickcontrol.value = "enable"
}

function disable_click()
{
	document.ini.clickcontrol.value = "disable"
}

function focus_control()
{
	if(document.ini.clickcontrol.value == "disable")
		openwin.focus();
}
</script>


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
//-->
</script>
</head>

<!-----------------------------------------------------------------------------------------------------
※ 주의 ※
 아래의 body TAG의 내용중에 
 onload="javascript:enable_click()" onFocus="javascript:focus_control()" 이 부분은 수정없이 그대로 사용.
 아래의 form TAG내용도 수정없이 그대로 사용.
------------------------------------------------------------------------------------------------------->

<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0 onload="javascript:enable_click();pay(document.getElementById('ini'));" onFocus="javascript:focus_control()"><center>
<form id="ini" name=ini method=post action="paymentOk" onSubmit="return pay(this)" style="display: none;"> 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="85" background="/img/payment/card.gif" style="padding:0 0 0 64">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%" valign="top"><img src="/img/payment/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>결제요청</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:8 0 0 56"> <table width="530" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><!-- 이 페이지는 결제을 요청하는 페이지로써 샘플(예시) 페이지입니다. <br>
                  결제페이지 개발자는 소스 내용 중에 "<font color=red>※ 주의 ※</font>" 표시가 포함된 문장은 특히 주의하여 귀사의 요구에 맞게 적절히 수정 적용하시길 바랍니다.
                  <br>
                  <br> -->은행의 인터넷뱅킹 Site에서 사용 중인 플러그인(보안프로그램)과 동일한 방식으로 이니시스 결제 페이지에서도 플러그인 프로그램을 이용하여 보안 및 인증 처리를 하고 있습니다.<br>
		      인터넷 뱅킹 Site에서 인터넷뱅킹 업무를 수행하기 전에 플러그인 설치확인 페이지를 수행하는 것과 마찬가지로 이니페이 플러그인 설치확인 페이지(plugin_check.html)를 수행한 후 결제요청 페이지(INIsecurepay.html)의 기능을 구현하셔야 합니다.
		  <br>
                  
                  <br>
                 "결제" 버튼을 누르면 결제 정보를 안전하게 암호화하기 위한 플러그인 창이 출력됩니다.<br>
                  플러그인에서 제시하는 단계에 따라 정보를 입력한 후 <b>[결제 정보 확인]</b> 단계에서 "확인" 버튼을 누르면 
                  결제처리가 시작됩니다.<br>
                  통신환경에 따라 다소 시간이 걸릴수도 있으니 결제결과가 표시될때까지 "중지" 버튼을 누르거나 브라우저를 종료하시지 말고
                  잠시만 기다려 주십시오.<br></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="/img/payment/life.gif" width="7" height="30"></td>
                <td background="/img/payment/center.gif"><img src="/img/payment/icon03.gif" width="12" height="10"> 
                  <b>정보를 기입하신 후 결제버튼을 눌러주십시오.</b></td>
                <td width="8"><img src="/img/payment/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="510" colspan="2"  style="padding:0 0 0 23"> <table width="470" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">상 점 명</td>
                      <!-- <td width="280">(주)Jglovis<input type="hidden" name=mid size=20 value="pobplay000"></td> -->
                      <td width="280">(주)Jglovis<input type="hidden" name=mid size=20 value="artn000000"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">결 제 방 법 </td>                      
                      <td width="343"><input type="text" name="gopaymethod" value="${param.paymethod }" readonly="readonly"/> <%-- <select name=gopaymethod value="${param.paymethod}"> --%>
                          <!-- <option value="">[ 결제방법을 선택하세요. ] --> 
                          <!-- <option value="Card">신용카드 결제 -->
                          <!-- <option value="VCard">인터넷안전 결제  -->
                          <!-- <option value="DirectBank">실시간 은행계좌이체  -->
                          <!-- <option value="HPP">핸드폰 결제
                          <option value="PhoneBill">받는전화결제 
                          <option value="Ars1588Bill">1588 전화 결제 --> 
                          <!-- <option value="VBank">무통장 입금  -->
                          <!-- <option value="OCBPoint">OK 캐쉬백포인트 결제
                          <option value="Culture">문화상품권 결제
                          <option value="kmerce">K-merce 상품권 결제
			  <option value="TeenCash">틴캐시 결제
			  <option value="DGCL">스마트문상 결제
			  <option value="sktgift">SKT 상품권 결제
                          <option value="onlycard" >신용카드 결제(전용메뉴) 
                          <option value="onlyisp">인터넷안전 결제 (전용메뉴) 
                          <option value="onlydbank">실시간 은행계좌이체 (전용메뉴) 
                          <option value="onlycid"> 신용카드/계좌이체/무통장입금(전용메뉴) 
                          <option value="onlyvbank">무통장입금(전용메뉴) 
                          <option value="onlyhpp">핸드폰 결제(전용메뉴) 
                          <option value="onlyphone">전화 결제(전용메뉴) 
                          <option value="onlyocb">OK 캐쉬백 결제 - 복합결제 불가능(전용메뉴) 
                          <option value="onlyocbplus">OK 캐쉬백 결제- 복합결제 가능(전용메뉴) 
                          <option value="onlyculture">문화상품권 결제(전용메뉴) 
                          <option value="onlykmerce">K-merce 상품권 결제(전용메뉴)
			  <option value="onlyteencash">틴캐시 결제(전용메뉴)
                          <option value="onlydgcl">스마트문상 결제(전용메뉴)
                          <option value="onlysktgift">SKT 상품권 결제(전용메뉴) -->
                          </select></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">상 품 명</td>
                      <td width="280"><input type=text name=goodname size=20 value="${param.subject }" readonly="readonly"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">가 격</td>
                      <td width="343"><input type=text name=price size=20 value="${param.amount}" readonly="readonly"><br><font color=red><!-- <b>* 주의* LG카드는 반드시 1004원으로 결제테스트 하시기 바랍니다.</b> --></font></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">성 명</td>
                      <td width="343"><input type=text name=buyername size=20 value="${param.to_name }" readonly="readonly"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">전 자 우 편</td>
                      <td width="343"><input type=text name=buyeremail size=20 value="${param.pay_mail }" readonly="readonly"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    
                  <!-----------------------------------------------------------------------------------------------------
			※ 주의 ※
			보호자 이메일 주소입력 받는 필드는 소액결제(핸드폰 , 전화결제)
			중에  14세 미만의 고객 결제시에 부모 이메일로 결제 내용통보하라는 정통부 권고 사항입니다. 
			다른 결제 수단을 이용시에는 해당 필드(parentemail)삭제 하셔도 문제없습니다.
		  ------------------------------------------------------------------------------------------------------->  
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">보호자 전자우편</td>
                      <td width="343"><input type=text name=parentemail size=20 value="" readonly="readonly"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="/img/payment/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">이 동 전 화</td>
                      <td width="343"><input type=text name=buyertel size=20 value="${param.pay_phone }" readonly="readonly"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="/img/payment/line.gif"></td>
                    </tr>
                    <tr valign="bottom"> 
                      <td height="40" colspan="3" align="center"><input type=image src="/img/payment/button_03.gif" width="63" height="25"></td>
                    </tr>
                    <tr valign="bottom">
                      <td height="45" colspan="3">전자우편과 이동전화번호를 입력받는 것은 고객님의 결제성공 내역을 E-MAIL 또는 SMS 로
                   알려드리기 위함이오니 반드시 기입하시기 바랍니다.</td>
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
</center>

<!-- 
상점아이디.
테스트를 마친 후, 발급받은 아이디로 바꾸어 주십시오.
<input type=hidden name=mid value=INIpayTest>
-->


<!--
화폐단위
WON 또는 CENT
주의 : 미화승인은 별도 계약이 필요합니다.
-->
<input type=hidden name=currency value="WON">


<!--
무이자 할부
무이자로 할부를 제공 : yes
무이자할부는 별도 계약이 필요합니다.
카드사별,할부개월수별 무이자할부 적용은 아래의 카드할부기간을 참조 하십시오.
무이자할부 옵션 적용은 반드시 매뉴얼을 참조하여 주십시오.
-->
<input type=hidden name=nointerest value="no">


<!--
카드할부기간
각 카드사별로 지원하는 개월수가 다르므로 유의하시기 바랍니다.

value의 마지막 부분에 카드사코드와 할부기간을 입력하면 해당 카드사의 해당
할부개월만 무이자할부로 처리됩니다 (매뉴얼 참조).
-->
<input type=hidden name=quotabase value="선택:일시불:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월">


<!-- 기타설정 -->
<!--
SKIN : 플러그인 스킨 칼라 변경 기능 - 6가지 칼라(ORIGINAL, GREEN, ORANGE, BLUE, KAKKI, GRAY)
HPP : 컨텐츠 또는 실물 결제 여부에 따라 HPP(1)과 HPP(2)중 선택 적용(HPP(1):컨텐츠, HPP(2):실물).
Card(0): 신용카드 지불시에 이니시스 대표 가맹점인 경우에 필수적으로 세팅 필요 ( 자체 가맹점인 경우에는 카드사의 계약에 따라 설정) - 자세한 내용은 메뉴얼  참조.
OCB : OK CASH BAG 가맹점으로 신용카드 결제시에 OK CASH BAG 적립을 적용하시기 원하시면 "OCB" 세팅 필요 그 외에 경우에는 삭제해야 정상적인 결제 이루어짐.
no_receipt : 은행계좌이체시 현금영수증 발행여부 체크박스 비활성화 (현금영수증 발급 계약이 되어 있어야 사용가능)
-->
<input type=hidden name=acceptmethod value="SKIN(ORIGINAL):HPP(1):OCB">


<!--
상점 주문번호 : 무통장입금 예약(가상계좌 이체),전화결재(1588 Bill) 관련 필수필드로 반드시 상점의 주문번호를 페이지에 추가해야 합니다.
결제수단 중에 은행 계좌이체 이용 시에는 주문 번호가 결제결과를 조회하는 기준 필드가 됩니다.
상점 주문번호는 최대 40 BYTE 길이입니다.
"MALLTEST"는 은행계좌이체와 전화결제 테스트용 주문번호로 테스트가 끝나신후 변경하시기 바랍니다.
-->
<input type=hidden name=oid size=40 value="JGLOVISMALL">


<!--
플러그인 좌측 상단 상점 로고 이미지 사용
이미지의 크기 : 90 X 34 pixels
플러그인 좌측 상단에 상점 로고 이미지를 사용하실 수 있으며,
주석을 풀고 이미지가 있는 URL을 입력하시면 플러그인 상단 부분에 상점 이미지를 삽입할수 있습니다.
-->
<!--input type=hidden name=ini_logoimage_url  value="http://[사용할 이미지주소]"-->

<!--
좌측 결제메뉴 위치에 이미지 추가
이미지의 크기 : 단일 결제 수단 - 91 X 148 pixels, 신용카드/ISP/계좌이체/가상계좌 - 91 X 96 pixels 
좌측 결제메뉴 위치에 미미지를 추가하시 위해서는 담당 영업대표에게 사용여부 계약을 하신 후
주석을 풀고 이미지가 있는 URL을 입력하시면 플러그인 좌측 결제메뉴 부분에 이미지를 삽입할수 있습니다.
-->
<!--input type=hidden name=ini_menuarea_url value="http://[사용할 이미지주소]"-->

<!--
플러그인에 의해서 값이 채워지거나, 플러그인이 참조하는 필드들
삭제/수정 불가
uid 필드에 절대로 임의의 값을 넣지 않도록 하시기 바랍니다.
-->
<input type=hidden name=quotainterest value="">
<input type=hidden name=paymethod value="">
<input type=hidden name=cardcode value="">
<input type=hidden name=cardquota value="">
<input type=hidden name=rbankcode value="">
<input type=hidden name=reqsign value="DONE">
<input type=hidden name=encrypted value="">
<input type=hidden name=sessionkey value="">
<input type=hidden name=uid value=""> 
<input type=hidden name=sid value="">
<input type=hidden name=version value=4000>
<input type=hidden name=clickcontrol value="">

</form>
</body>
</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                              
