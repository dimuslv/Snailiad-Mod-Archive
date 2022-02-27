 
package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   
   public class SplashLayer extends FlxGroup implements IEventDispatcher
   {
      
      private static const FADE_IN_TIME:Number = 0.78;
      
      private static const STATIC_TIME:Number = 2.42;
      
      private static const FADE_OUT_TIME:Number = 0.78;
       
      
      private var _1811999097Splash:Class;
      
      private var splash:MovieClip;
      
      private var bg:FlxSprite;
      
      private var elapsed:Number = 0;
      
      private var loader:Loader;
      
      private var _loaded:Boolean = false;
      
      private var _initialized:Boolean = false;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function SplashLayer()
      {
         this._1811999097Splash = SplashLayer_Splash;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         FlxG.mouse.show();
         FlxG.framerate = 45;
         this.bg = new FlxSprite();
         this.bg.y = 0;
         this.bg.x = 0;
         this.bg.createGraphic(FlxG.width,FlxG.height,4278190080);
         this.bg.scrollFactor.x = this.bg.scrollFactor.y = 0;
         add(this.bg);
         this.splash = new this.Splash();
         FlxG.stage.addChild(this.splash);
      }
      
      override public function destroy() : void
      {
         this.splash = null;
         this.bg = null;
         super.destroy();
      }
      
      public function loadCompleteListener(param1:Event) : void
      {
         this._loaded = true;
      }
      
      override public function update() : void
      {
         this.elapsed += FlxG.elapsed;
         if(this.elapsed < FADE_IN_TIME)
         {
            this.splash.alpha = this.elapsed / FADE_IN_TIME;
         }
         else if(this.elapsed < FADE_IN_TIME + STATIC_TIME)
         {
            this.splash.alpha = 1;
         }
         else
         {
            if(this.elapsed >= FADE_IN_TIME + STATIC_TIME + FADE_OUT_TIME)
            {
               this.bg.visible = false;
               this.splash.visible = false;
               FlxG.stage.removeChild(this.splash);
               this.splash = null;
               FlxG.framerate = 120;
               kill();
               return;
            }
            this.splash.alpha = 1 - (this.elapsed - (FADE_IN_TIME + STATIC_TIME)) / FADE_OUT_TIME;
         }
         super.update();
      }
      
      [Bindable(event="propertyChange")]
      public function get Splash() : Class
      {
         return this._1811999097Splash;
      }
      
      public function set Splash(param1:Class) : void
      {
         var _loc2_:Object = this._1811999097Splash;
         if(_loc2_ !== param1)
         {
            this._1811999097Splash = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"Splash",_loc2_,param1));
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}
