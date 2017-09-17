/**
 * Arotechno Framework
 * (Validation Check)
 * @author jhson
 * @since 2013.06.05
 * @version 1.0 
 */


/**
* 폼엘리먼트의 value 가 변화되면 keyup 이벤트 발생시키기
*
* @author hooriza at nhncorp.com
* @version 0.1
*
* @created Nov.8.2007.
*/
var Observe=function(e){this._o=e,this._value=e.value,this._bindEvents()};Observe.prototype._bindEvents=function(){var e=this,t=function(e,t,n){e.attachEvent?e.attachEvent("on"+t,n):e.addEventListener(t,n,!1)};t(this._o,"focus",function(){e._timer&&clearInterval(e._timer),e._timer=setInterval(function(){e._value!=e._o.value&&(e._value=e._o.value,e._fireEvent())},50)}),t(this._o,"blur",function(){e._timer&&clearInterval(e._timer),e._timer=null})},Observe.prototype._fireEvent=function(){if(document.createEvent){var e;window.KeyEvent?(e=document.createEvent("KeyEvents"),e.initKeyEvent("keyup",!0,!0,window,!1,!1,!1,!1,65,0)):(e=document.createEvent("UIEvents"),e.initUIEvent("keyup",!0,!0,window,1),e.keyCode=65),this._o.dispatchEvent(e)}else{var e=document.createEventObject();e.keyCode=65,this._o.fireEvent("onkeyup",e)}};
var Artn = Artn || {};

