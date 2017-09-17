<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu" contents="${param.contents }">
<%-- <s:if test='%{#session.user != null}'> --%>
	<div class="layout-contents">
	<div class="nav left-menu">
	     <h3>365plus</h3>
	     <ul>
	        <li><a href="/user/menu">메인메뉴</a></li>
	    </ul>
	    </div>
	        <div class="section contents-base">
	            <div class="article">
	                <div class="nav">
	                    <h2>365 PLUS</h2>          
	                    <ul>
	                        <s:if test="auth.menu(1)"><li><span class="artn-button control"><a href="/365plus/selector1.jsp?menu=1" id="button_CureAndExcercise">통증치료 및 예방운동</a></span></li></s:if>
	                        <s:if test="auth.menu(2)"><li><span class="artn-button control"><a href="/prescript/list.action?menu=1" id="button_MyScription">나의 처방 운동</a></span></li></s:if>
	                        <s:if test="auth.menu(3)"><li><span class="artn-button control"><a href="/365plus/theme_search.jsp" id="button_Routine">테마별 운동(Routine)</a></span></li></s:if>
	                        <s:if test="auth.menu(4)"><li><span class="artn-button control"><a href="/365plus/work_out.jsp" id="button_Workout">Workout(개인별 운동구성)</a></span></li></s:if>
	                        <s:if test="auth.menu(5)"><li><span class="artn-button control"><a href="/groupuser/list?id_user=${user.id }">소속 병원 목록</a></span></li></s:if>
	                        
	                        <s:if test="auth.menu(6)"><li><span class="artn-button admin"><a href="/prescript/list.action?menu=prescript" id="button_Workout">처방전 관리</a></span></li></s:if>
	                        <s:if test="auth.menu(7)"><li><span class="artn-button admin"><a href="/movie/list.action">영상 등록 및 관리</a></span></li></s:if>
	                        <s:if test="auth.menu(8)"><li><span class="artn-button admin"><a href="/comb/list.action?menu=comb">조합 등록 및 관리</a></span></li></s:if>
	                        <s:if test="auth.menu(9)"><li><span class="artn-button admin"><a href="/365plus/list.action?menu=365pluscomb">365Plus 조합 관리</a></span><li></li></s:if>
	                        <s:if test="auth.menu(10)"><li><span class="artn-button admin"><a href="/groupuser/list?id_user=${user.id}&contents=sub1_6_1">소속 의료기관 정보</a></span></li></s:if>
	                        
	                        <s:if test="auth.menu(11)"><li><span class="artn-button admin"><a href="/group/list">의료기관 정보</a></span></li></s:if>
	                        <s:if test="auth.menu(12)"><li><span class="artn-button admin"><a href="/user/list">회원 관리</a></span></li></s:if>
	                        <s:if test="auth.menu(13)"><li><span class="artn-button admin"><a href="/admin/auth_list">권한 목록</a></span></li></s:if>
	                        <s:if test="auth.menu(14)"><li><span class="artn-button admin"><a href="/groupuser/list">병원 전체 회원 </a></span></li></s:if>
	                        <s:if test="auth.menu(15)"><li><span class="artn-button admin"><a href="/group/list">전체 그룹 관리 목록</a></span></li></s:if>
	                    </ul>
	                    <ul class="menu_setting">
	                        <!-- <li><a href="#" id="button_Setting">setting(옵션설정)</a></li> -->
	                        <li><span class="artn-icon-16 caret-e"></span><a href="/contents?contents=sub2_1_1&menu=2" id="button_SwInfo">365 plus란?</a></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	</div>
<%-- </s:if> --%>
</a:html>