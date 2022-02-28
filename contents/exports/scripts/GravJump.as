 
package
{
   public class GravJump extends SuperUniqueItem
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 16;
      
      private static const MODE_NONE:int = 0;
      
      private static const MODE_GORIGHT:int = 1;
      
      private static const MODE_GRAVUP:int = 2;
      
      private static const MODE_GRAVLEFT:int = 3;
      
      private static const MODE_GRAVRIGHT:int = 4;
      
      private static const MODE_GRAVFALL:int = 5;
      
      private static const MODE_GRAVDONE:int = 6;
      
      private static const GRAV_TIMER:Number = 0.5;
      
      private static const DONE_TIMEOUT:Number = 1;
       
      
      private var _mode:int = 0;
      
      private var _modeFrames:Number = 0;
      
      private var _gravTimer:Number = 0;
      
      private var _doneTimeout:Number = 0;
      
      private var _shot:Boolean;
      
      private var _totalElapsed:Number = 0;
      
      public function GravJump(param1:int, param2:int)
      {
         super(param1,param2,true,false);
         x -= IMG_OFS_X;
         y -= IMG_OFS_Y;
         loadGraphic(Art.ItemGravJump,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = Number(IMG_WIDTH);
         height = Number(IMG_HEIGHT);
         addAnimation("normal",[0,1,2,3],22,true);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         PlayState.player.addGravityJump();
         PlayState.hud.itemName.setItem("GRAVITY JUMP");
         super.touch(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}
