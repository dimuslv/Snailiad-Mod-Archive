 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxU;
   
   public class EnemyMoth extends Enemy
   {
      
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 100;
      
      private static const DEFENSE:int = 100;
      
      private static const OFFENSE:int = 6;
      
      private static const HITBOX_DELAY:Number = 0.75;
      
      private static const MAX_LIFETIME:Number = 1.5;
       
      
      private var lifetime:Number = 0.0;
      
      public function EnemyMoth(param1:int, param2:int)
      {
         this.lifetime = 0;
         this.lifetime = 0;
         this.lifetime = 0;
         this.lifetime = 0;
         Sfx.playSplash1();
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyMoth,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[0]);
         addAnimation("bottom",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23],16,false);
         addAnimation("right",[24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47],16,false);
         addAnimation("top",[48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71],16,false);
         addAnimation("left",[72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95],16,false);
         addAnimation("air",[96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119],16,false);
         play("normal");
         var tweakX:Boolean = false;
         var tweakY:Boolean = false;
         var downRight:Boolean = false;
         if(PlayState.worldMap.enemySolidAt(x,y + 16))
         {
            play("bottom");
            tweakX = true;
            downRight = true;
         }
         else if(PlayState.worldMap.enemySolidAt(x - 16,y))
         {
            play("left");
            tweakY = true;
         }
         else if(PlayState.worldMap.enemySolidAt(x + 16,y))
         {
            play("right");
            tweakY = true;
            downRight = true;
         }
         else if(PlayState.worldMap.enemySolidAt(x,y - 16))
         {
            play("top");
            tweakX = true;
         }
         else
         {
            play("air");
            tweakX = true;
            tweakY = true;
         }
         if(tweakX)
         {
            if(!(PlayState.worldMap.enemySolidAt(x - 16,y) && PlayState.worldMap.enemySolidAt(x + 16,y)))
            {
               x += (FlxU.random() - 0.5) * 16;
            }
            else if(PlayState.worldMap.enemySolidAt(x - 16,y) && PlayState.worldMap.enemySolidAt(x + 16,y + (!!downRight ? 16 : -16)))
            {
               x += FlxU.random() * 16;
            }
            else if(PlayState.worldMap.enemySolidAt(x + 16,y) && PlayState.worldMap.enemySolidAt(x - 16,y + (!!downRight ? 16 : -16)))
            {
               x -= FlxU.random() * 16;
            }
         }
         if(tweakY)
         {
            if(!(PlayState.worldMap.enemySolidAt(x,y - 16) && PlayState.worldMap.enemySolidAt(x,y + 16)))
            {
               y += (FlxU.random() - 0.5) * 16;
            }
            else if(PlayState.worldMap.enemySolidAt(x,y - 16) && PlayState.worldMap.enemySolidAt(x + (!!downRight ? 16 : -16),y + 16))
            {
               y += FlxU.random() * 16;
            }
            else if(PlayState.worldMap.enemySolidAt(x,y + 16) && PlayState.worldMap.enemySolidAt(x + (!!downRight ? 16 : -16),y - 16))
            {
               y -= FlxU.random() * 16;
            }
         }
      }
      
      override public function touch(param1:Player) : void
      {
         if(this.lifetime > HITBOX_DELAY)
         {
            super.touch(param1);
         }
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.lifetime += FlxG.elapsed;
         if(this.lifetime > MAX_LIFETIME)
         {
            kill();
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}
