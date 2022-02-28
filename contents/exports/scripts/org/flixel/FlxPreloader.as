 
package org.flixel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class FlxPreloader extends MovieClip
   {
       
      
      protected var ImgLogo:Class;
      
      protected var ImgLogoCorners:Class;
      
      protected var ImgLogoLight:Class;
      
      protected var fglTextFormat:TextFormat;
      
      protected var fglTextField:TextField;
      
      protected var _init:Boolean;
      
      protected var _buffer:Sprite;
      
      protected var _bmpBar:Bitmap;
      
      protected var _text:TextField;
      
      protected var _width:uint;
      
      protected var _height:uint;
      
      protected var _logo:Bitmap;
      
      protected var _logoGlow:Bitmap;
      
      protected var _min:uint;
      
      public var className:String;
      
      public var myURL:String;
      
      public var minDisplayTime:Number;
      
      public function FlxPreloader()
      {
         var _loc1_:Bitmap = null;
         var _loc2_:TextFormat = null;
         var _loc3_:TextField = null;
         this.ImgLogo = FlxPreloader_ImgLogo;
         this.ImgLogoCorners = FlxPreloader_ImgLogoCorners;
         this.ImgLogoLight = FlxPreloader_ImgLogoLight;
         super();
         this.minDisplayTime = 0;
         stop();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         if(false && this.myURL != null && root.loaderInfo.url.indexOf(this.myURL) < 0)
         {
            _loc1_ = new Bitmap(new BitmapData(stage.stageWidth,stage.stageHeight,true,4294967295));
            addChild(_loc1_);
            _loc2_ = new TextFormat();
            _loc2_.color = 0;
            _loc2_.size = 16;
            _loc2_.align = "center";
            _loc2_.bold = true;
            _loc2_.font = "system";
            _loc3_ = new TextField();
            _loc3_.width = _loc1_.width - 16;
            _loc3_.height = _loc1_.height - 16;
            _loc3_.y = 8;
            _loc3_.multiline = true;
            _loc3_.wordWrap = true;
            _loc3_.embedFonts = true;
            _loc3_.defaultTextFormat = _loc2_;
            _loc3_.text = "Hi there!  It looks like somebody copied this game without my permission.  Just click anywhere, or copy-paste this URL into your browser.\n\n" + this.myURL + "\n\nto play the game at my site.  Thanks, and have fun!";
            addChild(_loc3_);
            _loc3_.addEventListener(MouseEvent.CLICK,this.goToMyURL);
            _loc1_.addEventListener(MouseEvent.CLICK,this.goToMyURL);
            return;
         }
         this._init = false;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
      }
      
      private function destroy(param1:Event = null) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         this._bmpBar.bitmapData.dispose();
         this._logo.bitmapData.dispose();
         this._logoGlow.bitmapData.dispose();
         this._text = null;
         while(this._buffer.numChildren > 0)
         {
            this._buffer.removeChildAt(0);
         }
         this._buffer = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      private function goToMyURL(param1:MouseEvent = null) : void
      {
         navigateToURL(new URLRequest("http://" + this.myURL));
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Class = null;
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         if(!this._init)
         {
            if(stage.stageWidth <= 0 || stage.stageHeight <= 0)
            {
               return;
            }
            this.create();
            this._init = true;
         }
         graphics.clear();
         var _loc3_:uint = getTimer();
         if(framesLoaded >= totalFrames && _loc3_ > this._min)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            nextFrame();
            if(_loc4_ = Class(getDefinitionByName(this.className)))
            {
               _loc5_ = new _loc4_();
               addChild(_loc5_ as DisplayObject);
            }
            removeChild(this._buffer);
         }
         else
         {
            _loc6_ = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
            if(this._min > 0 && _loc6_ > _loc3_ / this._min)
            {
               _loc6_ = _loc3_ / this._min;
            }
            this.update(_loc6_);
         }
      }
      
      protected function create() : void
      {
         this._min = 0;
         if(!FlxG.debug)
         {
            this._min = this.minDisplayTime * 1000;
         }
         this._buffer = new Sprite();
         this._buffer.scaleX = 2;
         this._buffer.scaleY = 2;
         addChild(this._buffer);
         this._width = stage.stageWidth / this._buffer.scaleX;
         this._height = stage.stageHeight / this._buffer.scaleY;
         this._buffer.addChild(new Bitmap(new BitmapData(this._width,this._height,false,13406)));
         var _loc1_:Bitmap = new this.ImgLogoLight();
         _loc1_.smoothing = true;
         _loc1_.width = _loc1_.height = this._height;
         _loc1_.x = (this._width - _loc1_.width) / 2;
         this._buffer.addChild(_loc1_);
         this._bmpBar = new Bitmap(new BitmapData(1,7,false,6253311));
         this._bmpBar.x = 4;
         this._bmpBar.y = this._height - 11;
         this._buffer.addChild(this._bmpBar);
         this._text = new TextField();
         this._text.defaultTextFormat = new TextFormat("system",8,6253311);
         this._text.embedFonts = true;
         this._text.selectable = false;
         this._text.multiline = false;
         this._text.x = 2;
         this._text.y = this._bmpBar.y - 11;
         this._text.width = 80;
         this._buffer.addChild(this._text);
         this._logo = new this.ImgLogo();
         this._logo.scaleX = this._logo.scaleY = this._height / 8;
         this._logo.x = (this._width - this._logo.width) / 2;
         this._logo.y = (this._height - this._logo.height) / 2;
         this._buffer.addChild(this._logo);
         this._logoGlow = new this.ImgLogo();
         this._logoGlow.smoothing = true;
         this._logoGlow.blendMode = "screen";
         this._logoGlow.scaleX = this._logoGlow.scaleY = this._height / 8;
         this._logoGlow.x = (this._width - this._logoGlow.width) / 2;
         this._logoGlow.y = (this._height - this._logoGlow.height) / 2;
         this._buffer.addChild(this._logoGlow);
         _loc1_ = new this.ImgLogoCorners();
         _loc1_.smoothing = true;
         _loc1_.width = this._width;
         _loc1_.height = this._height;
         this._buffer.addChild(_loc1_);
         _loc1_ = new Bitmap(new BitmapData(this._width,this._height,false,16777215));
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc1_.bitmapData.setPixel(_loc3_++,_loc2_,0);
            }
            _loc2_ += 2;
         }
         _loc1_.blendMode = "overlay";
         _loc1_.alpha = 0.25;
         this._buffer.addChild(_loc1_);
      }
      
      protected function update(param1:Number) : void
      {
         this._bmpBar.scaleX = param1 * (this._width - 8);
         this._text.text = FlxU.floor(param1 * 100) + "%";
         this._text.setTextFormat(this._text.defaultTextFormat);
         if(param1 < 0.1)
         {
            this._logoGlow.alpha = 0;
            this._logo.alpha = 0;
         }
         else if(param1 < 0.15)
         {
            this._logoGlow.alpha = FlxU.random();
            this._logo.alpha = 0;
         }
         else if(param1 < 0.2)
         {
            this._logoGlow.alpha = 0;
            this._logo.alpha = 0;
         }
         else if(param1 < 0.25)
         {
            this._logoGlow.alpha = 0;
            this._logo.alpha = FlxU.random();
         }
         else if(param1 < 0.7)
         {
            this._logoGlow.alpha = (param1 - 0.45) / 0.45;
            this._logo.alpha = 1;
         }
         else if(param1 > 0.8 && param1 < 0.9)
         {
            this._logoGlow.alpha = 1 - (param1 - 0.8) / 0.1;
            this._logo.alpha = 0;
         }
         else if(param1 > 0.9)
         {
            this._buffer.alpha = 1 - (param1 - 0.9) / 0.1;
         }
      }
   }
}