Artn.Validation = {
	_regex : {
		kor : {
			test : /^[ㄱ-ㅎㅃㅉㄸㄲ가-힣0-9\s]{0,}$/,
			match : /[ㄱ-ㅎㅃㅉㄸㄲ가-힣0-9\s]{0,}/
		},
		eng : {
			test : /^[A-z0-9\s\.]{0,}$/,
			match : /[A-z0-9\s\.]{0,}/
		},
		"id" : {
			test : /^[a-z0-9]{0,}[\-\_\.]{0,1}[a-z0-9]{0,}$/,
			match : /[a-z0-9]{0,}[\-\_\.]{0,1}[a-z0-9]{0,}/
		},
		num : {
			test : /^[0-9]{0,}$/,
			match : /[0-9]{0,}/
		},
		dec : {
			test : /^[-]?[0-9]{0,}[\.]{0,1}[0-9]{0,}$/,
			match : /^[-]?[0-9]{1,}[\.]{0,1}[0-9]{0,}/
		}
	},
	_message : {
		showed : 0,
		required : "필수 입니다.",
		required_group : "좌측의 모든 입력란은 필수 입니다.",
		password : "비밀번호가 일치하지 않습니다.",
		kor : "한글만 가능합니다. 한/영 전환 상태를 확인하세요.",
		eng : "영문과 숫자, 공백만 가능합니다.",
		"id" : "영문 소문자와 숫자와 특수기호 1개만 쓸 수 있으며, 특수기호는 바(-), 언더바(_), 마침표(.)만 가능합니다.",
		num : "숫자만 가능합니다.",
		dec : "숫자 혹은 실수만 가능합니다.",
		emailTitle1 : "이메일 주소의 앞부분을 적어주세요.",
		emailTitle2 : "이메일 주소의 뒷부분을 적어주세요.",
		emailTitle3 : "이메일 주소의 뒷부분을 선택하세요.",
		phoneTitle1 : "전화번호의 앞부분을 적어주세요.",
		phoneTitle2 : "전화번호의 뒷부분을 적어주세요.",
		minlen : TrimPath.parseTemplate( "최소 ${minlen}자 이상 작성 하여야 합니다." ),
		userId : "사용 가능한 ID 입니다.",
		userIdNot : "이미 존재하는 ID 입니다.",
		userIdAlert : "사용 가능 여부를 다시 확인하십시요.",
		mixEngNum : "숫자와 영문을 반드시 조합하여 주십시요."
	},
	_title : {
		"id" : "ID를 입력 하세요.",
		password : "비밀번호를 입력 하세요."
	},
	_ajaxCurr : null,
	
	create : function(){
		$("*[id^='datepicker_']").attr("readonly", "readonly").datepicker({
			dateFormat: "yy-mm-dd"
		}).each(function(index){
			var year = $(this).data("year");
			var maxYear = $(this).data("max-year");
			
			if (maxYear){
				maxYear = new Date().getFullYear() + maxYear;
			}
			else{
				maxYear = new Date().getFullYear();
			}
			
			if (year){
				$(this).datepicker("option", {
					changeYear: true,
					changeMonth: true,
					yearRange: year + ":" + maxYear
				});
			}
		});

	    $("form.break-enter").bind("keypress", function(event){
	    	return ( event.keyCode !== 13 );
	    });
		
		$("form.validator").find("input[type!='hidden'][type!='submit'], select, textarea, .valid-group").each(function(index){
			var jqInput = $(this);
			var sRule = $(this).data("rule");

			if (sRule){
				try{
					Artn.Validation["regist_" + sRule ]( jqInput );
				}
				catch(e){
					try{console.log(e.toString() + ":" + sRule);}
					catch(e){}
				}
			}
			else if ( this.type === "button" ){
				return;
			}
			else if ( this.type === "password" ){
				Artn.Validation.regist_password( jqInput );
			}
			else if ( (this.type === "checkbox") || (this.type === "radio") ){
				
			}
			else if ( this.tagName === "INPUT"){
				jqInput.focusout(function(e){
					Artn.Validation.showMessage( $(this), "" );
				});
			}
			else if ( this.tagName === "SELECT" ){
				Artn.Validation.regist_select( this );
			}
			
			//Artn.Validation.registTooltip( jqInput );
		});

		$("*[data-rule='comboChain']").each(function(index){
			var jqSelect = $(this).find("select");
			jqSelect.change({to: jqSelect.parent().data("to"), url: jqSelect.parent().data("url"), keys: jqSelect.parent().data("keys")}, function(e){
				var sTo = e.data.to;
				var sUrl = e.data.url;
				var sKeys = e.data.keys;
				var jqSelect = $(this);
				var sName = jqSelect.attr("name");
				var mParams = {};
				mParams[ sName ] = jqSelect.val();
				mParams[ "keys" ] = sKeys;
				Artn.Ajax.data = e.data;
				$.extend(Artn.Ajax.data, {
					jqFrom: jqSelect,
					jqTo: $(sTo)
				});
				$.getJSON(sUrl, mParams, function(data){
					var saKeys = Artn.Ajax.data.keys.split(",");
					var template = TrimPath.parseTemplate( "<option value=\"${" + saKeys[0] + "}\">${" + saKeys[1] + "}</option>" );
					var iLen = data.length;
					Artn.Ajax.data.jqTo.empty();
					for(var i = 0; i < iLen; i++){
						Artn.Ajax.data.jqTo.append( template.process( data[i] ) );
					}
				});
			});
		});
		
		$("textarea[maxlength]").each(function(index){
			Artn.Validation.regist_textarea( $(this) );
		});
		
		$("form.validator").find("input[data-mixEngNum='true']").focusout(function(e){
			Artn.Validation.checkMixEngNum( $(this) );
		});
		
		//좌표 찾기 기능의 변경으로 새로 추가 함 - 2013.09.01 by shkang
	    //좌표 찾기 - execute 에서 뽑아 옴 - 2013.09.24 by jhson
	    $("input[name='map_button']").click(function(){
	        window.open( Artn.Const.MAP_COORD, "_blank", "width=600, height=500" );
	    });

		$("form.validator").submit( this.onsubmit );
		
		this.registBreakEnter();
	},
	
	check : function(index, jqElem){
		//var elemForm = ( (e.data) && (e.data.form !== undefined) )? e.data.form : this;
		var jqForm = (jqElem || $("form.validator").eq( index || 0 ));
		var bOK = this.checkRequired( jqForm );
		

		bOK = this.checkMinLength( jqForm ) && bOK;
		bOK = this.checkMixEngNum( jqForm ) && bOK;
		
		jqForm.find("textarea[maxlength]").each(function(index){
			var jqText = $(this);
			var iMaxLen = parseInt( jqText.attr("maxlength") );
			var isOverLen = parseInt( $("#__" + jqText.attr("name") + "_counter_hdn").val() ) > iMaxLen;

			bOK = bOK && (isOverLen === false);
		});
		
		this.checkHeightRemove( jqForm );

		return bOK;
	},

	onsubmit : function(e){
		return Artn.Validation.check(0, $(this));
	},
	
	checkValidByKey : function(strKey, jqInput){
		if (this._regex[ strKey ].test.test( jqInput.val() ) === false){
			var saMatchRet = jqInput.val().match( this._regex[ strKey ].match );
			var iLen = (saMatchRet)? saMatchRet.length : 0;
			var sValue = "";
			
			for(var i = 0; i < iLen; i++){
				sValue += saMatchRet[ i ];
			}
			jqInput.val( sValue );
			
			//this.showTooltip( jqInput, this._message[ strKey ] );
			this._message.showed = 2;
			return false;
		}
		else if (this._message.showed > 0){
			this._message.showed--;
			return true;
		}
		//this.showTooltip( jqInput, "" );
		this.showMessage( jqInput, "" );
		return true;
	},
	isKor : function(jqInput){ return this.checkValidByKey("kor", jqInput); },
	isEng : function(jqInput){ return this.checkValidByKey("eng", jqInput); },
	isId  : function(jqInput){ return this.checkValidByKey("id",  jqInput); },
	isNum : function(jqInput){ return this.checkValidByKey("num", jqInput); },
	isDec : function(jqInput){ return this.checkValidByKey("dec", jqInput); },

	
	showMessage : function(jqElem, strMsg){
		var jqValidMsg = null;
		
		if (jqElem.parent().hasClass("valid-group") === true){
			jqElem = jqElem.parent();
		}
		
		jqValidMsg = jqElem.nextAll(".valid-msg");
		
		if ( jqValidMsg.length === 0 ){
			jqValidMsg = jqElem.after("<span class=\"valid-msg\">" + strMsg + "</span>");
		}
		else{
			jqValidMsg.html( strMsg );
		}
	},
	showTooltip : function(jqElem, strMsg){
		if (Artn.Environment.isMobile() === false){
			return;
		}
		if ( (strMsg !== "")){
			jqElem.tooltip("option", "content", strMsg);
			jqElem.tooltip("open");
		}
		else{
			jqElem.tooltip("option", "content", jqElem.data("title") );
		}
	},
	createHiddenChecked : function(jqElem){
		$( Artn.Util.createHidden( "__" + jqElem.attr("name") + "_checked", "true" ) ).insertBefore( jqElem );
	},
	removeHiddenChecked : function(jqElem){
		jqElem.siblings("input[name='__" + jqElem.attr("name") + "_checked']").remove();
	},
	isHiddenChecked : function(jqElem){
		return jqElem.siblings("input[name='__" + jqElem.attr("name") + "_checked']").length > 0;
	},
	registTooltip : function( jqInput ){
		jqInput.data("title", jqInput.get(0).title);
		jqInput.tooltip({
			position: {
				my: "right-20 middle",
				at: "left middle"
				/*my: "center bottom-10",
				at: "center top"*/
			},
			close : function(event, ui){
				
			}
		});
		jqInput.blur(function(e){
			$(this).tooltip("close");
		});
	},
	registBreakEnter : function(){
		$("form.break-enter").bind("keypress", function(event){
	    	return ( event.keyCode !== 13 );
	    });
	},
	
	checkPassword : function(){
		var iMinLen = 6;
		$("input[type='password']").each(function(index){
			iMinLen = parseInt( $(this).data("minlen") || iMinLen );
			
		});
	},
	checkRequired : function(elemForm){
		var jqForm = $(elemForm);
		var bOK = true;
		var mbRadio = {};

		jqForm.find("*[required='required']").each(function(index){
			var jqInput = $(this);
			
			if ( jqInput.val() === "" ){
				Artn.Validation.showMessage( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
		});
		
		jqForm.find("input[data-rule='id']").each(function(index){
			var jqInput = $(this);
			
			if ( jqInput.val() === "" ){
				Artn.Validation.showMessage( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
			
			if ( bOK && ( jqInput.data("url") !== undefined ) ){
				if ( Artn.Validation.isHiddenChecked( jqInput ) === false ){
					Artn.Validation.showMessage( jqInput, Artn.Validation._message.userIdAlert );
					bOK = false;
				}
			}
		});
		
		jqForm.find("input[type='password']").each(function(index){
			var jqPw = $(this);
			var jqPwRe = jqForm.find("input[name='" + jqPw.attr("name") + "re']");
			var jqPwOld = jqForm.find("input[name='" + jqPw.attr("name") + "old']");
			
			if ((jqPwOld.length === 0) ||
				((jqPwOld.length === 1) && (jqPwOld.val() !== ""))
				){
				if (jqPwRe.length === 1){
					if (jqPw.val() !== jqPwRe.val()){
						Artn.Validation.showMessage( jqPwRe, Artn.Validation._message.password );
						bOK = false;
					}
				}
			}
			
		});
		
		jqForm.find("*[data-required='required']").each(function(index){
			var jqValidGroup = $(this);
			var sRule = jqValidGroup.data("rule");
			var bOKGroup = false;
			
			if ((sRule === "email") || (sRule === "phone")) {
				bOKGroup = Artn.Validation.checkTextboxGroup( jqValidGroup );
				
				if (bOKGroup === false){
					Artn.Validation.showMessage( jqValidGroup, Artn.Validation._message.required_group );
					bOK = false;
				}
			}
			else if (sRule === "survey"){
				var jqChildLast = jqValidGroup.children().not(".valid-msg").last();
				
				if (jqValidGroup.find("input[type='radio']:checked").length === 0){
					Artn.Validation.showMessage( jqChildLast, Artn.Validation._message.required );
					bOK = false;
				}
				else{
					Artn.Validation.showMessage( jqChildLast, "" );
				}
			}
		});
		
		jqForm.find("input[type='checkbox'][required='required']").each(function(index){
			var jqInput = $(this);

			if (jqInput.get(0).checked === false){
				//alert( " " + Artn.Validation._message.required );
				Artn.Validation.showMessage( $("label[for='" + jqInput.attr("id") + "']"), Artn.Validation._message.required );
				//Artn.Validation.showTooltip( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
			else{
				Artn.Validation.showMessage( $("label[for='" + jqInput.attr("id") + "']"), "" );
			}
		});
		
		// TODO: 라디오 버튼에 대한 필수 체크 기능 작성 할 것 - 2013.07.29 by jhson
//		jqForm.find("input[type='radio'][required='required']").each(function(index){
//			var sName = $(this).attr("name");
//			
//			if ( mbRadio[sName] === undefined ){
//				mbRadio[sName] = true;
//			}
//		});
		
		jqForm.find("select[data-required]").each(function(index){
			if ( this.selectedIndex === 0 ){
				Artn.Validation.showMessage( $(this), Artn.Validation._message.required );
				bOK = false;
			}
		});
		
		return bOK;
	},
	checkTextboxGroup : function( jqValidGroup ){
		var jqTextList = jqValidGroup.find("input[type='text']");
		var bOK = true;
		var iLen = jqTextList.length;
		
		for(var i = 0; i < iLen; i++){
			if (jqTextList.eq( i ).val().length < 3 ){
				return false;
			}
		}
		
		return bOK;
	},
	
	checkMinLength : function( elemForm ){
		var jqForm = $( elemForm );
		var bOK = true;

		jqForm.find("input[data-minlen]").each(function(index){
			bOK = bOK && Artn.Validation.checkMinLengthSingle( $(this) );
		});
		
		return bOK;
	},
	checkMinLengthSingle : function( jqInput ){
		var iMinLen = parseInt( jqInput.data("minlen") );
		var iLen = jqInput.val().length;
		
		if ((iLen > 0) && (iLen < iMinLen)){
			Artn.Validation.showMessage( jqInput, Artn.Validation._message.minlen.process( {"minlen": iMinLen} ) );
			return false;
		}

		return true;
	},
	checkMixEngNum : function( jqElem ){
		var jqInput = $(jqElem);
		
		if (jqInput.prop("tagName").toLowerCase() === "form"){
			var bOK = true;
			
			if (jqInput.prop("tagName").toLowerCase() === "form"){
				jqInput.find("input[data-mixEngNum='true']").each(function(index){
					bOK = Artn.Validation.checkMixEngNum( $(this) ) && bOK;
				});
			}
			
			return bOK;
		}
		else{
			try{
				var regexAlphabet = new RegExp( "[A-z]", "i" );
				var regexNumeric = new RegExp( "\\d" );
				
				if (regexAlphabet.test( jqInput.val() ) && 
					regexNumeric.test( jqInput.val() )){
					Artn.Validation.showMessage( jqInput, "");
					return true;
				}
				else{
					alert( $("label[for='" + jqInput.attr("id") + "']").text() + " 항목(은)는 " + Artn.Validation._message.mixEngNum );
					//Artn.Validation.showMessage( jqInput, Artn.Validation._message.mixEngNum);
					return false;
				}
			}
			catch(e){
				try{console.log(e);}
				catch(e){}
			}
		}
	},
	checkHeightRemove : function( elemForm ){
//		var jqForm = $( elemForm );
//		
//		jqForm.find("textarea[data-height-remove]").each(function(index){
//			var jqTextarea = $( this );
//			var sText = jqTextarea.html();
//			
//			sText = sText.replace( /height=('|\")?[0-9]*('|\")?"/, "" );
//			jqTextarea.get(0).innerHTML = sText;
//		});
	},
	
	checkCheckbox : function( elemCheckbox ){
		
	},
	
	registKeyInput : function( jqInput, strArrKeys ){
		new Observe(jqInput.get(0));
		jqInput.keyup({keys: strArrKeys}, function(e){
			Artn.Validation.showMessage( $(this), this.value );
		});
	},
	registMultiLangKeyupEvent : function( jqInput ){
		var iLen = jqInput.length;
		
		if (iLen > 0){
			for (var i = 0; i < iLen; i++ ){
				new Observe( jqInput.get(i) );
			}
		}
	},
	// FIXME: Ajax로 JSON 데이터를 Single로 받아올 시 ID 중복 체크가 안됨 - 2013.07.30 by jhson
	regist_id : function( jqInput ){
		var sUrl = jqInput.data("url");
		var sTitle = jqInput.attr("title");
		
		if ( (sTitle === undefined) || (sTitle === "") ){
			jqInput.attr("title", this._title.id);
		}
		
		jqInput.keyup(function(e){
			//return Artn.Validation.isId( $(this) );
			$(this).val( $(this).val().toLowerCase() );
		});
		
		if ( (sUrl !== undefined) && (sUrl !== "") ){
			jqInput.focusout(function(e){
				var jqInput = $(this);
				
				Artn.Validation.removeHiddenChecked( jqInput );
				
				if ( Artn.Validation.checkMinLengthSingle( jqInput ) === false ) return;
				if ( jqInput.val().length === 0 ) return;
				
				
				jqInput.after( Artn.Const.AJAX_LOADING );
				Artn.Validation._ajaxCurr = jqInput;
				
				$.getJSON( jqInput.data("url"), {"id": jqInput.val()}, function(data){
					var jqInput = Artn.Validation._ajaxCurr;
					var sMsg = "";
					
					jqInput.next( Artn.Const.AJAX_LOADING_SMALL_CLASS ).remove();
					//console.log( data.length );
					
					if ( data.length !== undefined ){
						if ( data.length === 0 ){
							sMsg = Artn.Validation._message.userId;
							Artn.Validation.createHiddenChecked( jqInput );
						}
						else {
							sMsg = Artn.Validation._message.userIdNot;
						}
					}
					else{
						if ( data[ jqInput.attr( "name" ) ] === undefined ){
							sMsg = Artn.Validation._message.userId;
							Artn.Validation.createHiddenChecked( jqInput );
						}
						else {
							sMsg = Artn.Validation._message.userIdNot;
						}
					}
					
					Artn.Validation.showMessage( jqInput, sMsg );
				});
			});
		}
		
		//this.registMultiLangKeyupEvent( jqInput );
	},
	regist_kor : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isKor( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	regist_eng : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isEng( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
//	regist_lowerCase : function( jqInput ){
//		jqInput.keyup(function(e){
//			$(this).val( $(this).val().toLowerCase() );
//		});
//	},
	regist_num : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isNum( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	regist_dec : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isDec( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	regist_password : function( jqInput ){
		var jqFormParent = jqInput.parents("form");
		var jqPwRe = jqFormParent.find("input[name='" + jqInput.attr("name") + "re']");
		//var jqOtherPwInput = jqFormParent.find("input[id^='" + jqInput.get(0).id + "']");
		var sTitle = jqInput.attr("title");
		
		if ( (sTitle === undefined) || (sTitle === "") ){
			jqInput.attr("title", this._title.password);
		}
				
		if (jqPwRe.length === 1){
			jqInput.change({other: jqPwRe}, function(e){
				Artn.Validation.showMessage( $(this), "" );
				Artn.Validation.showMessage( e.data.other, "" );
			});
			jqPwRe.change({ori: jqInput}, function(e){
				var jqInput = e.data.ori;
				var jqThis = $(this);
				
				if ( jqThis.val() !== jqInput.val() ){
					Artn.Validation.showMessage( jqThis, Artn.Validation._message.password );
				}
				else if ( jqThis.val() !== "" ){
					Artn.Validation.showMessage( jqThis, "<span class=\"confirmed\">OK</span>" );
				}
				else{
					Artn.Validation.showMessage( jqThis, "" );
				}
			});
		}
		/*
		if (jqOtherPwInput.length === 2){
			jqOtherPwInput.eq(0).change({other: jqOtherPwInput.eq(1)}, function(e){
				Artn.Validation.showMessage( $(this), "" );
				Artn.Validation.showMessage( e.data.other, "" );
			});
			
			jqOtherPwInput.eq(1).change({ori: jqInput}, function(e){
				var jqInput = e.data.ori;
				if ( this.value !== jqInput.val() ){
					Artn.Validation.showMessage( $(this), Artn.Validation._message.password );
				}
				else if ( this.value !== "" ){
					Artn.Validation.showMessage( $(this), "<span class=\"confirmed\">OK</span>" );
				}
				else{
					Artn.Validation.showMessage( $(this), "" );
				}
			});
		}*/
	},
	
	regist_email : function( jqWrap ){
		var jqSelect = jqWrap.find("select");
		var jqEmailText = jqWrap.find("input[type='text']");
		
		jqEmailText.get(0).title = this._message.emailTitle1;
		jqEmailText.get(1).title = this._message.emailTitle2;
		//jqSelect.get(0).title = this._message.emailTitle3; - 익스 때문에 삭제함 -_-
		
		this.regist_id( jqEmailText.eq(0) );
		this.regist_eng( jqEmailText.eq(1) );
		
		if (jqSelect.val() !== "직접작성"){
			jqEmailText.eq(1).attr("readonly", true);
		}
		
		jqSelect.change({emailText: jqEmailText.eq(1)}, function(e){
			
			var jqSelect = $(this);
			var jqEmailText = e.data.emailText;
			
			if (jqSelect.val() === "직접작성"){
				jqEmailText.attr("readonly", false);
				jqEmailText.focus();
				jqEmailText.get(0).select();
			}
			else{
				jqEmailText.attr("readonly", true);
				jqEmailText.val( jqSelect.val() );
			}
			
		});
	},
	regist_phone : function( jqWrap ){
		var jqPhoneText = jqWrap.find("input[type='text']");
		
		jqPhoneText.get(0).title = this._message.phoneTitle1;
		jqPhoneText.get(1).title = this._message.phoneTitle2;
		this.regist_num( jqPhoneText );
	},
	regist_select : function( elemSelect ){
		var jqSelect = $(elemSelect) ;
		
		if ( (jqSelect.find("option").eq(0).text().indexOf("필수") >= 0) || 
			(jqSelect.attr("data-required") !== undefined) ){
			jqSelect.attr("data-required", "required");
			
			jqSelect.change(function(){
				if (this.selectedIndex > 0){
					Artn.Validation.showMessage( $(this), "" );
				}
			});
		}
	},	
	regist_textarea : function( jqText ){
		var sCounterId = "__" + jqText.attr("name") + "_counter";
		var iMaxLength = parseInt( jqText.attr("maxlength") );
		var iTextLen = this.getTextAreaLength( jqText );
		
		jqText.after("<br/><span class=\"text-counter\" id=\"" + sCounterId + "\">" + "글자수 제한: (" + iTextLen + " / " + iMaxLength + ")" + "</span><input type=\"hidden\" id=\"" + sCounterId + "_hdn\" value=\"" + iTextLen + "\">");
		jqText.keyup({counterId: sCounterId, maxlength: iMaxLength, jqCounderHdn: $("#" + sCounterId + "_hdn")}, function(e){
			var jqCounter = $( "#" + e.data.counterId );
			var iTextLen = Artn.Validation.getTextAreaLength( $(this) );
			var sText = "글자수 제한: (" + iTextLen + " / " + e.data.maxlength + ")";
			
			if (iTextLen > e.data.maxlength){
				jqCounter.addClass("alert");
				sText = sText + " - 허용 글자수 최대 한도를 초과 하였습니다.";
			}
			else{
				jqCounter.removeClass("alert");
			}
			
			e.data.jqCounderHdn.val( iTextLen );
			jqCounter.text( sText );
		});
	},
	getTextAreaLength : function( jqText ){
		var regex = /\n/gi;
		var sValue = jqText.val();
		var saMatch = sValue.match( regex );
		var iCrLfLen = (saMatch)? saMatch.length : 0;
		
		return sValue.length + (iCrLfLen * 4);
	},
	regist_zipcode : function( jqInput ){
		var LIST_ID = "__tbodyZipcode__";
		var DIALOG_ID = "__dialog_zipcode__";
		var FORM_ID = "__form_zipcode__";
		var PAGE_CTRL_ID = "__pageCtrlZipcode__";
		var PAGE_CTRL_COMMENT = "※ 결과물이 많을 시 좀 더 상세히 입력 해 주세요<br/>※ 검색 결과에서 찾을 수 없다면 아래의 주소로 가신 뒤 검색 하시고 직접 입력하시길 바랍니다.<br/>▶▶▶<a href=\"http://www.juso.go.kr/openIndexPage.do\" target=\"_blank\">도로명주소 안내시스템</a>";
		
		var sDataTo = jqInput.data("to") || ".address";
		var sDataToNew = jqInput.data("tonew") || ".address_new";
		var sDataAjaxUrl = jqInput.data("ajaxurl");
		var jqDialog = null;
		var jqAddress = $(sDataTo);
		var jqAddressNew = $(sDataToNew);
		
		var fnOpenDialog = function(e){
			e.data.dialogTarget.dialog("open");
			return false;
		};
		
		if (sDataAjaxUrl === undefined){
			//sDataAjaxUrl = "http://www.juso.go.kr/support/AddressMainSearch.do?searchType=location_newaddr";
			sDataAjaxUrl = Artn.Const.ZIPCODE;
		}
		
		$("<div id=\"" + DIALOG_ID + "\" title=\"우편번호 및 주소 검색기\">"+
				"<form id=\"" + FORM_ID + "\" action=\"" + sDataAjaxUrl + "\" class=\"artn-search\" data-type=\"list\" data-to=\"#" + LIST_ID + "\" data-buttons=\"#" + PAGE_CTRL_ID + "\">"+
				"<div><label for=\"__keyword__\">주소 검색</label><input type=\"text\" id=\"__keyword__\" name=\"keyword\" value=\"\" /><input type=\"submit\" class=\"artn-button board\" name=\"dong-search\" value=\"검색\"/></div>"+
				"<table class=\"board-list zipcode-search-result\"><thead><tr><th class=\"m-hdn\">번호</th><th style=\"width: 6em;\">우편번호</th><th>주소</th></tr></thead>"+
				"<tbody id=\"" + LIST_ID + "\" data-cross-domain=\"true\">"+
				"<!--<tr><td class=\"m-hdn\">{row_num}</td><td>{zipcode}</td><td><a href=\"#\" class=\"select close\">{address}</a>" +
				"<input type=\"hidden\" name=\"zipcode\" value=\"{zipcode}\"/>" +
				"<input type=\"hidden\" name=\"address\" value=\"{address}\"/>" +
				"<input type=\"hidden\" name=\"address_new\" value=\"{address_new}\"/>" +
				"</td></tr>-->"+
				"</tbody></table>"+
				"<div id=\"" + PAGE_CTRL_ID + "\"><div><button class=\"artn-button board prev\" type=\"button\">이전</button><button class=\"artn-button board next\" type=\"button\">다음</button></div><span class=\"comment\">" + PAGE_CTRL_COMMENT + "</span></div>" +
				"<div id=\"loading_" + DIALOG_ID + "\" class=\"artn-loading-overlay\"><span class=\"artn-loading-img\"></span></div>" +
				"</form></div>")
		.appendTo("body");
		
		jqDialog = $("#" + DIALOG_ID);
		
		jqDialog.dialog({
			width: 900,
			height: 600,
			autoOpen: false,
			show: {
                effect: "fade",
                duration: 500
            },
            hide: {
                effect: "fade",
                duration: 250
            }
		});
		
		Artn.AsyncSearch.create("#" + FORM_ID)
		.dataerror(function(e){
			//console.log(e.item.response);
			Artn.Ajax.AsyncSearch.data = Artn.Validation.parseZipcodeData(e.item.response);
		});
		Artn.List.create("#" + LIST_ID)
		.selectclick({zipcode: jqInput, address: jqAddress, addressNew: jqAddressNew}, function(e){
			e.data.zipcode.val( e.item.zipcode );
			e.data.address.val( e.item.address );
			e.data.addressNew.val( e.item.address + " " +e.item.address_new );
			e.data.address.nextAll("input[type='text']").eq(0).focus();
		})
		.itemadd({dialogTarget: jqDialog}, function(e){
			$(e.currentTarget).find(".close").click({dialogTarget: e.data.dialogTarget}, function(e){
				e.data.dialogTarget.dialog("close");
			});
		});
		
		jqInput
		.after( $("<button type=\"button\" class=\"artn-button board\" style=\"color: #333\">우편번호 검색</button>").click({dialogTarget: jqDialog}, fnOpenDialog) );
		//jqInput.click({dialogTarget: jqDialog}, fnOpenDialog);
		//jqAddress.click({dialogTarget: jqDialog}, fnOpenDialog);
		//jqAddressNew.click({dialogTarget: jqDialog}, fnOpenDialog);

		//jqInput.attr("readonly", true);
		//jqAddress.attr("readonly", true);
	},
	parseZipcodeData : function(data){
		var jqXml = $(data);
		var maData = [];
		var jqMatchTd;
		var sDong = "";
		var sNewAddr = "";
		
		jqXml.find("tr:even").each(function(index){
			jqMatchTd = $(this).children("td");
			sDong = jqMatchTd.eq(1).find("b").text();
			sNewAddr = jqMatchTd.eq(1).find("a").text();
			
			if (sDong){
				sNewAddr += "(" + sDong + ")";
			}
			//if ((sDong == null) || (sNewAddr == null)) break;
			
			maData[index] = {
				row_num: jqMatchTd.eq(0).text(),
				address_new: sNewAddr.trim(),
				address: jqMatchTd.eq(2).text(),
				zipcode: jqMatchTd.eq(3).text()
			};
		});
		
		return maData;
	}
	
//	,
//	regist_coordinate : function(jqButton){
//		var sDialogMap = "";
//		sDialogMap += "<div id=\"dialog_Coordinate\">";
//		sDialogMap += "<div id=\"wrap_innerCoord\">";
//		sDialogMap += " <div id=\"map_panel\">";
//		sDialogMap += " <input id=\"searchTextField\" type=\"text\"></div>";
//		sDialogMap += " <div id=\"map-canvas\"></div>";
//		sDialogMap += " <input type=\"text\" id=\"coordinate\"/>";
//		sDialogMap += " <input type=\"button\" id=\"map_send\" value=\"좌표사용\"/>";
//		sDialogMap += "</div>";
//		sDialogMap += "</div>";
//		jqButton.after(sDialogMap);
//		
//		var mapOptions = {
//			center: new google.maps.LatLng(37.566535, 126.97796919999996),
//		    zoom: 13,
//		    mapTypeId: google.maps.MapTypeId.ROADMAP
//		};
//		var map = new google.maps.Map(document.getElementById('map-canvas'),
//				mapOptions);
//	
//		var input = /** @type {HTMLInputElement} */(document.getElementById('searchTextField'));
//		var autocomplete = new google.maps.places.Autocomplete(input);
//		autocomplete.bindTo('bounds', map);
//		
//		var infowindow = new google.maps.InfoWindow();
//		var marker = new google.maps.Marker({
//		    map: map
//		});
//		
//		var fnOpenDialog = function(e){
//			e.data.dialogTarget.dialog("open");
//		};
//		jqDialog = $("#dialog_Coordinate");
//		
//		jqDialog.dialog({
//			width: 630,
//			height: 550,
//			autoOpen: false,
//			show: {
//                effect: "fade",
//                duration: 500
//            },
//            hide: {
//                effect: "fade",
//                duration: 250
//            }
//		});
//		
//		google.maps.event.addListener(autocomplete, 'place_changed', function() {
//		    infowindow.close();
//		    marker.setVisible(false);
//		    input.className = '';
//		    var place = autocomplete.getPlace();
//		    if (!place.geometry) {
//		      // Inform the user that the place was not found and return.
//		      input.className = 'notfound';
//		      return;
//		    }
//	
//		    // If the place has a geometry, then present it on a map.
//		    if (place.geometry.viewport) {
//		      map.fitBounds(place.geometry.viewport);
//		    } else {
//		      map.setCenter(place.geometry.location);
//		      map.setZoom(17);  // Why 17? Because it looks good.
//		    }
//		    var sLocation = place.geometry.location.toString();
//		    var sCoordinate = sLocation.substring(1,sLocation.length-1);
//		    $("#coordinate").val(sCoordinate);
//		    
//		    marker.setIcon(/** @type {google.maps.Icon} */({
//		      url: place.icon,
//		      size: new google.maps.Size(71, 71),
//		      origin: new google.maps.Point(0, 0),
//		      anchor: new google.maps.Point(17, 34),
//		      scaledSize: new google.maps.Size(35, 35)
//		    }));
//		    marker.setPosition(place.geometry.location);
//		    marker.setVisible(true);
//	
//		    var address = '';
//		    if (place.address_components) {
//		      address = [
//		        (place.address_components[0] && place.address_components[0].short_name || ''),
//		        (place.address_components[1] && place.address_components[1].short_name || ''),
//		        (place.address_components[2] && place.address_components[2].short_name || '')
//		      ].join(' ');
//		    }
//		    
//		    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
//		    infowindow.open(map, marker);
//		});
//	
//		google.maps.event.addDomListener(window, 'load', initialize);
////		$("#dialog_Coordinate").dialog("option", {
////        	modal: true,//다이얼로그 외에는 클릭 안됨
////        	width: 850,
////    		height: 750
////		});
//		
//		jqButton.click({dialogTarget: jqDialog}, fnOpenDialog);
//		
//		$("#map_send").click({dialogTarget: jqDialog, to: jqButton.data("to")}, function(e){
//			$(e.data.to).val($("#cooldinate").val());
////			$(opener.document).find("textbox_zipcode_group").val();
//			e.data.dialogTarget.dialog("close");
//		});
//		
////		$("input[name='map_button']").click(function(){
////			$("#dialog_Coordinate").dialog("open");
////		});
//	}
};