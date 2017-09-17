<%@tag import="artn.database.DBManager"%>
<%@tag import="artn.common.model.Environment"%>
<%@tag import="org.apache.poi.xssf.util.EvilUnclosedBRFixingInputStream"%>
<%@tag import="artn.common.model.Visitor"%>
<%@tag import="artn.common.manager.LoginManager"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="공통으로 쓰이는 html 바탕 구조" trimDirectiveWhitespaces="true" %>
<%@ attribute name="title" %>
<%@ attribute name="contents" %>
<%@ attribute name="innerClear" type="java.lang.Boolean" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%!
	public int getMenuNumber(String subValue){
	    try{
	    	String sValue = subValue.split("_")[0];
	        return Integer.parseInt( sValue.substring(3, sValue.length()) );
	    }
	    catch(Exception ex){
	        return 0;
	    }
	}
%>
<%
int iMenu = 0;

if ((contents != null) && (contents.equals("") == true)){
	//response.sendRedirect("/main");
	request.setAttribute("menu", 0);
}
else{
	iMenu = getMenuNumber(contents);
	request.setAttribute("menu", iMenu);
}

if (iMenu > 900){
	request.setAttribute("adminClass", " admin");
}
else{
	request.setAttribute("adminClass", "");
}
if (request.getParameter("board_no") != null){
	request.setAttribute("boardClass", " board-temp");
}
else{
	request.setAttribute("boardClass", "");
}

// 사용자 접속정보 객체 등록부 [시작]
if(session.getAttribute("loginManager") == null){	
	request.getSession().setAttribute("loginManager", LoginManager.getInstance());
}
if(session.getAttribute("environment") == null){
	Visitor visitor = new Visitor( request.getHeader("referer"), request.getRemoteAddr() );
	Environment environment = new Environment(request.getHeader("User-Agent"));
	DBManager dbm = null;
	
	visitor.readEnvironment(environment);
	
	if(session.getAttribute("id_user") == null){
		visitor.setIdUser("guest");
	}
	
	if(session.getAttribute("dbm") == null){
		dbm = new DBManager();
	}
	else{
		dbm = (DBManager)session.getAttribute("dbm");
	}
	
	session.setAttribute("visitor", visitor);
	session.setAttribute("environment", environment);
	session.setAttribute("dbm", dbm);
	visitor.doInsert( dbm );
}
//사용자 접속정보 객체 등록부 [종료]

response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, pre-check=0, post-check=0, max-age=0");
response.setHeader("Pragma", "no-cache, no-store");   
response.setDateHeader("Expires", 0);

if (request.getProtocol().equals("HTTP/1.1")){
	//response.setHeader("Cache-Control", "no-cache");
}

%>
<%--<s:bean name="artn.common.model.User" var="user"><s:property value="#session.user"/></s:bean> --%>
<s:set name="artn.common.model.User" var="user" value="#session.user"></s:set>
<!DOCTYPE html>
<html>
    <head> 
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta http-equiv="Expires" content="-1"> 
		<meta http-equiv="Pragma" content="no-cache"> 
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <!--[if IE]>
        	
        <![endif]-->
        <%--
         --%>
        <!--  -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!--아이폰 용 줌 가능<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0,maximum-scale=10.0"> -->
        <jsp:include page="/WEB-INF/include/title_css_script.htmlpart"/>
<%--         <script>
        	$(document).ready(function(){
        		if(Artn.Environment.isMobile() === true){
        			$(".container.fixed-header").css("position", "absolute");
        		}
        	});
        </script> --%>
	</head>
    <body>
