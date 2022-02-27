 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   
   public class EnemySnake2 extends Enemy
   {
      
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 450;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const WEAPON_SPEED:Number = 80;
      
      private static const MOVE_TIMEOUT:Number = 1.2;
      
      private static const SPEED:Number = 240;
      
      private static const SHOT_TIMEOUT:Number = 1.2;
       
      
      private var REACT_DISTANCE:int = 240;
      
      private var moveTimeout:Number = 0;
      
      private var shotTimeout:Number = 1.2;
      
      public function EnemySnake2(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemySnake2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.moveTimeout = MOVE_TIMEOUT;
         addAnimation("normal",[0,1],10,true);
         play("normal");
         acceleration.y = 1200;
         drag.x = SPEED * 2;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc5_:EnemyBullet = null;
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         if(PlayState.player && PlayState.player._insaneMode)
         {
            if(_loc5_ = PlayState.enemyBulletPool.getBullet(4))
            {
               _loc5_.shoot(x + width / 2,y + height / 2,_loc3_ * 1.3,_loc4_ * 1.3);
            }
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            this.moveTimeout -= FlxG.elapsed;
            if(this.moveTimeout < 0 && Math.abs(PlayState.player.x - x) < this.REACT_DISTANCE)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               this.moveTimeout = MOVE_TIMEOUT;
            }
            this.shotTimeout -= FlxG.elapsed;
            if(this.shotTimeout <= 0)
            {
               this.shotTimeout = SHOT_TIMEOUT;
               _loc1_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               this.shoot(_loc1_);
            }
         }
         if(velocity.x < 0)
         {
            facing = RIGHT;
         }
         if(velocity.x > 0)
         {
            facing = LEFT;
         }
         super.update();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         velocity.y *= -0.1;
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
      }
   }
}
