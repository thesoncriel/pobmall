var artn = {};
artn.lib = {};

/**
 * JS Library 의 컨트롤러 에서 쓰이는 각종 초기화 메서드들을 포함하는 기본 클래스 이다.
 * @class artn.lib.BaseController
 */
artn.lib.BaseController = function(){
	/**
	 * 컨트롤러가 적용 된 컨테이너 요소.
	 * @type jQuery
	 */
	this._jqContainer = null;
	/**
	 * 컨트롤러 생성 시 사용되는 각종 옵션.
	 * @type Map
	 */
	this._option;
	/**
	 * @ignore 특별히 사용되지는 않음.
	 */
	this._jqErrorList = null;
	//this.evt_created = $.noop();
};

artn.lib.BaseController.prototype = {
	/**
	 * 생성자.
	 * @param {String|jQuery} strSelector_jqElem 컨트롤을 적용시키고자 하는 요소.
	 * @param {Map} mOption 컨트롤 생성 시 사용되는 옵션.
	 * @returns {artn.lib.BaseController}
	 */
	init : function(strSelector_jqElem, mOption){
		if ( (typeof strSelector_jqElem) === "string" ){
			this._jqContainer = $( strSelector_jqElem );
		}
		else if ( strSelector_jqElem instanceof jQuery ){
			this._jqContainer = strSelector_jqElem;
		}
		else if ( strSelector_jqElem ){
			this._jqContainer = $( strSelector_jqElem );
		}
		
		if (mOption){
			this._option = mOption;
		}
		else{
			this._option = {};
		}
		
		return this;
	},
	/**
	 * 옵션을 초기화 한다.<br/>
	 * BaseController._option에 설정 된 것들을 대상으로 name(key)이 존재하는지 확인하고 없을 경우,
	 * name을 key로 하여 매개변수로 입력한 초기값을 넣어준다.
	 * @param {String} sName 초기화 할 값에 대한 key.
	 * @param {String|Number} sDefValue 초기화 할 값.
	 */
	_initOption : function( sName, sDefValue){
		if (this._option.hasOwnProperty( sName ) === false){
			if ($.isNumeric(sDefValue) === true){
				this._option[ sName ] = parseInt( this._jqContainer.data( sName ) || sDefValue );
			}
			else{
				this._option[ sName ] = this._jqContainer.data( sName ) || sDefValue;
			}
			
//			if ((sDataType === undefined) && (this._option[ sName ] !== sDefValue)){
//				if ((sDataType === "boolean")){
//					this._option[ sName ] = (this._option[ sName ] === "true");
//				}
//				else if ((sDataType === "number")){
//					this._option[ sName ] = parseInt( this._option[ sName ] );
//				}
//				else if ((sDataType === "double")){
//					this._option[ sName ] = parseFloat( this._option[ sName ] );
//				}
//			}
		}
	},
	/**
	 * 컨트롤러가 데이터를 전달하는 측이 form 인지 혹은 list 형태인지를 확인한다.<br/>
	 * 전달받는 요소가 form 일 경우 'form'을, <br/>
	 * ul, tbody, ol, table일 경우 'list'를, <br/>
	 * 그 어디에도 속하지 않으면 'normal'을 반환 한다.<br/>
	 * @param {String|jQuery} strSelector_jqElem 받아들이는 형태를 알고자 하는 요소.
	 * @returns {String}
	 */
	getRcvType : function(strSelector_jqElem){
    	try{
    		var sTagName = $(strSelector_jqElem).prop("tagName").toLowerCase();
        	
        	if (sTagName === "form"){
        		return "form";
        	}
        	else if((sTagName === "ul") || (sTagName === "tbody") || (sTagName === "ol") || (sTagName === "table")){
        		return "list";
        	}
    	}
    	catch(e){}
    	
    	return "normal";
    },
    /**
     * 상기의 getRcvType() 을 이용하여 얻게된 결과를 바탕으로 타 요소로 데이터를 전달 한다.<br/>
     * 일반적으로 getRcvType()의 결과는 _option.rcvtype 에 등록되어 있다.<br/>
     * 또 한 데이터 전달 시 data-to 속성에 데이터를 전달 할 요소에 대한 '선택자'가 미리 정의 되어 있어야 한다.<br/>
     * 전달 시 rcvtype 에 따른 데이터 전달 방법은 다음과 같다.
     * <ul>
     * <li>form : Artn.AsyncForm 에 submit 데이터로써 전달한다.</li>
     * <li>list : Artn.List에 목록을 추가 한다.</li>
     * <li>normal : 사용되지 않음. </li>
     * </ul>
     * @param {jQuery} jqCurrent 데이터가 존재하는 요소.
     * @returns {Map} 전달된 데이터.
     */
    _sendDataTo : function( jqCurrent ){
    	var sRcvType = this._option.rcvtype;
		var sDataTo = this._option.to;
		var mItem = null;
		var jqDialog = null;
		
		try{
			mItem = Artn.Util.serializeMap( jqCurrent );
			
			if (sRcvType === "form"){
				Artn.AsyncForm.inst[ sDataTo ].submit( mItem );
			}
			else if (sRcvType === "list"){
				Artn.List.inst[ sDataTo ].add( mItem );
			}
			else{
				jqDialog = this._jqContainer.parents("div[id^='dialog']");
				if (jqDialog.length > 0){
					Artn.Util.deserialize(
						$( sDataTo ).children().eq( jqDialog.data("fromItemIndex") || 0 ),
						mItem);
				}
			}
		}catch(e){}
		
		return mItem;
    },
    /**
     * 이벤트를 현재 객체에 추가 한다.<br/>
     * 본 메서드는 일반적인 용도로 사용하지 않으며, BaseController를 상속받아 이벤트를 해당 클래스에 추가 할 때만 사용토록 한다.<br/>
     * (즉 생성자(constructor)에서만 사용한다.)<br/>
     * 일반적으로 이벤트는 총 3단계를 거치며 메서드 수행시 다음과 같은 명칭으로 property가 생성 된다.
     * <ol>
     * <li>이벤트명([data: Map,] handler: function) : 이벤트 핸들러를 등록할 수 있는 메서드.</li>
     * <li>evt_이벤트명 : 이벤트 핸들러를 저장하는 함수 포인터.</li>
     * <li>
     * on이벤트명(...): 특정 시기에 이벤트 핸들러를 수행시켜주는 메서드. 일반적으로 이벤트가 포함된 객체 내부에서 수행된다.<br/>
     * 파라메터:
     * <ul>
     * <li>sender {BaseController} : 이벤트가 수행된 컨트롤러 객체.</li>
     * <li>item {Map} : 이벤트 수행 시 전달되는 데이터.</li>
     * <li>jqItem {jQuery} : 컨트롤러 형태가 List일 때 이벤트가 수행된 item 요소.</li>
     * <li>index {Integer} : 컨트롤러 형태가 List일 때 이벤트가 수행된 item의 인덱스.</li>
     * <li>elemCurrent {Element} : 이벤트가 수행된 DOM 객체. button, input 요소등이다.</li>
     * </ul><!--파라메터 [종료] -->
     * </li>
     * </ol>
     * 본 이벤트를 외부에서 사용 시 파라메터로 주어지는 이벤트 객체의 내용은 다음과 같다.
     * <pre>
     * {
     * sender: BaseController (이벤트가 수행된 컨트롤러 객체),
     * item: Map (컨트롤러가 리스트일 경우 이벤트가 수행된 아이템의 데이터),
     * data: Object (이벤트 등록 시 같이 넣은 Object),
     * currentItem: jQuery (컨트롤러가 리스트일 경우 이벤트가 수행된 아이템에 대한 요소),
     * index: Integer (컨트롤러가 리스트일 경우 이벤트가 수행된 아이템에 대한 인덱스),
     * currentTarget: Element (이벤트가 직접적으로 일으켜진 button, input 등의 UI 요소)
     * }
     * </pre>
     * @param {String} strEventName 추가할 이벤트명
     * @param {Boolean} isSendDataEvent 데이터 전달 이벤트인지 여부를 설정한다. true면 이벤트 핸들러 수행 시 전달되는 데이터를 _sendDataTo() 로 가져온 것으로 대체 한다.
     * @example
     * function AroController(){
     * 	this.aro = "화이팅!!";
     * 	this.regEvent("success", false); // success 이벤트 추가
     * 	this.regEvent("fire", true);	// file 이벤트 추가
     * };
     * AroController.prototype = new BaseController(); // BaseController 상속
     * $.extend(AroController.prototype, {
     * 	// methods...
     * });
     * 
     * var aro = new AroController().init("aro_controller");
     * aro.success(function(e){
     *	// success 이벤트 처리 내용
     * })
     * .fire(function(e){
     * 	// fire 이벤트 처리 내용
     * });
     */
    regEvent : function(strEventName, isSendDataEvent){
    	this.eventData = this.eventData || {};
    	
    	this[ strEventName ] = function(){
    		if (arguments.length === 2){
    			this.eventData[ strEventName ] = arguments[0];
    			this[ "evt_" +  strEventName ] = arguments[1];
    		}
    		else{
    			this.eventData[ strEventName ] = undefined;
    			this[ "evt_" +  strEventName ] = arguments[0];
    		}
    		
    		return this;
    	};
    	this[ "evt_" + strEventName ] = Artn.EmptyMethod;
    	
    	if (isSendDataEvent){
    		this[ "on" + strEventName ] = function(sender, item, jqItem, index, elemCurrent){
    			item = sender._sendDataTo( jqItem );
    			sender[ "evt_" + strEventName ]( {sender: sender, item: item, data: this.eventData[strEventName], currentItem: jqItem, index: index, currentTarget: elemCurrent} );
        	};
    	}
    	else{
    		this[ "on"   + strEventName ] = function(sender, item, jqItem, index, elemCurrent){
        		sender[ "evt_" + strEventName ]( {sender: sender, item: item, data: this.eventData[strEventName], currentItem: jqItem, index: index, currentTarget: elemCurrent} );
        	};
    	}
    },
    /**
     * 에러 내용을 해당 컨트롤러에 출력 한다.<br/>
     * 일반적으로는 쓰이지 않으며, 디버깅 용도로 잠시 사용하면 좋다.
     * @param {String} name 에러명
     * @param {String} msg 에러 내용
     */
    setError : function(name, msg){
    	if(this._jqErrorList){
    		this._jqErrorList.append("<li>[Error (" + name + "): " + msg + "]</li>");
    	}
    	else{
    		if (this._jqContainer.prev().prop("tagName").toLowerCase() === "thead"){
    			this._jqContainer.parent().before("<ul class=\"artn-ui-error\"></ul>");
    			this._jqErrorList = this._jqContainer.parent().prev();
    		}
    		else{
    			this._jqContainer.before("<ul class=\"artn-ui-error\"></ul>");
        		this._jqErrorList = this._jqContainer.prev();
    		}
    		
    		this.setError(name, msg);
    	}
    }
	/*,
	created : function(handler){ this.evt_created = handler; return this; }*/
};

/**
 * 리스트 컨트롤러.<br/>
 * 각종 리스트 형태(ol, ul, li, table, tbody 등)에 대하여 JSON 데이터를 목록에 추가/삭제 하거나 사용자 이벤트를 받아들일 수 있도록 만들어준다.
 * @class
 * @see artn.lib.BaseController
 */