<%if((innerClear == null) || (innerClear == false)){ %>
    	<span class="menu_selector" data-sub="${param.contents }" style="display: none;"></span>
        <input type="hidden" name="contents" value="${param.contents}"/>
        <input type="hidden" name="join" value="${param.join}"/>
        <div class="container fixed-header">
        	<div class="contents-wrap">
	        	<div class="header">
	                <div class="nav top-menu">                		
                        <div class="account">
	                        <div class="top-decoration m-hdn-hdn">
	                        	<%-- <span>SMART COMPANY <mark>JGLOVIS . TO ENJOY POB</mark></span>	                        	
	                        	<span><span class="artn-icon-32 bookmark" style="margin-top: -3px"></span>HAPPY Mall</span> --%>
	                        	<span class="artn-icon-16 home">⊙</span><a href="http://pobplay.com">제품소개 사이트로</a>
	                        	<span class="artn-icon-16 bullet1" style="margin-left:10px;">⊙</span><a href="/contents?contents=sub10_1"> 제품 상세페이지</a>
	                        </div>
	                        <h1><a href="/index.jsp">POB</a></h1>	                        
	                        <div class="top-mini-menu account-menu m-hdn-hdn">
	                      	  	<%--<a href="http://www.pobmall.com" class="store" target="_blank">STORE</a> --%>
								<s:if test ="#user.isAdmin == true">
									<a href="/user/list?contents=adm1000_1" data-artn-icon="gear" style="color: #F54785;">관리자</a>
								</s:if>
								 <s:if test='%{#user != null}'>
		                            <%-- <s:property value="#user.name"/>님 환영합니다. --%>                           
		                            <a href="/logout" data-artn-icon="logout">로그아웃</a>
		                        </s:if>
		                        <s:else>                            
		                            <a href="/login" data-artn-icon="login">로그인</a>
		                            <a href="/join" data-artn-icon="write">회원가입</a>
		                        </s:else>
								    <div class="mypage" style="display: inline-block;">
	                                	<a class="m-hdn" href="#" onclick="return false;">마이 POB&nbsp;<span class="artn-icon-16 circle-caret-2-s"></span>&nbsp;</a>
	                                	<ul class="mypageul">
		                                    <li><a href="/user/show.action?id=${user.id }&contents=sub4" data-artn-icon="my">나의 정보</a></li>
	                                    	<li><a class="m-hdn" href="/product/board/myposts?contents=sub5">내가 쓴글</a></li>
	                                    	<li><a href="/payment/list?contents=sub6" data-artn-icon="delivery">주문 내역</a></li>
	                                	</ul>
	                                </div>
								<a href="/product/cart/list?contents=sub7" data-artn-icon="cart-2">장바구니</a>
								<a href="/email/send?contents=sub8" data-artn-icon="mail">Contact us</a>
							</div>
							<%-- <a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a>
							<a href="/email/send" data-artn-icon="cart">Contact us</a> --%>
                        </div>
	                    <div class="top-gnb">
	                    	<div class="category">
	                    		<a href="#">PRODUCT CATEGORY<span class="artn-icon-16 circle-caret-1-s">↓</span></a>
	                    		<ul>
	                    			<li><a href="/product/grid?category=1&pob=true"><span class="artn-icon-16 arrow-square-e"></span>MOBILE SUIT POB</a></li>
	                    			<%-- <li><a href="/product/grid?category=2"><span class="artn-icon-16 arrow-square-e"></span>제품1</a></li>
	                    			<li><a href="/product/grid?category=4"><span class="artn-icon-16 arrow-square-e"></span>제품2</a></li> --%>
	                    			<li class="last"><a href="/product/grid?category=2"><span class="artn-icon-16 arrow-square-e"></span>악세사리</a></li>	                    			
	                    		</ul>
	                    	</div>
	                    	<div class="search_div">
							    <form action="/product/grid?pob=true" method="post" class="product-search">
							        <input type="text" name="search_text"/>
							        <button class="artn-button board search_btn"><span class="artn-icon-16 search"></span>검색</button>							        
							    </form>
							</div>
	                    	<jsp:include page="/WEB-INF/include/menu/gnb.htmlpart"/>
	                    	<a href="#" class="m-action-icon bars m-show m-gnb-toggle"><span class="artn-icon-32 bars">모바일 메뉴</span></a>
	               		</div>
	                </div>
	        	</div>
        	</div>
        </div>
        <div class="container body-container">
            <%-- <div class="header">
                <div class="nav top-menu">                		
                        <div class="account">
                      	  <a href="http://www.pobmall.com" class="store" target="_blank">STORE</a>
							<s:if test ="#user.isAdmin == true">
								<a href="/user/list?contents=adm1000_1">admin</a>
							</s:if>
	                        <s:if test='%{#user != null}'>
	                            <s:property value="#user.name"/>님 환영합니다.                           
	                            <a href="/logout">Log out</a>
	                        </s:if>
	                        <s:else>                            
	                            <a href="/login">Log in</a>
	                        </s:else>
                        </div>
                    <div class="top-gnb">
                    	
                    	<jsp:include page="/WEB-INF/include/menu/gnb.htmlpart"/>
               		</div>    
                </div>
                
              	
            </div> --%>
<div id="body">
<div class="contents-wrap${adminClass }${boardClass }">
<s:set var="menu">${menu }</s:set>
<s:if test="#menu > 999"> 
	<div class="nav left-menu jgadmin">
		<jsp:include page="/WEB-INF/include/menu/${menu }.htmlpart"/>
	</div>
	<div class="section contents${adminClass }">
		<jsp:doBody/>
	</div>
</s:if>
<s:else>
	<div class="contents">
		<jsp:doBody/>
	</div>
</s:else>
</div>
</div>
<div id="footer">
<div class="contents-wrap">
<jsp:include page="/WEB-INF/include/footer.htmlpart"/>
</div>
</div>
<div id="aside">
<%--
<s:include value="/WEB-INF/include/browserClick.htmlpart"/>
<jsp:include page="/WEB-INF/include/browser.htmlpart" flush="true" /> --%>
    <jsp:include page="/WEB-INF/include/menu/side_banner.jsp"/>
</div>
</div>
<%} else { %><jsp:doBody/><%} %>
</body>
</html>