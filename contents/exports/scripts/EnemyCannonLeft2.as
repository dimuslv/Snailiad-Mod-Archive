 
package
{
   import org.flixel.FlxObject;
   
   public class EnemyCannonLeft2 extends Enemy
   {
      
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 400;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 0;
       
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var theta:Number = 0;
      
      private var elapsed:Number = 0;
      
      private var actualCannon:FlxObject;
      
      public function EnemyCannonLeft2(param1:int, param2:int, param3:Boolean)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyCannonLeft2,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         this.originX = param1;
         this.originY = param2;
         addAnimation("normal",[0]);
         play("normal");
         if(param3)
         {
            facing = LEFT;
            this.actualCannon = PlayState.enemies.add(new EnemyCannon2(param1 - 16,param2 - 16));
         }
         else
         {
            facing = RIGHT;
            this.actualCannon = PlayState.enemies.add(new EnemyCannon2(param1 - 16,param2 - 16));
         }
         solid = false;
         active = true;
      }
      
      override public function destroy() : void
      {
         this.actualCannon = null;
         super.destroy();
      }
      
      override public function touch(param1:Player) : void
      {
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
      
      override public function kill() : void
      {
         this.actualCannon.kill();
         super.kill();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}