artn.lib.ListController = function(){
	this._keywords;
    this._tagTemplate;
    //this._dataTo;
    //this._selectable;
    //this._rcvType = "list";
    //this._childrenSelector = "li:last-child";
    this.listType = "";
    
    this.regEvent("itemselected", true);
    this.regEvent("itemdblclick", true);
    this.regEvent("selectclick", true);
    this.regEvent("editclick", true);
    this.regEvent("inputchange", true);
    this.regEvent("itembeforeremove");
    this.regEvent("itemremove");
    this.regEvent("itemadd");
    /*
	this.evt_itemdblclick = Artn.EmptyMethod;
	this.evt_selectclick = Artn.EmptyMethod;
	this.evt_itemremove = Artn.EmptyMethod;
	this.evt_itemadd = Artn.EmptyMethod;
	*/
};
artn.lib.ListController.prototype = new artn.lib.BaseController();
$.extend(artn.lib.ListController.prototype, {
	/**
	 * @ignore
	 */
	constructor : artn.lib.ListController,
	/**
	 * 생성자.<br/>
	 * 각종 옵션과 설정을 초기화 하고 이벤트 등록을 한다.
	 * @param {String} strSelector 컨트롤러로 만들 요소에 대한 선택자.
	 * @param {Map} mOption 생성 시 필요한 옵션들.
	 * @returns {artn.lib.ListController}
	 */
	init : function(strSelector, mOption){
		artn.lib.BaseController.prototype.init.call(this, strSelector, mOption);
		
		this._tagTemplate = Artn.Util.extractTemplate( this._jqContainer );
		
		this._initOption( "to", "" );
		this._initOption( "selectable", "no" );
		this._initOption( "seq-name", "seq" );
		this._initOption( "renumber", undefined );
		this._initOption( "autorenumber", "false" );
		this._initOption( "rcvtype", this.getRcvType( this._option.to ) );
		this.initList();
		
		var sTagName = this._jqContainer.prop("tagName").toLowerCase();
		
		if ((sTagName === "ul") || (sTagName === "ol")){
			this.listType = "list";
		}
		else if (sTagName === "tbody"){
			this.listType = "tbody";
		}
		else if (sTagName === "table"){
			this.listType = "table";
		}
		else{
			this.listType = "div";
		}
		
		return this;
	},
	/**
	 * 이미 문서 구조상 만들어진 리스트에 대하여 UI 및 이벤트를 적용시키고 초기화 한다.
	 */
	initList : function(){
    	var jqChildren = this._jqContainer.children();
    	var inst = this;
    	var jqItem = null;
    	var saData = this.serialize();
    	
    	jqChildren.each(function(index){
    		jqItem = $(this);
    		inst.bindUI( jqItem, saData[index] );
    		inst.bindDialogEvent( jqItem );
    		inst.bindClickEvent( jqItem, saData[index] );
    		inst.bindChangeEvent( jqItem, saData[index] );
    	});
    	
    	if (this._option.autorenumber === "true"){
    		this.renumber();
    	}
    },
    /**
     * 옵션을 설정한다.<br/>
     * 옵션명이 'dialog'일 경우 bindDialogEvent를 수행한다.
     * @param {String} name 옵션명.
     * @param {Map} mValue 옵션값.
     * @see artn.lib.ListController.bindDialogEvent
     */
    setOption : function(name, mValue){
    	this._option[ name ] = mValue;
    	
    	if (name === "dialog"){
        	var inst = this;
        	var jqItem = null;
        	
        	this._jqContainer.children().each(function(index){
        		jqItem = $(this);
        		inst.bindDialogEvent( jqItem );
        	});
    	}
    },
    
    /**
     * 리스트 내 모든 항목을 제거 한다.
     */
	clear : function(){
        this._jqContainer.empty();
    },
    // 메서드명 변경. 하위 호환성을 위해 임시로 놔둠. [시작] - 2013.10.27 by jhson
    addItemRange : function(maData){
    	this.addRange(maData);
    },
    addItem : function(mData){
    	this.add(mData);
    },
    // 메서드명 변경. 하위 호환성을 위해 임시로 놔둠. [종료] - 2013.10.27 by jhson
    
    /**
     * 데이터 여럿줄을 리스트 컨트롤러에 한번에 추가 한다.
     * @param {List<Map>|Map[]} maData 추가 할 데이터들.
     */
    addRange : function(maData){
        if (maData.length === undefined) return;
        
        var iLen = maData.length;
        
        for (var i = 0; i < iLen; ++i){
            this.add( maData[i] );
        }
        
        if (this._option.renumber){
    		this.renumber();
    	}
    },
    /**
     * 데이터를 목록에 추가 한다.
     * @param {Map} mData 목록에 추가 할 데이터.
     */
    add : function(mData){
        var jqItem = null;
        var sItemTag = this._tagTemplate.process( mData );
        
        this._jqContainer.append( sItemTag );
    	jqItem = this._jqContainer.children().last();
        
        this.bindUI( jqItem, mData || {} );
        this.bindDialogEvent( jqItem );
        this.bindClickEvent( jqItem, mData || {} );
        this.bindChangeEvent( jqItem, mData || {} );
        this.bindValue( jqItem, mData || {} );
        
        this.onitemadd(this, mData, jqItem, this._jqContainer.children().length - 1, jqItem.get(0));
    },
    /**
     * 컨트롤러 내 목록의 번호 매기기를 다시 수행 한다.
     */
    renumber : function(){
    	this._jqContainer.children().find( "." + this._option["seq-name"] ).each(function(index){
            $(this).text( index + 1 );
        });
    	this._jqContainer.find( "input[name='" + this._option["seq-name"] + "']" ).each(function(index){
    		$(this).val( index + 1 );
    	});
    },
    /**
     * 특정 요소에 대하여 이 요소가 현재 컨트롤러 목록 내에서 위치하는 인덱스 값을 가져 온다.
     * @param {jQuery} jqItem 인덱스 값을 알고자 하는 요소
     * @returns {Integer}
     */
    indexOf : function( jqItem ){
    	return Artn.Util.indexOf( jqItem, ".item" );
    },
    /**
     * 특정 인덱스 값을 이용하여 컨트롤러 목록 내의 요소를 가져 온다.
     * @param {Integer} index 가져올 요소에 대한 인덱스.
     * @returns {jQuery}
     */
    get : function( index ){
    	return this._jqContainer.eq( index );
    },
    /**
     * 컨트롤러 내에서 특정 항목을 삭제 한다.
     * @param {Integer|jQuery} arg 정수를 넣을 경우 해당 index에 해당되는 것을, jQuery로 넣을 경우 해당 요소를 삭제 한다.
     * @param {Element} [elemDelete] 목록 내 항목을 삭제시키는 이벤트를 일으킨 DOM 요소. 컨트롤러 내 Delete 이벤트에서만 쓰인다.
     */
    remove : function( arg, elemDelete ){
    	var jqItem = null;
    	var mItem = null;
    	var index = 0;
    	
    	if ( ($.isNumeric( arg ) === true) && (arg >= 0) ){
    		index = arg;
    		jqItem = this._jqContainer.eq( index );
    	}
    	else if (arg instanceof jQuery) {
    		index = this.indexOf( arg );
    		jqItem = arg;
    	}
    	
    	mItem = this.serializeSingle( jqItem );
    	this.itembeforeremove(this, mItem, jqItem, index, elemDelete);
    	jqItem.remove();
    	
    	if (this._option.renumber){
    		this.renumber();
    	}
    	
    	this.onitemremove(this, mItem, jqItem, index, elemDelete);
    },
    /**
     * 컨트롤러 내의 항목 길이를 가져 온다.
     * @returns {Integer}
     */
    size : function(){
    	return this._jqContainer.children(".item").length;
    },
    /**
     * 아이템 요소에 다이얼로그 이벤트를 등록 한다.<br/>
     * 이벤트가 등록되는 요소는 data-rule="dialogButton" 속성을 가져야 한다.
     * @param {jQuery} jqItem 이벤트를 등록시킬 요소.
     */
    bindDialogEvent : function( jqItem ){
    	var inst = this;
    	
    	if (this._option.dialog === undefined){
    		this._option.dialog = {};
    	}
    	
    	jqItem.find("*[data-rule='dialogButton']").each(function(index){
    		var jqDialogButton = $(this);
    		var sName = jqDialogButton.data("name") || jqDialogButton.text();
    		var sDialog = jqDialogButton.data("dialog");
    		
    		if (inst._option.dialog[ sName ] === undefined){
    			inst._option.dialog[ sName ] = new artn.lib.InputDialog().init( sDialog );
    		}
    		
    		inst._option.dialog[ sName ].regist( jqDialogButton, jqItem );
		});
    },
    /**
     * 리스트 컨트롤러에서 사용자가 특정 요소를 선택했을 때 발생되는 이벤트를 등록 시킨다.<br/>
     * 이벤트가 등록된 요소는 _option.selectable 값에 따라 다음과 같이 .selected 클래스를 적용 시킨다.
     * <ul>
     * <li>multi : 다중 선택 가능. 이미 선택한 것에 대하여 다시한번 선택 시 .selected가 해제 된다.</li>
     * <li>single: 하나만 선택 가능. 이미 선택한 것에 대하여 다시한번 선택 시 .selected가 해제 된다.</li>
     * <li>fixed: 하나만 선택 가능. 이미 선택한 것에 대하여 <u>선택 상태 해제가 불가</u> 하다.</li>
     * <li>no: 선택이 불가 하다.</li>
     * </ul>
     * @param {jQuery} jqItem 이벤트를 적용시킬 요소.
     * @param {Map} mData 이벤트 등록 시 함께 전달 할 데이터.
     */
    bindSelectedEvent : function( jqItem, mData){
    	if (this._option.selectable === "multi"){
    		jqItem.click({inst: this, item: mData}, function(e){
    			var jqItem = $(this);
    			
    			if (jqItem.hasClass("selected") === true){
    				jqItem.removeClass("selected");
    			}
    			else{
    				jqItem.addClass("selected");
    			}

    			return false;
    		});
    	}
    	else if (this._option.selectable === "single"){
    		jqItem.click({inst: this, item: mData}, function(e){
    			var jqItem = $(this);
    			var isSelected = jqItem.hasClass("selected");
    			
    			jqItem.siblings().removeClass("selected");
    			
    			if (isSelected === true){
    				jqItem.removeClass("selected");
    			}
    			else{
    				jqItem.addClass("selected");
    				e.data.inst.onitemselected(e.data.inst, e.data.item, jqItem, e.data.inst.indexOf( jqItem ), this);
    			}
    			
    			return false;
    		});
    	}
    	else if (this._option.selectable === "fixed"){
    		jqItem.click({inst: this, item: mData}, function(e){
    			var jqItem = $(this);
    			var isSelected = jqItem.hasClass("selected");
    			
    			jqItem.siblings().removeClass("selected");
    			
    			if (isSelected === false){
    				jqItem.addClass("selected");
    				e.data.inst.onitemselected(e.data.inst, e.data.item, jqItem, e.data.inst.indexOf( jqItem ), this);
    			}
    			
    			return false;
    		});
    	}
    },
    /**
     * 해당 아이템 요소에 클릭 이벤트를 적용 시킨다.<br/>
     * 이벤트 등록 시 그 아이템 요소 내에 아래와 같은 특정 class 요소만을 찾아 적용 된다.
     * <ul>
     * <li>.select : '<b>선택 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 '선택 상태'가 되며 selectclick 이벤트가 수행 된다.</li>
     * <li>.edit : '<b>수정 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 editclick 이벤트가 수행 된다.</li>
     * <li>.delete : '<b>삭제 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 remove 이벤트가 수행 된다.</li>
     * </ul>
     * 추가적으로 컨트롤러 옵션 중 _option.selectable 값이 <b>no</b>일 경우엔 itemdblclick 이벤트를, 그 이외의 값은 bindSelectedEvent를 이용하여 각종 선택 이벤트를 등록 한다.
     * @param {jQuery} jqItem 이벤트를 등록할 요소.
     * @param {Map} mData 이벤트 등록 시 넘겨줄 데이터.
     * @see artn.lib.ListController.bindSelectedEvent
     */
    bindClickEvent : function( jqItem, mData ){
    	if (this._option.selectable !== "no"){
    		this.bindSelectedEvent(jqItem, mData);
    	}
    	// data-selectable="true" 라면 더블 클릭 이벤트로 데이터를 넘기지 않겠다는 의미로 간주
    	else{
    		jqItem.dblclick({inst: this, item: mData}, function(e){
                var inst = e.data.inst;
                inst.onitemdblclick(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this);
            });
    	}
    	
        jqItem.find(".select").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.onselectclick(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this );
        	
        	return false;
        });
        jqItem.find(".edit").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.oneditclick(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this );
        	
        	return false;
        });
        jqItem.find(".delete").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.remove( jqItem, this );
        	
        	return false;
        });
    },
    /**
     * 해당 아이템 요소내에 스피너(Spinner)를 추가하고 spinstop 이벤트를 등록하여 컨트롤러 내의 inputchange 와 연결시키거나,
     * input[type='text'] 혹은 select 요소를 찾아 change 이벤트를 추가하여 컨트롤러 내의 inputchange 와 연결시킨다.<br/>
     * 스피너 추가는 아이템내에 다음과 같은 조건의 자식 요소가 있을 경우에만 해당 된다.<br/>
     * input[id^='spinner'], input[data-rule='spinner']
     * @param {jQuery} jqItem 이벤트를 적용 할 요소.
     * @param {Map} mData 이벤트 수행 시 전달할 데이터.
     */
    bindChangeEvent : function( jqItem, mData ){
    	var jqSpinner = jqItem.find("input[id^='spinner'], input[data-rule='spinner']");
    	
    	jqSpinner.spinner();
    	jqSpinner.on("spinstop", {inst: this, item: mData}, function(e){
			var inst = e.data.inst;
			inst.oninputchange(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this);
		});
    	
    	jqItem.find("input[type='text'], select").not( jqSpinner ).change({inst: this, item: mData}, function(e){
			var inst = e.data.inst;
			inst.oninputchange(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this);
		});
    },
    /**
     * 해당 아이템 요소에 .item 클래스를 추가하고,
     * 아이템 내부의 .artn-button 클래스가 적용된 요소를 jquery-ui button으로 변경 시킨다.
     * @param {jQuery} jqItem UI 적용을 수행 할 요소
     * @param {Map} mData UI 적용 시 전달 할 데이터.
     */
    bindUI : function( jqItem, mData ){
    	jqItem.find(".artn-button").button();
    	jqItem.addClass("item");
    },
    /**
     * 해당 아이템 요소에 selectbox가 있을 경우 이 곳에 값을 설정 한다.<br/>
     * 설정되는 값은 매개변수 mData에 기반하며 이 곳에 select 요소의 name과 이름이 동일한 key로 매핑된 것이 설정 된다.<br/>
     * 값 설정 완료 후 _option.renumber 가 true일 경우 해당 아이템 요소에 대하여 번호매김을 새로 한다.
     * @param {jQuery} jqItem 값을 적용할 요소
     * @param {Map} mData 적용할 데이터
     */
    bindValue : function( jqItem, mData ){
    	jqItem.find("select").each(function(index){
        	var jqSelect = $(this);
        	var sName = jqSelect.attr( "name" );
        	
        	if (mData.hasOwnProperty( sName ) === true){
        		jqSelect.val( mData[ sName ] );
        	}
        });
    	if (this._option.renumber){
        	var iChildLen = this._jqContainer.children().length;
        	jqItem.find( "." + this._option["seq-name"] ).html( iChildLen );
        	jqItem.find("input[name='" + this._option["seq-name"] + "']").val( iChildLen );
    	}
    },
    /**
     * 컨트롤러 내의 각종 입력 요소를 이용하여 사용되는 모든 name 값을 가져와 Array로 변경하여 가져 온다.
     * @returns {String[]} 키워드명 모음
     */
    extractKeywords : function(jqNodeLi){
    	var saName = [];
    	
    	this._jqContainer.children().first().find("input[type!='button'][type!='submit'], select, textarea").each(function(index){
    		saName[index] = this.name;
    	});
    	
    	this._keywords = saName;
    	return saName;
    },
    /**
     * 컨트롤러 내에서 사용되는 키워드를 자체 _keywords 필드에 등록하고 반환 한다.
     * @returns {String[]}
     * @see artn.lib.ListController.extractKeywords
     */
    getKeywords : function(){
    	if (!!this._keywords === false){
    		this._keywords = this.extractKeywords();
        }
    	return this._keywords;
    },
    /**
     * 해당 요소에서 입력요소의 데이터를 직렬화 하여 가져온다.
     * @param {jQuery} jqItem 직렬화 할 데이터가 있는 요소
     * @returns {Map} 직렬화 된 데이터
     */
    serializeSingle : function(jqItem){
    	var mValue = {};
    	var saKey = this.getKeywords();
    	var iLen = saKey.length;
    	
    	for(var i = 0; i < iLen; ++i){
    		mValue[saKey[i]] = jqItem.find("[name='" + saKey[i] + "']").val();
        }
    	return mValue;
    },
    /**
     * 현재 컨트롤러 내의 모든 입력요소들을 대상으로 데이터 직렬화 한다.<br/>
     * 직렬화 할 시 <u>'선택 상태'인 요소들 만을 대상</u>으로 삼는다.
     * @param {Boolean} isSelectedOnly
     * @returns {Map[]} 직렬화 된 데이터
     */
    serialize : function(isSelectedOnly){
        var maData = [];
        var saKey = this._keywords;
        var iLen = 0;
        var inst = this;
        var mapVal;
        var iMapIndex = 0;
        var jqItem;
        var isSelected = isSelectedOnly || false;
        
        this._jqContainer.children().each(function(index){
            jqItem = $(this);
            saKey = inst.getKeywords();
            iLen = saKey.length;
            if ((isSelected === false) ||
        		(jqItem.hasClass("selected") === true) ){
                mapVal = {};
                for(var i = 0; i < iLen; ++i){
                    mapVal[saKey[i]] = jqItem.find("[name='" + saKey[i] + "']").val();
                }
                maData[iMapIndex] = mapVal;
                ++iMapIndex;
            }
        });
        
        return maData;
    },
    /**
     * @ignore 쓰이지 않음.
     */
    getListType : function( jqElem, iDepth ){
    	var mData = {};
    	var jqParent = jqElem.parent();
    	var sTagName = jqParent.prop("tagName").toLowerCase();
    	
    	if (sTagName === "td"){
    		mData.type = "table";
    		mData.jqItem = jqParent.parent();
    	}
    	else if (sTagName === "li"){
    		mData.type = "list";
    		mData.jqItem = jqParent;
    	}
    	else if (jqParent.hasClass("item") === true){
    		mData.type = "div";
    		mData.jqItem = jqParent;
    	}
    	else{
    		var iLocalDepth = iDepth || 0;
    		
    		// 너무 많은 부모를 찾게될 경우 (한도는 5번) 중단하고 null을 발생 시킨다.
    		if (iLocalDepth < 5){
    			iLocalDepth++;
    			mData = this.getListType( jqParent, iLocalDepth );
    		}
    		else{
    			return null;
    		}
    	}
    	
    	return mData;
    }
});

