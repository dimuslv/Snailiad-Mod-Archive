 
package
{
   import org.flixel.FlxG;
   
   public class EnemyTallfish2 extends Enemy
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 48;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 900;
      
      private static const DEFENSE:int = 10;
      
      private static const OFFENSE:int = 4;
      
      private static const MOVE_TIMEOUT:Number = 2.3;
      
      private static const SHOT_TIMEOUT:Number = 0.1;
      
      private static const SHOT_NUM:int = 9;
      
      private static const WEAPON_SPEED:int = 100;
      
      private static const SPEED:Number = 160;
       
      
      private var elapsed:Number = 0;
      
      private var moveTimeout:Number = 0;
      
      private var shotTimeout:Number = 0;
      
      private var originY:Number = 0;
      
      private var shotNum:int = 0;
      
      public function EnemyTallfish2(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyTallfish2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originY = param2;
         this.moveTimeout = MOVE_TIMEOUT / 8;
         addAnimation("normal",[0]);
         addAnimation("swim",[0,1,2,3,3,0,0,1,1,1,2,2,2,2,3,3,3,3,0],10,false);
         play("swim");
         drag.x = SPEED * 0.6;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.elapsed += FlxG.elapsed;
         y = this.originY + 4 * Math.sin(this.elapsed * 2);
         if(onScreen())
         {
            this.moveTimeout -= FlxG.elapsed;
            if(this.moveTimeout < 0)
            {
               if(PlayState.player.x < x)
               {
                  velocity.x = -SPEED;
               }
               else
               {
                  velocity.x = SPEED;
               }
               this.shotNum = SHOT_NUM;
               this.shotTimeout = 0;
               this.moveTimeout = MOVE_TIMEOUT;
               play("normal");
               play("swim");
            }
            this.shotTimeout -= FlxG.elapsed;
            if(this.shotTimeout <= 0 && this.shotNum > 0)
            {
               _loc1_ = Math.atan2(y - PlayState.player.y,x - PlayState.player.x);
               this.shoot(_loc1_);
               this.shotTimeout = SHOT_TIMEOUT;
               --this.shotNum;
            }
         }
         if(velocity.x < 0)
         {
            facing = LEFT;
         }
         if(velocity.x > 0)
         {
            facing = RIGHT;
         }
         super.update();
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc2_:Number = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         var _loc5_:EnemyBullet;
         if(_loc5_ = PlayState.enemyBulletPool.getBullet(4))
         {
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
         }
      }
   }
}
