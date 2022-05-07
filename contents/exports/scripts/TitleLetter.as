 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class TitleLetter extends FlxSprite
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 55;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const ANIM_STOP_TIMEOUT:Number = 3;
       
      
      public var targetX:Number = 0;
      
      private var animStopTimeout:Number = 0;
      
      public function TitleLetter(param1:String)
      {
         super();
         this.animStopTimeout = ANIM_STOP_TIMEOUT;
         var _loc2_:int = 0;
         switch(param1)
         {
            case "A":
               _loc2_ = 0;
               break;
            case "D":
               _loc2_ = 1;
               break;
            case "I":
               _loc2_ = 2;
               break;
            case "L":
               _loc2_ = 3;
               break;
            case "N":
               _loc2_ = 4;
               break;
            case "O":
               _loc2_ = 5;
               break;
            case "S":
               _loc2_ = 6;
               break;
            case "U":
               _loc2_ = 7;
               break;
            case "W":
               _loc2_ = 8;
               break;
            case "Y":
               _loc2_ = 9;
               break;
            case " ":
               _loc2_ = 10;
         }
         loadGraphic(Art.TitleLetter,true,true,IMG_WIDTH,IMG_HEIGHT);
         switch(_loc2_)
         {
            case 0:
               width = 26;
               height = 43;
               break;
            case 1:
               width = 26;
               height = 43;
               break;
            case 2:
               width = 4;
               height = 43;
               break;
            case 3:
               width = 4;
               height = 43;
               break;
            case 4:
               width = 22;
               height = 43;
               break;
            case 5:
               width = 26;
               height = 43;
               break;
            case 6:
               width = 23;
               height = 43;
               break;
            case 7:
               width = 26;
               height = 43;
               break;
            case 8:
               width = 30;
               height = 43;
               break;
            case 9:
               width = 26;
               height = 43;
               break;
            case 10:
               width = 22;
               height = 43;
         }
         addAnimation("normal",[11 * 0 + _loc2_,11 * 3 + _loc2_,11 * 4 + _loc2_,11 * 3 + _loc2_,11 * 0 + _loc2_],10,false);
         addAnimation("flash1",[11 * 0 + _loc2_,11 * 1 + _loc2_,11 * 2 + _loc2_,11 * 3 + _loc2_,11 * 4 + _loc2_,11 * 5 + _loc2_,11 * 6 + _loc2_,11 * 7 + _loc2_],30,true);
         addAnimation("flash2",[11 * 0 + _loc2_,11 * 1 + _loc2_,11 * 2 + _loc2_,11 * 3 + _loc2_,11 * 4 + _loc2_,11 * 5 + _loc2_,11 * 6 + _loc2_,11 * 7 + _loc2_],20,true);
         addAnimation("flash3",[11 * 0 + _loc2_,11 * 1 + _loc2_,11 * 2 + _loc2_,11 * 3 + _loc2_,11 * 4 + _loc2_,11 * 5 + _loc2_,11 * 6 + _loc2_,11 * 7 + _loc2_],10,true);
         scrollFactor.x = scrollFactor.y = 0;
         active = true;
         visible = false;
      }
      
      override public function update() : void
      {
         if(visible)
         {
            this.animStopTimeout -= FlxG.elapsed;
            if(this.animStopTimeout < 0)
            {
               play("normal");
            }
            else
            {
               play("flash1");
            }
         }
         super.update();
      }
   }
}