/**
 * 무한 리스트 컨트롤러.<br/>
 * 사용 시 JSON 데이터를 전달 해 줄 AsyncSearch 컨트롤러가 필요하다.
 * @class
 * @see artn.lib.BaseController
 * @see artn.lib.ListController
 */
artn.lib.InfiniteList = function(){
    this._loadingTags = "";
    this._loadingTemp = TrimPath.parseTemplate("<li class=\"${cssClass}\" style=\"margin-bottom: 1em;\"><img src=\"${img}\" alt=\"읽어오는 중...\" width=\"55\" height=\"55\"/></li>");
    this._loadingTagClass = "__loading";
    this._isScrollEnd = false;
    
    this.evt_scrollend = Artn.EmptyMethod;
    
};
artn.lib.InfiniteList.prototype = new artn.lib.ListController();
$.extend(artn.lib.InfiniteList.prototype, {
	/**
	 * @ignore 일반적인 생성자.
	 */
	constructor : artn.lib.InfiniteList,
	/**
	 * 생성자.<br/>
	 * 각종 옵션과 설정을 초기화 하고 이벤트 등록을 한다.
	 * @param {String} strSelector 컨트롤러로 만들 요소에 대한 선택자.
	 * @param {Map} mOption 생성 시 필요한 옵션들.
	 * @returns {artn.lib.ListController}
	 */
    init : function(strSelector, mOption){
    	artn.lib.ListController.prototype.init.call(this, strSelector, mOption);
    	
    	this._initOption("loadingimg", "/img/loading.png");
    	this._initOption("rowlimit", 10);
    	this._initOption("from", undefined);
    	
    	/* TODO: 추후 다양한 data-option을 통해 타 클래스와 연동될 수 있게 할 것*/
    	if (( this._option.from ) && ( this._option.from.length >= 2 ) ){
			this.scrollend(function(e){
				Artn.AsyncSearch.inst[ e.data.inst._option.from ].next();
			});
    	}
    	
        this._loadingTags = this._loadingTemp.process( {"cssClass": this._loadingTagClass, "img": this._option.loadingimg} );

        this._jqContainer.bind("scroll", {inst: this},  this.onscrollend);
        
        return this;
    },
    /**
     * 리스트 내 모든 항목을 제거 한다.
     */
    clear : function(){
    	this._jqContainer.empty();
        this._jqContainer.scrollTop(0);
    	this._jqContainer.append(this._loadingTags);
    	this.showLoading( false );
    },
    /**
     * 데이터 여럿줄을 리스트 컨트롤러에 한번에 추가 한다.
     * @param {List<Map>|Map[]} maData 추가 할 데이터들.
     */
    addRange : function(jsonData){
        var iLen = jsonData.length;
        
        for (var i = 0; i < iLen; ++i){
            this.add( jsonData[i] );
        }
        
        if (iLen === this._option.rowlimit){
            this._isScrollEnd = false;
            this.showLoading(true);
        }
        else{
            this._isScrollEnd = true;
            this.showLoading(false);
        }
        
        if (this._option.renumber){
    		this.renumber();
    	}
    },
    /**
     * 데이터를 목록에 추가 한다.
     * @param {Map} mData 목록에 추가 할 데이터.
     */
    add : function(mData){
        var jqItem = null;
        var sItemTag  = this._tagTemplate.process( mData );
        
        this._jqContainer.find("." + this._loadingTagClass).before(sItemTag).fadeIn();
        jqItem = this._jqContainer.children().last().prev();
        
        this.bindUI( jqItem, mData );
        this.bindDialogEvent( jqItem );
        this.bindClickEvent( jqItem, mData );
        this.bindChangeEvent( jqItem, mData );
        this.bindValue( jqItem, mData );

        this.onitemadd(this, mData, jqItem, this._jqContainer.children().length - 2, jqItem.get(0));
    },
    /**
     * 무한 리스트에 로딩 이미지를 출력하거나 숨긴다.
     * @param {Boolean} isShow true면 출력, false면 숨김.
     */
    showLoading : function(isShow){
    	this._jqContainer.find("." + this._loadingTagClass).toggle( isShow === true );
    },
    
    /* events */
    /**
     * 무한 리스트에서 스크롤 끝까지 내렸을 때 발생되는 이벤트.
     * @param {function} handler 이벤트 시 수행되는 callback 메서드. 
     */
    scrollend : function(handler){
        this.evt_scrollend = handler;
    },
    /**
     * @ignore
     * @param e
     */
    onscrollend : function(e){
    	if (e.data.inst._isScrollEnd == true) return;
        
    	var elem = $(e.currentTarget);

        if ((elem[0].scrollHeight - elem.scrollTop()) <= elem.outerHeight())
        {
        	e.data.inst.evt_scrollend(e);
        }
    }
    
});



/**
 * 마우스로 Drag & Drop 하여 재정렬이 가능한 리스트(이하 정렬 가능 리스트).<br/>
 * 내부적으로 jquery-ui의 sortable 을 사용한다.
 * @see artn.lib.ListController
 * @see artn.lib.BaseController
 */
artn.lib.SortableList = function(){

};
artn.lib.SortableList.prototype = new artn.lib.ListController();
$.extend(artn.lib.SortableList.prototype, {
	/**
	 * @ignore
	 */
	constructor : artn.lib.SortableList,
	/**
	 * 생성자.<br/>
	 * 각종 옵션과 설정을 초기화 하고 이벤트 등록을 한다.
	 * @param {String} strSelector 컨트롤러로 만들 요소에 대한 선택자.
	 * @param {Map} mOption 생성 시 필요한 옵션들.
	 * @returns {artn.lib.ListController}
	 */
	init : function(strSelector, mOption){
		artn.lib.ListController.prototype.init.call(this, strSelector, mOption);
		
		this._option.renumber = (this._option.renumber === undefined)? true : (this._option.renumber === "true"); // Sortable List는 기본적으로 renumber 가 true다.
		
		this._jqContainer.sortable({
            beforeStop: function(event, ui){
            	var inst = $(this).data("inst");
                inst.renumber();
            }
        });
        
		this._jqContainer.disableSelection();
		this._jqContainer.data("inst", this);
		this.renumber();
		
		return this;
	},
	/**
     * 해당 아이템 요소에 클릭 이벤트를 적용 시킨다.<br/>
     * 이벤트 등록 시 그 아이템 요소 내에 아래와 같은 특정 class 요소만을 찾아 적용 된다.
     * <ul>
     * <li>.select : '<b>선택 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 '선택 상태'가 되며 selectclick 이벤트가 수행 된다.</li>
     * <li>.edit : '<b>수정 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 editclick 이벤트가 수행 된다.</li>
     * <li>.delete : '<b>삭제 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 remove 이벤트가 수행 된다.</li>
     * <li>.itemup : '<b>올리기 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 해당 아이템의 순서가 한칸 위로 올라 간다. 만약 최상단에 있다면 수행이 취소 된다.</li>
     * <li>.itemdown : '<b>내리기 버튼</b>' 역할을 하는 요소를 의미 한다. 클릭 시 해당 아이템의 순서가 한칸 아래로 내려 간다. 만약 최하단에 있다면 수행이 취소 된다.</li>
     * </ul>
     * @param {jQuery} jqItem 이벤트를 등록할 요소.
     * @param {Map} mData 이벤트 등록 시 넘겨줄 데이터.
     */
    bindClickEvent : function( jqItem, mData ){
//    	jqItem.dblclick({inst: this, item: mData}, function(e){
//            var inst = e.data.inst;
//            inst.onitemdblclick(inst, e.data.item, jqItem);
//        });

        jqItem.find(".select").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.onselectclick(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this );
        	
        	return false;
        });
        jqItem.find(".edit").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.oneditclick(inst, e.data.item, jqItem, inst.indexOf( jqItem ), this );
        	
        	return false;
        });
        jqItem.find(".delete").click({inst: this, item: mData}, function(e){
        	var inst = e.data.inst;
        	inst.remove( jqItem, this );
        	
        	return false;
        });
        jqItem.find(".itemup").click({inst: this}, this._onItemUpClick);
        jqItem.find(".itemdown").click({inst: this}, this._onItemDownClick);
    },
    /**
     * bindClickEvent 로 .itemup 에 이벤트가 등록 되었을 때 수행 된다.
     * @param {Object} e 이벤트 객체
     * @returns {Boolean} anchor 태그의 기능을 방지하기 위하여 false를 반환 한다.
     * @see {artn.lib.SortableList.bindClickEvent}
     */
    _onItemUpClick : function(e){
    	var jqLi = $(this).parents("li");
    	
    	if (jqLi.length === 0){
    		jqLi = $(this).parents("tr");
    	}
    	jqLi.after(jqLi.prev());
    	
    	if (e.data.inst._option.renumber){
    		e.data.inst.renumber();
    	}
    	
    	return false;
    },
    /**
     * bindClickEvent 로 .itemdown 에 이벤트가 등록 되었을 때 수행 된다.
     * @param {Object} e 이벤트 객체
     * @returns {Boolean} anchor 태그의 기능을 방지하기 위하여 false를 반환 한다.
     * @see {artn.lib.SortableList.bindClickEvent}
     */
    _onItemDownClick : function(e){
    	var jqLi = $(this).parents("li");
    	
    	if (jqLi.length === 0){
    		jqLi = $(this).parents("tr");
    	}
    	jqLi.before(jqLi.next());
    	
    	if (e.data.inst._option.renumber){
    		e.data.inst.renumber();
    	}
    	
    	return false;
    }
});




