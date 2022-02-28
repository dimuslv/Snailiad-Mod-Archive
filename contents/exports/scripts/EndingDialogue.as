 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxText;
   
   public class EndingDialogue extends FlxGroup
   {
      
      private static const IMG_WIDTH:int = 368;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
       
      
      private var _msg:FlxText;
      
      private var _active:Boolean;
      
      private var _started:int;
      
      private var _fullMsg:String;
      
      private const LETTER_DELAY:Number = 0.067;
      
      private var _elapsed:Number = 0;
      
      private var _oldLetters:int;
      
      private var _voice:int;
      
      private var _speed:Number = 1.0;
      
      public function EndingDialogue()
      {
         super();
         this._active = false;
         this._msg = new FlxText(20,20,FlxG.width);
         this._msg.font = Fonts.normal;
         this._msg.size = 20;
         this._msg.color = 16777215;
         this._msg.shadow = 1;
         this._msg.alignment = "left";
         this._msg.scrollFactor.x = this._msg.scrollFactor.y = 0;
         this._msg.visible = false;
         add(this._msg);
      }
      
      public function setAlpha(param1:Number) : void
      {
         this._msg.alpha = param1;
      }
      
      override public function destroy() : void
      {
         this._msg = null;
         super.destroy();
      }
      
      public function start(param1:String, param2:int = 1, param3:Number = 1.0) : void
      {
         this._msg.alpha = 1;
         this._msg.text = "";
         this._fullMsg = param1;
         this._active = true;
         this._msg.visible = true;
         this._oldLetters = 0;
         this._voice = param2;
         this._elapsed = 0;
         this._speed = param3;
      }
      
      public function stop() : void
      {
         this._active = false;
         this._msg.visible = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this._elapsed += FlxG.elapsed;
         super.update();
         if(this._active)
         {
            _loc1_ = this._elapsed / (this.LETTER_DELAY / this._speed);
            if(_loc1_ != this._oldLetters)
            {
               _loc2_ = this._fullMsg.charAt(_loc1_).toLowerCase();
               if(_loc2_ >= "a" && _loc2_ <= "z")
               {
                  if(this._voice > -1)
                  {
                     Sfx.playDialogueLetter(this._voice);
                  }
               }
               this._oldLetters = _loc1_;
            }
            this._msg.text = this._fullMsg.substr(0,_loc1_);
         }
      }
   }
}
