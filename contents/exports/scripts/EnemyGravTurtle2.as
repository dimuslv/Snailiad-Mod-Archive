 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   
   public class EnemyGravTurtle2 extends Enemy
   {
      
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 32;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 200;
      
      private static const DEFENSE:int = 20;
      
      private static const OFFENSE:int = 2;
      
      private static const JUMP_TIMEOUT:Array = [2.5,2.3,3,2.1,2.7,2.6,2.9,2.1,2.3,3.1,3.3,2.9,2.6,2.4,1.9,3.1,2.7,3.9,4.2,1.8,2.8,3.1,3.8,2.8];
      
      private static const FLIP_TIMEOUT:Number = 0.3;
      
      private static const JUMP_POWER:Number = 500;
      
      private static const GRAVITY:Number = 1200;
      
      private static const UPDOWN_TIMEOUT:Number = 1.8;
       
      
      private var jumpTimeoutIndex:int = 0;
      
      private var jumpTimeout:Number = 0;
      
      private var flipTimeout:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var WALKSPEED:Number = 24;
      
      private var facingUp:Boolean = true;
      
      private var upDownTimeout:Number = 0;
      
      public function EnemyGravTurtle2(param1:int, param2:int, param3:Boolean)
      {
         if(PlayState.player && PlayState.player._hardMode)
         {
            this.WALKSPEED *= 1.9;
         }
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.EnemyGravTurtle2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.elapsed = 0;
         this.jumpTimeoutIndex = y / 16;
         this.jumpTimeoutIndex %= JUMP_TIMEOUT.length;
         this.jumpTimeout = JUMP_TIMEOUT[this.jumpTimeoutIndex];
         this.flipTimeout = 99999999;
         if(param3)
         {
            facing = LEFT;
            acceleration.x = -GRAVITY;
         }
         else
         {
            facing = RIGHT;
            acceleration.x = GRAVITY;
         }
         addAnimation("up",[0,1,2,3],3,true);
         addAnimation("down",[4,5,6,7],3,true);
         active = true;
         visible = true;
         if(PlayState.player.y < y)
         {
            play("up");
            velocity.y = -this.WALKSPEED;
         }
         else
         {
            play("down");
            velocity.y = this.WALKSPEED;
         }
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function updatePosition() : void
      {
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen())
         {
            this.jumpTimeout -= FlxG.elapsed;
            if(this.jumpTimeout < 0)
            {
               ++this.jumpTimeoutIndex;
               this.jumpTimeoutIndex %= JUMP_TIMEOUT.length;
               this.jumpTimeout = JUMP_TIMEOUT[this.jumpTimeoutIndex];
               this.flipTimeout = FLIP_TIMEOUT;
               if(facing == RIGHT)
               {
                  velocity.x = -JUMP_POWER;
               }
               else
               {
                  velocity.x = JUMP_POWER;
               }
               Sfx.playJump1();
            }
            this.flipTimeout -= FlxG.elapsed;
            if(this.flipTimeout < 0)
            {
               this.flipTimeout = 9999999;
               if(facing == RIGHT)
               {
                  facing = LEFT;
                  acceleration.x = -GRAVITY;
               }
               else
               {
                  facing = RIGHT;
                  acceleration.x = GRAVITY;
               }
            }
            this.upDownTimeout -= FlxG.elapsed;
            if(this.upDownTimeout <= 0)
            {
               this.upDownTimeout = UPDOWN_TIMEOUT;
               if(this.facingUp && PlayState.player.y > y)
               {
                  velocity.y = this.WALKSPEED;
                  this.facingUp = false;
                  play("down");
               }
               else if(!this.facingUp && PlayState.player.y < y)
               {
                  this.facingUp = true;
                  velocity.y = -this.WALKSPEED;
                  play("up");
               }
            }
         }
         if(onScreen())
         {
            super.update();
         }
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         this.facingUp = true;
         velocity.y = -this.WALKSPEED;
         play("up");
      }
      
      override public function hitTop(param1:FlxObject, param2:Number) : void
      {
         this.facingUp = false;
         velocity.y = this.WALKSPEED;
         play("down");
      }
   }
}