/**
 * 비동기 양식을 적용할 수 있다.<br/>
 * 이 것에 적용된 form 요소로 검색 시 검색 결과를 설정 해 놓은 컨트롤러로 자동으로 전달 한다.
 * @returns {artn.lib.AsyncForm}
 */
artn.lib.AsyncForm = function(){
	this.regEvent( "success" );
};
artn.lib.AsyncForm.prototype = new artn.lib.BaseController();
$.extend(artn.lib.AsyncForm.prototype, {
	/**
	 * @ignore
	 */
	constructor : artn.lib.AsyncForm,
	/**
	 * 생성자.<br/>
	 * 각종 옵션과 설정을 초기화 하고 이벤트 등록을 한다.
	 * @param {String} strSelector 컨트롤러로 만들 요소에 대한 선택자.
	 * @param {Map} mOption 생성 시 필요한 옵션들.
	 * @returns {artn.lib.ListController}
	 */
	init : function(strSelector, mParams){
		artn.lib.BaseController.prototype.init.call(this, strSelector, mParams);
    	
		this._initOption( "response-type", "string" );
		this._initOption( "message-type", "alert" );
		//this._initOption( "messageType", "alert" );
    	this._jqContainer.unbind("submit");
    	this._jqContainer.submit( {inst: this}, this._onSubmitClick );
        
        return this;
	},
	/**
	 * <h4>프로퍼티</h4>
	 * 컨트롤러의 action url을 설정하거나 가져온다.
	 * @param {String} strUrl 설정할 URL
	 * @returns {String}
	 */
	action : function(strUrl){
        if (strUrl){
            this._jqContainer.attr("action", strUrl);
        }
        else{
            return this._jqContainer.attr("action");
        }
    },
    /**
     * 컨트롤러 내부의 입력 요소에서 값을 가져온다.
     * @param {String} sName 값을 가져올 요소의 이름.
     * @returns {String}
     */
    get : function(sName){
		try{
			return this._jqContainer.find( "*[name='" + sName + "']" ).val();
		}
		catch(e){
			return undefined;
		}
	},
	/**
	 * 컨트롤러 내부의 입력 요소에 값을 설정한다.
	 * @param {String} sName 값을 설정할 요소의 이름.
	 * @param {String} sValue 설정할 값.
	 */
	set : function(sName, sValue){
		try{
			this._jqContainer.find( "*[name='" + sName + "']" ).val( sValue );
		}
		catch(e){ }
	},
	/**
	 * 
	 * @param e
	 * @returns {Boolean}
	 */
    _onSubmitClick : function(e){
    	var inst = e.data.inst;
        try{
        	$.post( inst._jqContainer.attr("action"), inst._jqContainer.serialize(), function(data){
        		var saData = null;
        		var mData = null;
        		var sMessage = "";
        		
        		if (inst._option["response-type"] === "string"){
        			saData = data.split("|");
        			sMessage = saData[1] || "입력 완료";
        			mData = {message: sMessage, code: saData[0], arrayData: saData, data: data};
        		}
        		else if (inst._option["response-type"] === "json"){
        			mData = $.parseJSON( data );
        			sMessage = mData.__message || mData._message || mData.message || "입력 완료";
        		}
        		
        		if (inst._option["message-type"] === "alert"){
        			alert( sMessage );
        		}
        		else if (inst._option["message-type"] === "message"){
        			inst._jqContainer.find(".message").html( sMessage );
        		}
        		
        		inst.onsuccess( inst, mData );
        	});
        }
        catch(e){
        	try{console.log(e.toString());}
            catch(e){}
        }
        return false;
    },

    submit : function(handler){
    	if (typeof handler === "function"){
    		this.evt_submit = handler; 
    		return this;
    	}
    	else if (typeof handler === "object"){
    		this._jqContainer.find("input").each(function(index){
    			var jqInput = $(this);
    			
    			if (handler.hasOwnProperty( jqInput.attr("name") ) === true){
    				jqInput.val( handler[ jqInput.attr("name") ] );
    			}
    		});
    	}
    	
    	this._jqContainer.submit();
    }
});


artn.lib.AsyncSearch = function(){
    this._page = 0;
    this._rowlimit = 10;
    this._currLen = 0;
    this._listType = "";
    this._listTo = null;
    this._jqTo = null;
    //this._cache = [];
    
    this.evt_read = Artn.EmptyMethod;
    this.evt_submit = Artn.EmptyMethod;
    this.regEvent( "success" );
    this.regEvent( "dataerror" );
};
artn.lib.AsyncSearch.prototype = new artn.lib.BaseController();
$.extend(artn.lib.AsyncSearch.prototype, {
	constructor : artn.lib.AsyncSearch,
    init : function(strSelector, mParams){
    	artn.lib.BaseController.prototype.init.call(this, strSelector);
    	
    	this._initOption("to", undefined);
    	this._initOption("rcvtype", this.getRcvType( this._option.to ) );
    	this._initOption("buttons", "");
    	this._initOption("rowlimit", 10);
    	this._initOption("auto-load", false);
    	this._initOption("cross-domain", false);

    	var sButtons = this._option.buttons;
    	var jqButtons = null;
    	
    	if (sButtons !== ""){
    		jqButtons = this._jqContainer.find(".next, .prev");
    	}
    	else if (sButtons.indexOf(",") >= 0){
    		jqButtons = $(sButtons);
    	}
    	else{
    		jqButtons = $(sButtons).find(".next, .prev");
    	}

    	this.receiveType( jqButtons );

    	this._jqContainer.unbind("submit");
    	this._jqContainer.submit( {inst: this}, this.onSubmitClick );
        if ( this._jqContainer.find("[name='page']").length === 0 ){
        	this._jqContainer.append( Artn.Util.createHidden("page", this._page) );
        }
        if ( this._jqContainer.find("[name='rowlimit']").length === 0 ){
        	this._jqContainer.append( Artn.Util.createHidden("rowlimit", this._option.rowlimit ) );
        }
        
        // TODO: 비동기 다중 요청이 될 수 있으므로 이 점 수정 할 것 - 2013.11.12 by jhson
        if (this._option["auto-load"] === true){
        	this.submit();
        }
        
        return this;
    },

    receiveType : function(jqButtons){
    	if (this._option.to){
    		var sRcvType = this._option.rcvtype;
    		
    		if (this._option.to === "") return;
    		
    		if (sRcvType === "infinite"){
    			this.submit(function(sender){
    				Artn.InfiniteList.inst[ sender._option.to ].clear();
    			})
    			.read(function(data, sender){
    				Artn.InfiniteList.inst[ sender._option.to ].addRange(data);
    			});
    		}
    		else if (sRcvType === "list"){
    			this.submit(function(sender){
    				Artn.List.inst[ sender._option.to ].clear();
    			})
    			.read(function(data, sender){
    				Artn.List.inst[ sender._option.to ].clear();
    				Artn.List.inst[ sender._option.to ].addRange(data);
    			});
    		}
    		else if (sRcvType === "form"){
    			this.read(function(data, sender){
    				var mData = null;
    				
    				if ($.isArray(data) === true){
    					mData = data[0];
    				}
    				else{
    					mData = data;
    				}
    				
    				Artn.Util.deserialize( $( sender._option.to ), mData );
    			});
    		}
    		else {
    			this.submit(function(sender){
    				$(sender._option.to).empty();
    			})
    			.read(function(data, sender){
    				$(sender._option.to).append( data );
    			});
    		}
    		
    		jqButtons.click({inst: this}, function(e){
    			var jqThis = $(this);
    			var inst = e.data.inst;

    			if (jqThis.hasClass("next") === true){
    				inst.next();
    			}
    			else{
    				inst.prev();
    			}
    		});
    		
    	}
    	else{
    		return this._option.rcvtype;
    	}
    },
    get : function(sName){
		try{
			return this._jqContainer.find( "*[name='" + sName + "']" ).val();
		}
		catch(e){
			return undefined;
		}
	},
	set : function(sName, sValue){
		try{
			this._jqContainer.find( "*[name='" + sName + "']" ).val( sValue );
		}
		catch(e){ }
	},
    action : function(){
        if (arguments.length > 0){
            var strUrl = arguments[0];
            this._jqContainer.attr("action", strUrl);
        }
        else{
            return this._jqContainer.attr("action");
        }
    },
    page : function(){
        if (arguments.length > 0){
            //setter
            this._page = arguments[0];
            this._jqContainer.find("[name='page']").val(this._page);
        }
        else{
            //getter
            return this._page;
        }
    },
    rowlimit : function(){
    	if (arguments.length > 0){
    		this._rowlimit = arguments[0];
    		this._jqContainer.find("[name='rowlimit']").val(this._option.rowlimit);
    	}
    	else{
    		return this._option.rowlimit;
    	}
    },
    next : function(){
        this.page( this._page + 1 );
        this._read();
    },
    prev : function(){
    	this.page( this._page - 1 );
    	this._read();
    },
    _read : function(){
    	var jqForm = this._jqContainer;
    	var inst = this;
    	var sAction = jqForm.attr("action");
    	var isCrossDomain = this._option["cross-domain"];

//    	if( sAction.indexOf("?") > 0){
//    		sAction = sAction + "&";
//    	}else{
//    		sAction = sAction + "?";
//    	}
    	
    	$(jqForm).ajaxStart(function(){
    		jqForm.find(".artn-loading-overlay").fadeIn();
    	});
    	
    	$.post( sAction, jqForm.serialize(), function(data){
    		var mData;
    		
    		try{
    			mData = $.parseJSON(data);
    		}
    		catch(e){
    			Artn.Ajax.AsyncSearch = Artn.Ajax.AsyncSearch || {};
    			inst.ondataerror( inst, {response: data} );
    			mData = Artn.Ajax.AsyncSearch.data || {};
    		}
    		
    		inst.onsuccess( inst, mData );
    		inst._currLen = mData.length;
    		inst.evt_read( mData, inst );
    		
    	}).fail(function(jqXHR, textStatus, errorThrown) {
    		alert(textStatus + errorThrown);
    	});
    	
    	$(jqForm).ajaxError(function(){
    		alert("검색 결과가 존재하지 않습니다.");
    		jqForm.find(".artn-loading-overlay").fadeOut(200);
    	});
    	
    	$(jqForm).ajaxStop(function(){
    		jqForm.find(".artn-loading-overlay").fadeOut(200);
    	});
    },
    hasNext : function(){
    	return this._currLen >= this._option.rowlimit;
    },
    hasPrev : function(){
    	return this._page > 0;
    },
    
    onSubmitClick : function(e){
    	var inst = e.data.inst;
        try{
        	inst.page( 0 );
        	inst.evt_submit( inst );
        	inst.next();
        }
        catch(ex){
            alert(ex.toString());
        }
        return false;
    },
    /* events */
    
    read : function(handler){ this.evt_read = handler; return this; },
    submit : function(handler){
    	if (typeof handler === "function"){
    		this.evt_submit = handler; 
    		return this;
    	}
    	else if (typeof handler === "object"){
    		this._jqContainer.find("input").each(function(index){
    			var jqInput = $(this);
    			
    			if (handler.hasOwnProperty( jqInput.attr("name") ) === true){
    				jqInput.val( handler[ jqInput.attr("name") ] );
    			}
    		});
    	}
    	
    	this._jqContainer.submit();
    }
});



