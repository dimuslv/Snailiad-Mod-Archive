 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class TitleLetter extends FlxSprite
   {
      
      private static const IMG_WIDTH:int = 10;
      
      private static const IMG_HEIGHT:int = 67;
      
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
            case "S":
               _loc2_ = 0;
               break;
            case "N":
               _loc2_ = 1;
               break;
            case "A":
               _loc2_ = 2;
               break;
            case "I":
               _loc2_ = 3;
               break;
            case "L":
               _loc2_ = 4;
               break;
            case "D":
               _loc2_ = 5;
               break;
            case "B":
               _loc2_ = 6;
               break;
            case "C":
               _loc2_ = 7;
               break;
            case "E":
               _loc2_ = 8;
               break;
            case "F":
               _loc2_ = 9;
               break;
            case "G":
               _loc2_ = 10;
               break;
            case "H":
               _loc2_ = 11;
               break;
            case "J":
               _loc2_ = 12;
               break;
            case "K":
               _loc2_ = 13;
               break;
            case "M":
               _loc2_ = 14;
               break;
            case "O":
               _loc2_ = 15;
               break;
            case "P":
               _loc2_ = 16;
               break;
            case "Q":
               _loc2_ = 17;
         }
         loadGraphic(Art.TitleLetter,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = 10;
         height = 67;
         addAnimation("normal",[18 * 0 + _loc2_,18 * 3 + _loc2_,18 * 4 + _loc2_,18 * 3 + _loc2_,18 * 0 + _loc2_],10,false);
         addAnimation("normal2",[18 * 8 + _loc2_],1,false);
         addAnimation("flash1",[18 * 0 + _loc2_,18 * 1 + _loc2_,18 * 2 + _loc2_,18 * 3 + _loc2_,18 * 4 + _loc2_,18 * 5 + _loc2_,18 * 6 + _loc2_,18 * 7 + _loc2_],30,true);
         addAnimation("flash2",[18 * 0 + _loc2_,18 * 1 + _loc2_,18 * 2 + _loc2_,18 * 3 + _loc2_,18 * 4 + _loc2_,18 * 5 + _loc2_,18 * 6 + _loc2_,18 * 7 + _loc2_],20,true);
         addAnimation("flash3",[18 * 0 + _loc2_,18 * 1 + _loc2_,18 * 2 + _loc2_,18 * 3 + _loc2_,18 * 4 + _loc2_,18 * 5 + _loc2_,18 * 6 + _loc2_,18 * 7 + _loc2_],10,true);
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
               play("normal2");
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
