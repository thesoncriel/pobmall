function ThumbnailList(){
    this._jqContainer = null;
    this.option = null;
    this._selectedIndex = -1;
    this._length = 0;
    this._location = {
        first : 0,
        last : 0
    };
    
    this.evt_click = function(index){};
}

ThumbnailList.prototype = {
    init : function(sId, mOption){
        this._jqContainer = $("#" + sId + " ol");
        //this._jqContainer.wrap("<div id=\"wrapper_ThumbnailItems\" />");
        
        if (mOption === undefined){
            this.option = {
                itemTags : "",
                itemkeys : []
            };
        }
        else{
            this._jqContainer.css({
                overflow : "hidden",
                position : "relative"
            });
            if (mOption.width && mOption.height){
                this._jqContainer.css({
                    width : mOption.width,
                    height : mOption.height
                });
            }
            if (mOption.visibility !== undefined){
            	this._jqContainer.css({
            		visibility : mOption.visibility
            	});
            }
            
            $.data(this._jqContainer[0], "thumbnail", this);
            this._jqContainer.siblings("a.ui-list-prev, a.ui-list-next")
                .data("thumbnail", this).click(this.onMoveCtrlClick);

            this.option = mOption;
            this.evt_click = this.option.click;
        }
        
        return this;
    },
    width : function(width){
        if (width !== undefined){
            this._jqContainer.css("width", width);
        }
        else{
            return parseInt( this._jqContainer.css("width") ); 
        }
    },
    height : function(height){
        if (height !== undefined){
            this._jqContainer.css("height", height);
        }
        else{
            return parseInt( this._jqContainer.css("height") );
        }
    },
    setItems : function(maItemData){
        this.clear();
        this.addItemRange( maItemData );
    },
    addItemRange : function(maItemData){
        var iLen = maItemData.length;
        for(var i = 0; i < iLen; ++i){
            this.addItem( maItemData[i] );
        }
    },
    addItem : function(mItemData){
        this.itemDataLimitation(mItemData);
        
        var sInnerTag = Artn.Util.replaceTemplate(
            this.option.itemTags, this.option.itemKeys , mItemData);
        
        var jqNodeContainer = this._jqContainer;
        var iLocation = this.option.itemWidth * this._length;
        
        if (this._length > 0){
            this._location.last = iLocation;
        }

        $(sInnerTag).appendTo(jqNodeContainer);
        
        jqNodeContainer.find("li:last-child a").click( this.onItemClick );
        jqNodeContainer.find("li:last-child").css({
            left : iLocation
        });
        
        if (this.option.itemClass !== undefined){
            jqNodeContainer.find("li:last-child").addClass( this.option.itemClass );
        }
        else{
            jqNodeContainer.find("li:last-child").css({
                display : "block",
                position : "absolute",
                top : 0
            });
        }
        
        ++this._length;
    },
    itemDataLimitation : function(mItemData){
        if (this.option.itemTextLimit){
            var sKey = this.option.itemTextLimit.key;
            var iLimit = this.option.itemTextLimit.limit;
            var iLen = mItemData.length;
            var sText = "";
            
            sText = mItemData[ sKey ];
            sText = (sText.length > iLimit)? sText.substring(0, iLimit) + "..." : sText;
            mItemData[ sKey ] = sText;
        }
    },
    clear : function(){
        this._jqContainer.empty();
        this._length = 0;
        this._location.first = 0;
        this._location.last = 0;
    },
    count : function(){
        return this._jqContainer.children().length;
    },
    checkItemShowing : function(index){
        var iItemLocation = this._location.first + (this.option.itemWidth * index);
        
        if ( iItemLocation < 0 ) return -1;
        if ( iItemLocation > (parseInt( this._jqContainer.css("width") ) - this.option.itemWidth) ) return 1;
        
        return 0;
    },
    movePrev : function(){
        var iItemWidth = this.option.itemWidth;
        var iMoveDistance = this._location.first;
        iMoveDistance = Math.abs(iMoveDistance);
        
        if (iMoveDistance > 0){
            if (iMoveDistance > iItemWidth){
                iMoveDistance = iItemWidth;
            }
            this._location.first += iMoveDistance;
            this._location.last += iMoveDistance;
            this._jqContainer.find("li").animate({"left": "+=" + iMoveDistance + "px" }, 250);
        }
    },
    moveNext : function(){
        var iItemWidth = this.option.itemWidth;
        var iLastDistance = this._location.last;
        var iContainerWidth = parseInt( this._jqContainer.css("width") );
        var iMoveDistance =  iLastDistance - iContainerWidth + iItemWidth;

        if (iMoveDistance > 0){
            if (iMoveDistance > iItemWidth){
                iMoveDistance = iItemWidth;
            }
            this._location.first -= iMoveDistance;
            this._location.last -= iMoveDistance;
            this._jqContainer.find("li").animate({"left": "-=" + iMoveDistance + "px" }, 250);
        }
    },
    selectedIndex : function(index){
        if (index !== undefined){
            this._jqContainer.find("li").removeClass("selected");
            this._jqContainer.find("li:eq(" + index + ")").addClass("selected");
            this._selectedIndex = index;
            
            var iShowingDirection = this.checkItemShowing(index);
            
            while( iShowingDirection !== 0 ){
                switch( this.checkItemShowing(index) ){
                    case -1:
                        this.movePrev();
                        break;
                    case 1:
                        this.moveNext();
                        break;
                }
                iShowingDirection = this.checkItemShowing(index);
            } 
        }
        else{
            return this._selectedIndex;
        }
    },
    onMoveCtrlClick : function(){
        var instance = $.data(this, "thumbnail");

        if ($(this).hasClass("ui-list-prev") === true){
            instance.movePrev();
        }
        else{
            instance.moveNext();
        }
        
        return false;
    },
    onItemClick : function(){
        var jqListItem = $(this).parent();
        var index = jqListItem.prevAll().length;
        var instance = null;
        
        try{
        	instance = $.data(jqListItem.parent()[0], "thumbnail");
        }
        catch(e){
        	instance = this;
        }

        instance.selectedIndex( index );
        instance.onclick(index);
        
        return false;
    },
    
    click : function(handler){ this.evt_click = handler; },
    onclick : function(index){
        this.evt_click(index);
    }
    
};