artn.lib.AutoComplete = function(){
	this.saCache = {};
	this.sListCache = [];
	this.lastTermCache = "";
	this.jsonCache = {};
	this.sFormat = null;
	this.saField = [];
	this.url = "";
	this.name = "";
	this.valueKey = "";
	this.type = "";
	this.saDataFromKeys = [];
	this.saDataToKeys = [];
	
	//this.evt_onselected = Artn.EmptyMethod;
};
artn.lib.AutoComplete.prototype = new artn.lib.BaseController();
$.extend(artn.lib.AutoComplete.prototype, {
	constructor : artn.lib.AutoComplete,
	init : function(strSelector){
		artn.lib.BaseController.prototype.init.call(this, strSelector);
		
		this.regEvent("selected");
		this.sFormat = Artn.Util.extractTemplate( this._jqContainer.data("format") );
		this.saField = this._jqContainer.data("field").split(",");
		this.url = this._jqContainer.data("url");
		this.name = this._jqContainer.attr("name");
		this.valueKey = this.parseDataField();
		this.type = this._jqContainer.data("type");
		
		
		var iMinLen = parseInt( this._jqContainer.data("minlen") );
		
		
		this._jqContainer.data("inst", this);
		this._jqContainer.bind("focus", function(){
			Artn.Instance.ac = $(this).data("inst");
		});
		this._jqContainer.autocomplete({
			minLength: iMinLen,
			source: this.readJsonData
		});
		this._jqContainer.on( "autocompleteselect", {inst: this}, function(e, ui){
			var inst = e.data.inst;
			var iLen = inst.saDataToKeys.length;
			var sDataFromKey = "";
			var sDataToKey = "";
			var sDataValue = "";
			
			for (var i = 0; i < iLen; i++){
				sDataFromKey = inst.saDataFromKeys[ i ];
				sDataToKey = inst.saDataToKeys[ i ];
				sDataValue = ui.item.data[ sDataFromKey ];
				$("." + sDataToKey).html( sDataValue );
				$("input[name='" + sDataToKey + "']" ).val( sDataValue );
			}
			
			inst.onselected(inst, ui.item, undefined, undefined, undefined);
		});
		
		return this;
	},
	readJsonData : function(request, response){
		var term = request.term;
		var inst = Artn.Instance.ac;
		
		if (( inst.type === "map" ) && 
			( term in inst.sListCache )){
			return;
		}
		
		if ( term in inst.saCache ){
			response( inst.saCache[ term ] );
			return;
		}
		
		request[ inst.name ] = term;
		this.lastTermCache = term;
		$.getJSON( inst.url, request, function(data){
			var inst = Artn.Instance.ac;
			inst.jsonCache = data;
			
			if (inst.type === "map"){
				inst.saCache[ term ] = inst.getFormattedList(data);
			}
			else{
				inst.saCache[ term ] = data;
				inst.sListCache = data;
			}
			response( inst.saCache[ term ] );
		});
	},
	parseDataField : function(){
		var iLen = this.saField.length;
		var sValueKey = "";
		var index = 0;
		var sField = "";
		var saDataPair = [];
		
		for(var i = 0; i < iLen; ++i){
			sField = this.saField[i];
			if (sField.charAt(0) === "#"){
				this.saField[i] = sField.replace("#", "");
				sValueKey = this.saField[i];
			}
			else if (sField.charAt(0) === "@"){
				saDataPair = sField.split( ":" );
				this.saField[i] = saDataPair[0].replace("@", "");
				this.saDataFromKeys[ index ] = this.saField[i];
				this.saDataToKeys[ index ] = (saDataPair.length === 2)? saDataPair[1] : this.saDataFromKeys[ index ];
				index++;
			}
		}
		
		return sValueKey;
	},
	getFormattedList : function(maData){
		var saValue = [];
		var iLen = maData.length;
		var template = this.sFormat;
		
		this.sListCache = {};
		
		for (var i = 0; i < iLen; ++i){
			saValue[ i ] = {
				label: template.process( maData[i] ), 
				value: maData[i][this.valueKey], 
				data: maData[i]
			};
			this.sListCache[ maData[i][this.valueKey] ] = 0;
		}
		
		return saValue;
	},
	selected : function(fn){ this.evt_onselected = fn; },
	onSelected : function(sender, item){
		this.evt_onselected(sender, item);
	}
});

/*
this._initOption( "action-show", "show" );
		this._initOption( "action-edit", "edit" );
		this._initOption( "action-modify", "modify" );
		this._initOption( "action-delete", "delete" );
		this._initOption( "action-delete", "delete" );
 */
artn.lib.PageNav = function(){
	this.CSS_FIRST = "artn-icon-32 page-first";
	this.CSS_PREV = "artn-icon-32 page-prev";
	this.CSS_NEXT = "artn-icon-32 page-next";
	this.CSS_LAST = "artn-icon-32 page-last";
	
	this.FONT_ENG_FIRST = "First";
	this.FONT_ENG_PREV = "Prev";
	this.FONT_ENG_NEXT = "Next";
	this.FONT_ENG_LAST = "Last";
	this.FONT_KOR_FIRST = "처음";
	this.FONT_KOR_PREV = "이전";
	this.FONT_KOR_NEXT = "다음";
	this.FONT_KOR_LAST = "맨끝";
	this.FONT_SYMBOL_FIRST = "&#171;";
	this.FONT_SYMBOL_PREV = "&#8249;";
	this.FONT_SYMBOL_NEXT = "&#8250;";
	this.FONT_SYMBOL_LAST = "&#187;";
	
	this._page = 1;
	this._lastPage = 1;
	this._rowCount = 0;
	this._navFirstPage = 0;
	this._navLastPage = 0;
	
	this.regEvent("pageclick");
	this.regEvent("pageclick");
};
artn.lib.PageNav.prototype = new artn.lib.BaseController();
$.extend(artn.lib.PageNav.prototype, {
	constructor : artn.lib.PageNav,
	init : function(strSelector, mOption){
		artn.lib.BaseController.prototype.init.call(this, strSelector, mOption);
		
		this._initOption( "font", "eng" );
		this._initOption( "action-list", "list" );
		this._initOption( "rowlimit", 10 );
		this._initOption( "navcount", 5 );
		//this._initOption( "rowcount", 10 );

		this._createPageNavBody();
		
		return this;
	},
	
	_initFont : function(){
		var sFont = this._option["font"];
		var saFont = [];
		
		if (sFont === "eng"){
			saFont[0] = this.FONT_ENG_FIRST;
			saFont[1] = this.FONT_ENG_PREV;
			saFont[2] = this.FONT_ENG_NEXT;
			saFont[3] = this.FONT_ENG_LAST;
		}
		else if (sFont === "kor"){
			saFont[0] = this.FONT_KOR_FIRST;
			saFont[1] = this.FONT_KOR_PREV;
			saFont[2] = this.FONT_KOR_NEXT;
			saFont[3] = this.FONT_KOR_LAST;
		}
		else {
			saFont[0] = this.FONT_SYMBOL_FIRST;
			saFont[1] = this.FONT_SYMBOL_PREV;
			saFont[2] = this.FONT_SYMBOL_NEXT;
			saFont[3] = this.FONT_SYMBOL_LAST;
		}
		
		return saFont;
	},
	_createPageNavBody : function(){
		var saFont = this._initFont();
		var jqChildAnchor = null;
		
		this._jqContainer.addClass("page-controller");
		this._jqContainer.append(
			"<a class=\"" + this.CSS_FIRST + "\" href=\"#\">" + saFont[0] + "</a> " +
			"<a class=\"" + this.CSS_PREV + "\" href=\"#\">" + saFont[1] + "</a> " +
			"<span>" +
			//"<a class=\"page-num\">1</a>" + 
			"</span>" +
			"<a class=\"" + this.CSS_NEXT + "\" href=\"#\">" + saFont[2] + "</a> " + 
			"<a class=\"" + this.CSS_LAST + "\" href=\"#\">" + saFont[3] + "</a> "
		);
		
		jqChildAnchor = this._jqContainer.children("a");
		jqChildAnchor.eq(0).click({inst: this}, function(e){
			e.data.inst._onPageClickEvent( 1, $(this) );
			
			return false;
		});
		jqChildAnchor.eq(1).click({inst: this}, function(e){
			var inst = e.data.inst;
			var iPage = inst._currFirstPage - inst._option["navcount"];
			
			if (iPage < 1){
				iPage = 1;
			}
			
			inst._onPageClickEvent(iPage , $(this) );
			
			return false;
		});
		jqChildAnchor.eq(2).click({inst: this}, function(e){
			var inst = e.data.inst;
			var iPage = inst._currLastPage + 1;
			
			if (iPage > inst._lastPage){
				iPage = inst._lastPage;
			}
			
			inst._onPageClickEvent(iPage , $(this) );
			
			return false;
		});
		jqChildAnchor.eq(3).click({inst: this}, function(e){
			var inst = e.data.inst;
			inst._onPageClickEvent( inst._lastPage, $(this) );
			
			return false;
		});
		
		this._createPageSelector(1, this._option["rowlimit"], this._option["navcount"], 1);
	},
	_createPageSelector : function(iPage, iRowLimit, iNavCount, iRowCount){
		var jqPageNumWrap = this._jqContainer.children("span");
		var jqPageNums = null;
		var iaNavNums = null;
		var iLenNavNums = 0;
		var iSelectedIndex = 0;
		var sNavNumsTag = "";
		
		this._initLastPage(iPage, iRowLimit, iRowCount);
		iaNavNums = this._getPageSelectorNumbers(iPage, iNavCount);
		iLenNavNums = iaNavNums.length;
		
		for(var i = 0; i < iLenNavNums; i++){
			sNavNumsTag += "<a href=\"#\" class=\"page-num\">" + iaNavNums[i] + "</a> ";
			
			if (iPage === iaNavNums[i]){
				iSelectedIndex = i;
			}
		}
		
		this._currFirstPage = iaNavNums[0];
		this._currLastPage = iaNavNums[ iLenNavNums - 1 ];
		
		jqPageNumWrap.empty();
		jqPageNumWrap.append( sNavNumsTag );
		jqPageNums = jqPageNumWrap.find(".page-num");
		jqPageNums.eq( iSelectedIndex ).addClass( "selected" );
		jqPageNums.click({inst: this}, function(e){
			var inst = e.data.inst;
			var jqItem = $(this);
			inst._onPageClickEvent( parseInt( jqItem.text() ), jqItem );
			
			return false;
		});
	},
	_getPageSelectorNumbers : function(iPage, iNavCount){
        var iBegin = (( parseInt((iPage - 1) / iNavCount) * iNavCount) + 1);
        var iMaxCount = ((this._lastPage - iPage) < (this._lastPage % iNavCount))? this._lastPage % iNavCount : iNavCount;
        var iCurrent = iBegin;
        var iaRet = [];
        
        for(var i = 0; i < iMaxCount; ++i){
            iaRet[i] = iCurrent;
            ++iCurrent;
        }
        
        return iaRet;
    },
    _initLastPage : function(iPage, iRowLimit, iRowCount){
    	this._lastPage = parseInt(iRowCount / iRowLimit) + ( ((iRowCount % iRowLimit) > 0)? 1 : 0);
		if (this._lastPage < 1) this._lastPage = 1;
        if (iPage > this._lastPage) iPage = this._lastPage;
	},
	_onPageClickEvent : function(iPage, jqItem){
		var index = Artn.Util.indexOf( jqItem );
		var mItem = {
			page: iPage,
			rowLimit: this._option["rowlimit"],
			rowCount: this._rowCount,
			navCount: this._option["navcount"],
			lastPage: this._lastPage
		};

		this.onpageclick(this, mItem, jqItem, index, jqItem.get(0));
		this.setPage(iPage);
		
		return false;
	},
	
	option : function(sName, value){
		this._option[sName] = value;
	},
	setPage : function(iPage){
		if (iPage > this._lastPage){
			iPage = this._lastPage;
		}
		else if (iPage < 1){
			iPage = 1;
		}

		if ((iPage > this._currLastPage) ||
			(iPage < this._currFirstPage)){
			this._createPageSelector(iPage, this._option["rowlimit"], this._option["navcount"], this._rowCount);
		}
		else{
			var jqPageNums = this._jqContainer.find(".page-num");
			jqPageNums.removeClass("selected");
			jqPageNums.eq( this._currFirstPage - iPage ).addClass("selected");
		}
		
		this._page = iPage;
	},
	setRowLimit : function(iRowLimit){
		
	},
	setNavCount : function(iNavCount){
		
	},
	setRowCount : function(iRowCount){
		this._rowCount = iRowCount;
		this._initLastPage( this._page, this._option["rowlimit"], iRowCount );
	},
	next : function(){
		
	},
	prev : function(){
		
	},
});

