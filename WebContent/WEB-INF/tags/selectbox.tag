<%@tag import="artn.common.tag.SelectboxMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="각종 셀렉트박스 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%--
	attribute: type
	 
	numeric: 지정된 min,max,step 으로 숫자값 selectbox 생성
	split: digit, index를 이용하여 value를 substring 으로 쪼개고 그 값을 사용함.
	shift: digit, index를 이용하여 value를 shift 연산으로 쪼개고 그 값을 사용함.
	※default: numeric
--%>
<%@ attribute name="type" %>
<%@ attribute name="id" %>
<%@ attribute name="name" %>
<%@ attribute name="value" %>
<%@ attribute name="min" type="java.lang.Integer" %>
<%@ attribute name="max" type="java.lang.Integer" %>
<%@ attribute name="step" type="java.lang.Integer" %>
<%@ attribute name="unit" %>
<%@ attribute name="zero" %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="digit" type="java.lang.Integer" %>
<%@ attribute name="index" type="java.lang.Integer" %>
<%@ attribute name="offset" type="java.lang.Integer" %>
<%

SelectboxMaker selectbox = new SelectboxMaker(id, cssClass, style, name, value);
selectbox.setMin(min).setMax(max).setStep(step).setUnit(unit).setZero(zero).setDigit(digit).setIndex((offset != null)? offset : index).setType(type);

if (type != null){
	if (type.equals("auth_type:manager") == true){
		selectbox.setCustomList(
			"0","없음(비회원)",
			"1","최고관리자", 
			"2","관리자", 
			"3","의료관계자+의사",
			"4","의료관계자+운동치료사",
			"5","의료관계자",
			"6","의사+운동치료사",
			"7","의사",
			"8","운동치료사",
			"9","환자고객",
			"10","일반고객"
		);
	}
}



out.print(selectbox.make().toString());
%>