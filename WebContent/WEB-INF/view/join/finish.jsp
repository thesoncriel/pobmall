<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Join" contents="sub901">


    <div class="header">
	  <h1>가입 완료</h1>
   	  <div id="breadcrumbs" data-sub="*회원가입,가입완료"></div>
	</div>
	<div class="section">
		<div class="article member-join finish">
			<div class="hgroup artn-bg-64 step3">
			    <h2>1. 약관동의</h2>  
			    <h2>2. 회원정보 입력</h2>
			    <h2 class="selected">3. 가입완료</h2>
			</div>
			<div style="padding: 3em 3em 0 3em;">
				<h3><em>${user.name }</em>님! 환영합니다!</h3>
				<br/>
				<p>회원가입이 정상적으로 완료되었습니다.</p>
				<p>JGLOVIS를 이용해 주셔서 감사합니다.</p>
				<!-- <br/>
				<p style="text-align: right">병원 등록을 바로 진행 하시겠습니까?</p> -->
			</div>
			<hr/>
			<div style="text-align: right;">
				<%-- <a href="/group/list" class="artn-button board">등록 하기</a> --%><a href="/main" class="artn-button board">확인</a>
			</div>
		</div>
	</div>
</a:html>