//TODO : 3depth 이상 옆으로 메뉴 펼쳐지는 기능 - 130730 by shkang
//TopMenu by shkang_20130709
artn.lib.GlobalNav = function(){
	this.TYPE_VERTICAL = "vertical";
	this.TYPE_HORIZONTAL = "horizon";
	this.TYPE_ALL = "all";
	this.TYPE_WIDE = "wide";
	this.ANIMATE_NORMAL = "normal";
	this.ANIMATE_SLIDE = "slide";
	this.ANIMATE_FADE = "fade";
	this.sContext = "";
	this.jqTopMenu = null;
	this.sMenuType = "";
	this.iDepthType = 0;
	this.sAnimateType = "";
	this.sAllMenu = "";
	this.sBgHeight = "";
};
artn.lib.GlobalNav.prototype = {
	init : function(strId){
		this.sContext = strId;
		this.jqTopMenu = $(this.sContext);
		this.sMenuType = this.jqTopMenu.data("type") || "vertical";
		this.iDepthType = parseInt( this.jqTopMenu.data("depth") || 1 );
		this.sAnimateType = this.jqTopMenu.data("animate") || "normal";
		
		this.setDepthType(this.iDepthType);
		
		//allMenu 생성
		this.jqTopMenu.children("ul").wrap("<div class=\"wrap\"/>");
		this.sAllMenu = this.jqTopMenu.find(".wrap").html();
		this.jqTopMenu.find(".wrap>ul").unwrap();
		$("#allMenuView").html(this.sAllMenu).append("<div id=\"allMenuClose\"><a href=\"#\">닫기</a></div>");
		$("#allMenuView").children("ul").css("display","inline-block");
		$("#allMenuView").css("display","inline").css("margin","0 auto").hide();
		
		this.setMenuType(this.sMenuType);
		this.depthAddClass(this.jqTopMenu, this.iDepthType);
		
		this.mainMouseOver();
	    if( (this.sMenuType === this.TYPE_VERTICAL) || (this.sMenuType === this.TYPE_HORIZONTAL) ){
			this.subMouseOver();
		}
	    this.allMenuClick();
    	this.outSideEvent(strId);
	    return this;
	},
	setMenuType : function(sMenu){
		var leftWidth = "-"+(parseInt(this.jqTopMenu.children("ul").css("width")))/2+"px";
		
		if(sMenu === this.TYPE_VERTICAL){
			this.jqTopMenu.addClass(this.TYPE_VERTICAL);
		}else if(sMenu === this.TYPE_HORIZONTAL){
			this.jqTopMenu.addClass(this.TYPE_HORIZONTAL);
//				this.jqTopMenu.find(">ul>li>ul").css("margin-left",leftWidth);
		}else if(sMenu === this.TYPE_ALL){
			this.jqTopMenu.addClass(this.TYPE_ALL);
		}else if(sMenu === this.TYPE_WIDE){
			this.jqTopMenu.addClass(this.TYPE_WIDE);
		}
		
		if( (sMenu === this.TYPE_ALL) || (sMenu === this.TYPE_WIDE) ){
			var bgBarWidth = this.jqTopMenu.children("ul").css("width");
			
			if(this.iDepthType === 1){
				ulHeight = 0;
			}
			this.jqTopMenu.after("<div class=\"allBar\"/>");
			$(".allBar").css("width", bgBarWidth).css("margin-left",leftWidth).hide();
			this.jqTopMenu.find(">ul>li>ul").each(function(index){
				$(".allBar").append($(this).clone().css("width",$(this).parent().css("width")));
				$(this).empty();
			});
			if(sMenu === this.TYPE_WIDE){
				bgBarWidth = "100%";
				$(".allBar").wrap("<div class=\"wideBar\"/>");
				$(".wideBar").css("width", bgBarWidth).css("height",$(".allBar").css("height")).hide();
			}
		}
	},
	setDepthType : function(iDepth){
		switch (iDepth)
		{
		case 1 : this.jqTopMenu.find(">ul>li ul").empty();
				 break;
		case 2 : this.jqTopMenu.find(">ul>li>ul>li ul").empty();
		 		 break;
		case 3 : this.jqTopMenu.find(">ul>li>ul>li>ul>li ul").empty();
		 		 break;
		case 4 : this.jqTopMenu.find(">ul>li>ul>li>ul>li>ul>li ul").empty();
		 		 break;
		default : this.jqTopMenu.find(">ul>li ul").empty();
		}
	},
	mainMouseOver : function(){
		this.jqTopMenu.find(">ul>li>a").mouseover({inst: this}, function(e){
			var inst = e.data.inst;
			if( (inst.sMenuType === inst.TYPE_VERTICAL) || (inst.sMenuType === inst.TYPE_HORIZONTAL) ){
				inst.menuCloseAnimate($(this).parent().siblings().find(">ul"), inst.sAnimateType);
				if( (inst.sMenuType === inst.TYPE_VERTICAL) && (inst.iDepthType >= 3) ){
					inst.showMenu($(this).parent(), true, 2);
				}else{
					inst.menuOpenAnimate($(this).parent().children("ul"), inst.sAnimateType);
				}
			}
			else{
				if( inst.iDepthType >= 3 ){
					inst.showMenu(inst.jqTopMenu, true, 3);
				}else{
					inst.menuOpenAnimate(inst.jqTopMenu.find("ul"), inst.sAnimateType);
				}
				if( (inst.sMenuType === inst.TYPE_WIDE) || (inst.sMenuType === inst.TYPE_ALL) ){
					inst.menuOpenAnimate($(".wideBar"), inst.sAnimateType);
					inst.menuOpenAnimate($(".allBar"), inst.sAnimateType);
				}
			}
	    });
	},
	subMouseOver : function(){
		this.jqTopMenu.find(">ul>li ul li a").mouseover({inst: this},function(e){
			var inst = e.data.inst;
				if(inst.sMenuType === inst.TYPE_HORIZONTAL){
					inst.menuCloseAnimate($(this).parent().siblings().find("ul"), inst.sAnimateType);
					$(this).parent().children("ul").css("width","100%").css("position","absolute").css("left","0px"); //left 삭제시 메인메뉴 바로 밑에 메뉴 호출, position:absolute; 추가시 밑으로 안밀어냄
					$(this).parent().children().children("li").css("float","left");
				}else{
					inst.menuCloseAnimate($(this).parentsUntil(inst.sContext+">ul>li").siblings().find(".depth4"), inst.sAnimateType);	
				}
				inst.menuOpenAnimate($(this).parent().children("ul"), inst.sAnimateType);
		});
	},
	showMenu : function(jqElem, isShow, intDepth, intCurr){
		var iCurr = intCurr || 1;
		var jqLi = jqElem.find(">ul"); 
		this.menuOpenAnimate(jqLi, this.sAnimateType);
		if (iCurr < intDepth){
			jqLi = jqLi.find(">li");
			this.showMenu( jqLi, isShow, intDepth, ++iCurr );
		}
	},
	allMenuClick : function(){
		$(".allMenu").click({inst: this},function(e){
			var inst = e.data.inst;
			if($("#allMenuView").css("display") === "none"){
				$("#allMenuView").css("position","absolute").css("z-index","101");
				$("#allMenuClose").css("text-align","right");
				inst.menuOpenAnimate($("#allMenuView"), inst.sAnimateType);
			}else{
				inst.menuCloseAnimate($("#allMenuView"), inst.sAnimateType);
			}
			inst.allMenuClose();
		});
	},
	allMenuClose : function(){
		$("#allMenuClose a").click({inst: this},function(e){
			var inst = e.data.inst;
			inst.menuCloseAnimate($("#allMenuView"), inst.sAnimateType);
		});
	},
	menuOpenAnimate : function(jqTarget, sAnimateType){
		if(sAnimateType === this.ANIMATE_NORMAL){
			jqTarget.show();
		}else if(sAnimateType === this.ANIMATE_SLIDE){
			jqTarget.slideDown();
		}else if(sAnimateType === this.ANIMATE_FADE){
			jqTarget.fadeIn();
		}
	},
	menuCloseAnimate : function(jqTarget, sAnimateType){
		if(sAnimateType === this.ANIMATE_NORMAL){
			jqTarget.hide();
		}else if(sAnimateType === this.ANIMATE_SLIDE){
			jqTarget.slideUp();
		}else if(sAnimateType === this.ANIMATE_FADE){
			jqTarget.fadeOut();
		}
	},
	outSideEvent : function(strId){
		Artn.OutsideEvent.add("#allMenuView", this, function(data){
	    	var inst = data.inst;
	    	inst.menuCloseAnimate( $(data.currentTarget), inst.sAnimateType );
	    });
    	
	    if(this.sMenuType === this.TYPE_ALL){
	    	Artn.OutsideEvent.add(".allBar", this, function(data){
		    	var inst = data.inst;
		    	inst.menuCloseAnimate( $(data.currentTarget), inst.sAnimateType );
		    });
		}else if( this.sMenuType === this.TYPE_WIDE ){
			Artn.OutsideEvent.add(".wideBar", this, function(data){
		    	var inst = data.inst;
		    	inst.menuCloseAnimate( $(data.currentTarget), inst.sAnimateType );
		    });				
		}
    	Artn.OutsideEvent.add(strId + ">ul>li ul", this, function(data){
	    	var inst = data.inst;
	    	inst.menuCloseAnimate( $(data.currentTarget), inst.sAnimateType );
	    	inst.menuCloseAnimate( $(".bgBar"), inst.sAnimateType );
	    });
    	Artn.OutsideEvent.addExcept(".wideBar");
	},
	depthAddClass : function(jqElem, intDepth, intCurr){
		var iCurr = intCurr || 1;
		var jqLi = jqElem.find(">ul");
		jqLi.addClass("depth"+iCurr);
		if (iCurr <= intDepth){
			jqLi = jqLi.find(">li");
			this.depthAddClass( jqLi, intDepth, ++iCurr );
		}
	}
};

artn.lib.Scroller = function(){
	this.sScrollerType = "";
	this.sAutoPlayType = "";
	this.iScrollerChangeTime = 0;
	this.sScrollerTransSpeed = "normal";
	this.iScrollerClearTime = 0;
	this.iScrollerViewLength = 0;
	this.iScrollerViewNum = 0;
	this.bScrollerViewFirst = false;
	this.iShowCount = 0;
	this.iLeft = 0;
	this.iImgWidth = 0;
//	this.time = 0;
};
artn.lib.Scroller.prototype = {
	init : function(strId){
		this.sContext = strId;
		this.jqScroller = $(this.sContext);
		this.sScrollerType = this.jqScroller.data("type") || "slide";
		this.sAutoPlayType = this.jqScroller.data("auto") || "on";
		this.iScrollerChangeTime = parseInt(this.jqScroller.data("time") || "5000");
		this.sScrollerTransSpeed = this.jqScroller.data("speed") || "normal";
		this.iImgWidth = parseInt(this.jqScroller.data("imgWidth") || "234"); 
		this.iScrollerViewLength = this.jqScroller.find(".scroll_view").children("li").length;
		this.iLeft = this.jqScroller.find(".scroll_view").children("li").outerWidth(true)*this.iScrollerViewLength;
		this.iShowCount = 1;
		
		this.setOption();
		this.mouseEvent();
	    return this;
	},
	setOption : function(){
		var inst = this;
		
		if( this.sScrollerType == "slide" ){
			this.jqScroller.show();
			this.jqScroller.find(".scroll_view").children("li").hide();
			
			var img = new Image();
			
			img.onload = function(){
				if(inst.bScrollerViewFirst == false){
					inst.bScrollerViewFirst = true;
					inst.play();
				}
			};
			img.src = this.jqScroller.find(".scroll_view").children("li").eq(0).children("a").children("img").attr("src");
			if(img.complate){
				if(this.bScrollerViewFirst == false){
					this.bScrollerViewFirst = true;
					this.play();
				}
			}
		}else if(this.sScrollerType == "banner"){
			this.iScrollerClearTime = setTimeout(function(){inst.play();},this.iScrollerChangeTime);
			
			this.jqScroller.find(".scroll_view:first").children("li").hide();
			this.jqScroller.find(".scroll_view:first").children("li").slice(0,this.iShowCount).show();
			this.jqScroller.find(".scroll_view:first").width(this.iLeft);
			this.jqScroller.find(".scroll_view:first").children("li").show();
			this.jqScroller.find(".scroll_view:first").clone().prependTo(this.jqScroller.children("div"));
			this.jqScroller.find(".scroll_view:first").clone().appendTo(this.jqScroller.children("div"));
			this.jqScroller.find(".scroll_view:eq(0)").css("left",-this.iLeft);
			this.jqScroller.find(".scroll_view:eq(2)").css("left",this.iLeft);
		}
		
	},
	play : function(){
		var inst = this;	
		if(this.sAutoPlayType == "on"){
            clearTimeout(this.iScrollerClearTime);
            if(this.sScrollerType == "slide"){
            	if(this.iScrollerViewNum >= this.iScrollerViewLength){
                	this.iScrollerViewNum = 0;
                }
                this.jqScroller.find(".scroll_view").children("li").fadeOut(this.sScrollerTransSpeed);
                this.jqScroller.find(".scroll_view").children("li").eq(this.iScrollerViewNum).fadeIn(this.sScrollerTransSpeed);
                this.jqScroller.find(".scroll_nav").children("li").removeClass("selected");
                this.jqScroller.find(".scroll_nav").children("li").eq(this.iScrollerViewNum).addClass("selected");
                this.iScrollerViewNum++;
                if(this.iScrollerViewNum >= this.iScrollerViewLength){
                	this.iScrollerViewNum = 0;
                }
                this.iScrollerClearTime = setTimeout(function(){inst.play();},this.iScrollerChangeTime);	
            }else if(this.sScrollerType == "banner"){
            	this.iScrollerViewNum++;
            	this.iLeft = this.jqScroller.find(".scroll_view:first").children("li").outerWidth(true)*this.iScrollerViewLength;
            	if(this.iScrollerViewNum >= this.iScrollerViewLength + 1){
            		this.iScrollerViewNum = 0;
            		this.jqScroller.find(".scroll_view:eq(0)").css("left",-this.iLeft);
                    this.jqScroller.find(".scroll_view:eq(1)").css("left","0px");
                    this.jqScroller.find(".scroll_view:eq(2)").css("left",this.iLeft);
                    if( this.jqScroller.find(".scroll_view:eq(1)").css("left") == (this.iImgWidth+10)+"px"){
                        this.jqScroller.find(".scroll_view:eq(0)").remove();
                        this.jqScroller.find(".scroll_view:eq(1)").clone().appendTo(this.jqScroller.children("div"));
                    }
                    this.iScrollerClearTime = setTimeout(function(){inst.play();},0);
                }else{
                	this.jqScroller.find(".scroll_view").animate({
                		left: "-="+(this.iImgWidth+10)
                    },500);
                	this.iScrollerClearTime = setTimeout(function(){inst.play();},this.iScrollerChangeTime);
                }
            }
        }else if(this.sAutoPlayType == "off"){
        	this.jqScroller.find(".scroll_view").children("li").eq(this.iScrollerViewNum-1).fadeIn();
        }
	},
	stop : function(jqNav) {
		clearTimeout(this.iScrollerClearTime);
		var iNavNum = jqNav.parent().children().index(jqNav);
        if(iNavNum != (this.iScrollerViewNum-1)){
        	this.iScrollerViewNum = iNavNum + 1;
        	this.jqScroller.find(".scroll_view").children("li").fadeOut();
        	this.jqScroller.find(".scroll_view").children("li").eq(iNavNum).fadeIn();
        	this.jqScroller.find(".scroll_nav").children("li").removeClass("selected");
        	this.jqScroller.find(".scroll_nav").children("li").eq(iNavNum).addClass("selected");
        }
	},
	previous : function(){
		clearTimeout(this.iScrollerClearTime);
        	this.iScrollerViewNum--;
        	if(this.iScrollerViewNum >= -(this.iScrollerViewLength + 1)){
        		this.iScrollerViewNum = 0;
        	}
            this.jqScroller.find(".scroll_view").animate({
                left: "+="+(this.iImgWidth+10)
            },500);
            
            if( this.jqScroller.find(".scroll_view:eq(0)").css("left") == (-(this.iImgWidth+10)+"px") ){
            	this.jqScroller.find(".scroll_view:eq(0)").css("left",-this.iLeft);
                this.jqScroller.find(".scroll_view:eq(1)").css("left","0px");
                this.jqScroller.find(".scroll_view:eq(2)").remove();
                this.jqScroller.find(".scroll_view:eq(0)").clone().prependTo(this.jqScroller.children("div"));
            }
	},
	next : function(){
		this.play();
	},
	mouseEvent : function(){
		var inst = this;
		if(this.sScrollerType == "slide"){
			this.jqScroller.find(".scroll_view").hover(function(){
				clearTimeout(inst.iScrollerClearTime);
	        },function(){
	        	inst.iScrollerClearTime = setTimeout(function(){inst.play();},inst.iScrollerChangeTime);
	        });
	        this.jqScroller.find(".scroll_nav").children("li").hover(function(){
	        	clearTimeout(inst.iScrollerClearTime);
	            inst.stop($(this));
            },function(){
            	inst.iScrollerClearTime = setTimeout(function(){inst.play();},inst.iScrollerChangeTime);
            }).click(function(){
            	return false;
            });	
	        
		}else if(this.sScrollerType == "banner"){
			
			this.jqScroller.hover(function(){
                clearTimeout(inst.iScrollerClearTime);
            },function(){
            	inst.iScrollerClearTime = setTimeout(function(){inst.play();},inst.iScrollerChangeTime);
            });
			this.jqScroller.find(".scroll_nav").children("li").click(function(){
	            if($(this).parent().children().index($(this))==0){
//	            	setTimeOut(inst.previous(), 1000);
	            	inst.previous();
	            }else if($(this).parent().children().index($(this))==1){
//	            	console.log(inst.time);
//	            	if(inst.time == 0){
//	            		inst.time = 1;
//	            		inst.time = setTimeout(0, 500);
	            		inst.next();
//	            	}
	            	
	            }
	            return false;
	        });
		}
	}
};


