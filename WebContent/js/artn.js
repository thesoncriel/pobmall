//ajaxfileupload 2.1
// 일반 스트링을 못읽어와서 일부 수정함 -_-;
// dataType: false   를 추가하면 됨...
jQuery.extend({createUploadIframe:function(t,e){var i="jUploadFrame"+t,n='<iframe id="'+i+'" name="'+i+'" style="position:absolute; top:-9999px; left:-9999px"';return window.ActiveXObject&&("boolean"==typeof e?n+=' src="javascript:false"':"string"==typeof e&&(n+=' src="'+e+'"')),n+=" />",jQuery(n).appendTo(document.body),jQuery("#"+i).get(0)},createUploadForm:function(t,e,i){var n="jUploadForm"+t,r="jUploadFile"+t,s=jQuery('<form  action="" method="POST" name="'+n+'" id="'+n+'" enctype="multipart/form-data"></form>');if(i)for(var o in i)jQuery('<input type="hidden" name="'+o+'" value="'+i[o]+'" />').appendTo(s);var a=jQuery("#"+e),l=jQuery(a).clone();return jQuery(a).attr("id",r),jQuery(a).before(l),jQuery(a).appendTo(s),jQuery(s).css("position","absolute"),jQuery(s).css("top","-1200px"),jQuery(s).css("left","-1200px"),jQuery(s).appendTo("body"),s},ajaxFileUpload:function(t){t=jQuery.extend({},jQuery.ajaxSettings,t);var e=(new Date).getTime(),i=jQuery.createUploadForm(e,t.fileElementId,"undefined"==typeof t.data?!1:t.data);jQuery.createUploadIframe(e,t.secureuri);var n="jUploadFrame"+e,r="jUploadForm"+e;t.global&&!jQuery.active++&&jQuery.event.trigger("ajaxStart");var s=!1,o={};t.global&&jQuery.event.trigger("ajaxSend",[o,t]);var a=function(e){var r=document.getElementById(n);try{r.contentWindow?(o.responseText=r.contentWindow.document.body?r.contentWindow.document.body.innerHTML:null,o.responseXML=r.contentWindow.document.XMLDocument?r.contentWindow.document.XMLDocument:r.contentWindow.document):r.contentDocument&&(o.responseText=r.contentDocument.document.body?r.contentDocument.document.body.innerHTML:null,o.responseXML=r.contentDocument.document.XMLDocument?r.contentDocument.document.XMLDocument:r.contentDocument.document)}catch(a){jQuery.handleError(t,o,null,a)}if(o||"timeout"==e){s=!0;var l;try{if(l="timeout"!=e?"success":"error","error"!=l){var c=jQuery.uploadHttpData(o,t.dataType);t.success&&t.success(c,l),t.global&&jQuery.event.trigger("ajaxSuccess",[o,t])}else jQuery.handleError(t,o,l)}catch(a){l="error",jQuery.handleError(t,o,l,a)}t.global&&jQuery.event.trigger("ajaxComplete",[o,t]),t.global&&!--jQuery.active&&jQuery.event.trigger("ajaxStop"),t.complete&&t.complete(o,l),jQuery(r).unbind(),setTimeout(function(){try{jQuery(r).remove(),jQuery(i).remove()}catch(e){jQuery.handleError(t,o,null,e)}},100),o=null}};t.timeout>0&&setTimeout(function(){s||a("timeout")},t.timeout);try{var i=jQuery("#"+r);jQuery(i).attr("action",t.url),jQuery(i).attr("method","POST"),jQuery(i).attr("target",n),i.encoding?jQuery(i).attr("encoding","multipart/form-data"):jQuery(i).attr("enctype","multipart/form-data"),jQuery(i).submit()}catch(l){jQuery.handleError(t,o,null,l)}return jQuery("#"+n).load(a),{abort:function(){}}},uploadHttpData:function(r,type){var data;return type!==!1?(data=!type,data="xml"==type||data?r.responseXML:r.responseText,"script"==type&&jQuery.globalEval(data),"json"==type&&eval("data = "+data),"html"==type&&jQuery("<div>").html(data).evalScripts()):data=r.responseText,data}});
//TrimPath Template. Release 1.0.38.
var TrimPath;(function(){if(TrimPath==null)TrimPath=new Object;if(TrimPath.evalEx==null)TrimPath.evalEx=function(src){return eval(src)};var UNDEFINED;if(Array.prototype.pop==null)Array.prototype.pop=function(){if(this.length===0){return UNDEFINED}return this[--this.length]};if(Array.prototype.push==null)Array.prototype.push=function(){for(var e=0;e<arguments.length;++e){this[this.length]=arguments[e]}return this.length};TrimPath.parseTemplate=function(e,t,n){if(n==null)n=TrimPath.parseTemplate_etc;var r=parse(e,t,n);var i=TrimPath.evalEx(r,t,1);if(i!=null)return new n.Template(t,e,r,i,n);return null};try{String.prototype.process=function(e,t){var n=TrimPath.parseTemplate(this,null);if(n!=null)return n.process(e,t);return this}}catch(e){}TrimPath.parseTemplate_etc={};TrimPath.parseTemplate_etc.statementTag="forelse|for|if|elseif|else|var|macro";TrimPath.parseTemplate_etc.statementDef={"if":{delta:1,prefix:"if (",suffix:") {",paramMin:1},"else":{delta:0,prefix:"} else {"},elseif:{delta:0,prefix:"} else if (",suffix:") {",paramDefault:"true"},"/if":{delta:-1,prefix:"}"},"for":{delta:1,paramMin:3,prefixFunc:function(e,t,n,r){if(e[2]!="in")throw new r.ParseError(n,t.line,"bad for loop statement: "+e.join(" "));var i=e[1];var s="__LIST__"+i;return["var ",s," = ",e[3],";","var __LENGTH_STACK__;","if (typeof(__LENGTH_STACK__) == 'undefined' || !__LENGTH_STACK__.length) __LENGTH_STACK__ = new Array();","__LENGTH_STACK__[__LENGTH_STACK__.length] = 0;","if ((",s,") != null) { ","var ",i,"_ct = 0;","for (var ",i,"_index in ",s,") { ",i,"_ct++;","if (typeof(",s,"[",i,"_index]) == 'function') {continue;}","__LENGTH_STACK__[__LENGTH_STACK__.length - 1]++;","var ",i," = ",s,"[",i,"_index];"].join("")}},forelse:{delta:0,prefix:"} } if (__LENGTH_STACK__[__LENGTH_STACK__.length - 1] == 0) { if (",suffix:") {",paramDefault:"true"},"/for":{delta:-1,prefix:"} }; delete __LENGTH_STACK__[__LENGTH_STACK__.length - 1];"},"var":{delta:0,prefix:"var ",suffix:";"},macro:{delta:1,prefixFunc:function(e,t,n,r){var i=e[1].split("(")[0];return["var ",i," = function",e.slice(1).join(" ").substring(i.length),"{ var _OUT_arr = []; var _OUT = { write: function(m) { if (m) _OUT_arr.push(m); } }; "].join("")}},"/macro":{delta:-1,prefix:" return _OUT_arr.join(''); };"}};TrimPath.parseTemplate_etc.modifierDef={eat:function(e){return""},escape:function(e){return String(e).replace(/&/g,"&").replace(/</g,"<").replace(/>/g,">")},capitalize:function(e){return String(e).toUpperCase()},"default":function(e,t){return e!=null?e:t}};TrimPath.parseTemplate_etc.modifierDef.h=TrimPath.parseTemplate_etc.modifierDef.escape;TrimPath.parseTemplate_etc.Template=function(e,t,n,r,i){this.process=function(e,t){if(e==null)e={};if(e._MODIFIERS==null)e._MODIFIERS={};if(e.defined==null)e.defined=function(t){return e[t]!=undefined};for(var n in i.modifierDef){if(e._MODIFIERS[n]==null)e._MODIFIERS[n]=i.modifierDef[n]}if(t==null)t={};var s=[];var o={write:function(e){s.push(e)}};try{r(o,e,t)}catch(u){if(t.throwExceptions==true)throw u;var a=new String(s.join("")+"[ERROR: "+u.toString()+(u.message?"; "+u.message:"")+"]");a["exception"]=u;return a}return s.join("")};this.name=e;this.source=t;this.sourceFunc=n;this.toString=function(){return"TrimPath.Template ["+e+"]"}};TrimPath.parseTemplate_etc.ParseError=function(e,t,n){this.name=e;this.line=t;this.message=n};TrimPath.parseTemplate_etc.ParseError.prototype.toString=function(){return"TrimPath template ParseError in "+this.name+": line "+this.line+", "+this.message};var parse=function(e,t,n){e=cleanWhiteSpace(e);var r=["var TrimPath_Template_TEMP = function(_OUT, _CONTEXT, _FLAGS) { with (_CONTEXT) {"];var i={stack:[],line:1};var s=-1;while(s+1<e.length){var o=s;o=e.indexOf("{",o+1);while(o>=0){var u=e.indexOf("}",o+1);var a=e.substring(o,u);var f=a.match(/^\{(cdata|minify|eval)/);if(f){var l=f[1];var c=o+l.length+1;var h=e.indexOf("}",c);if(h>=0){var p;if(h-c<=0){p="{/"+l+"}"}else{p=e.substring(c+1,h)}var d=e.indexOf(p,h+1);if(d>=0){emitSectionText(e.substring(s+1,o),r);var v=e.substring(h+1,d);if(l=="cdata"){emitText(v,r)}else if(l=="minify"){emitText(scrubWhiteSpace(v),r)}else if(l=="eval"){if(v!=null&&v.length>0)r.push("_OUT.write( (function() { "+v+" })() );")}o=s=d+p.length-1}}}else if(e.charAt(o-1)!="$"&&e.charAt(o-1)!="\\"){var m=e.charAt(o+1)=="/"?2:1;if(e.substring(o+m,o+10+m).search(TrimPath.parseTemplate_etc.statementTag)==0)break}o=e.indexOf("{",o+1)}if(o<0)break;var u=e.indexOf("}",o+1);if(u<0)break;emitSectionText(e.substring(s+1,o),r);emitStatement(e.substring(o,u+1),i,r,t,n);s=u}emitSectionText(e.substring(s+1),r);if(i.stack.length!=0)throw new n.ParseError(t,i.line,"unclosed, unmatched statement(s): "+i.stack.join(","));r.push("}}; TrimPath_Template_TEMP");return r.join("")};var emitStatement=function(e,t,n,r,i){var s=e.slice(1,-1).split(" ");var o=i.statementDef[s[0]];if(o==null){emitSectionText(e,n);return}if(o.delta<0){if(t.stack.length<=0)throw new i.ParseError(r,t.line,"close tag does not match any previous statement: "+e);t.stack.pop()}if(o.delta>0)t.stack.push(e);if(o.paramMin!=null&&o.paramMin>=s.length)throw new i.ParseError(r,t.line,"statement needs more parameters: "+e);if(o.prefixFunc!=null)n.push(o.prefixFunc(s,t,r,i));else n.push(o.prefix);if(o.suffix!=null){if(s.length<=1){if(o.paramDefault!=null)n.push(o.paramDefault)}else{for(var u=1;u<s.length;u++){if(u>1)n.push(" ");n.push(s[u])}}n.push(o.suffix)}};var emitSectionText=function(e,t){if(e.length<=0)return;var n=0;var r=e.length-1;while(n<e.length&&e.charAt(n)=="\n")n++;while(r>=0&&(e.charAt(r)==" "||e.charAt(r)=="	"))r--;if(r<n)r=n;if(n>0){t.push('if (_FLAGS.keepWhitespace == true) _OUT.write("');var i=e.substring(0,n).replace("\n","\\n");if(i.charAt(i.length-1)=="\n")i=i.substring(0,i.length-1);t.push(i);t.push('");')}var s=e.substring(n,r+1).split("\n");for(var o=0;o<s.length;o++){emitSectionTextLine(s[o],t);if(o<s.length-1)t.push('_OUT.write("\\n");\n')}if(r+1<e.length){t.push('if (_FLAGS.keepWhitespace == true) _OUT.write("');var i=e.substring(r+1).replace("\n","\\n");if(i.charAt(i.length-1)=="\n")i=i.substring(0,i.length-1);t.push(i);t.push('");')}};var emitSectionTextLine=function(e,t){var n="}";var r=-1;while(r+n.length<e.length){var i="${",s="}";var o=e.indexOf(i,r+n.length);if(o<0)break;if(e.charAt(o+2)=="%"){i="${%";s="%}"}var u=e.indexOf(s,o+i.length);if(u<0)break;emitText(e.substring(r+n.length,o),t);var a=e.substring(o+i.length,u).replace(/\|\|/g,"#@@#").split("|");for(var f in a){if(a[f].replace)a[f]=a[f].replace(/#@@#/g,"||")}t.push("_OUT.write(");emitExpression(a,a.length-1,t);t.push(");");r=u;n=s}emitText(e.substring(r+n.length),t)};var emitText=function(e,t){if(e==null||e.length<=0)return;e=e.replace(/\\/g,"\\\\");e=e.replace(/\n/g,"\\n");e=e.replace(/"/g,'\\"');t.push('_OUT.write("');t.push(e);t.push('");')};var emitExpression=function(e,t,n){var r=e[t];if(t<=0){n.push(r);return}var i=r.split(":");n.push('_MODIFIERS["');n.push(i[0]);n.push('"](');emitExpression(e,t-1,n);if(i.length>1){n.push(",");n.push(i[1])}n.push(")")};var cleanWhiteSpace=function(e){e=e.replace(/\t/g,"    ");e=e.replace(/\r\n/g,"\n");e=e.replace(/\r/g,"\n");e=e.replace(/^(\s*\S*(\s+\S+)*)\s*$/,"$1");return e};var scrubWhiteSpace=function(e){e=e.replace(/^\s+/g,"");e=e.replace(/\s+$/g,"");e=e.replace(/\s+/g," ");e=e.replace(/^(\s*\S*(\s+\S+)*)\s*$/,"$1");return e};TrimPath.parseDOMTemplate=function(e,t,n){if(t==null)t=document;var r=t.getElementById(e);var i=r.value;if(i==null)i=r.innerHTML;i=i.replace(/</g,"<").replace(/>/g,">");return TrimPath.parseTemplate(i,e,n)};TrimPath.processDOMTemplate=function(e,t,n,r,i){return TrimPath.parseDOMTemplate(e,r,i).process(t,n)}})()
/**
 * 공용 라이브러리 네임 스페이스.<br/>
 * 특수한 목적이 아닌 이상 공용 라이브러리는 Artn 네임스페이스를 이용하는 것을 원칙으로 한다.
 * @example
 * //Util 객체의 replaceAll을 사용 시의 예제 
 * var sResult = Artn.Util.replaceAll( "하나둘셋넷다섯", "하나", "더손" );
 * @namespace
 */
var Artn = {};

/**
 * 공용 라이브러리 내 객체 인스턴스 관리 모듈.<br/>
 * 과거 구버전에서 이벤트 메서드로 접근 할 수 있는 인스턴스 모음집으로 쓰인 것.<br/>
 * 특별한 사유가 있지 않다면 쓰지 않기를 권고함.
 * @type {Object.<string, Object>}
 * @deprecated since version 0.1
 */
Artn.Instance = {};

/**
 * 커스텀 함수 보관용 컨테이너.<br/>
 * 프로젝트 진행 중 임의의 사용자 함수를 잠시 만들어 쓸 경우 사용한다.<br/>
 * @example
 * // add 메서드를 잠시 만들어 쓸 경우의 예제
 * Artn.Method.add = function(iArg1, iArg2){
 *     return iArg1 + iArg2; 
 * };
 * console.log( Artn.Method.add( 3, 4 ) ); // 결과는 7
 */
Artn.Method = {};

/**
 * 타이밍 이벤트 <br/>
 * 특정 이벤트를 일정 시간 후 실행 되도록 한다.<br/>
 * 
 */
Artn.TimerId = {};

/**
 * 사용자 추상 메서드.<br/>
 * 클래스 작성 시 추상 메서드가 필요할 때 사용한다.<br/>
 * @example
 * // AbsClass의 delete 메서드를 추상 메서드로 설정 할 때
 * function AbsClass(){
 *     this.delete = Artn.AbstractMethod;
 * }
 */
Artn.AbstractMethod = function(){ throw "Not Implemented Error : This is abstract method. please implementing this."; };

/**
 * 빈 메서드.<br/>
 * 클래스 작성, 혹은 객체 생성시 빈 메서드가 필요할 때 사용한다.<br/>
 * 주로 이벤트 작성 시 빈 메서드가 필요할 때 사용 된다.
 * @example
 * // TestClass에 read 이벤트를 설정 할 시의 예제 
 * function TestClass(){
 *     // private 이벤트 핸들러 변수를 설정한다.
 *     // 빈 메서드를 설정 했기 때문에 type은 function이 된다.
 *     this.evt_read = Artn.EmptyMethod;
 *     // 실제 코드상에서 이벤트가 수행 될 시기에 불러올 메서드.
 *     this.onread = function(){
 *         this.evt_read( this );
 *     };
 *     // 외부에서 TestClass의 인스턴스에 이벤트 메서드를 등록할 때 사용되는 메서드.
 *     this.read = function( fnHandler ){
 *         this.evt_read = fnHandler;
 *     };
 * }
 */
Artn.EmptyMethod = function(){};

/**
 * Ajax 임시 객체.<br/>
 * 주로 서버측과 Ajax로 요청 후 응답 성공 시 재 가용하기 위한 객체나 변수를 잠시 등록할 때 쓰인다.<br/>
 * 클로저(Closure)를 쓸 수도 있으나 그 사용에 다소 불안정 하거나 그 값(포인터)을 신용할 수 없을 때,<br/>
 * 혹은 아예 클로저를 쓰지 못하는 환경에서 임시로 사용 한다.
 * @since 0.1
 * @author jhson
 * @example
 * Artn.Ajax.myName = "TheSON";
 * $.post("example.jsp", function(data){
 *     console.log("요청자: " + Artn.Ajax.myName);
 *     console.log("받은 데이터: " + data);
 * });
 */
Artn.Ajax = {};

/**
 * 여러가지 공용 메서드를 포함하는 유틸리티 객체.
 * @class
 */
Artn.Util = {
	/**
	 * 파일경로를 통해 파일명만을 따로 추출한다.
	 * @param {String} fileName 파일명을 추출하고자 하는 파일 경로
	 * @returns {String}
	 */
    getFileName : function(fileName){
        var s=fileName.lastIndexOf("/");
        var m=fileName.lastIndexOf(".");
        var e=fileName.length;
        var filename=fileName.substring(s+1,m);
        var extname=fileName.substring(m+1,e);
        return filename + "." + extname;
    },
    /**
     * 문자열에서 특정 문자열을 다른 문자열로 모두 바꾼다.
     * @param {String} strSrc 변경 할 원본 소스 문자열
     * @param {String} strOld 변경 할 문자열
     * @param {String} strNew 변경 될 문자열
     * @returns {String} 
     */
    replaceAll : function(strSrc, strOld, strNew){
        return strSrc.replace(new RegExp(strOld, "g"), strNew);
    },
    /**
     * 템플릿 문자열 내에 키 이름을 값으로 치환한다.<br/> 
     * 템플릿 문자열을 기반으로 한다.<br/>
     * 템플릿 문자열 내에 여러개의 키가 있어도 단 1개씩만 치환 된다.
     * @deprecated since ver 0.1
     */
    replaceTemplateSingle : function(strTemplate, strKey, strVal){
    	var saRegResult;
    	var sValueTemp = "{" + strKey + "}";
    	var regex, regexAlt;
    	var sValue = strVal;
    	
    	regexAlt = new RegExp( sValueTemp + "@.*@", "g" );
		regex = new RegExp( sValueTemp, "g" );
    	
    	if (sValue === ""){
    		if ( strTemplate.indexOf( sValueTemp + "@" ) >= 0 ){
    			saRegResult = regexAlt.exec(strTemplate);
    			sValue =  saRegResult[0];
    			sValue = sValue.replace( sValueTemp + "@", "" );
    			sValue = sValue.substr( 0, sValue.length - 1 );
    		}
    	}

        return strTemplate.replace( regexAlt, sValue ).replace( regex, sValue );
    },
    /**
     * 템플릿 문자열 내에 키 이름을 값으로 치환한다.<br/> 
     * 템플릿 문자열을 기반으로 한다.<br/>
     * 템플릿 문자열 내에 여러개의 키와 값이 쌍으로 치환될 수 있다.
     * @param {String} strTemplate 사용 할 템플릿 문자열
     * @param {String[]} saKey 키 이름이 들어있는 배열
     * @param {(Map<String, Object>|Object)} jsonData 키 이름으로 사용될 데이터가 있는 맵 컬렉션 (혹은 객체)
     * @example
     * // 템플릿 문자 작성 방법
     * var sTmp1 = "&lt;a href=\"{url}\">{desc}&lt;/a>"; // 각각 url과 desc라는 이름을 가진 키와 대응 된다.
     * var sTmp2 = "&lt;img src=\"{url}@/img/none.gif@\"/>; // url 키와 대응되나 그 값이 undefined, null, 
     *                                               // 혹은 빈 스트링일 경우 @...@ 사이의 값으로 대체 된다.
     * // 템플릿 문자 사용 방법
     * var sResult = Artn.Util.replaceTemplate( sTmp1, ["url"], {"http://www.skbt.co.kr/logo.png"} );
     */
    replaceTemplate : function(strTemplate, mData){
//        var iLen = saKey.length;
//        var sTemplate = strTemplate;
//        var sAltValue = "";
//        var sValue = "";
//        var sValueTemp = "";
//        var saRegResult;
//        var regex, regexAlt;
//        
//        for(var i = 0; i < iLen; ++i){
//        	sValue = jsonData[ saKey[i] ];
//        	sValueTemp = "{" + saKey[i] + "}";
//        	
//        	regexAlt = new RegExp( sValueTemp + "@.*@", "g");
//    		regex = new RegExp( sValueTemp, "g");
//        	
//        	if (sValue === ""){
//        		if ( sTemplate.indexOf( sValueTemp + "@" ) >= 0 ){
//        			saRegResult = regexAlt.exec(sTemplate);
//        			sValue =  saRegResult[0];
//        			sValue = sValue.replace( sValueTemp + "@", "" );
//        			sValue = sValue.substr( 0, sValue.length - 1 );
//        		}
//        	}
//        	else{
//        		//sTemplate = sTemplate.replace( regexAlt, "" );
//        	}
//
//        	sTemplate = sTemplate.replace( regexAlt, sValue );
//        	sTemplate = sTemplate.replace( regex, sValue );
//        }
//        
//        return sTemplate;
    	if (strTemplate instanceof String){
    		return TrimPath.parseTemplate( strTemplate ).process( mData );
    	}
    	
    	return strTemplate.process( mData );
    },
    /**
     * jQuery 객체 내부에 주석으로 존재하는 HTML 템플릿 문자열을 추출 한다.<br/>
     * 템플릿 주석은 반드시 jQuery 내부 DOM Element의 직속 자식 요소(Child Element) 중에 포함 되어 있어야 한다.<br/>
     * 자식 요소는 tr, li, 혹은 item 클래스명을 가진 div 태그 만을 대상으로 한다.
     * @param {jQuery} jqElem 템플릿을 가져올 객체
     * @returns {String}
     */
    extractTemplate : function(jqElem, index){
    	var jqTemp = "";
		var sTemp = "";
		var iNodeIndex = index || 0;
		
		if (jqElem instanceof jQuery){
			jqTemp = jqElem.contents().filter(function(){ return this.nodeType === 8; });
			
			if (jqTemp.length > 0){
				sTemp = jqTemp.get( iNodeIndex ).nodeValue;
				//try{ jqTemp.get(0).remove(); }catch(e){}
			}
		}
		else{
			sTemp = jqElem;
		}
		
		
//		else if (jqElem.children("tr, li, div.item").length > 0){
//			sTagName = jqElem.children().eq(0).prop("tagName").toLowerCase();
//			jqTemp = $( "<div>" + jqElem.children().eq(0).html() + "</div>");
//			jqTemp.find("input[type!='button'][type!='submit'][type!='image'], textarea").each(function(index){
//				var jqThis = $(this);
//
//				jqThis.val( "\{" + jqThis.attr("name") + "\}" );
//			});
//			jqTemp.find("input[type='text']").each(function(index){
//				this.value = "{" + this.name + "}";
//			});
//
//			sTemp = jqTemp.html();
//
//			if (sTagName === "tr"){
//				sTemp = "<tr>" + sTemp + "</tr>";
//			}
//			else if (sTagName === "li"){
//				sTemp = "<li>" + sTemp + "</li>";
//			}
//			else{
//				sTemp = "<div class=\"item\">" + sTemp + "</div>";
//			}
//		}

		sTemp = Artn.Util.replaceAll(Artn.Util.replaceAll(sTemp, "{", "${"), "\\@\\$\\{", "{");
		return TrimPath.parseTemplate( sTemp );
    },
    /**
     * 히든 필드 (Hidden Field)를 생성한다.<br/>
     * input[type='hidden'] 형태의 태그 문자열로 반환 된다.
     * @param {String} strName 필드명
     * @param {String} strValue 필드값
     * @returns {String}
     */
    createHidden : function(strName, strValue){
        return "<input type=\"hidden\" name=\"" + strName + "\" value=\"" + strValue + "\" />";
    },
    /**
     * 특정 선택자를 통해 그 내부의 히든 필드의 값들을 직렬화(Serialization)하여<br/>
     * 객체(Object - 정확히는 List-Map 타입)로 변환하여 전달 한다.
     * @param {String} strSelector 선택자
     * @param {String[]} saKey 선택자 결과물 내에서 가져올 필드명 배열
     * @returns {List<Map>} 직렬화 된 히든 필드값
     * @deprecated since ver 0.1
     * @link Artn.Util.serializeMap
     */
    convertHiddenValuesToMaps : function(strSelector, saKey){
        var maListValues = [];
        var jqListHidden = $( strSelector + " input[type='hidden']" ) ;
        var iLen;
        var saValues;
        var sKey;
        
        jqListHidden.each( function(index){
            saValues = $(this).attr("value").split("|");
            
            if ((saValues.length === 1 ) && 
                (saValues[0] === "")){
                saValues = [];
            }
            
            sKey = $(this).attr("name");
            iLen = saValues.length;
            
            for(var i = 0; i < iLen; ++i){
                maListValues[ i ] = maListValues[ i ] || {};
                maListValues[ i ][ sKey ] = saValues[ i ];
            }
        });
        
        $(strSelector).remove();
        
        return maListValues;
    },
    /**
     * jQuery-XML 객체에서 원하는 키로 구성된 객체 배열을 얻는다.
     * @param {jQuery} jqXml 원본 데이터가 포함 된 jQuery XML 객체
     * @param {String[]} saKey 데이터를 가져올 기준이 되는 키값 배열
     * @returns {List<Map>}
     */
    convertXMLToMaps : function(jqXml, saKey){
        var maListValues = [];
        var jqXmlRows = jqXml.find(Artn.Const.XML_ROOT); 
        var iRowLen = jqXmlRows.length;
        var iColLen = saKey.length;
        var sKey;
        
        for(var iRow = 0; iRow < iRowLen; ++iRow){
            maListValues[ iRow ] = {};
            for(var iCol = 0; iCol < iColLen; ++iCol){
                sKey = saKey[iCol];
                maListValues[ iRow ][ sKey ] = jqXmlRows.eq(iRow).find(sKey).text();
            }
        }
        
        return maListValues;
    },
    /**
     * 날짜에 특정 일수를 더한 값을 가져 온다.<br/>
     * 날짜 계산에 응용하면 좋음.<br/>
     * 출처: http://junyong.tistory.com/7
     * @param {Date} date 계산 할 날짜 데이터
     * @param {Integer} intVal 더할 일 수 - 음수(마이너스)도 사용 가능
     * @returns {String}
     */
    addDate : function(date, intVal){
    	date.setDate( date.getDate() + intVal );
    	return Artn.Util.formatDate(date);
    },
    /**
     * 두 날짜의 차이값(일수)을 가져 온다.
     * 출처: http://junyong.tistory.com/7
     * @param {Date} dateFrom 계산할 앞 날짜
     * @param {Date} dateTo 계산할 뒷 날짜
     * @returns {Integer}
     * @ignore
     */
    dateDef : function(dateFrom, dateTo){
    	// FIXME: 함수를 좀 더 간단하게 만들 것. (할 수 있다면... ^^;)
    	var diffDay = 0;
    	var start_yyyy = fromDate.substring(0,4);
    	var start_mm = fromDate.substring(5,7);
    	var start_dd = fromDate.substring(8,fromDate.length);
    	var sDate = new Date(start_yyyy, start_mm-1, start_dd);
    	var end_yyyy = toDate.substring(0,4);
    	var end_mm = toDate.substring(5,7);
    	var end_dd = toDate.substring(8,toDate.length);
    	var eDate = new Date(end_yyyy, end_mm-1, end_dd);

    	diffDay = Math.ceil((eDate.getTime() - sDate.getTime())/(1000*60*60*24));
    	return diffDay;
    },
    /**
     * Date 객체의 값을 문자열 값으로 변환 한다.
     * @param {Date} date 문자열로 바꿀 날짜 데이터
     * @param {String} [delimiter=-] 문자로 바꿀 때 연월일 사이에 넣을 구분자
     * @returns {String}
     */
    formatDate : function(date, delimiter) {
        delimiter = delimiter || "-";
        return date.getFullYear() + delimiter + this.formatLen(date.getMonth() + 1) + delimiter + this.formatLen(date.getDate());
    },
    /**
     * 인수인 문자열의 자릿수를 2자릿수로 바꿔준다.<br/>
     * formatDate 에서 쓰인다.
     * @param {String} str 2자릿수로 만들 문자열
     * @returns {String}
     */
    formatLen : function(str) {
        return str = (""  +str).length < 2 ? "0" + str : str;
    },
    
    /**

     * jQuery 객체 내의 모든 입력 요소(Input Element)의 값들을 <b>직렬화</b> 하여 Map Collection 혹은 객체로 만들어 준다.
     * @param {jQuery} jqElem 직렬화 할 요소가 담긴 부모 요소
     * @returns {Map}
     */
    serializeMap : function( jqElem ){
    	var mData = {};
    	var jqInput = null;
    	var sName = "";
    	var sValue = "";
    	
    	jqElem.find("input[type!='button'][type!='submit'][type!='image'], select, textarea").each(function(index){
    		jqInput = $(this);
    		
    		//if (jqInput.hasAttr("disabled") === true) return;
    		
    		sName = jqInput.attr("name");
    		sValue = jqInput.val();
    		
    		if (mData.hasOwnProperty( sName ) === false){
    			mData[ sName ] = sValue;
    		}
    		else{
    			if (typeof mData[ sName ] === "string"){
    				mData[ sName ] = [ sValue ];
    			}
    			else{
    				mData[ sName ][ mData[ sName ].length ] = sValue;
    			}
    		}
    	});
    	
    	return mData;
    },

    /**
     * jQuery 객체 내의 모든 입력 요소(Input Elemnt)에 특정 데이터의 값으로 설정(<b>역직렬화</b>)한다.
     * @param {jQuery} jqElem 역직렬화 할 요소가 담긴 부모 요소
     * @param {Map} mData 데이터 컬렉션
     * @param {Boolean} [isForceWork=false] 부모 요소에 데이터 컬렉션 키에 해당되는 요소가 없을 시 강제로 히든 필드를 생성하여 값을 설정 한다. true면 강제 설정, false면 설정 안함
     * @returns {jQuery} 인수로 들어 온 부모 요소
     */
    deserialize : function( jqElem, mData, isForceWork ){
//    	var jqInput = null;
//    	var sName = "";
//    	var mInputIndex = {};

    	if (isForceWork){
    		var jqInput = null;
    		for(var data in mData){
        		if (mData.hasOwnProperty(data) === true){
        			jqInput = jqElem.find("*[name='" + data + "']");
        			
        			if (jqInput.length === 0){
        				jqElem.append( Artn.Util.createHidden(data, mData[data]) );
        			}
        			else{
        				jqInput.val( mData[data] );
        			}
        			
        			//jqElem.find("." + data).text( mData[data] );
        		}
        	}	
    	}
    	else{
    		for(var data in mData){
        		if (mData.hasOwnProperty(data) === true){
        			jqElem.find("*[name='" + data + "']").val( mData[data] );
        			//jqElem.find("." + data).text( mData[data] );
        		}
        	}
    	}
    	
//    	
//    	jqElem.find("input[type!='button'][type!='submit'][type!='image'], select, textarea").each(function(index){
//    		jqInput = $(this);
//    		sName = jqInput.attr("name");
//    		
//    		if (mData[ sName ] !== undefined){
//    			if ( $.isArray( mData[ sName ] ) === true ){
//    				if (mInputIndex.hasOwnProperty( sName ) === false){
//        				mInputIndex[ sName ] = 0;
//        			}
//        			else{
//        				mInputIndex[ sName ]++;
//        			}
//        			
//        			jqInput.val( mData[ sName ][ mInputIndex[ sName ] ] );
//    			}
//        		else{
//        			jqInput.val( mData[ sName ] );
//        		}
//    		}
//    	});
    	
    	return jqElem;
    },
    /**
     * 해당 요소 내부에 리스트 객체가 존재하는지 확인한다.<br/>
     * 만약 존재한다면 해당 리스트의 id값을 배열로써 반환 한다.
     * @param {jQuery} jqElem 리스트 객체 존재 여부를 확인하고픈 부모 요소
     * @returns {String[]}
     */
    getContainsListId : function( jqElem ){
    	var saResult = [];
    	
    	jqElem.find("table, ul, ol").find("*[id^='list'], *[id^='sortable'], *[id^='infinite']").each(function(index){
    		saResult[index] = this.id;
    	});
    	
    	return saResult;
    },
    /**
     * 특정 요소가 리스트의 한 부분일 경우 그 요소의 인덱스 번호를 알아 낸다.
     * @param {jQuery} jqItem 몇번째 목록인지 알고자 하는 목록 요소
     * @param {String} [strSelector=undefined] 부모 노드 입장에서 자식 노드들 중 특정 선택자를 가진 자식들 끼리의 인덱스 번호를 찾고자 할 때 쓰임
     * @returns {Integer}
     */
    indexOf : function( jqItem, strSelector ){
    	var jqParent = jqItem.parent();
    	var iCurrIndex = -1;
    	
    	if (strSelector){
    		jqParent.children(strSelector).each(function(index){
        		if( this === jqItem.get(0) ){
        			iCurrIndex = index;
        		}
        	});
    	}
    	else{
    		jqParent.children().each(function(index){
        		if( this === jqItem.get(0) ){
        			iCurrIndex = index;
        		}
        	});
    	}
    	
    	
    	return iCurrIndex;
    },
    /**
     * 선택자 내부의 숫자 값들을 모두 3자리씩 끊어서 표현한다.
     * @param {String} strSelector 선택자
     */
    numberFormatToTable : function( strSelector ){
    	$(strSelector).each(function(index){
    		this.innerHTML = this.innerHTML.format();
    	});
    },
    /**
     * 일정 시간후 이벤트를 실행한다.
     */
    timingEvent : function(){
    	var sName = arguments[0];
    	var iTimer = 1000;
    	var fnHandler = Artn.EmptyMethod;
    	
    	if (arguments.length === 3){
    		iTimer = arguments[1];
    		fnHandler = arguments[2];
    	}
    	else{
    		fnHandler = arguments[1];
    	}

    	clearTimeout( Artn.TimerId[sName] || 0 );
    	Artn.TimerId[sName] = setTimeout(fnHandler, iTimer);
    },
    
    /**
     * 모바일용 네비게이션을 복사 한다.<br/>
     * 복사 시 지정한 요소의 모든 anchor를 대상으로 하며, ul/ol/li 로 구성되어 있어도 그 구조의 Depth는 무시 된다.
     * @param {Map} mParam 맵을 인수로 받으며, 필요로하는 멤버는 다음과 같다.
     * <ul>
     * <li>selector : 복사할 네비게이션에 대한 선택자.</li>
     * <li>edgeIcon : 복사하는 네비게이션이 리스트 형태일 경우, 각 메뉴 우측 모서리에 생성되는 아이콘에 대한 class를 설정 한다.</li>
     * <li>except : 메뉴 복사 시 제외할 요소에 대한 선택자.</li>
     * <li>cssClass : 복사되는 네비게이션에 적용 할 class.</li>
     * <li>isList : 복사할 네비게이션이 리스트 타입인지의 여부를 확인한다. true일 경우 리스트 형식, false일 경우 아이콘 형식으로 간주 된다.</li>
     * <li>innerIconSize : 복사된 네비게이션이 아이콘 형식일 경우 그 크기를 설정 한다. 단위는 pixel.</li>
     * </ul>
     */
    cloneNavigation : function(mParam/*strSelector, isList, iIconSize, iInnerIconSize, cssClass, strExcept*/){
    	var jqContainer = $(mParam.selector);
    	var jqNavResult = null;
    	var maxIndex = 0;
    	var jqEmptyIcon = $("<a></a>").addClass("artn-icon-hidden");
    	var jqEdgeIcon = $("<span class=\"artn-icon-edge artn-icon-16\"></span>").addClass( mParam.edgeIcon );
    	
    	if (jqContainer.length === 0) return;
    	
    	if (mParam.except !== ""){
    		mParam.except += ", .m-hdn, .m-hdn-hdn";
    	}
    	else{
    		mParam.except = ".m-hdn, .m-hdn-hdn";
    	}
    	
    	Artn.MobileGnb = Artn.MobileGnb || [];
    	
    	if (!!mParam.isList){
    		if (jqContainer.find("ul").length > 0){
    			jqNavResult = jqContainer.find("ul").not(".depth2").clone().addClass( mParam.cssClass );
        		jqNavResult.children("li").each(function(indexLi){
        			var jqLi = $(this);
        			//var jqLiChild = null;
        			
        			$(this).find("ul").each(function(indexLiChind){
        				jqLi.after(this);
        				
        				//$(this).children("li").append( jqEdgeIcon );
        			});
        		});
        		jqNavResult.find("li").append( jqEdgeIcon );
    		}
    		else{
    			jqNavResult = $("<ul></ul>").addClass("m-gnb-list");
    			jqContainer.find("a").each(function(indexAnchor){
    				var jqLi = $("<li></li>");
    				jqLi.append( $(this).clone() ).append( jqEdgeIcon.clone() );
    				jqNavResult.append( jqLi );
    			});
    		}
    		
    		Artn.MobileGnb[ Artn.MobileGnb.length ] = jqNavResult;
    		return jqNavResult.clone();
    	}
    	else{
    		/*jqNavResult = $("<ul></ul>");
    		jqContainer.find("a").not( strExcept ).each(function(index){
    			jqNavResult.append( $("<li></li>").append( $(this).clone() ) );
    		});*/
    		jqNavResult = $("<nav></nav>");
    		jqContainer.find("a").not( mParam.except ).each(function(index){
    			var jqThis = $(this);
    			var jqClone = jqThis.clone();
    			var sIcon = jqThis.data("artn-icon");
    			var sText = jqThis.text();
    			var jqIcon = $("<span></span>");
    			
    			if ( (sIcon !== undefined) || (sIcon !== "") ){
    				jqIcon.addClass("artn-icon-" + mParam.innerIconSize).addClass( sIcon );
    				jqClone.empty();
    				jqClone.append( jqIcon ).append( $("<span class=\"icon-text\">" + sText + "</span>") );
    			}
    			
    			jqNavResult.append( jqClone );
    			jqNavResult.append( document.createTextNode(" ") );
    			
    			maxIndex = index;
    		});
    		
    		for(var i = 0; i < maxIndex; i++){
    			jqNavResult.append( jqEmptyIcon.clone() );
    			jqNavResult.append( document.createTextNode(" ") );
    		}
    		
    		jqNavResult.addClass( mParam.cssClass );
    		Artn.MobileGnb[ Artn.MobileGnb.length ] = jqNavResult.clone();
    		
    		return jqNavResult;
    	}
    	
    },

    /**
     * 모바일용 GNB를 생성한다.<br/>
     * 내부적으로 Artn.Util.cloneNavigation()과 Artn.Util.doBlockJustify()를 수행한다.
     * @param {String} strSelectorMakePlace GNB를 생성할 위치.
     * @param {Map[]} amSelectorOpt Artn.Util.cloneNavigation() 에서 사용되는 맵 파라메터의 배열형. (cloneNavigation 메서드를 참고)
     */
    makeMobileGnb : function( strSelectorMakePlace, amSelectorOpt){
    	var jqContainer = $("<div class=\"m-gnb\"></div>");
    	var jqGnb = null;
    	var iLen = amSelectorOpt.length;
    	
    	for(var i = 0; i < iLen; i++){
    		Artn.Util.initOption( amSelectorOpt[i], {
    			selector: "body",
    			isList: true,
    			innerIconSize: 32,
    			except: "",
    			cssClass: "",
    			iconSize: 64,
    			edgeIcon: "caret-e"
    		} );
    		jqGnb =  this.cloneNavigation( amSelectorOpt[i] );
    		jqContainer.append( jqGnb );
    		
    		this.doBlockJustify( jqGnb, i );
    	}
    	
    	$(strSelectorMakePlace).after( jqContainer );
    },
    
    /**
     * 옵션 모음집으로 쓰이는 Map Collection의 특정 키에 대한 초기 값을 설정한다.<br/>
     * 초기값 설정은 대상 Map 에 해당 키가 없을 경우 수행 한다.
     * @param {Map} mParam 초기화 할 대상 Map 데이터.
     * @param {Map} mKeyDef 초기화 키와 값이 매핑 되어 있는 Map 데이터.
     */
    initOption : function(mParam, mKeyDef){
    	var oValue = null;
    	
    	for(var sKey in mKeyDef){
    		if (mKeyDef.hasOwnProperty(sKey) === true){
    			oValue = mParam[ sKey ];
    			
    			if ((oValue === undefined) || (oValue === null)){
    				mParam[ sKey ] = mKeyDef[ sKey ];
    			}
    		}
    	}
    	
    	return mParam;
    },
//    
//    getOneRowBlockCount : function( strSelector ){
//    	var jqContainer = $(strSelector);
//    	var jqChilds = jqContainer.children("li, a").not(".artn-icon-hidden");
//    	var jqChild = jqChilds.eq(0);
//    	var iParentWidth = jqContainer.width();
//    	var iParentPadding = parseInt( jqContainer.css("padding-left").replace("px", "") );
//    	var iChildWidth = jqChild.width();
//    	var iChildMargin = parseInt( jqChild.css("margin-left").replace("px", "") );
//    	//var iMaxNum = parseInt( ( (iParentWidth  - (iParentPadding * 2)) / ( ( iChildMargin * 2 ) + iChildWidth ) ) );
//    	var mResult = {
//    		"jqContainer": jqContainer,
//    		childTagName: jqChild.prop("tagName").toLowerCase(),
//    		parentWidth: iParentWidth,
//    		parentPadding: iParentPadding,
//    		childWidth: iChildWidth,
//    		childMargin: iChildMargin,
//    		blockCount: jqChilds.length,
//    		colCount: Math.floor((iParentWidth / (iChildWidth + 3) ))
//    	};
//
//    	return mResult;
//    },
    /**
     * 자식요소를 아이콘화 하였을 때 그 아이콘이 가로로 놓일 수 있는 최대 개수를 가져 온다.
     * <style type="text/css">
	 *	.desc-justified-block{width: 300px; height: 300px; border: 1px solid #333; padding: 5px; }
	 *	.desc-justified-block div{font-weight: bold; float: left; width: 80px; height: 80px; margin: 5px; text-align: center;}
	 *	.desc-justified-block .justified{ border: 1px dashed #444; }
	 *	.desc-justified-block .empty{border: 1px dashed #fcc; color: #f88;}
	 *	</style>
	 *	
	 *	<div class="desc-justified-block">
	 *	<div class="justified">justified block</div>
	 *	<div class="justified">justified block</div>
	 *	<div class="justified">justified block</div>
	 *	<div class="justified">justified block</div>
	 *	<div class="empty">empty block</div>
	 *	<div class="empty">empty block</div>
	 *	</div>
	 *	justified block count: 4<br/>
	 *	empty block count: 2
	 * @param {Integer} parentWidth 부모 요소의 가로 크기
	 * @param {Integer} childWidth 자식 요소의 가로 크기
	 * @param {Integer} parentPadding 부모 요소의 안쪽 여백 크기
	 * @param {Integer} childMargin 자식 요소의 바깥 여백 크기
	 * @return {Integer}
     */
    getJustifiedBlockCount : function( parentWidth, childWidth, parentPadding, childMargin ){
    	var iTotalChildWidth = (childWidth + (childMargin * 2));
    	
    	if (iTotalChildWidth === 0){
    		return 0;
    	}
    	
    	return Math.floor(( (parentWidth - (parentPadding * 2)) / iTotalChildWidth ));
    },
    
    /**
     * 자식요소를 아이콘화 하였을 때 Justify 로 배치 한 후 하단에 생기는 여백에 아이콘이 들어가는 개수를 가져 온다.<br/>
     * justified block 및 empty block 개념은 상기의 getJustifiedBlockCount() 설명을 참고.
     * @param {Integer} justifiedBlockCount 아이콘이 가로로 배치될 수 있는 개수
     * @param {Integer} totalCount 아이콘 총 개수
     * @return {Integer}
     */
    getEmptyBlockCount : function( justifiedBlockCount, totalCount ){
    	var iMod = ( totalCount % justifiedBlockCount );
    	
    	if ((iMod === 0) || (totalCount === 0)){
    		return 0;
    	}
    	return justifiedBlockCount - iMod;
    },
    
    /**
     * 아이콘화 된 모바일 GNB를 대상으로 동일 간격 배치(justify)를 수행 한다.
     * @param {String} strSelector 동일 간격 배치를 수행 할 대상에 대한 선택자.
     */
    doBlockJustify : function( strSelector ){
    	var jqContainer = $(strSelector);
    	var iParentWidth = jqContainer.parent().width();
    	var iChildWidth = jqContainer.children().eq(0).width();
    	var iParentPadding = parseInt( jqContainer.css("padding-left") );
    	var iChildMargin = parseInt( jqContainer.children().eq(0).css("margin-left") );
    	var jqChild = jqContainer.children("li, a").not(".artn-icon-hidden");
    	var jqChildHidden = jqContainer.find(".artn-icon-hidden");
    	var itemIndex = jqChild.length;
    	var iEmptyBlockCount = this.getEmptyBlockCount( this.getJustifiedBlockCount(iParentWidth, iChildWidth, iParentPadding, iChildMargin), itemIndex );
    	
    	jqChildHidden.hide();
    	
    	for(var i = 0; i < iEmptyBlockCount; i++){
    		jqChildHidden.eq(i).show();
    	}
    }
};


/**
 * 사용자 환경 정보를 가져올 때 쓰인다.<br/>
 * 주로 웹브라우저의 IE 및 그 버전에 따른 정보, 혹은 모바일 브라우저 여부를 확인 한다.
 * @class
 */
Artn.Environment = {
	/** @access private */
	_isMobile : false,
	_isUnderIE10 : false,
	_isUnderIE9 : false,
	_isIE9 : false,
	_isIE8 : false,
	_isIE : false,
	_isIE11 : false,
	
	/**
	 * 사용자 환경 정보를 가져오고 설정한다.<br/>
	 * 초기화 수행자.
	 */
	create : function(){
		try{
			var ua = window.navigator.userAgent.toLowerCase();
			this._isMobile = ( /iphone/.test(ua) || /ipad/.test(ua) || /android/.test(ua) || /opera/.test(ua) || /bada/.test(ua) );
		}
		catch(e){ }
		
		try{
			var bIE = ( $.browser.msie == true );
			//FIXME : 익스11버전 확인하는 부분 만들어야함 - 2014.04.09 by shkang
			//익스11 = mozilla/5.0 (windows nt 6.1; wow64; trident/7.0; slcc2; .net clr 2.0.50727; .net clr 3.5.30729; .net clr 3.0.30729; media center pc 6.0; .net4.0c; .net4.0e; rv:11.0) like gecko
			//var bIE11 = ( $.browser.net == true);
			this._isIE = bIE;
			bIE = bIE && ( $.browser.version <= 9 );
			this._isUnderIE10 = bIE;
			this._isUnderIE9 = ( $.browser.version <= 8 );
			this._isIE9 = ( $.browser.version == 9 );
			this._isIE8 = ( $.browser.version == 8 );
			this._isIE11 = ( $.browser.version == 11 );
		}
		catch(e){ }
	},
	/**
	 * 모바일 환경인지의 여부를 확인 한다.
	 * @returns {Boolean}
	 */
	isMobile : function(){
		return this._isMobile;
	},
	/**
	 * 현재 사용자의 IE 버전이 10 미만인지 여부를 확인한다.
	 * @returns {Boolean}
	 */
	isUnderIE10 : function(){
		return this._isUnderIE10;
	},
	/**
	 * 현재 사용자의 IE 버전이 9 미만인지 여부를 확인한다.
	 * @returns {Boolean}
	 */
	isUnderIE9 : function(){
		return this._isUnderIE9;
	},
	/**
	 * 현재 사용자의 IE 버전이 9 인지 여부를 확인한다.
	 * @returns {Boolean}
	 */
	isIE9 : function(){
		return this._isIE9;
	},
	/**
	 * 현재 사용자의 IE 버전이 8 인지 여부를 확인한다.
	 * @returns {Boolean}
	 */
	isIE8 : function(){
		return this._isIE8;
	},
	/**
	 * 현재 사용자의 웹브라우저가 IE 인지를 확인한다.
	 * @returns {Boolean}
	 */
	isIE : function(){
		return this._isIE;
	},

	isIE11 : function(){
		return this._isIE11;
	}
};


/**
 * 아코디언 메뉴를 만든다.<br/>
 * 현재 기능이 검증되지 않음
 * @ignore
 */
Artn.ArcodianMenu = {
    _focusedObj: {},
    create: function(strSelector) {
        $(strSelector + " ul li ul").css("display", "none");

        if ($(strSelector + ">ul>li ul>li>a.selected").length > 0) {
            $(strSelector + ">ul>li ul>li>a.selected").parent().parent("ul").css("display", "block");
        }
        $(strSelector + ">ul>li>a").focus(function() {
            Artn.ArcodianMenu.onClick_Menu(this, false);
        });

        $(strSelector + ">ul>li>a").mousedown(function() {
            Artn.ArcodianMenu.onClick_Menu(this, true);
        });
    },
    onClick_Menu: function(sender, isClick) {
        var jqSubMenu = $(sender).siblings("ul");
        var sMenuWrapper = "#" + $(sender).parent().parent().parent().parent().attr("id");
        var isFocused = (Artn.ArcodianMenu._focusedObj === sender);
        var isVisible = (jqSubMenu.css("display") === "block");

        if ((isClick === false) &&
            (isFocused === true)) {

            return false;
        }

        $(sMenuWrapper + ">ul>li>ul").css("display", "none");
        $(sMenuWrapper + ">ul>li").removeClass("selected");

        $(sender).parent().addClass("selected");

        if ((jqSubMenu.css("display") === "none") && (isVisible === false)) {
            jqSubMenu.css("display", "block");
        }
        else if (isClick === true) {
            jqSubMenu.css("display", "none");
        }

        Artn.ArcodianMenu._focusedObj = sender;

        if ((isClick === true) &&
            (jqSubMenu.length === 0)) {
            location.href = $(sender).attr("href");

            return true;
        }

        return false;
    }

};

/**
 * 탭기능을 만든다.<br/>
 * 생성시 아래와 같은 조건이 필요하다.<br/>
 * <ol>
 * <li>탭기능이 생성될 요소(Element)는 data-rule="tabContents" 라는 속성(Attribute)이 반드시 포함 되어야 한다.</li>
 * <li>탭기능 요소 내부엔 반드시 다음과 같은 형식의 문서구조를 이루어야 한다.
 * <pre>
 *   *[data-rule='tabContents']
 * 	├─ul.tab
 * 	│	├─li
 * 	│	│	└─a
 * 	│	└─(...)
 * 	│
 * 	├─*.content
 * 	└─(...)
 * ※ 생성 시 선택자를 직접 사용 할 경우 탭기능 요소의 <b>조건 속성</b>은 없어도 무방하다.
 * ※ 문서구조 제작 측면에서 탭기능 요소와 ul.tab, *.content 요소간은 직속 자식 요소가 아니어도 구동될 수 있다.
 * </pre>
 * </li>
 * </ol>
 * @class
 */
Artn.TabContents = {
	/**
	 * <h4>생성자</h4>
	 * 탭기능을 만든다.
	 * 기본적으로 프레임워크 구동 시 <u>인수 없이 자동으로 수행</u>된다.
	 * @param {String|jQuery} [strSelector="*[data-rule='tabContents']"] 탭 기능을 생성 시킬 요소.
	 */
    create: function(strSelector) {
    	var jqTabContainer = null;
    	var jqTabMenu = null;
    	var iLen = 0;
    	
    	if (strSelector === undefined){
    		jqTabContainer = $("*[data-rule='tabContents']");
    	}
    	else{
    		jqTabContainer = $(strSelector);
    	}
    	
        jqTabMenu = jqTabContainer.find(".tab li a");
        iLen = jqTabContainer.length;
        
        jqTabContainer.each(function(index){
        	var jqContainer = $(this);
        	jqTabMenu = jqContainer.find(".tab li a");
        	
        	jqTabMenu.click({jqContainer: jqContainer}, Artn.TabContents.onClick_TabMenu);
            jqTabMenu.focus({jqContainer: jqContainer}, Artn.TabContents.onClick_TabMenu);
        });

        for(var i = 0; i < iLen; ++i){
        	this.setSelectedIndex( jqTabContainer.eq(i), 0);
        }
    },
    /**
     * @ignore
     */
    setSelectedIndex: function(jqTabContainer, index) {
        var jqTabMenu = jqTabContainer.find(".tab");
        var jqTabCont = jqTabContainer.find(".content");

        jqTabMenu.find("li a").removeClass("selected");
        jqTabMenu.find("li a").eq(index).addClass("selected");

        jqTabCont.hide();
        jqTabCont.eq(index).show();
    },
    /**
     * @ignore
     */
    onClick_TabMenu: function(e) {
    	var jqItem = $(this).parent();
        var jqContainer = e.data.jqContainer;
        
        Artn.TabContents.setSelectedIndex( jqContainer, Artn.Util.indexOf( jqItem ));

        return false;
    }
};


/**
 * @ignore
 * @deprecated
 */
function ComboBoxChain(){
	this.chainName = null;
	this.actor = null;
	this.ajaxUrl = "";
	this.parentAction = "";
}
// mapChainInfo 구조
// {actor: [], chain: "", ajaxUrl: ""}
/**
 * @ignore
 * @deprecated
 */
ComboBoxChain.prototype = {
	/**
	 * @ignore
	 * @param mapChainInfo
	 */
	init : function(mapChainInfo){
		this.chainName = mapChainInfo.chain;
		this.actor = mapChainInfo.actor;
		this.ajaxUrl = mapChainInfo.ajaxUrl;
		
		Artn.Instance.ComboBoxChain = Artn.Instance.ComboBoxChain || {};
		
		this.chain();
	},
    chain : function(){
    	var saActor = this.actor;
        var iLen = saActor.length;
        
        for (var i = 0; i < iLen; ++i){
        	Artn.Instance.ComboBoxChain[ saActor[i] ] = this;
    		$("select[name='" + saActor[i] + "']").change(this.onComboChange);
    	}
    },
    getActorValue : function(){
    	var iLen = this.actor.length;
    	var jqActor;
    	var sRet = "";

    	for(var i = 0; i < iLen; ++i){
    		jqActor = this.getJqActor(i);
    		
    		sRet += jqActor.val() + ".";
    	}
    	
    	return sRet.substr(0, sRet.length - 1);
    },
    getJqActor : function(index){
    	return $("form[action='" + this.parentAction + "'] *[name='" + this.actor[index] + "']");
    },
    getJqTarget : function(){
    	return $("form[action='" + this.parentAction + "'] select[name='" + this.chainName + "']");
    },
    replace : function(strTags){
    	this.getJqTarget().replaceWith(strTags);
    	this.getJqTarget().change( this.onComboChange );
    },
    isTargetDisabled : function(){
    	return (this.getJqTarget().eq(0).attr("disabled") === "disabled");
    },
    onComboChange : function(){
        var cmbChain = Artn.Instance.ComboBoxChain[ this.name ];
        var sAction = $(this).parents("form").attr("action");
        
        if ((cmbChain === undefined) || (
        	cmbChain.isTargetDisabled() === true)) return;
        
        Artn.Instance.ComboBoxChain.curr = cmbChain;
        Artn.Instance.ComboBoxChain.curr.parentAction = sAction;
        
        $.get(cmbChain.ajaxUrl, {
        	cmb : cmbChain.chainName,
        	val : "",
        	sub : cmbChain.getActorValue()
        }, function(text){
        	// FIXME: 두번 읽는거 수정하기
        	try{
        		Artn.Instance.ComboBoxChain.curr.replace(text);
        	}
        	catch(e){}
        	Artn.Instance.ComboBoxChain.curr = undefined;
        });
        
        //Artn.Ajax.GetText();
    }
};
/**
 * @ignore
 * @deprecated
 */
Artn.ComboChain = {
	create : function(){
		$("input[name='combochain']").each(function(index){
			var mChainInfo = $.parseJSON( Artn.Util.replaceAll($(this).val(), "'", "\"") );
			new ComboBoxChain().init(mChainInfo);
		});
	}
};


/**
 * 바깥 클릭 시 특정 영역 요소를 닫게 하는 기능.<br/>
 * 일명: 바깥 클릭 이벤트.<br/>
 * 하위 메뉴나 다이얼로그 팝업 시 해당 부위 외 영역을 클릭 하면 사라지게 할 필요성이 있을 때 사용한다.
 * @class
 */
Artn.OutsideEvent = {
	/**
	 * 바깥 클릭 이벤트가 필요한 객체에 이벤트 ID를 부여하고 설정, 가져올 때 사용 하기 위한 공통 키 이름
	 * @constant
	 */
	HANDLER_KEY : "__outeventkey",
	/**
	 * @private
	 */
	_appdId : "",
	_except : "",
	_status : false,
	_hander : {},
	_inst : {},
	_regNum : 0,
	/**
	 * <h4>생성자</h4>
	 * 바깥 클릭 이벤트 기능을 현재 문서에 설정 하기 위한 일련의 작업을 수행 한다.<br/>
	 * 기본적으로 프레임워크 구동 시 자동으로 수행 된다.
	 */
	create : function(){
		$(document).mouseup(function(e){
			if (e.which > 1) return;
			
			var jqTargets = $(Artn.OutsideEvent._appdId);
			var jqThis = null;
			var iRegNum = 0;
			var isRegisteredNode = false;
			var jqExcept = $(Artn.OutsideEvent._except);
			
			if (jqExcept.has(e.target).length > 0) return;
			
			Artn.OutsideEvent._status = false;
			
			jqTargets.each(function(index){
				jqThis = $(this);
				iRegNum = jqThis.data( Artn.OutsideEvent.HANDLER_KEY );
				isRegisteredNode = (this !== e.target) && (jqThis.has(e.target).length === 0);
				
				if ((iRegNum !== undefined) && isRegisteredNode){
					Artn.OutsideEvent._hander[ iRegNum ]({
						currentTarget: this,
						inst: Artn.OutsideEvent._inst[ iRegNum ]
					});
				}
				else if ( isRegisteredNode === true ){
					if ( jqThis.css("display") !== "none" ){
						Artn.OutsideEvent._status = true;
					}
					else{
						Artn.OutsideEvent._status = Artn.OutsideEvent._status || false;
					}
					jqThis.hide();
				}
			});
		});
	},
	/**
	 * 바깥 클릭 이벤트를 추가 한다.<br/>
	 * @param {String} strSelector 바깥 클릭 이벤트를 추가 할 요소에 대한 선택자
	 * @param {Object} [objInst=] 이벤트 수행 시 필요한 각종 데이터가 담긴 객체. 데이터 내용은 사용자가 임의로 설정 한다.
	 * @param {Function} [handler=] 이벤트 수행 후 별도로 처리 될 이벤트 핸들러 함수.
	 */
	add : function(strSelector, objInst, handler){
		if (this._appdId === ""){
			this._appdId = strSelector;
		}
		else{
			this._appdId += ", " + strSelector;
		}
		
		if ((objInst !== undefined) && (handler !== undefined)) {
			$( strSelector ).data( this.HANDLER_KEY, this._regNum );
			this._inst[ this._regNum ] = objInst;
			this._hander[ this._regNum ] = handler;
		}
		
		this._regNum++;
	},
	/**
	 * 바깥 클릭 이벤트에 영향 받지 않을 예외 요소를 추가 한다.<br/>
	 * 간혹 바깥 클릭 시 동작하면 안되는 요소가 있다면 사용 한다.
	 * @param {String} strSelector 바깥 클릭 이벤트에 예외가 될 요소에 대한 선택자
	 */
	addExcept : function(strSelector){
		if (this._except === ""){
			this._except = strSelector;
		}
		else{
			this._except += ", " + strSelector;
		}
	},
	/**
	 * 바깥 클릭 이벤트에 등록된 요소가 현재 화면에서 보여지고 있는지의 여부를 확인 한다.
	 * @returns {Boolean}
	 */
	existShowed : function(){
		return this._status;
	}
};

/**
 * 프레임워크 내에 공통적으로 생성/사용될 UI에 대하여 미리 생성시켜주는 객체.<br/>
 * 포함된 멤버 메서드들은 공통적으로 선택자를 요구하며, 선택자가 없을 시 각각의 기본 설정에 따라 UI를 생성한다.<br/>
 * 자동 생성된 경우가 아닌 별도 생성이 필요하다면 용도에 맞는 메서드를 선택하고 적절한 선택자를 줌으로써 간단히 구현 가능 하다.<br/>
 * jQuery-UI를 통해 Rendering 되는 UI의 경우, 해당 요소에 별도의 Style을 주지 않을 경우 jQuery-UI Theme에 맞춰져 Rendering 된다.
 * @class
 */
Artn.CommonUI = {
	/**
	 * <h4>생성자</h4>
	 * 기본적으로 프레임워크 구동 시 자동으로 수행 된다.<br/>
	 */
	create : function(){
		try{
			this.insertInnerBorder();
			this.insertLastColumn();
			
			this.createAjaxUpload();
			this.createButton();
			this.createSpinner();
			this.createDialog();
			this.registConfirmButton();
			this.registTransfer();
			this.registGotoBack();
			
			this.doFormat();
//			this.convertButtonToAnchor();
//			this.registBreakEnter();
		}
		catch(e){}
	},
	/**
	 * 버튼을 생성 한다.<br/>
	 * 생성 후 jQuery-UI의 Button으로 변화된다.
	 * @param {String|jQuery} [strSelector="a.artn-button, button.artn-button, input.artn-button"] 버튼으로 만들 요소에 대한 선택자
	 */
	createButton : function(strSelector){
		var sSelector = strSelector || "a.artn-button, button.artn-button, input.artn-button";
		
		$(sSelector).button();
	},
	/**
	 * 스피너(수치 증감 입력)를 생성 한다.<br/>
	 * 생성 후 jQuery-UI의 Spinner로 변화 된다.<br/>
	 * 스피너 생성 요소에 data-min 과 data-max 속성이 있을 시 각각 스피너의 min/max 설정 수치에 대응, 옵션에 설정 된다.<br/>
	 * 없을 경우 min=-999, max=999 로 고정 된다.
	 * @param {String|jQuery} [strSelector="input[id^='spinner'], input[data-rule='spinner']"] 스피너로 만들 요소에 대한 선택자
	 */
	createSpinner: function(strSelector){
		var sSelector = strSelector || "input[id^='spinner'], input[data-rule='spinner']";
		
		$( sSelector ).each(function(index){
			var jqSpinner = $(this); 
			var mParam = {
				min: parseInt( jqSpinner.data("min") || -999 ),
				max: parseInt( jqSpinner.data("max") || 999 ),
			};
			
			jqSpinner.spinner( mParam );
		});
	},
	/**
	 * 다이얼로그를 생성 한다.<br/>
	 * 생성 후 jQuery-UI의 Dialog로 변화 된다.<br/>
	 * 다이얼로그에 다음과 같은 속성이 있을 시 Dialog 옵션에 적용 된다.
	 * <ul>
	 * <li>data-width : 다이얼로그 가로 크기. 기본은 auto</li>
	 * <li>data-height : 다이얼로그 세로 크기. 기본은 auto</li>
	 * <li>data-auto-open : true 면 자동 열기. 기본은 false</li>
	 * <li>data-modal : false면 모달폼 아님. 기본은 true</li>
	 * <li>data-openby : 속성값은 선택자. 값이 있다면 이 선택자에 대응되는 요소 클릭 시 본 다이얼로그가 열리게 된다.</li>
	 * <li>title : 속성이 존재하거나 그 값이 있다면 다이얼로그 상단에 제목줄이 표시 된다. 없으면 별도의 닫기 단추만 생성 되고 사이즈 변경을 막는다.</li>
	 * </ul>
	 * ※ 다이얼로그 내부에 아래와 같은 요소가 있다면 다이얼로그 닫기 버튼의 역할을 자동으로 하게 된다.<br/>
	 * a[data-close], button[data-close]
	 * @param {String|jQuery} [strSelector="*[id^='dialog']"] 다이얼로그로 만들 요소에 대한 선택자
	 */
	createDialog : function(strSelector){
		var sSelector = strSelector || "*[id^='dialog']";
		
		Artn.Dialog = Artn.Dialog || [];
		
		$( sSelector ).each(function(index){
			var jqDialog = $(this);
			var sWidth = jqDialog.data("width");
			var sHeight = jqDialog.data("height");
			var sPositionX = jqDialog.data("position-x");
			var sPositionY = jqDialog.data("position-y");
			var sAutoOpen = jqDialog.data("auto-open");
			var bAutoOpen = (sAutoOpen === true) || (sAutoOpen === "true");
			var sModal = jqDialog.data("modal");
			var isNonTitle = (jqDialog.attr("title") === undefined);
			
			if ( jqDialog.data("modal") === null || jqDialog.data("modal") === undefined ){
				sModal = "true";
			}
			//( (jqDialog.data("modal") === undefined)? true : (jqDialog.data("modal") === "true") );			
			var mArgs = {
				modal: (sModal === "true") || (sModal === true),
				autoOpen: Artn.CommonUI.hasCookie( jqDialog.attr("id") ) && bAutoOpen,
		        show: {
		            effect: "fade",
		            duration: 500
		        },
		        hide: {
		            effect: "fade",
		            duration: 250
		        }
			};			
			if (!!sWidth){
				mArgs.width = parseInt( sWidth );
			}
			if (!!sHeight){
				mArgs.height = parseInt( sHeight );
			}
			if (!!sPositionX){
				mArgs.position = [parseInt( sPositionX ), 0];
			}
			if (!!sPositionY){
				mArgs.position = [0, parseInt( sPositionY )];
			}
			if ( (!!sPositionX) && (!!sPositionX) ){
				mArgs.position = [parseInt( sPositionX ), parseInt( sPositionY )];				
			}
			
			if(Artn.CommonUI.isNewWin(jqDialog) === false || Artn.Environment.isUnderIE9() === true){
				jqDialog.dialog( mArgs );				
				if (isNonTitle === true){
					jqDialog.siblings(".ui-dialog-titlebar.ui-widget-header").hide();
					jqDialog.parent().addClass("artn-dialog-nontitlebar");
					jqDialog.prepend("<a class=\"artn-icon-32 close\">close</a>");
					jqDialog.find(".artn-icon-32.close").click(function(e){
						$(this).parent().dialog("close");
					});
					jqDialog.dialog("option", "resizable", false);
				}
				
				Artn.CommonUI.registDialogOpen( jqDialog.data("openby"), jqDialog );
				Artn.CommonUI.registDialogClose( jqDialog.find("a[data-close], button[data-close]"), jqDialog );
			}
			if(Artn.CommonUI.isNewWin(jqDialog) === true){
				jqDialog.find("a").attr("target", "_blank");
			}
			Artn.Dialog[ index ] = jqDialog;			
		});		
		
		if ( Artn.Environment.isMobile() === true ){
			$(".ui-dialog").css( "width", "98%" );
			$(".ui-dialog").css( "left", 0 );
		}
		
		$(window).resize(function(){
			var jqWindow = $(window);
			if ( jqWindow.width() < 1024 ){
				$(".ui-dialog").css( "width", "98%" );
				$(".ui-dialog").css( "left", 0 );
			}
		});
		
		$(sSelector).find("label[id^='label_close_checkbox']", "input[id^='close_checkbox']").click(function(){
			jqThis = $(this);			
			Artn.CommonUI.closeWin("dialog_popup"+jqThis.parent().data("index"), 1, (jqThis.parent().data("once-open") === "session"));
		});		
	},
	
	/* thkim[시작] */
	/**
	 * 특정 키에 대한 쿠키 값을 가져 온다.
	 * @param {String} name 가져올 값에 대한 키.
	 * @return {String} 
	 */
	getCookie : function( name ) {
		var nameOfCookie = name + "=";  
		   var x = 0;
		   try{
			   while ( x <= document.cookie.length ) {  
			       var y = (x + nameOfCookie.length);  
			       if ( document.cookie.substring( x, y ) == nameOfCookie ) {  
			           if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )  
			               endOfCookie = document.cookie.length;  
			           return unescape( document.cookie.substring( y, endOfCookie ) );  
			       }  
			       x = document.cookie.indexOf( " ", x ) + 1;  
			       if ( x == 0 )  
			           break;  
			   }  
		   } catch(e){}
		   
		   return "";  
	},
	
	/**
	 * 특정 키에 대한 쿠키 값의 존재 여부를 확인 한다.
	 * @param {String} name 확인할 키.
	 * @return {Boolean}
	 */
	hasCookie : function( name ) {		
		return Artn.CommonUI.getCookie( name ).length <= 0;
	},
	/**
	 * 특정 키에 대한 값을 쿠키에 추가 한다.
	 * @param {String} name 설정할 키.
	 * @param {String} value 설정할 값.
	 * @param {Integer} expiredays 유효기간 (일).
	 */
	setCookie : function( name, value, expiredays ) {
		var todayDate = new Date();
		
		todayDate.setDate( todayDate.getDate() + expiredays );   
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	},
	
	/**
	 * 사용자가 팝업창의 '그만보기'를 클릭했을 시 수행된다.<br/>
	 * 세션 사용 시 해당 세션동안만 '그만보기'가 수행되고,<br/>
	 * 세션 미 사용 시 쿠키를 이용하여 '그만보기'를 수행 한다.<br/>
	 * '그만보기'수행 후 해당 팝업, 혹은 다이얼로그를 닫는다.
	 * @param {String} name 팝업명. 주로 div 에 id attribute로 설정되어 있다.
	 * @param {Integer} expiredays 쿠키 사용 시 '그만보기'를 수행하는 유효 기간. (일)
	 * @param {Boolean} useSession 세션 사용 여부. true일 경우 /popup/nonOpen 액션 수행을 시도 한다. 생략하거나 false일 경우 쿠키를 이용한다.
	 */
	closeWin : function( name, expiredays, useSession ){		
		if( useSession === true ){
			//console.log($( "#" + name ));
			$.getJSON("/popup/nonOpen?json=true", "id="+$( "#" + name ).data("index"), function(data){
				console.log("성공");				
				if( Artn.CommonUI.isNewWin($("div[id^=" + name + "]")) ){
					   //팝업창 닫음.
					   window.close();
				}else{
					   $("div[id^=" + name + "]").dialog("close");
				}
			});
		} else{
			Artn.CommonUI.setCookie( name, "done" , expiredays);
			if( Artn.CommonUI.isNewWin($("div[id^=" + name + "]")) ){
				   //팝업창 닫음.
				   window.close();
			}else{
				   $("div[id^=" + name + "]").dialog("close");
			}	 
		}	   
	     	   
	},
	
	/**
	 * 새창 팝업을 생성하여 띄운다.<br/>
	 * 띄우는 조건은 선택자로 표현 시 다음과 같다.<br/>
	 * div[id^='dialog_popup'][data-new-window='true']<br/>
	 * 생성 시 필요한 속성은 다음과 같다.
	 * <table>
		<thead style="background-color: #f80;">
		<tr>
		<td>attr.</td>
		<td>type</td>
		<td>desc.</td>
		</tr>
		</thead>
		<tbody>
		<tr>
		<td>data-width</td>
		<td>Integer</td>
		<td>팝업창의 가로 크기</td>
		</tr>
		<tr>
		<td>data-height</td>
		<td>Integer</td>
		<td>팝업창의 세로 크기</td>
		</tr>
		<tr>
		<td>data-position-x</td>
		<td>Integer</td>
		<td>팝업창의 가로 위치</td>
		</tr>
		<tr>
		<td>data-position-y</td>
		<td>Integer</td>
		<td>팝업창의 세로 위치</td>
		</tr>
		<tr>
		<td>title</td>
		<td>String</td>
		<td>팝업창의 제목. (data-* 가 아님을 주의)</td>
		</tr>
		</tbody>
		</table>
	 * 새창 생성 시 다음과 같은 js library를 포함 한다.
	 * <ul>
	 * <li>http://code.jquery.com/jquery-1.10.2.js</li>
		<li>/js/jquery.superLabels.min.js</li>
		<li>/js/jquery-ui-1.9.2.custom.min.js</li>
		<li>/js/jquery-migrate-1.2.1.min.js</li>
		<li>/js/template.js</li>
		<li>/js/artn.js</li>
		<li>/js/artn.const.js</li>
		<li>/js/artn.lib.js</li>
		<li>/js/artn.thumblist.js</li>    
		<li>/js/artn.validation.js</li>
	 * </ul>
	 */
	openWin : function(){
		var divText;
		var winPopup;
		var doc;
		var sWidth;
		var sHeight;
		var sTitle;
		var sPositionX;
		var sPositionY;
		var jqWindow;
		
		$( "div[id^='dialog_popup'][data-new-window='true']" ).each(function(){	
			jqWindow = $(this);
			sWidth = jqWindow.data("width");
			sHeight = jqWindow.data("height");
			sTitle = jqWindow.attr("title");
			sPositionX = jqWindow.data("position-x");
			sPositionY = jqWindow.data("position-y");		
			
			divText = jqWindow.get(0).outerHTML;			
			if( Artn.Environment.isUnderIE9() === false ){
				if( Artn.CommonUI.hasCookie( jqWindow.attr("id") ) ){				
				winPopup = window.open("/common/popup.html", jqWindow.attr("id"),"width=" + sWidth + ",height=" + sHeight + ",location=no ,left=" + sPositionX + ",top=" + sPositionY);
				
				doc = winPopup.document;
				doc.open("text/html", "replace");
				doc.write("<!DOCTYPE html><html><head><title>" + sTitle + "</title>" +
							"<script src=\"http://code.jquery.com/jquery-1.10.2.js\"></script>" +
							"<script src=\"/js/jquery.superLabels.min.js\"></script>" +
							"<script src=\"/js/jquery-ui-1.9.2.custom.min.js\"></script>" +
							"<script src=\"/js/jquery-migrate-1.2.1.min.js\"></script>" +
							"<script src=\"/js/template.js\"></script>" +
							"<script src=\"/js/artn.js\"></script>" +
							"<script src=\"/js/artn.const.js\"></script>" +
							"<script src=\"/js/artn.lib.js\"></script>" +
							"<script src=\"/js/artn.thumblist.js\"></script>" +       
							"<script src=\"/js/artn.validation.js\"></script>" +						
							/*"<script>$(document).ready(function(){ $(\"label[id^='label_close_checkbox'], input[id^='close_checkbox']\").click(function(){" +												
							"Artn.CommonUI.closeWin(\"dialog_popup\" + $(this).parent().data(\"index\"), 1);" +
							"}); });</script>" +*/
							"</head><body id=\"popup_newWindow\">");				
				doc.write(divText);
				doc.write("</body></html>");
				doc.close();
				}				
			}			
		});
		
	},
	
	/**
	 * 검사하고자 하는 jQuery Object에서 data-new-window 속성을 검사하여 이것이 새창 팝업인지의 여부를 확인 한다.
	 * @param {jQuery} jqDialog 새창 여부를 확인하고 싶은 jQuery 객체
	 * @return {Boolean}
	 */
	isNewWin : function( jqDialog ){
		var sNewWindow;		
		sNewWindow = jqDialog.data("new-window");		
		return ( sNewWindow !== undefined ) && ( ( sNewWindow === "true" ) || ( sNewWindow === true )) ;
	},
	/*thkim[종료]*/
	/**
	 * @ignore
	 */
	registDialogOpen : function( strSelector, jqDialog ){
		if (strSelector){
			$(strSelector).click({jqTarget: jqDialog}, function(e){
				e.data.jqTarget.dialog("open");
				return false;
			});
		}
	},
	/**
	 * @ignore
	 */
	registDialogClose : function( jqClose, jqDialog ){
		if (jqClose.length > 0){
			jqClose.click({jqTarget: jqDialog}, function(e){
				e.data.jqTarget.dialog("close");
				return false;
			});
		}
	},
	/**
	 * 입력 확인 버튼을 만든다.<br/>
	 * 웹 문서 내 Anchor 를 통해 이동하기 전 비밀번호 확인이나 다른 입력등을 요구 할 필요가 있을 때 사용 한다.<br/>
	 * 변환 하고자 하는 요소는 반드시 아래와 같은 형태여야 하며 오픈 시킬 다이얼로그 선택자도 필수로 들어가야 한다.<br/>
	 * a[data-rule='confirmButton'][data-dialog]<br/>
	 * 해당 다이얼로그 내 form 요소는 자동으로 비동기 양식(Async Form)이 되며 그에 따라 form 요소 내 action 속성의 URL을 이용, Ajax로 서버와 요청/응답이 가능 하다.
	 * 서버측에서는 아래와 같은 방법으로 응답을 보낼 수 있어야 한다.<br/>
	 * <ul>
	 * <li>0|메시지 : 실패함. 클라이언트 측에서는 메시지를 다이얼로그창에 출력한다.</li>
	 * <li>1|메시지 : 성공함. 클라이언트 측에서는 곧바로 입력 확인 버튼의 href 속성에 기재된 URL로 이동 한다.</li>
	 * <li>2|메시지 : 성공함. 입력 확인 버튼 근처에 input[type='hidden'][name='confirm_ok'] 요소를 만들고 다이얼로그를 닫는다.</li>
	 * </ul>
	 * 출력되는 메시지는 다이얼로그의 form 요소 내부에 *.message 형식의 요소가 있으면 이 곳에 출력하게 된다.
	 * @example
	 * &lt;!-- 입력 확인 버튼을 생성 한다. -->
	 * &lt;a href="/board/show?id=33" data-rule="confirmButton" data-dialog="#dialog_confirm">들어가기&lt;/a>
	 * 
	 * &lt;!-- 사용될 다이얼로그를 작성 한다. -->
	 * &lt;div id="dialog_confirm">
	 * &lt;form action="/password_confirm" method="post">
	 * &lt;h3>비밀번호를 확인 합니다.&lt;/h3>
	 * &lt;input type="password" name="pw"/>&lt;br/>
	 * &lt;p class="message">&lt;/p>
	 * &lt;/form>
	 * &lt;/div>
	 * 
	 */
	registConfirmButton : function(){
		var jqConfirmButton = $("a[data-rule='confirmButton']");
		
		Artn.CommonUI.ConfirmButton = {};
		
		jqConfirmButton.each(function(index){			
			var jqButton = $(this);
			var jqDialog = $( jqButton.data("dialog") );
			var isTableList = jqButton.parents("table.board-list").length > 0;
			var mParam = {
				"jqDialog": jqDialog, 
				"isTableList": isTableList
			};
			
			jqButton.click(mParam, function(e){
				var jqButton = $(this);
				
				Artn.Ajax.ConfirmButton = {
					button: jqButton,
					dialog: e.data.jqDialog
				};
				
				if (e.data.isTableList === true){
					var iRowIndex = 0;
					
					jqButton.parents("table.board-list").find("tbody tr a[data-rule='confirmButton']").each(function(index){
						if (jqButton.attr("href") === $(this).attr("href")){
							iRowIndex = index;
						}
					});
					
					if (e.data.jqDialog.find("input[name='row_index']").length > 0){
						e.data.jqDialog.find("input[name='row_index']").val( iRowIndex );
					}
					else{
						e.data.jqDialog.find("form").append( Artn.Util.createHidden("row_index", iRowIndex) );
					}
				}
				
				e.data.jqDialog.find("form").find("input[type='text'], input[type='password']").val("");
				e.data.jqDialog.find(".message").html("");
				e.data.jqDialog.dialog("open");
				
				return false;
			});
			
			if ( Artn.CommonUI.ConfirmButton[ jqDialog.attr("id") ] ){
				return;
			}
			
			Artn.CommonUI.ConfirmButton[ jqDialog.attr("id") ] = true;

			jqDialog.on("dialogclose", function( event, ui ){
				return false;
			});
			
			jqDialog.find("form").submit(function(){
				var jqForm = $(this);

				jqForm.find(".message").html("");
				
				$.post(jqForm.attr("action"), jqForm.serialize(), function(data){
					var saData = data.split("|");
					
					if (saData[0] === "1"){
						if (Artn.Environment.isIE() === true){
							window.location.href( Artn.Ajax.ConfirmButton.button.attr("href") );
						}
						else{
							location.href = Artn.Ajax.ConfirmButton.button.attr("href");
						}
						
						//console.log( Artn.Ajax.ConfirmButton.button.attr("href") );
					}
					else if (saData[0] === "2"){
						var jqButton = Artn.Ajax.ConfirmButton.button;
						
						if (jqButton.siblings("input[name='confirm_ok']").length === 0){
							jqButton.next( Artn.Util.createHidden("confirm_ok", "confirm_ok") );
						}
						else{
							jqButton.siblings("input[name='confirm_ok']").val("confirm_ok");
						}
						
						jqDialog.dialog("close");
						
					}
					else{
						Artn.Ajax.ConfirmButton.dialog.find(".message").html( saData[1] );
					}
					return false;
				});
				
				return false;
			});
		});
	},
	
	/**
	 * <b>리스트 데이터 전달 버튼</b>을 만든다.<br/>
	 * 등록 된 해당 버튼 요소를 클릭 시, 어느 한쪽의 리스트 컨트롤러 내 모든 데이터를 다른 한쪽의 리스트 컨트롤러로 전달 하는 역할을 맡게 된다.<br/>
	 * 기능 특성상 리스트 컨트롤러와 조합하여 사용해야 한다.<br/>
	 * 리스트 데이터 전달 버튼 역할을 맡게되는 요소는 <b>data-rule="transfer"</b> 속성이 존재 해야 하며, 추가적으로 data-from 및 data-to 속성을 설정 해야 한다.<br/>
	 * <h5>사용 속성 목록</h5>
	 * <table border="1">
	 * <thead>
	 * <tr><th>속셩명</th><th>데이터 타입</th><th>필수여부</th><th>설명</th></tr>
	 * </thead>
	 * <tbody>
	 * <tr><td>data-from</td><td>Selector</td><td>O</td><td>데이터 원본이 있는 리스트 컨트롤러의 선택자</td></tr>
	 * <tr><td>data-to</td><td>Selector</td><td>O</td><td>데이터가 옮겨져 적용 될 리스트 컨트롤러의 선택자</td></tr>
	 * <tr><td>data-clear</td><td>from|to|<br/>both|none(default)</td><td></td>
	 * 		<td>데이터가 옮겨질 때 각 리스트에 남겨진 데이터를 제거할 지의 여부를 설정 한다.<br/>
	 * 			from : 데이터 전달 후 from에 해당되는 리스트는 내용이 제거 된다. - Move & Append<br/>
	 * 			to : 데이터 전달 전 to에 해당되는 리스트를 미리 제거하고 수행 한다. - Copy<br/>
	 * 			both : 위의 from 과 to 일 경우를 동시에 수행한다 - Move<br/>
	 * 			none : 데이터 복사만을 수행 한다. - Copy & Append
	 * 		</td></tr>
	 * </tbody>
	 * </table>
	 * @example
	 * &lt;!-- from 리스트 요소 -->
	 * &lt;ul id="list_from"> ... &lt;/ul>
	 * 
	 * &lt;!-- 데이터 전달 버튼-->
	 * &lt;a href="#" data-rule="transfer" data-from="#list_from" data-to="#list_to" data-clear="from">자료 이동&lt;/a>
	 * 
	 * &lt;!-- to 리스트 요소 -->
	 * &lt;table id="list_to"> ... &lt;/table>
	 */
	registTransfer : function(){
		$("a[data-rule='transfer'][data-from][data-to], button[data-rule='transfer'][data-from][data-to]").each(function(index){
			$(this).click(function(e){
				var jqButton = $(this);
				var sClear = jqButton.data("clear") || "none";
				var listFrom = Artn.List.inst[ jqButton.data("from") ];
				var listTo = Artn.List.inst[ jqButton.data("to") ];
				
				if ((sClear === "to") || (sClear === "both")){
					listTo.clear();
				}
				
				listTo.addItemRange( listFrom.serialize() );
				
				if ((sClear === "from") || (sClear === "both")){
					listFrom.clear();
				}
				
				return false;
			});
		});
	},
	/**
	 * 뒤로가기 버튼을 등록 한다.<br/>
	 * 특정 화면(View)에서 이전 화면으로 돌리는 기능이 필요할 때 쓰인다. 사용하고자 하는 a, button 요소에 data-rule="gotoback" 을 설정하면 자동으로 생성 된다.
	 */
	registGotoBack : function(){
		$("area[data-rule='gotoback'], a[data-rule='gotoback'], button[data-rule='gotoback']").click(function(e){
			window.history.back();
			return false;
		});
	},
	/**
	 * 비동기 업로드(Asyncronize Upload) 기능을 생성 한다.<br/>
	 * 기본적으로 입력 요소(input)가 type="file" 이고 id가 ajaxupload로 시작된다면 자동으로 비동기 업로드로 만들어 준다.<br/>
	 * 동시에 비동기 업로드를 수행할 수 있는 별도의 다이얼로그도 자동으로 만들어준다.
	 * <h5>사용 속성</h5>
	 * <table border="1">
	 * <thead>
	 * <tr><th>속셩명</th><th>데이터 타입</th><th>필수여부</th><th>설명</th></tr>
	 * </thead>
	 * <tbody>
	 * <tr><td>data-path</td><td>Path (default: "/upload/")</td><td></td><td>파일을 업로드/다운로드 하게 될 경로.</td></tr>
	 * <tr><td>data-action</td><td>URL (default: "/ajaxUpload.action")</td><td></td><td>파일을 업로드할 컨트롤러 URL</td></tr>
	 * <tr><td>data-to-img</td><td>Selector (default: "." + (file input name) )</td><td></td>
	 * 		<td>업로드 성공 후 이미지 URL 정보를 전달 할 이미지 태그에 대한 선택자.
	 *		별도로 지정하지 않으면 파일 입력 시 사용된 <b>이름(name)</b>값으로 클래스명을 가진 근처 이미지 태그에
	 *		자동으로 이미지 URL을 설정 해 준다.
	 * 		</td></tr>
	 * </tbody>
	 * </table>
	 * @param {String|jQuery} strSelector 비동기 업로드를 생성할 요소의 선택자
	 * @example
	 * &lt;!-- 업로드 후 이미지가 보여질 img 태그 작성-->
	 * &lt;img src="/img/none.png" alt="미리보기" class="file_img"/>
	 * 
	 * &lt;!-- 파일 입력 요소 작성 -->
	 * &lt;input type="file" id="ajaxupload_file_img" name="file_img" data-path="/upload/images/" data-action="/images_upload"/>
	 * 
	 * &lt;!-- 썸네일 크기 설정 추가 (선택 사항)-->
	 * &lt;input type="hidden" name="thumbWidth" value="200"/>
	 * &lt;input type="hidden" name="thumbHeight" value="200"/>
	 */
	createAjaxUpload : function(strSelector){
		if ($("#__form_ajaxupload").length === 0){
			$("body").append(
					"<div id=\"dialog_ajaxupload\">" +
					"<form id=\"__form_ajaxupload\" action=\"/ajaxUpload.action\" method=\"post\" enctype=\"multipart/form-data\">" +
					"<fieldset>" +
					"<input type=\"file\" name=\"file_image\" id=\"__file_ajaxupload\"/><br/>" +
					"<input type=\"hidden\" name=\"path\" id=\"__path_ajaxupload\">" +
					"<h2>썸네일 크기</h2>" +
					"<p>※ 비어있을 경우 썸네일을 만들지 않음</p>" +
					"<label for=\"__thumbWidth\">가로</label><input type=\"text\" name=\"thumbWidth\" id=\"__thumbWidth\"/>px<br/>" +
					"<label for=\"__thumbHeight\">세로</label><input type=\"text\" name=\"thumbHeight\" id=\"__thumbHeight\">px<br/>" +
					"<button type=\"submit\">업로드</button>" +
					"</fieldset>" +
					"</form>" +
					"</div>"
				);
		}
		
		var jqFormAjaxUpload = $("#__form_ajaxupload");
		
		$( strSelector || "input[type='file'][id^='ajaxupload']").each(function(index){
			var jqFileInput = $(this);
			var jqButtonOpener = jqFileInput.siblings(".button_ajaxupload_opener");
			var mParam = {
				name: jqFileInput.attr("name") || "file_img",
				path: jqFileInput.data("path") || "/upload/",
				action: jqFileInput.data("action") || "/ajaxUpload.action",
				toImg: jqFileInput.data("to-img") || jqFileInput.data("toimg") || ( "." + jqFileInput.attr("name") )
			};
			mParam.ori = mParam.name.replace("file_", "ori_");
			mParam.fileValue = jqFileInput.siblings( "input[name='" + mParam.name + "_exists']" ).val();
			mParam.oriValue = jqFileInput.siblings( "input[name='" + mParam.name + "_orivalue']" ).val();
			mParam.thumbWidth = jqFileInput.siblings( "input[name='thumbWidth']" ).val();
			mParam.thumbHeight = jqFileInput.siblings( "input[name='thumbHeight']" ).val();
			
			var jqHidden = jqFileInput.siblings("input[type!='file'][name='" + mParam.name + "']");
			var jqHiddenOri = jqFileInput.siblings("input[type!='file'][name='" + mParam.ori + "']");
			
			if (jqButtonOpener.length === 0){
				jqFileInput.after( "<button type=\"button\" class=\"artn-button board button_ajaxupload_opener\">파일 업로드</button>" );
				jqButtonOpener = jqFileInput.siblings(".button_ajaxupload_opener");
			}
			
			mParam.jqButtonOpener = jqButtonOpener;
			
			if (jqHidden.length === 0){
				jqFileInput.after( Artn.Util.createHidden( mParam.name, mParam.fileValue ) );
				jqHidden = jqFileInput.siblings("input[type!='file'][name='" + mParam.name + "']");
			}
			if (jqHiddenOri.length === 0){
				jqFileInput.after( Artn.Util.createHidden( mParam.ori, mParam.oriValue ) );
				jqHiddenOri = jqFileInput.siblings("input[type!='file'][name='" + mParam.ori + "']");
			}
			
			jqFileInput.remove();
			
			jqButtonOpener.click(mParam, function(e){
				var mParam = e.data;
				
				Artn.Ajax.upload = mParam;
				
				jqFormAjaxUpload.attr("action", mParam.action);
				jqFormAjaxUpload.find("#__file_ajaxupload").attr("name", mParam.name);
				jqFormAjaxUpload.find("#__path_ajaxupload").val(mParam.path);
				jqFormAjaxUpload.find("#__thumbWidth").val(mParam.thumbWidth || "");
				jqFormAjaxUpload.find("#__thumbHeight").val(mParam.thumbHeight || "");
				
				$("#dialog_ajaxupload").dialog("open");
				
				return false;
			});
		});
		
		jqFormAjaxUpload.submit(function(e){
			var sFileId = $(this).find("input[type='file']").attr("id");
			var mParam = Artn.Util.serializeMap( $(this) );
			
			if (($("#" + sFileId).val() === undefined) || ($("#" + sFileId).val() === "")){
				alert("파일을 먼저 선택 해 주세요.");
				return false;
			}
			delete mParam[sFileId];
			
			$.ajaxFileUpload
			(
				{
					url: $(this).attr("action"),
					secureuri: false,
					fileElementId: sFileId,
					dataType: false,
					data: mParam,
					success: function (data, status)
					{
						var saData = data.split("|");
						var sPath = saData[1];
						var sFileName = sPath.split("&")[1].replace("amp;fileName=", "");
						
						if (Artn.Ajax.upload){
							var mParam = Artn.Ajax.upload;
							var jqImg = mParam.jqButtonOpener.siblings( mParam.toImg );
							
							if (jqImg.length === 0){
								jqImg = mParam.jqButtonOpener.parent().siblings( mParam.toImg );
							}
							jqImg.attr("src", sPath);
							mParam.jqButtonOpener.siblings( "input[name='" + Artn.Ajax.upload.name + "']" ).val( sFileName );
							mParam.jqButtonOpener.siblings( "input[name='" + Artn.Ajax.upload.ori + "']" ).val( saData[2] );
						}
						
						$("#dialog_ajaxupload").dialog("close");
					},
					error: function (data, status, e)
					{
						alert(e);
					}
				}
			);
			
			return false;
		});
	},
	/**
	 * @ignore
	 * 게시판 디자인(table이고 클래스가 board-list 인 것)으로 운영되는 요소가 있다면,
	 * 우측에서 첫번째와 두번째열 사이에 꾸밈용 구분자(Delimiter)열을 추가 해 준다.<br/>
	 * ※ 추가된 열의 클래스명은 "_border" 이다.
	 */
	insertInnerBorder : function(){
//		var jqBoardListTr = $(".board-list>thead>tr, .board-list>tbody>tr");
//		var jqBoardListTfootTr = $(".board-list > tfoot > tr");
//		var iColspan = 0;
//		
//		jqBoardListTr.find("th:last-child").before("<th class=\"_border\"></th>");
//		jqBoardListTr.find("td:last-child").before("<td></td>");
//		
//		jqBoardListTfootTr.each(function(index){
//			var jqCell = $(this).children().eq(0);
//			iColspan = parseInt( jqCell.attr("colspan") );
//			iColspan++;
//			jqCell.attr("colspan", iColspan);
//		});
//		
//		if (jqBoardListTfootTr.length > 0){
//			
//		}
	},
	/**
	 * 사용자가 IE9 미만의 브라우저 사용 시 게시판 디자인(table이고 클래스가 board-list 인 것)의 last-child가 적용되지 아니하므로 직접 last라는 명칭의 클래스를 추가 해 준다.
	 */
	insertLastColumn : function(){
		if (Artn.Environment.isUnderIE9() === true ){
			var jqThLast = $("table.board-list thead th:last-child").addClass("last");
			
			jqThLast.prepend("<span class=\"_border\"></span>");
//			
//			var jqBoardListTr = $(".board-list>thead>tr, .board-list>tbody>tr");
//			var jqBoardListTfootTr = $(".board-list > tfoot > tr");
//			var iColspan = 0;
//			
//			jqBoardListTr.find("th:last-child").before("<th class=\"_border\"></th>");
//			jqBoardListTr.find("td:last-child").before("<td></td>");
//			
//			jqBoardListTfootTr.each(function(index){
//				var jqCell = $(this).children().eq(0);
//				iColspan = parseInt( jqCell.attr("colspan") );
//				iColspan++;
//				jqCell.attr("colspan", iColspan);
//			});
//			
//			if (jqBoardListTfootTr.length > 0){
//				
//			}
		}
	},
	/**
	 * 클래스명이 price인 요소들의 Text Node 데이터에 천단위 쉼표(,)를 넣어준다.
	 */
	doFormat : function(){
		$(".price").each(function(index){
			var sText = $(this).contents().filter(function(){ return this.nodeType === 3; });
			sText.get(0).nodeValue = sText.get(0).nodeValue.format();
		});
	}
};

/**
 * 리스트 컨트롤러를 생성하고 관리한다.
 * @class
 */
Artn.List = {
	/**
	 * 만들어진 리스트 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : {},
	/**
	 * 리스트를 생성한다.
	 * @param {String} strSelector 리스트로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.ListController().init(strSelector);
		}
		else{
			$("*[id^='list']").each(function(index){
				Artn.List.inst[ "#" + $(this).attr("id") ] = new artn.lib.ListController().init( $(this) );
			});
		}
	}
};

/**
 * 무한 리스트 컨트롤러를 생성하고 관리한다.<br/>
 * 사용 시 비동기 양식 컨트롤러와 연동 하여야 한다.
 * @class
 */
Artn.InfiniteList = {
	/**
	 * 만들어진 리스트 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : Artn.List.inst,
	/**
	 * 리스트를 생성한다.
	 * @param {String} strSelector 리스트로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.InfiniteList().init(strSelector);
		}
		else{
			$("*[id^='infinite']").each(function(index){
				Artn.InfiniteList.inst[ "#" + $(this).attr("id") ] = new artn.lib.InfiniteList().init( $(this) );
			});
		}
	}
};

/**
 * 정렬가능한 리스트 컨트롤러를 생성하고 관리한다.<br/>
 * 이 것을 이용하여 리스트 생성 시, 마우스로 끌어올려 리스트 내 항목 순서를 변경할 수 있다.
 * @class
 */
Artn.SortableList = {
	/**
	 * 만들어진 리스트 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : Artn.List.inst,
	/**
	 * 리스트를 생성한다.
	 * @param {String} strSelector 리스트로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.SortableList().init(strSelector);
		}
		else{
			$("*[id^='sortable']").each(function(index){
				Artn.SortableList.inst[ "#" + $(this).attr("id") ] = new artn.lib.SortableList().init( $(this) );
			});
		}
	}
};

/**
 * 비동기 양식 컨트롤러를 생성하고 관리한다.<br/>
 * @class
 */
Artn.AsyncForm = {
	/**
	 * 만들어진 비동기 양식 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : {},
	/**
	 * 비동기 양식을 생성한다.
	 * @param {String} strSelector 비동기 양식으로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.AsyncForm().init(strSelector);
		}
		else{
			$("*[id^='asyncform']").each(function(index){
				Artn.AsyncForm.inst[ "#" + $(this).attr("id") ] = new artn.lib.AsyncForm().init( $(this) );
			});
		}
	}
};

/**
 * 비동기 검색 컨트롤러를 생성하고 관리한다.
 * @class
 */
Artn.AsyncSearch = {
	/**
	 * 만들어진 비동기 양식 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : Artn.AsyncForm.inst,
	/**
	 * 비동기 양식을 생성한다.
	 * @param {String} strSelector 비동기 검색으로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.AsyncSearch().init(strSelector);
		}
		else{
			$("*[id^='asyncsearch']").each(function(index){
				Artn.AsyncSearch.inst[ "#" + $(this).attr("id") ] = new artn.lib.AsyncSearch().init( $(this) );
			});
		}
	}
};

/**
 * 자동완성 컨트롤러를 생성하고 관리한다.
 * @class
 */
Artn.AutoComplete = {
	/**
	 * 만들어진 자동완성 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : {},
	/**
	 * 자동완성을 생성한다.
	 * @param {String} strSelector 자동완성으로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.AutoComplete().init(strSelector);
		}
		else{
			$("*[id^='autocomplete']").each(function(index){
				Artn.AutoComplete.inst[ "#" + $(this).attr("id") ] = new artn.lib.AutoComplete().init( $(this) );
			});
		}
	}
};

/**
 * 연쇄 콤보박스 컨트롤러를 생성하고 관리한다.<br/>
 * 변경된 selectbox 는 그 값이 변경될 시 연관된 selectbox의 목록을 변경한다.
 * @class
 */
Artn.ComboBoxChain = {
	/**
	 * 만들어진 연쇄 콤보박스 인스턴스를 보관한다.
	 * @type {Object.<string, number>}
	 */
	inst : {},
	/**
	 * 연쇄 콤보박스를 생성한다.
	 * @param {String} strSelector 연쇄 콤보박스로 만들 요소의 선택자
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.ComboBoxChain().init(strSelector);
		}
		else{
			$( "select[data-chain][data-url][data-to]" ).each(function(index){
				Artn.ArtnComboBoxChain.inst[ "#" + this.id  ] = new artn.lib.ComboBoxChain().init( $(this) );
			});
			$( "*[data-chain][data-url][data-to] select" ).each(function(index){
				var jqThis = $(this);
				var jqParent = jqThis.parent();
				
				jqThis.data( jqParent.data() );
				Artn.ArtnComboBoxChain.inst[ "#" + this.id ] = new artn.lib.ComboBoxChain().init( jqThis );
			});
		}
	}
};

/**
 * 경로(Bread-Crumbs)를 생성 한다.<br/>
 * 생성되는 경로는 GNB와 Contents-Code를 기준으로 작성 된다.<br/>
 * 작성 위치는 #breadcrumbs 혹은 .breadcrumbs 이다.<br/>
 * 사용되는 data-* attribute는 다음과 같다.
<table>
<thead style="background-color: #f80;">
<tr>
<td>attr.</td>
<td>type</td>
<td>desc.</td>
</tr>
</thead>
<tbody>
<tr>
<td>data-sub</td>
<td>String</td>
<td>
<strong>필수</strong>.<br/>
GNB 내에서 링크를 추적하기위한 컨텐츠 코드.<br/>
대체로 sub1_1 과 같은 패턴으로 작성 되어진다.<br/>
만약 <b>*로그인</b>과 같이 (*)로 시작되어질 시 GNB를 통하지 않고 (*)이후의 내용을 임의로 넣게 된다.
</td>
</tr>
<tr>
<td>data-target</td>
<td>'left' | <strong>'top'</strong></td>
<td>경로 생성 시 참조할 방향. top일 때는 GNB를 참조하며, left일 때는 좌측 사이드 메뉴를 참조 한다.</td>
</tr>
</tbody>
</table>
 * @class
 */
Artn.BreadCrumbs = { 
		/**
		 * 경로를 생성한다.
		 */
		create : function(){
			var SPAN_ARROW = " <span class=\"arrow\">&gt;</span> ";
			
			var jqBreadCrumbs = $("#breadcrumbs, .breadcrumbs");
			// input 을 이용, 별도로 분리된 값을 이용하기 보단 HTML5의 data- attribute를 활용하는 것이 좋을 것 같아 변경 함. - 2013.08.28 by jhson
			//var sHintValue = $( jqBreadCrumbs.eq(0).data("subkey") || "#subkey" ).val();
			var sHintValue = jqBreadCrumbs.eq(0).data("sub");
			var saHintValue = (sHintValue)? sHintValue.substr( 3, sHintValue.length).split("_") : [];			
			var iHintLen = saHintValue.length;			
			var jqNav = $("div.nav > ul > li");
			var jqLeftMenu = $("div.nav.left-menu > div > ul > li");
			var jqTopMenu = $("div.nav.top.gnb > ul.depth1 > li");
			
			var iMenu1 = 0;
			var iMenu2 = 0;
			var iMenu3 = 0;
			var iMenu4 = 0;
			
			try {
				iMenu1 = parseInt( saHintValue[0] );
				iMenu2 = parseInt( saHintValue[1] );
				iMenu3 = parseInt( saHintValue[2] );
				iMenu4 = parseInt( saHintValue[3] );
			}			
			catch(e){}
			
			var jqNav_innerList = jqNav.eq(iMenu1-1).children("ul").children("li");
			
			var jqOneDepth;			
			//jqBreadCrumbs.data("subKey", "breadcrumbs");
			sTarget = jqBreadCrumbs.data("target");
			try{
				if( (sTarget === undefined) || (sTarget === "") ){
					sTarget = "top";
				}else if( (sTarget === "auto") ) {
					if( $(".left-menu").length > 0 ){
						sTarget = "left";
					}
					else {
						sTarget = "top";
					}					
				}				
				if( (sTarget === "top")  ) {
					if( ((sHintValue !== "") || (sHintValue !== null)) && (sHintValue.charAt(0) !== "*") ){
						jqOneDepth = jqBreadCrumbs.append("<span class=\"artn-icon-16 home\">⊙</span><a href=\"/\">HOME</a>")
										.append( SPAN_ARROW )
										.append( this.removeTagWithBeyondBR( jqNav.eq(iMenu1-1).children("a").clone() ) );						
						if( iHintLen > 3 ){
							jqOneDepth
								.append( SPAN_ARROW )
								.append( jqNav_innerList.children("a").eq(iMenu2-1).clone() )		
								.append( SPAN_ARROW )
								.append( jqNav_innerList.eq(iMenu2-1)
										.children("ul")
										.children("li")
										.children("a").eq(iMenu3-1).clone() )
								.append( SPAN_ARROW )
								.append( jqNav_innerList.eq(iMenu2-1)
										.children("ul")
										.children("li").eq(iMenu3-1)
										.children("ul")
										.children("li")
										.children("a").eq(iMenu4-1).clone() );
						} else if(iHintLen === 3){
							jqOneDepth
								.append( SPAN_ARROW )
								.append( jqNav_innerList.children("a").eq(iMenu2-1).clone() )
								.append( SPAN_ARROW )
								.append( jqNav_innerList.eq(iMenu2-1)
										.children("ul")
										.children("li")
										.children("a").eq(iMenu3-1).clone() );
						} else if(iHintLen === 2){
							jqOneDepth
								.append( SPAN_ARROW )
								.append( jqNav_innerList.children("a").eq(iMenu2-1).clone() );
						}				
					}
				}				
				
				if(sTarget === "left") {
					if( ((sHintValue !== "") || (sHintValue !== null)) && (sHintValue.charAt(0) !== "*") ){
						jqOneDepth = jqBreadCrumbs.append("<span class=\"artn-icon-16 home\">⊙</span><a href=\"/\">HOME</a>")
											.append( SPAN_ARROW )
											.append( $("div.nav.left-menu h3").children("a").clone() )																					
										;
						if( iHintLen > 3 ){
							jqOneDepth.append( SPAN_ARROW )
									.append(jqLeftMenu.eq(iMenu2-1).children("a").clone())
									.append( SPAN_ARROW )
									.append(jqLeftMenu.eq(iMenu2-1)
											.children("ul")
											.children("li").eq(iMenu3-1)
											.children("a").clone() )
									.append( SPAN_ARROW )
									.append( jqLeftMenu.eq(iMenu2-1)
											.children("ul")
											.children("li").eq(iMenu3-1)
											.children("ul")
											.children("li")
											.children("a").eq(iMenu4-1).clone() );							
						} else if( iHintLen === 3 ){
							jqOneDepth.append( SPAN_ARROW )
									.append(jqLeftMenu.eq(iMenu2-1).children("a").clone())
									.append( SPAN_ARROW )
									.append(jqLeftMenu.eq(iMenu2-1)
											.children("ul")
											.children("li").eq(iMenu3-1)
											.children("a").clone() );
						} else if( iHintLen === 2 ){							
							jqOneDepth.append( SPAN_ARROW )
								.append(jqLeftMenu.eq(iMenu2-1).children("a").clone());							
						}
					} 
				}				
				
				if(sHintValue.charAt(0) === "*"){				
					jqOneDepth = jqBreadCrumbs.append("<span class=\"artn-icon-16 home\">⊙</span><a href=\"/\">HOME</a>");
					
					var saMenu = sHintValue.replace("*", "").split(",");				
					var sMenu1;
					var sMenu2;
					var sMenu3;
					var iMenuLen = saMenu.length; 
					
					sMenu1 = saMenu[0];		
					sMenu2 = saMenu[1];
					sMenu3 = saMenu[2];
					
					if(iMenuLen === 1){
						jqOneDepth
							.append( SPAN_ARROW )
							.append( sMenu1 );
					} else if(iMenuLen === 2) {
						jqOneDepth
							.append( SPAN_ARROW )
							.append( sMenu1 )
							.append( SPAN_ARROW )
							.append( sMenu2 );
					} else if(iMenuLen === 3){
						jqOneDepth
							.append( SPAN_ARROW )
							.append( sMenu1 )
							.append( SPAN_ARROW )
							.append( sMenu2 )
							.append( SPAN_ARROW )
							.append( sMenu3 );
					}

				}
			} catch(e){}			
		},
		// 메뉴 내 BR 태그가 속해있을 경우 그 태그와 함께 뒷부분 제거 및 각종 태그도 삭제 하는 기능 추가. - 2013.09.03 by jhson
		// BreadCrumbs가 없을 경우 오류나는 것 수정, IE8에서 수행 안되는 문제 수정 - 2013.09.03 by jhson
		/**
		 * jQuery DOM 내부에 BR 태그가 있을 경우 그것과 그 뒷부분을 모두 제거 하고 반환 해 준다.
		 * @param {jQuery} jqElem 작업할 jQuery 객체.
		 * @return {jQuery}
		 */
		removeTagWithBeyondBR : function( jqElem ){
			var sValue = jqElem.html();
			var indexBr;
			
			try{
				indexBr = sValue.toLowerCase().indexOf( "<br" );
				
				if(indexBr < 0){
					return jqElem;
				}
				sValue = sValue.substring( 0, indexBr );
				sValue = sValue.replace( /<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "" );
				jqElem.html( sValue );
			}
			catch(e){}
			
			return jqElem;
		},
		/**
		 * @ignore
		 * 쓰이지 않음
		 */
		createDepthOneNode : function(jqBreadCrumbs){
			return 
			jqBreadCrumbs.append("<span class=\"artn-icon-16 home\">⊙</span><a href=\"/\">HOME</a>")
				.append( SPAN_ARROW )
				.append( $("div.nav.left-menu h3").text() )
				.append( SPAN_ARROW )
				.append(jqLeftMenu.eq(iMenu2-1).children("a").clone());
		}
};

/**
 * 메뉴 선택기를 생성한다.<br/>
 * 메뉴 선택기는 #menu_selector 혹은 .menu_selector 의 data-sub 속성값(컨텐츠 코드)을 이용하여 GNB와 좌측메뉴에 .selected 클래스를 추가하여
 * 현재 보이는 페이지가 메뉴 중 어디에 속해 있는지 보여주는 역할을 한다.
 * 
 * @class
 */
Artn.MenuSelector = {  
		/**
		 * 메뉴 선택기를 생성한다.
		 */
		create : function(){
			var jqMenuSelector = $("#menu_selector, .menu_selector");
			// input 을 이용, 별도로 분리된 값을 이용하기 보단 HTML5의 data- attribute를 활용하는 것이 좋을 것 같아 변경 함. - 2013.08.28 by jhson
			//var sHintValue = $( jqBreadCrumbs.eq(0).data("subkey") || "#subkey" ).val();
			var sHintValue = jqMenuSelector.eq(0).data("sub");
			var saHintValue = (sHintValue)? sHintValue.substr( 3, sHintValue.length).split("_") : [];			
			var iHintLen = saHintValue.length;			
			//yyj 수정
			var jqLeftMenu = $("div.nav.left-menu > div > ul > li");
			/*var jqLeftMenu = $("div.nav.left-menu > ul > li");*/
			var jqTopMenu = $("div.nav.top.gnb > ul > li");
			
			var iMenu1 = 0;
			var iMenu2 = 0;
			var iMenu3 = 0;
			var iMenu4 = 0;
			
			try {
				iMenu1 = parseInt( saHintValue[0] );
				iMenu2 = parseInt( saHintValue[1] );
				iMenu3 = parseInt( saHintValue[2] );
				iMenu4 = parseInt( saHintValue[3] );
			} catch(e){}			
			
			try{
				if(iHintLen === 3) {
					jqLeftMenu.eq(iMenu2-1)
						.children("a").addClass("selected");
					jqLeftMenu.eq(iMenu2-1)
						.children("ul")
						.children("li").eq(iMenu3-1)
						.children("a").addClass("selected");					
				} else if(iHintLen === 2){
					jqLeftMenu
						.children("a").eq(iMenu2-1).addClass("selected");					
				}
			} catch(e){}
			
			try{			
				jqTopMenu.eq(iMenu1-1).addClass("selected");
			} catch(e){}
			
			
		}
};

/**
 * <h4>GNB를 생성한다.</h4>
 * 생성된 GNB는 태그 내 data-* attribute에 따라 다음과 같이 적용된다.
 * <table>
<thead style="background-color: #f80;">
<tr>
<td>attr.</td>
<td>type</td>
<td>desc.</td>
</tr>
</thead>
<tbody>
<tr>
<td>data-type</td>
<td><strong>vertical</strong> | horizon | all | wide</td>
<td>
GNB의 각 메뉴들의 하위메뉴가 사용자의 마우스 오버될 때 보여지는 형식에 대하여 정의 한다.
<ul>
<li>vertical : 세로로 표현된다.</li>
<li>horizon : 가로로 표현 된다.</li>
<li>all : 웹 페이지를 덮을 정도로 큰 box가 나타나 이 곳에 전체 하위 목록이 나열된다.</li>
<li>wide : 메뉴바를 기준, 모든 하위 메뉴가 아래로 펼쳐져 표현되며 그 영역은 화면 좌측 끝에서 우측 끝까지 연결 된다.</li>
</ul>
</td>
</tr>
<tr>
<td>data-depth</td>
<td>Integer | <strong>1</strong></td>
<td>하위 메뉴의 깊이(depth)를 설정한다.</td>
</tr>
<tr>
<td>data-animate</td>
<td><strong>normal</strong> | slide | fade</td>
<td>하위 메뉴의 애니메이션을 설정 한다.</td>
</tr>
</tbody>
</table>
 * @class
 */
Artn.GlobalNav = {
	/**
	 * @ignore
	 */
	inst : null,
	/**
	 * GNB 생성을 수행한다.
	 */
	create : function(){
		this.inst = new artn.lib.GlobalNav().init(".gnb");
	}
};

/**
 * <h4>이미지 스크롤러를 생성한다.</h4>
 * 스크롤러는 다음과 같은 data-* 속성에 따라 다르게 적용 된다.
<table>
<thead style="background-color: #f80;">
<tr>
<td>attr.</td>
<td>type</td>
<td>desc.</td>
</tr>
</thead>
<tbody>
<tr>
<td>data-type</td>
<td><strong>slide</strong> | banner</td>
<td>
슬라이더의 애니메이션 형태를 설정 한다.
<ul>
<li>slide: fade-out 되었다가 다음 이미지에서 fade-in 이 된다. 이 과정을 반복.</li>
<li>banner: 우측에서 좌측으로 이미지가 움직인다.</li>
</ul>
</td>
</tr>
<tr>
<td>data-auto</td>
<td><strong>on</strong> | off</td>
<td>스크롤러를 자동으로 재생할지의 여부 설정.</td>
</tr>
<tr>
<td>data-time</td>
<td>milisecond | <strong>5000</strong></td>
<td>다음 이미지로 변환되는 시간.</td>
</tr>
<tr>
<td>data-speed</td>
<td>milisecond | <strong>normal</strong></td>
<td>date-type="slide" 일 때 수행. fade-out/in 될 때의 속도를 설정 한다.</td>
</tr>
<tr>
<td>data-imgWidth</td>
<td>pixel | <strong>234</strong></td>
<td>슬라이더가 보여주는 이미지의 가로 크기.</td>
</tr>
</tbody>
</table>
 * @class
 */
Artn.Scroller = {
	inst : null,
	/**
	 * 스크롤러를 만든다.
	 * @param {String} strSelector 스크롤러로 만들 곳에 대한 선택자.
	 */
	create : function(strSelector){
		if (strSelector !== undefined){
			return this.inst[strSelector] = new artn.lib.Scroller().init(strSelector);
		}
		else{
			$("*[id^='scroller']").each(function(index){
				var scroller = new artn.lib.Scroller().init( $(this) );
			});
		}
	}
		
};

/**
 * Artn Board 를 사용 할 시 댓글(Comment) 달기 기능을 첨가 시킨다.<br/>
 * 이 때 사용되어질 문서구조가 자동으로 구성되므로 별도로 구성할 필요는 없다.<br/>
 * create 수행 시 다음과 같은 내용들을 등록 시킨다.
 * <ul>
 * <li>댓글 수정</li>
 * <li>댓글의 댓글 달기</li>
 * <li>댓글의 댓글 수정</li>
 * <li>댓글 수정 취소</li>
 * <li>댓글 삭제</li>
 * </ul>
 */
Artn.BoardComment = {
		/**
		 * @ignore
		 */
	inst: null,
	/**
	 * 댓글 달기 기능을 첨가 한다.
	 */
	create : function(){
		$(".comment-list .modify").click(function(){
			var jqThis = $(this);
			var jqCommentItem = jqThis.parentsUntil(".comment-item");
			var sContents = jqCommentItem.find(".comment-contents").html();
			
			sContents = Artn.Util.replaceAll( sContents, "<br/>", "\r\n" );
			sContents = Artn.Util.replaceAll( sContents, "<br>", "\r\n" );
			sContents = Artn.Util.replaceAll( sContents, "<BR>", "\r\n" );
			
			jqCommentItem.find("form.comment-modify textarea").val( sContents );
			$(".comment-list form.comment-modify, .comment-list .modify-cancel").hide();
			jqCommentItem.find("form.comment-modify, .modify-cancel").show();
			$(".comment-list .modify, .comment-list .comment-contents").show();
			jqCommentItem.find(".modify, .comment-contents").hide();
			
			return false;
		});
		$(".comment-list .reply").click(function(){
			var jqThis = $(this);
			var jqForm = $("form.comment-modify");
			var jqCommentItem = jqThis.parentsUntil(".comment-item");

			if( ($("input[name='id_user'").val() === undefined) && ($("input[name='user_name'").val() === undefined)  ){
				jqCommentItem.find("form.comment-modify").find("textarea[name='comment']")
														.before("<span>이름: </span><input type=\"hidden\" name=\"user_name\">")
														.before("<span>비밀번호: </span><input type=\"hidden\" name=\"password\">");
			}else {
				jqCommentItem.find("form.comment-modify").find("textarea[name='comment']").before("<input type=\"hidden\" name=\"id_user\" value=\""+$("input[name='id_user']").val()+"\">")
				.before("<input type=\"hidden\" name=\"user_name\" value=\""+$("input[name='user_name']").val()+"\">");
			}
			jqForm.attr("action", "commentReply");
			$(".comment-list form.comment-modify, .comment-list .modify-reply").hide();						
			jqCommentItem.find("form.comment-modify, .modify-reply").show();
			$(".comment-list .modify, .comment-list .comment-contents").show();			
			jqCommentItem.find(".reply").hide();
			
			return false;
		});
		
		$(".comment-list .modify-reply").click(function(){
			var jqThis = $(this);
			var jqCommentItem = jqThis.parentsUntil(".comment-item");

			jqCommentItem.find("form.comment-modify, .modify-reply").hide();
			jqCommentItem.find(".reply").show();
			
			return false;
		});
		
		$(".comment-list .modify-cancel").click(function(){
			var jqThis = $(this);
			var jqCommentItem = jqThis.parentsUntil(".comment-item");

			jqCommentItem.find("form.comment-modify, .modify-cancel").hide();
			jqCommentItem.find(".modify, .comment-contents").show();
			
			return false;
		});
		$(".comment-list .delete").click(function(){
			return confirm("정말 삭제 하시겠습니까?");
		});
		
		$("input[type='file']").change(function(e){
			$(this).parentsUntil("span").find("input[type='hidden'][name='" + $(this).attr("name") + "_exists']").val("");
		});
		
		/* 상기의 내용으로 변경되어 삭제 함 - 2013.09.05 by jhson
		$(".commentItem .comment_edit").click(function(){		
			var jqThis = $(this);
			var jqCommentItem = null;
			var jqCommentConmmentWrapForm = null;
			var jqButtonClickBefore = null;
			var jqCommentContents = null;		
			var jqCancel = null;
			var jqTextArea = null;
			//var sCommentContentsHTML = "";
			
			//console.log("aaa" + jqThis.parents(".commentItem").length);
			//jqCommentItem = jqThis.parents(".commentItem");
			//jqCommentContents = jqCommentItem.find(".comment_contents");
			//sCommentContentsHTML = jqCommentContents.html();
			//jqCommentContents.replaceWith("<input type=\"text\" name=\"comment\" size=\"70\" value=\"" + jqCommentContents.text() + "\"/>");				
			//jqCommentItem.find(".comment_delete").replaceWith("<a href=\"#\" class=\"comment_cancel\">취소</a>");
			//jqThis.replaceWith("<input type=\"submit\"/>");
			jqCommentItem = jqThis.parents(".commentItem");
			jqCommentConmmentWrapForm = jqCommentItem.find(".commentWrapForm");
			jqCommentContents = jqCommentItem.find(".comment_contents");
			jqButtonClickBefore = jqCommentItem.find(".before");
			jqButtonAround = $("#comment-area").find(".before");
			jqTextArea = jqCommentConmmentWrapForm.find("textarea[name='comment']");
			sComment = jqTextArea.text(); 
			
			//console.log(jqCommentConmmentWrapForm.find("textarea[name='comment']").text().replace("<br/>", "\r\n"));
			sCommentReplace = Artn.Util.replaceAll( sComment, "<br/>", "\r\n" );
			sCommentReplace = Artn.Util.replaceAll( sCommentReplace, "<br>", "\r\n" );
			
			jqTextArea.html(sCommentReplace);
			jqCommentConmmentWrapForm.show();
			jqCommentContents.hide(); 
			jqButtonClickBefore.hide();
			jqButtonAround.hide();
			
			jqCancel = $(".commentItem .comment_cancel");
			//jqCancel.data("beforeStructure", sCommentContentsHTML);		
			
			jqCancel.click(function(){
				//location.reload();
				jqCommentConmmentWrapForm.hide();			
				jqCommentContents.show();
				jqButtonClickBefore.show();
				jqButtonAround.show();
				return false;
			});
			return false;
		});
		*/
	}
};

/**
 * Artn Board 사용 시 게시판에 자료를 첨부하는 기능을 추가 한다.<br/>
 * 이 때 사용되어질 문서구조가 자동으로 구성되므로 별도로 구성할 필요는 없다.<br/>
 */
Artn.BoardAttach = {
	/**
	 * {jQuery} 파일첨부 컨트롤러 객체.
	 */
	_attachCtrl : null,
	/**
	 * {jQuery} 파일첨부 입력 객체. input[type='file']들의 모임이다.
	 */
	_fileButtons : null,
	/**
	 * {jQuery} 첨부된 파일들에 대한 목록.
	 */
	_fileList : null,
	/**
	 * @ignore
	 */
	inst : null,
	/**
	 * 파일 첨부 기능을 생성 한다.
	 */
	create : function(){
		var jqFileAttach = $("#fileAttachCtrl");
		var jqFileButtons = $(".file-attach-buttons");
		var jqClientFileList = $("#list_attachFilesClient");
		var jqServerFileList = $("#list_attachFilesServer");
		var iFileServerLen = jqServerFileList.find("li").length;
		
		this._attachCtrl = jqFileAttach;
		this._fileButtons = jqFileButtons;
		this._fileList = jqClientFileList;
		
		jqClientFileList.find("li").click(function(){
			var jqThis = $(this);
			var jqList = jqThis.siblings().not( jqThis );

			jqList.removeClass("selected");
			jqThis.toggleClass("selected");
		});
		
		jqFileAttach.find(".select-all").click(function(){
			Artn.BoardAttach._fileList.find("li").removeClass("selected").addClass("selected");
		});
		jqFileAttach.find(".select-none").click(function(){
			Artn.BoardAttach._fileList.find("li").removeClass("selected");
		});
		jqFileAttach.find(".del-file").click(function(){
			Artn.BoardAttach.deleteSelected();
		});
		jqFileAttach.find(".add-file").click(function(){
			Artn.BoardAttach.addFileInput();
		});
		
		jqServerFileList.find(".delete-attach").click(function(){
			var isConfirmed = confirm("정말 삭제 하시겠습니까?");
			var jqThis = $(this);
			
			if (isConfirmed == true){
				Artn.Ajax.BoardAttach = {
					deleteTarget : jqThis	
				};
				$.get( jqThis.attr("href"), {server_file_size: $("input[name='server_file_size']").val()}, function(data){
					var saData = data.split("|");
					var iCode = parseInt( saData[0] );
					
					if (iCode === 1){
						var jqTarget = Artn.Ajax.BoardAttach.deleteTarget;
						var jqServerFileSize = $("input[name='server_file_size']");
						var iSize = parseInt( jqServerFileSize.val() );
						
						iSize = iSize - 1;
						jqServerFileSize.val( iSize );
						jqServerFileSize.siblings("input[name='status']").val( (iSize > 0)? 0x8 : 0 );
						
						jqTarget.parents("li").remove();
						
					}
					alert( saData[1] );
				});
			}
			
			return false;
		});
		
		jqClientFileList.before(
			"<input type=\"hidden\" name=\"status\" value=\"0\"/>"
		);
		jqServerFileList.before(
			"<input type=\"hidden\" name=\"server_file_size\" value=\"" + iFileServerLen + "\"/>" +
			"<input type=\"hidden\" name=\"status\" value=\"" + ( (iFileServerLen > 0)? 0x8 : 0 ) + "\"/>"
		);

		this.addFileInput();
	},
	/**
	 * 파일 첨부 목록을 추가 한다.
	 * @param {String} sFileName 추가할 파일명
	 */
	addItem : function(sFileName){
		var jqClientFileList = this._fileList;
		
		jqClientFileList.append("<li>" + sFileName + "</li>");
		jqClientFileList.find("li:last-child").click(function(){
			var jqThis = $(this);
			var jqList = jqThis.siblings().not( jqThis );

			jqList.removeClass("selected");
			jqThis.toggleClass("selected");
		});
		
		jqClientFileList.siblings("input[name='status']").val( 0x8 );
	},
	/**
	 * 파일 첨부 목록에서 인덱스에 해당되는 목록을 삭제 한다.
	 * @param {Integer} index 삭제할 목록 내 인덱스.
	 */
	deleteItem : function(index){
		var jqClientFileList = this._fileList;
		var jqFileButtons = this._fileButtons;
		var iFileLen = 0;
		
		jqClientFileList.find("li").eq(index).remove();
		jqFileButtons.find("input[type='file']").eq(index).remove();
		iFileLen = jqClientFileList.find("li").length;
		
		if (iFileLen === 0){
			jqClientFileList.siblings("input[name='status']").val( 0 );
		}
	},
	/**
	 * 파일 첨부 목록 중 사용자에 의해 선택된 것을 삭제 한다.
	 */
	deleteSelected : function(){
		var jqClientFileList = this._fileList;
		var iLen = jqClientFileList.find("li.selected").length;
		var index = 0;
		
		for(var i = 0; i < iLen; i++){
			index = jqClientFileList.find("li.selected").prevAll().length;
			this.deleteItem( index );
		}
	},
	/**
	 * 파일 첨부 목록 상단에 input[type='file'] 요소를 추가 한다.
	 */
	addFileInput : function(){
		var jqFileButtons = this._fileButtons;
		
		jqFileButtons.append("<input type=\"file\" name=\"file_name\"/>");
		jqFileButtons.find("input[type='file']").change(function(e){
			var sFakePath = $(this).val();
			var saFakePath = null;
			var sFileName = "";
			
			if (sFakePath.indexOf(":\\") >= 0){
				saFakePath = sFakePath.split("\\");
			}
			else{
				saFakePath = sFakePath.split("/");
			}
			sFileName = saFakePath[ saFakePath.length - 1 ];
			
			Artn.BoardAttach.addItem( sFileName );
			
			$(this).hide();
			$(this).attr("filename", sFileName);
			
			Artn.BoardAttach.addFileInput();
		});
		
//		var sName = jqClientFileList.data("name");
//		
//		jqClientFileList.append("<li><input type=\"file\" name=\"" + sName + "\"/> <a href=\"#\" class=\"delete\">삭제</a></li>");
//		jqClientFileList.find("li:last-child input[name='" + sName + "']").change({clientList: jqClientFileList}, function(e){
//			$(this).parentsUntil
//			Artn.BoardAttach.addFileInput();
//		});
	}
};
/* 게시판 관리 페이지 : 2013.09.30 by thkim [시작]*/
/**
 * @ignore
 */
Artn.BoardManager = {
	inst : null,
	create : function(){
		$("#button_boardManager_addRow").click(function(){
			iBoardNo = ( parseInt($(".board-manager tr:last-child td").eq(0).text()) + 1 );
			
    		$(".board-manager tbody").append("<tr><td class=\"no\">" + iBoardNo + "<input type=\"hidden\" name=\"boardNo\" value=\"" + iBoardNo + "\"/></td>" +
    											"<td><input type=\"text\" name=\"name\"/></td>" +
    											"<td></td>" +				
    											"<td><input type=\"text\" name=\"contentsCode\"/></td>" +
    											"<td></td>" +
    											"<td></td>" +
    											"<td></td>" +
    											"<td></td>" +
    											"<td></td></tr>"
    		);
    		jqLastTd = $(".board-manager tr:last-child td"); 
    		jqLastTd.eq(2).append($(".board-manager select[name='view']").eq(0).clone().val(""));
    		jqLastTd.eq(4).append($(".board-manager select[name='authList']").eq(0).clone().val(0));
    		jqLastTd.eq(5).append($(".board-manager select[name='authShow']").eq(0).clone().val(0));
    		jqLastTd.eq(6).append($(".board-manager select[name='authModify']").eq(0).clone().val(0));
    		jqLastTd.eq(7).append($(".board-manager select[name='authDelete']").eq(0).clone().val(0));
    		jqLastTd.eq(8).append($(".board-manager select[name='rowLimit']").eq(0).clone().val(10));
    		
    		return false;
    	});
		
		$("#button_boardManager_modify").click(function(){
			var bModify_confirm = confirm("수정 하시겠습니까?");
			if(bModify_confirm == true){
				return;
			} else{
				return false;
			}
		});
	} 
};
/* 게시판 관리 페이지 : 2013.09.30 by thkim [종료]*/
/**
 * @ignore
 */
Artn.Product = {
		inst : null,
		create : function(strSelector){
			if (strSelector !== undefined){
				return this.inst[strSelector] = new artn.Product().init(strSelector);
			}
			else{
				$("*[id^='shop']").each(function(index){
					var product = new artn.Product().init( $(this) );
				});
			}
		}
		
};
/**
 * @ignore
 */
Artn.Rating = {
		inst : null,
		create : function(strSelector){
			if (strSelector !== undefined){
				return this.inst[strSelector] = new artn.lib.Rating().init(strSelector);
			}
			else{
				$("*[id^='rating']").each(function(index){
					var rating = new artn.lib.Rating().init( $(this) );
				});
			}
		}
}
/* Framework Initialize */
$(document).ready(function(){
	Artn.Environment.create();
	Artn.GlobalNav.create();
	Artn.TabContents.create();
	Artn.Validation.create();
	Artn.OutsideEvent.create();
	Artn.CommonUI.create();
	Artn.List.create();
	Artn.InfiniteList.create();
	Artn.SortableList.create();
	Artn.AutoComplete.create();
	Artn.AsyncForm.create();
	Artn.AsyncSearch.create();
	Artn.BreadCrumbs.create();
	Artn.Scroller.create();
	Artn.BoardComment.create();
	Artn.BoardAttach.create();
	Artn.BoardManager.create();
	Artn.ComboBoxChain.create();
	Artn.Rating.create();
	Artn.Product.create();
	Artn.MenuSelector.create();	
});

// 숫자에 3자리마다 콤마(,) 찍어주기
// 출처 : 스토브 훌로구
// URL : http://stove99.tistory.com/113
(function(){
	// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
	Number.prototype.format = function(){
	    if(this==0) return 0;
	 
	    var reg = /(^[+-]?\d+)(\d{3})/;
	    var n = (this + '');
	 
	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	 
	    return n;
	};
	 
	// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
	String.prototype.format = function(){
	    var num = parseFloat(this);
	    if( isNaN(num) ) return "0";
	 
	    return num.format();
	};
})();

// 웹노트 설정 부분 추가 - 2013.09.11 by jhson
webnote_config = {
	attach_proc:		"/ajaxUpload.action",		// 현재 쓰이는 업로드 컨트롤러로 연결 함 - 2013.09.11 by jhson
	image_center:		"/common/error.jsp"			// 현재 이미지 센터는 지원되지 않으므로 오류 페이지로 이동시킴 - 2013.10.16 by jhson
	/*
	base_dir:			"/webnote",								//웹노트 설치디렉토리를 직접 지정
	css_url:			"/webnote/webnote.css",					//기본 css 파일을 직접 지정
	icon_dir:			"/webnote/icon",						//기본 아이콘 디렉토리를 직접 지정
	emoticon_dir:		"/webnote/emoticon",					//기본 이모티콘 디렉토리를 직접 지정
	attach_proc:		"/webnote/webnote_attach.php",			//이미지 업로드를 처리하는 서버스크립트를 직접 지정
	image_center:		"/webnote/webnote_image_center.php",	//이미지센터를 다른 파일로 사용할 때
	use_blind:			true,									//팝업메뉴 출력 시 팝업 외에 다른 곳을 클릭 시 팝업이 닫히도록 반투명 배경 스크린 사용여부(true:사용(기본), false: 미사용)
	allow_dndupload:	true,									//드래그&드롭을 통한 이미지 파일 업로드 허용 여부
	allow_dndresize:	true,									//드래그&드롭을 통한 에디터 사이즈(높이) 조절 허용 여부

	fonts: ["굴림체","궁서체"],						//선택할 수 있는 폰트종류를 직접 정의
	fontsizes: ["9pt","10pt"],						//선택할 수 있는 폰트사이즈를 직접 정의(단위포함)
	lineheights: ["120%","150%","180%"],			//선택할 수 있는 줄간격을 직접 정의(단위포함)
	emoticons: ["smile","cry"],						//선택할 수 있는 이모티콘들을 직접 정의(png 확장자파일만 가능하며, 확장자를 제외한 파일명만 나열)
	specialchars: ["§","☆]							//선택할 수 있는 특수문자를 직접 정의
	*/
};