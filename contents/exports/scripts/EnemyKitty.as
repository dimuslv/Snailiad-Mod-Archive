 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   import org.flixel.FlxU;
   
   public class EnemyKitty extends Enemy
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 100;
      
      private static const DEFENSE:int = 1;
      
      private static const OFFENSE:int = 2;
      
      private static const MAX_SHOTS:int = 5;
      
      private static const SHOT_TIMEOUT:Number = 0.12;
      
      private static const HOP_TIMEOUTS:Array = [0.7,0.8,0.6,0.7,0.8,0.6,0.7,0.8,0.6];
      
      private static const HOP_HEIGHT:Array = [1,1,1,1.2,1.3,1,1.2,1,0.9];
      
      private static const WEAPON_SPEED:Number = 200;
      
      private static const TIMEOUTS:Array = [0.60153,0.48509,0.70037,0.66276,0.70802,0.79541,0.62043,0.5796,0.99605,0.15058,0.72121,0.86851,0.64371,0.76708,0.89401,0.52828,0.72309,0.15963,0.15116,0.1799,0.27829,0.40878,0.92538,0.45074,0.18865,0.59797,0.4318,0.94098,0.23463,0.29221,0.59734,0.34877,0.81676,0.57617,0.14883,0.16094,0.14123,0.57931,0.85924,0.22828,0.63834,0.10387,0.54746,0.24897,0.11105,0.49748,0.54746,0.19405,0.79792,0.36023,0.53726,0.78544,0.60425,0.83512,0.01696,0.10451,0.01513,0.78678,0.51617,0.24251];
      
      private static const BASE_TIMEOUT:Number = 3;
       
      
      private var hopNum:int = 0;
      
      private var hopTimeout:Number = 0;
      
      private var nextAttack:int = 2;
      
      private var attacking:Boolean = false;
      
      private var goingUp:Boolean = true;
      
      private var shots:int = -1;
      
      private var shotTimeout:Number;
      
      private var listPos:int = 0;
      
      private var timeout:Number = 0;
      
      public function EnemyKitty(param1:int, param2:int)
      {
         super(param1,param2,9999,0,0);
         solid = false;
         visible = false;
         this.listPos = (param1 * 4 + param2 * 20) % TIMEOUTS.length;
         this.timeout = TIMEOUTS[this.listPos] * BASE_TIMEOUT % (param1 % 20);
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      public function shoot(param1:Number) : void
      {
         var _loc5_:EnemyBullet = null;
         if(facing == RIGHT)
         {
            param1 = Math.PI - param1;
         }
         var _loc2_:* = WEAPON_SPEED;
         var _loc3_:Number = -Math.cos(param1) * _loc2_;
         var _loc4_:Number = -Math.sin(param1) * _loc2_;
         if(_loc5_ = PlayState.enemyBulletPool.getBullet(1))
         {
            _loc5_.shoot(x + width / 2,y + height / 2,_loc3_,_loc4_);
         }
      }
      
      override public function update() : void
      {
         var chance:Number = NaN;
         var newX:Number = NaN;
         var newY:Number = NaN;
         var newEnemy:Enemy = null;
         var attempts:int = 10;
         var freezePreventative:int = 30;
         var adequatePos:Boolean = false;
         var playerX:* = PlayState.player.x;
         var playerY:* = PlayState.player.y;
         var moveHoriz:int = 0 + (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D") ? 1 : 0) - (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A") ? 1 : 0);
         var moveVert:int = 0 + (FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("S") ? 1 : 0) - (FlxG.keys.pressed("UP") || FlxG.keys.pressed("W") ? 1 : 0);
         var tempI:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.timeout -= FlxG.elapsed;
         if(this.timeout < 0 && !PlayState.player.dead)
         {
            ++this.listPos;
            this.listPos %= TIMEOUTS.length;
            this.timeout = TIMEOUTS[this.listPos] * BASE_TIMEOUT;
            while(!adequatePos && attempts > 0 && freezePreventative > 0)
            {
               newX = playerX + (FlxU.random() - 0.5) * 128 + moveHoriz * 16 * 4;
               while(tempI < newX)
               {
                  tempI += 16;
               }
               newX = tempI;
               tempI = 0;
               newY = playerY + (FlxU.random() - 0.5) * 128 + moveVert * 16 * 4;
               while(tempI < newY)
               {
                  tempI += 16;
               }
               newY = tempI;
               if(!PlayState.worldMap.enemySolidAt(newX,newY))
               {
                  attempts--;
               }
               if(!PlayState.worldMap.enemySolidAt(newX,newY) && !PlayState.worldMap.enemySolidAt(newX,newY - 16) && !PlayState.worldMap.enemySolidAt(newX - 16,newY) && !PlayState.worldMap.enemySolidAt(newX + 16,newY) && !PlayState.worldMap.enemySolidAt(newX,newY + 16))
               {
                  chance = FlxU.random();
                  if(chance < 0.75)
                  {
                     adequatePos = true;
                  }
                  else
                  {
                     attempts--;
                  }
               }
               else if(!PlayState.worldMap.enemySolidAt(newX,newY))
               {
                  adequatePos = true;
               }
               else
               {
                  freezePreventative--;
               }
            }
            if(freezePreventative != 0)
            {
               newEnemy = new EnemyMoth(newX,newY);
               PlayState.enemies.add(newEnemy);
            }
            else if(moveHoriz != 0 && moveVert != 0)
            {
               newX -= 96 * moveHoriz;
               newY -= 96 * moveVert;
               if(!PlayState.worldMap.enemySolidAt(newX,newY))
               {
                  newEnemy = new EnemyMoth(newX,newY);
                  PlayState.enemies.add(newEnemy);
               }
            }
         }
         super.update();
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         velocity.x = 0;
         velocity.y *= -0.1;
         if(velocity.y <= -5)
         {
            play("quiver");
         }
      }
      
      override public function hitSide(param1:FlxObject, param2:Number) : void
      {
         velocity.x *= -1;
         play("quiver");
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("quiver");
      }
   }
}