artn.lib.ComboBoxChain = function(){
	this.chain = false;
	this.url = "";
	this.to = "";
	this.src = "";
};
artn.lib.ComboBoxChain.prototype = {
	init : function(strSelector){
		var jqList_CombChain = (strSelector instanceof jQuery)? strSelector : $( strSelector );
		var jqSelect;
		var sUrl = "";
		var sTo = null;
		var sSrc = "";
		var sKeys = "";
		
		jqList_CombChain.each(function(index){
			jqSelect = $(this);
			
			if (jqSelect.data("chain") !== "true") return;
			if (jqSelect.data("src") === undefined) return;
			
			sKeys = jqSelect.data("keys");
			sUrl = jqSelect.data("url");
			sTo = jqSelect.data("to");
			sSrc = jqSelect.data("src");
			
			
			jqSelect.change({url: sUrl, to: sTo, src: sSrc, keys: sKeys}, function(e){
				var mCurr = {};
				var mParams = {};
				
				if (keys){
					mParams.keys = sKeys;
				}
				
				mCurr.chain = $(this);
				mCurr.url = e.data.url;
				mCurr.to = $(e.data.to);
				mCurr.src = $(e.data.src);
				mCurr.keys = sKeys;
				Artn.Ajax.ComboBoxChain = mCurr;
				
				$(this).after( Artn.Const.AJAX_LOADING  );
				
				$.getJSON( e.data.url, mParams, function(data){
					var mCurr = Artn.Ajax.ComboBoxChain;
					var jqTo = mCurr.to;
					var iLen = data.length;
					var saKeys = mCurr.keys.split();
					var sKey = saKeys[0];
					var sValue = saKeys[1];
					var jqOption = null;
					
					jqTo.clear();
					
					for(var i = 0; i < iLen; i++){
						jqOption = $("<option></option>");
						jqOption.attr("value", sKey);
						jqOption.text(sValue);
						jqTo.append( jqOption );
					}
					
					$( AJAX_LOADING_SMALL_CLASS ).remove();
					
				} );
			});
		});
	}
};


/*
 * 다이얼로그 클래스 시리즈
 */
artn.lib.AbsDialogButton = function(){
	
};
artn.lib.AbsDialogButton.prototype = {
	init : function(strSelector){
		var jqConfirmButton = $( strSelector || "button[data-rule='dialogButton'], input[data-rule='dialogButton'], a[data-rule='dialogButton']" );
		
		Artn.CommonUI.ConfirmButton = {};
		
		jqConfirmButton.each(function(index){			
			var jqButton = $(this);
			var jqDialog = $( jqButton.data("dialog") );
			var mParam = {
				"jqDialog": jqDialog
			};
			//1. 버튼클릭
			jqButton.click(mParam, function(e){
				var jqButton = $(this);
				var mListInfo = Artn.Util.findListType( jqButton );
				
				Artn.Ajax.ConfirmButton = {
					button: jqButton,
					dialog: e.data.jqDialog
				};
				
				if (mListInfo.type === true){
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
				//2. 폼 데이터 전송
				e.data.jqDialog.find("form").find("input[type='text'], input[type='password']").val("");
				e.data.jqDialog.find(".message").html("");
				//3. 다이얼로그 열기
				e.data.jqDialog.dialog("open");
				
				return false;
			});
			
			if ( Artn.CommonUI.ConfirmButton[ jqDialog.attr("id") ] ){
				return;
			}
			
			Artn.CommonUI.ConfirmButton[ jqDialog.attr("id") ] = true;

			jqDialog.on("dialogclose", {haha: "하하"}, function( event, ui ){
				//6. 버튼이 속한 곳의 아이템에 데이터 전달.
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
					else{
						//4. 메시지 출력
						Artn.Ajax.ConfirmButton.dialog.find(".message").html( saData[1] );
					}
					return false;
				});
				
				return false;
			});
		});
	},
	regEvent : function(strEventName, isDataPassEvent){
    	this.eventData = this.eventData || {};
    	
    	this[ strEventName ] = function(){
    		if (arguments.length === 2){
    			this.eventData[ strEventName ] = arguments[0];
    			this[ "evt_" +  strEventName ] = arguments[1];
    		}
    		else{
    			this.eventData[ strEventName ] = undefined;
    			this[ "evt_" +  strEventName ] = arguments[0];
    		}
    		
    		return this;
    	};
    	this[ "evt_" + strEventName ] = Artn.EmptyMethod;
    	
    	if (isDataPassEvent){
    		this[ "on"   + strEventName ] = function(sender, data, jqCurrent, index){
    			try{
    				item = sender.serializeSingle( jqCurrent );
    				if (sender._option.rcvtype === "form"){
    					Artn.AsyncSearch.inst[ sender._option.to ].submit( item );
    				}
    				else{
    					Artn.List.inst[ sender._option.to ].add( item );
    				}
    			}catch(e){}
        		sender[ "evt_" + strEventName ]( {sender: sender, item: item, data: this.eventData[strEventName], currentTarget: jqCurrent, index: index} );
        	};
    	}
    	else{
    		this[ "on"   + strEventName ] = function(sender, item, jqCurrent, index){
        		sender[ "evt_" + strEventName ]( {sender: sender, item: item, data: this.eventData[strEventName], currentTarget: jqCurrent, index: index} );
        	};
    	}
    }
};


artn.lib.AbsInputDialog = function(){
	this.selected = null;
	this.dialog = null;
};
artn.lib.AbsInputDialog.prototype = {
	init : function(strSelector){
		var jqDialog = $(strSelector);
		var jqButtonOK = jqDialog.find("*[id$='OK']");
		
//		jqDialog.dialog({
//            autoOpen: false,
//            modal: true,
//            show: {
//                effect: "fade",
//                duration: 500
//            },
//            hide: {
//                effect: "fade",
//                duration: 250
//            }
//        });
        
        jqButtonOK.click( this.onButtonOKClick );
        jqButtonOK.data("inst", this);
        
        this.dialog = jqDialog;
        
        return this;
	},
	onButtonOKClick : function(){
		var jqOK = $(this);
		var inst = jqOK.data("inst");
		var jqSelected = inst.selected;
		
		jqSelected.text( inst.value() );
		jqSelected.siblings("input[name='" + jqSelected.attr("class") + "']").val( jqSelected.text() );
		inst.dialog.dialog("close");
		return false;
	},
	onInputItemClick : function(){
		var jqItem = $(this);
		var inst = jqItem.data("inst");
		
		inst.selected = jqItem;
		inst.value( jqItem.text() );
		inst.dialog.dialog("open");
		return false;
	},
	value : function(val){
		if (val !== undefined){
			this.setValue(val);
		}
		else{
			return this.getValue();
		}
	},
	regist : function(strSelector_jqItem){
		var jqItem = $(strSelector_jqItem);
		jqItem.data("inst", this);
		jqItem.click( this.onInputItemClick );
	},
	
	getValue : Artn.AbstractMethod,
	setValue : Artn.AbstractMethod
};




/////////////////////////////////////////////////////////////////////

artn.lib.InputDialog = function(){
	this._jqForm = null;
	this._jqOKButton = null;
	this._jqDialogButton = null;
	this._jqDialogButtonParentItem = null;
	
	this.regEvent("dialogbuttonchange");
	this.regEvent("dialogopen");
};
artn.lib.InputDialog.prototype = new artn.lib.BaseController();
$.extend(artn.lib.InputDialog.prototype, {
	constructor : artn.lib.InputDialog,
	// override
	init : function(strSelector){
		artn.lib.BaseController.prototype.init.call(this, strSelector);
		
		this._jqForm = this._jqContainer.find("form");
		this.jqOKButton = this._jqContainer.find("*[id$='OK'], *[id$='Complete']");
		this.jqOKButton.click({inst: this}, this._onButtonOKClick);
		this._jqContainer.dialog().on("dialogbeforeclose", {inst: this}, function(e){
			var inst = e.data.inst;
			var jqDialogButton = inst._jqDialogButton;
			var mParam = inst.value();
			
			if (jqDialogButton.data("value-print") !== undefined){
				inst.ondialogbuttonchange( inst, mParam, jqDialogButton );
				jqDialogButton.text( mParam.value );
			}
			
			Artn.Util.deserialize( inst._jqDialogButtonParentItem, mParam );
		});
		
		return this;
	},
	_onButtonOKClick : function(e){
		e.data.inst._jqContainer.dialog("close");
		
		return false;
	},
	_onDialogButtonClick : function(e){
		var jqItem = e.data.jqItem;
		var inst = e.data.inst;
		var mData = Artn.Util.serializeMap( jqItem );
		
		inst._jqContainer.find(".message").html("");
		inst._jqDialogButton = $(this);
		inst._jqDialogButtonParentItem = jqItem;
		inst.value( mData );
		inst._jqContainer.dialog("open");
		inst.ondialogopen( inst, mData, jqItem );
		
		return false;
	},
	value : function(val){
		if (val){
			var saListId = Artn.Util.getContainsListId( this._jqForm );
			var sListId = "";
			var listCtrl = null;
			
			if (saListId.length > 0){
				sListId = saListId[0];
			}
			
			// 설정할 데이터가 배열일 경우
			if ($.isArray(val) === true){
				if (sListId !== ""){
					listCtrl = Artn.List.inst[ "#" + sListId ];
					listCtrl.clear();
					listCtrl.addRange( val ); 
				}
				else{
					Artn.Util.deserialize( this._jqForm, val[0] );
				}
			}
			// 설정할 데이터가 플레인 오브젝트일 경우
			else if ($.isPlainObject(val) === true){
				if (sListId !== ""){
					listCtrl = Artn.List.inst[ "#" + sListId ];
					listCtrl.clear();
					listCtrl.add( val );
					
					Artn.Util.deserialize( this._jqForm.find("*[id!='" + sListId + "']"), val );
				}
				else{
					Artn.Util.deserialize( this._jqForm, val );
				}
			}
		}
		else{
			var mResult = Artn.Util.serializeMap( this._jqForm );
			var jqInput = this._jqForm.find("input[type!='submit'][type!='button'], select, textarea");
			
			if (jqInput.length === 1){
				if (mResult.hasOwnProperty( "value" ) === false){
					mResult.value = jqInput.val();
				}
			}
			
			return mResult;
		}
	},

	// override
	regist : function(strSelector_jqDialogButton, jqItem){
		var jqDialogButton = $(strSelector_jqDialogButton);
		var inst = this;
		
		jqDialogButton.click({inst: inst, jqItem: jqItem}, inst._onDialogButtonClick );
	}
});
//////////////////////////

