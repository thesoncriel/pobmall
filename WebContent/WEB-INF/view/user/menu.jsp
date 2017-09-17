<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<% response.sendRedirect("/main"); %>
<a:html title=" - Main Menu" contents="${contentsCode }">
    <div class="header">
        <h1>365 PLUS</h1>
        <div id="breadcrumbs" data-sub="*메인메뉴"></div>
    </div>
    <div class="section">
        <div class="article">
            <div class="nav">
                <div>     
                 <dl>
                     <dt>365+</dt>
                     <s:if test="auth.menu(1)"><dd><a href="/365plus/selector1.jsp?menu=1&contents=${contentsCode }_1" id="button_CureAndExcercise" class="button_CureAndExcercise"><span></span>통증치료 <br/>및 예방운동</a></dd></s:if>
                    </dl>
                    <dl>
                     <dt>스트레칭 365</dt>                          
                     <s:if test="auth.menu(3)"><dd><a href="/365plus/theme_search.jsp?contents=${contentsCode }_2" id="button_Routine" class="button_Routine"><span></span>테마별 운동(Routine)</a></dd></s:if>
                    </dl>
                    <dl>
                     <dt>나의 맞춤 운동</dt>
                     <s:if test="auth.menu(4)"><dd><a href="/365plus/work_out.jsp?contents=${contentsCode }_3" id="button_Workout" class="button_Workout"><span></span>개인별 운동구성<br/>(Workout)</a></dd></s:if>
                    </dl>
                </div>
                <div>
                    <dl>
                        <dt>MediFit</dt>
                     <s:if test="auth.menu(2) && #session.user.hasAnyGroup"><dd>
                        <s:if test="auth.isSiteStaff">
                        <a href="/prescript/list.action?menu=1&contents=sub100_4" id="button_MyScription" class="button_MyScription"></s:if>
                        <s:else>
                        <a href="/prescript/list.action?menu=1&contents=sub102_4" id="button_MyScription" class="button_MyScription"></s:else>
                        <span></span>처방받은 <br/>운동 리스트</a>
                     </dd></s:if>
                     <s:if test="auth.menu(6)"><dd><a href="/prescript/list.action?menu=prescript&contents=sub100_5" id="button_Workout" class="button_Workout"><span></span>처방전 관리</a></dd></s:if>
                     <s:if test="auth.menu(7)"><dd><a href="/movie/list.action?contents=sub100_6" class="button_movie"><span></span>영상 등록 <br/>및 관리</a></dd></s:if>
                     <s:if test="auth.menu(8)"><dd><a href="/comb/list.action?contents=sub100_7" class="button_mix"><span></span>조합 등록 <br/>및 관리</a></dd></s:if>
                     <s:if test="auth.menu(9)"><dd><a href="/365plus/list.action?contents=sub100_8" class="button_365plus"><span></span>365PLUS <br/>조합 관리</a></dd></s:if>
                 </dl>
                </div>
            </div>
        </div>
    </div>
</a:html>