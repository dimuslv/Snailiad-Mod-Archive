 
package
{
   public class TurtleNpc extends Npc
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
       
      
      private var _talkOpen:Boolean = false;
      
      private var _nexted:int = 0;
      
      private var _elapsed:Number = 0;
      
      public function TurtleNpc(param1:int, param2:int)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2);
         loadGraphic(Art.TurtleNpc,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0,1],3,true);
         play("normal");
         acceleration.y = 1200;
      }
      
      override public function touch(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(!this._talkOpen)
         {
            _loc2_ = PlayState.player.getPercentComplete();
            _loc3_ = PlayState.player.getHelixFragments();
            _loc4_ = "I keep having these weird dreams\n" + "where the world is rewritten\n" + "over and over again.\n";
            if(_loc2_ > 70)
            {
               _loc4_ = "Do you think these dreams mean\n" + "anything, Leggy?  Wait, what if\n" + "THIS is another dream?!\n";
            }
            PlayState.dialogue.start(_loc4_,1);
         }
         this._talkOpen = true;
      }
      
      public function stopTalking() : void
      {
         PlayState.dialogue.stop();
         this._talkOpen = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this._talkOpen)
         {
            _loc1_ = PlayState.player.x - x;
            _loc2_ = PlayState.player.y - y;
            if(_loc1_ * _loc1_ + _loc2_ * _loc2_ > 120 * 120)
            {
               this.stopTalking();
            }
         }
         super.update();
         facing = PlayState.player.x < x ? uint(LEFT) : uint(RIGHT);
      }
      
      override public function kill() : void
      {
         super.kill();
         if(this._talkOpen)
         {
            PlayState.dialogue.stop();
         }
      }
   }
}