artn.lib.SpinnerDialog = function(){
	this.spinner = null;
};
artn.lib.SpinnerDialog.prototype = new artn.lib.AbsInputDialog();
$.extend(artn.lib.SpinnerDialog.prototype, {
	constructor : artn.lib.SpinnerDialog,
	// override
	init : function(strSelector){
		artn.lib.AbsInputDialog.prototype.init.call(this, strSelector);
		
		this.spinner = this.dialog.find("*[id^='spinner']").spinner();
		
		return this;
	},
	// implement
	getValue : function(){
		return this.spinner.spinner("value");
	},
	// implement
	setValue : function(val){
		this.spinner.spinner("value", val);
	}
});
//////////////////////////
artn.lib.AbsMultiInputDialog = function(){
	this.keys = null;
};
artn.lib.AbsMultiInputDialog.prototype = new artn.lib.AbsInputDialog();
$.extend(artn.lib.AbsMultiInputDialog.prototype, {
	constructor : artn.lib.AbsMultiInputDialog,
	// override
	init : function(strSelector, aKeys){
		artn.lib.AbsInputDialog.prototype.init.call(this, strSelector);
		
		this.keys = aKeys;
		
		return this;
	},
	// override
	onButtonOKClick : function(){
		var jqOK = $(this);
		var inst = jqOK.data("inst");
		var jqSelected = inst.selected;
		var iLen = inst.keys.length;

		for(var i = 0; i < iLen; ++i){
			jqSelected.siblings("input[name='" + inst.keys[i] + "']")
					.val( inst.getValue( inst.keys[i] ) );
		}
		
		jqSelected.text( inst.getMarkValue() );
		inst.dialog.dialog("close");
	},
	// override
	onInputItemClick : function(){
		var jqItem = $(this);
		var inst = jqItem.data("inst");
		var iLen = inst.keys.length;
		
		for(var i = 0; i < iLen; ++i){
			inst.value( inst.keys[i], jqItem.siblings("input[name='" + inst.keys[i] + "']").val() );
		}
		
		inst.selected = jqItem;
		inst.setMarkValue( jqItem.text() );
		inst.dialog.dialog("open");
	},
	// override
	value : function(key, val){
		if (val !== undefined){
			this.setValue(key, val);
		}
		else{
			return this.getValue(key);
		}
	},
	
	getMarkValue : Artn.AbstractMethod,
	setMarkValue : Artn.AbstractMethod
});

artn.lib.SpinnerDialog = function(){
	this.spinner = null;
};
artn.lib.SpinnerDialog.prototype = new artn.lib.AbsInputDialog();
$.extend(artn.lib.SpinnerDialog.prototype, {
	constructor : artn.lib.SpinnerDialog,
	// override
	init : function(strSelector){
		artn.lib.AbsInputDialog.prototype.init.call(this, strSelector);
		
		this.spinner = this.dialog.find("*[id^='spinner']").spinner();
		
		return this;
	},
	// implement
	getValue : function(){
		return this.spinner.spinner("value");
	},
	// implement
	setValue : function(val){
		this.spinner.spinner("value", val);
	}
});

artn.lib.RadioDialog = function(){
	this.radioset = null;
};
artn.lib.RadioDialog.prototype = new artn.lib.AbsInputDialog();
$.extend(artn.lib.RadioDialog.prototype, {
	constructor : artn.lib.RadioDialog,
	// override
	init : function(strSelector){
		artn.lib.AbsInputDialog.prototype.init.call(this, strSelector);
		
		var jqListRadio = this.dialog.find("input[type='radio']");
		jqListRadio.data("inst", this);

		this.radioset = jqListRadio;
		
		return this;
	},
	// implement
	getValue : function(){
		return this.radioset.parents("form").serialize().split("=")[1];
	},
	// implement
	setValue : function(val){
		this.radioset.each(function(index){
			var jqRadio = $(this);
			
			jqRadio.get(0).checked = false;
			
			if ( jqRadio.attr("value") === val ){
				jqRadio.get(0).checked = true;
			}
		});
	}
});

artn.lib.PopupOptionDialog = function(){
	this.popup = null;
	this.popup_msg = null;
	this.popup_action = {};
};
artn.lib.PopupOptionDialog.prototype = new artn.lib.AbsMultiInputDialog();
$.extend(artn.lib.PopupOptionDialog.prototype, {
	constructor : artn.lib.PopupOptionDialog,
	
	init : function(strSelector, aKeys){
		artn.lib.AbsMultiInputDialog.prototype.init.call(this, strSelector, aKeys);
		
		this.dialog.find("select").empty().append( this.makeOptions( 1, 20 ) );
		this.dialog.dialog("option", {
			width: 400, height: 400
		});
		
		this.popup = 				this.dialog.find("*[name='popup']");
		this.popup_msg = 			this.dialog.find("textarea[name='popup_msg']");
		this.popup_action.name1 = 	this.dialog.find("*[name='popup_action_name1']");
		this.popup_action.target1 = this.dialog.find("select[name='popup_action_target1']");
		this.popup_action.name2 = 	this.dialog.find("*[name='popup_action_name2']");
		this.popup_action.target2 = this.dialog.find("select[name='popup_action_target2']");
		
		this.popup.data("inst", this);
		this.popup.change(function(){
			var inst = $(this).data("inst");
			inst.enabled( this.checked );
		});
		
		return this;
	},
	makeOptions : function(intMin, intMax){
		var sOptionTags = "<option value=\"\">-</option>";
		
		for(var i = intMin; i <= intMax; ++i){
			sOptionTags += "<option value=\"" + i + "\">" + i + "</option>";
		}
		
		return sOptionTags;
	},
	enabled : function(enabled){
		if (enabled !== undefined){
			this.dialog.find("input[name!='popup'][type!='button'], select, textarea").attr( "disabled", !enabled );
		}
		else{
			return ( this.popup_msg.attr("disabled") !== "disabled" );
		}
	},
	// implement
	getValue : function(key){
		if (key === "popup"){
			return this.getMarkValue();
		}
		
		if ( this.enabled() === false ) return "";
		
		if (key === "popup_msg"){
			return this.popup_msg.val();
		}
		else if (key === "popup_action"){
			return this.popup_action.name1.val() + "," +
				this.popup_action.target1.val() + "," +
				this.popup_action.name2.val() + "," +
				this.popup_action.target2.val();
		}
	},
	// implement
	setValue : function(key, val){
		if (key === "popup"){
			this.setMarkValue(val);
		}
		else if (key === "popup_msg"){
			this.popup_msg.val(val);
		}
		else if (key === "popup_action"){
			var saVal = val.split(",");
			
			if (saVal.length < 4){
				saVal = ["", "", "", ""];
			}
			
			this.popup_action.name1.val( saVal[0] );
			this.popup_action.target1.val( saVal[1] );
			this.popup_action.name2.val( saVal[2] );
			this.popup_action.target2.val( saVal[3] );
		}
	},
	// implement
	getMarkValue : function(){
		return (this.popup.get(0).checked === true)? this.popup.attr("value") : "";
	},
	// implement
	setMarkValue : function(val){
		this.popup.get(0).checked = (val === this.popup.attr("value"));
		this.enabled( this.popup.get(0).checked );
	}
});



artn.lib.MultiInputDialog = function(){
	this.popup = null;
	this.popup_msg = null;
	this.popup_action = {};
};
artn.lib.MultiInputDialog.prototype = new artn.lib.AbsMultiInputDialog();
$.extend(artn.lib.MultiInputDialog.prototype, {
	constructor : artn.lib.MultiInputDialog,
	
	init : function(strSelector, aKeys){
		artn.lib.AbsMultiInputDialog.prototype.init.call(this, strSelector, aKeys);

		this.dialog.dialog("option", {
			width: 400, height: 400
		});
		
		this.popup = 				this.dialog.find("*[name='popup']");
		this.popup_msg = 			this.dialog.find("textarea[name='popup_msg']");
		this.popup_action.name1 = 	this.dialog.find("*[name='popup_action_name1']");
		this.popup_action.target1 = this.dialog.find("select[name='popup_action_target1']");
		this.popup_action.name2 = 	this.dialog.find("*[name='popup_action_name2']");
		this.popup_action.target2 = this.dialog.find("select[name='popup_action_target2']");
		
		this.popup.data("inst", this);
		this.popup.change(function(){
			var inst = $(this).data("inst");
			inst.enabled( this.checked );
		});
		
		return this;
	},
	enabled : function(enabled){
		if (enabled !== undefined){
			this.dialog.find("input[name!='popup'][type!='button'], select, textarea").attr( "disabled", !enabled );
		}
		else{
			return ( this.popup_msg.attr("disabled") !== "disabled" );
		}
	},
	// implement
	getValue : function(key){
		if (key === "popup"){
			return this.getMarkValue();
		}
		
		if ( this.enabled() === false ) return "";
		
		if (key === "popup_msg"){
			return this.popup_msg.val();
		}
		else if (key === "popup_action"){
			return this.popup_action.name1.val() + "," +
				this.popup_action.target1.val() + "," +
				this.popup_action.name2.val() + "," +
				this.popup_action.target2.val();
		}
	},
	// implement
	setValue : function(key, val){
		if (key === "popup"){
			this.setMarkValue(val);
		}
		else if (key === "popup_msg"){
			this.popup_msg.val(val);
		}
		else if (key === "popup_action"){
			var saVal = val.split(",");
			
			if (saVal.length < 4){
				saVal = ["", "", "", ""];
			}
			
			this.popup_action.name1.val( saVal[0] );
			this.popup_action.target1.val( saVal[1] );
			this.popup_action.name2.val( saVal[2] );
			this.popup_action.target2.val( saVal[3] );
		}
	},
	// implement
	getMarkValue : function(){
		return (this.popup.get(0).checked === true)? this.popup.attr("value") : "";
	},
	// implement
	setMarkValue : function(val){
		this.popup.get(0).checked = (val === this.popup.attr("value"));
		this.enabled( this.popup.get(0).checked );
	}
});


artn.lib.Rating = function (){
	this.jqRating = null;
	this.iRatingLength = 0;
	this.iSelectNum = 0;
	this.iRatingValue = 0;
	this.sMouseEvent = "";
	this.sRatingTag = "";
	this.sRatingName = "";
	this.sNodeName = "";
};
artn.lib.Rating.prototype = {
	init : function(strId){
		this.jqRating = $(strId);
		this.sNodeName = this.jqRating.context.nodeName;
		this.iRatingLength = parseInt(this.jqRating.data("length")) || 5;
		this.iOneRatingVal = parseInt(this.jqRating.data("onevalue")) || 2;
		this.iRatingValue = parseInt(this.jqRating.data("value")) || 0;
		this.sMouseEvent = this.jqRating.data("mouse") || "yes";
		this.sRatingName = this.jqRating.data("name") || "rating";
		this.setting();
		if(this.sMouseEvent === "yes"){
			this.mouseEvent();
		}
	},
	setting : function(){
		this.sRatingTag = "<"+this.sNodeName+" class=\"rating_tag\">";
		for(var count=1; count <= this.iRatingLength; count++){
			this.sRatingTag += "<span class=\"rating_img\"></span>";
			this.sRatingTag += "<input type=\"radio\" name=\""+this.sRatingName+"\" class=\"rating_radio\" id=\"rating"+count+"\" value=\""+count*this.iOneRatingVal+"\"/>";
		}
		this.sRatingTag += "</"+this.sNodeName+">";
		
		this.jqRating.prepend(this.sRatingTag);
		if(this.iRatingValue !== 0){
			var iAvg = parseInt(this.iRatingValue/this.iOneRatingVal);
			this.jqRating.find(".rating_img").eq(iAvg-1).prevAll("span").addClass("checked");
			this.jqRating.find(".rating_img").eq(iAvg-1).addClass("checked");

			if(this.iRatingValue%this.iOneRatingVal === 1){
				this.jqRating.find(".rating_img").eq(iAvg).removeClass("checked");
				this.jqRating.find(".rating_img").eq(iAvg).addClass("half_checked");
			}		
		}
		
	},
	mouseEvent : function(){
		var inst = this;
		this.jqRating.find(".rating_img").mouseover(function(){
			$(this).parent().find(".rating_img").removeClass("select");
	        /* $(".rating_img").eq(count).addClass("select"); */
			inst.iSelectNum = $(this).parent().children("span").index($(this));
	        for(var count=0; count<=inst.iSelectNum; count++){
	        	$(this).parent().children("span").eq(count).addClass("select");
	        }
	    });
		this.jqRating.find(".rating_img").mouseout(function(){
			inst.jqRating.find(".rating_img").removeClass("select");
	    });
		this.jqRating.find(".rating_img").click(function(){
	        $(this).parent().children().attr("checked",false);
	        $(this).parent().children().removeClass("checked");
	        $(this).next().attr("checked",true);
	        $(this).addClass("checked");
	        $(this).prevAll("span").addClass("checked");
	    });
	}
	
};
