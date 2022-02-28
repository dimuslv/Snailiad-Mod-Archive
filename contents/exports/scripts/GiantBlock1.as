 
package
{
   import org.flixel.FlxU;
   
   public class GiantBlock1 extends Item
   {
      
      private static const IMG_WIDTH:int = 64;
      
      private static const IMG_HEIGHT:int = 64;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 150;
      
      private static const DEFENSE:int = 0;
       
      
      private var _lastHurt:int;
      
      private var _defense:int;
      
      private var _justFlashed:int;
      
      protected var _hp:int;
      
      public function GiantBlock1(param1:int, param2:int)
      {
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2,false);
         this._hp = MAX_HP;
         loadGraphic(Art.GiantBlock1,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0]);
         play("normal");
         solid = true;
         acceleration.y = 1200;
         this._lastHurt = 0;
         this._defense = DEFENSE;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function hurt(param1:Number) : void
      {
         if(this._lastHurt > 0)
         {
            return;
         }
         param1 -= this._defense;
         if(param1 <= 0)
         {
            Sfx.playEnemyPingOffArmor();
         }
         else
         {
            this._hp -= param1;
            if(this._hp <= 0)
            {
               Sfx.playEnemyKilled();
               PlayState.explosionPool.boom(x,y,0,10,FlxU.random() * 3 + 1);
               kill();
            }
            else
            {
               Sfx.playRandomExplode();
               flashColor(16777215);
               this._justFlashed = 1;
               this._lastHurt = 3;
            }
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
         --this._lastHurt;
         if(--this._justFlashed == 0)
         {
            unFlashColor();
         }
      }
   }
}
