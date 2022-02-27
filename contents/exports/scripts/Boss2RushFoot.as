 
package
{
   public class Boss2RushFoot extends Enemy
   {
      
      private static const IMG_WIDTH:int = 190;
      
      private static const IMG_HEIGHT:int = 156;
      
      private static const MAX_HP:int = 50000;
      
      private static const DEFENSE:int = 0;
      
      private static const OFFENSE:int = 3;
       
      
      private var _isLeftFoot:Boolean;
      
      public function Boss2RushFoot(param1:int, param2:int, param3:Boolean)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE,true);
         loadGraphic(Art.Boss2RushFoot,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         this._isLeftFoot = param3;
         if(this._isLeftFoot)
         {
            facing = LEFT;
         }
         addAnimation("normal",[0]);
         play("normal");
         addAnimation("hurt",[1]);
         play("normal");
      }
      
      override public function touch(param1:Player) : void
      {
         if(this._isLeftFoot && param1.x + param1.width < x + 118 && param1.y + param1.height < y + 112)
         {
            return;
         }
         if(!this._isLeftFoot && param1.x > x + 72 && param1.y + param1.height < y + 112)
         {
            return;
         }
         if(this._isLeftFoot && param1.x > x + width - 15)
         {
            return;
         }
         if(!this._isLeftFoot && param1.x + param1.width < x + 15)
         {
            return;
         }
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
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}
