 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxObject;
   
   public class Platform4b extends Item
   {
      
      private static const IMG_WIDTH:int = 48;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const MAX_HP:int = 150;
      
      private static const DEFENSE:int = 0;
      
      private static const ACCEL:Number = 0.02;
      
      private static const SPEED:Number = 0.5;
      
      private static const SEC_PER_TICK:Number = 0.01;
       
      
      private var _posy:Number;
      
      private var _accy:Number;
      
      private var _vely:Number;
      
      private var _lastHurt:int;
      
      private var _defense:int;
      
      private var _justFlashed:int;
      
      private var _elapsed:Number = 0;
      
      public function Platform4b(param1:int, param2:int)
      {
         super(param1,param2,false);
         loadGraphic(Art.Platform4b,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         addAnimation("normal",[0]);
         play("normal");
         this._posy = y;
         this._accy = 0;
         this._vely = -SPEED;
         solid = true;
         active = true;
      }
      
      override public function hitBottom(param1:FlxObject, param2:Number) : void
      {
         var _loc3_:Player = null;
         if(param1 is Player)
         {
            _loc3_ = param1 as Player;
         }
      }
      
      override public function triggerAi1() : void
      {
         this._accy = ACCEL;
      }
      
      override public function triggerAi2() : void
      {
         this._accy = -ACCEL;
      }
      
      override public function touch(param1:Player) : void
      {
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this._elapsed += FlxG.elapsed;
         while(this._elapsed > 0)
         {
            this._elapsed -= SEC_PER_TICK;
            this._vely += this._accy;
            if(this._vely > SPEED)
            {
               this._vely = SPEED;
            }
            if(this._vely < -SPEED)
            {
               this._vely = -SPEED;
            }
            this._posy += this._vely;
            _loc1_ = int(this._posy);
            _loc2_ = int(y);
            _loc3_ = _loc1_ - _loc2_;
            if(_loc2_ != _loc1_)
            {
               if(PlayState.player._gravityDir == Player.GRAV_DOWN)
               {
                  _loc4_ = _loc2_ - int(PlayState.player.y + PlayState.player.height);
                  if(Math.abs(_loc4_) < 3 && PlayState.player.x + PlayState.player.width > x && PlayState.player.x < x + width)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y = _loc1_ - PlayState.player.height;
                        PlayState.player.velocity.y = 0;
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_UP)
               {
                  _loc4_ = _loc2_ + height - int(PlayState.player.y);
                  if(Math.abs(_loc4_) < 3 && PlayState.player.x + PlayState.player.width > x && PlayState.player.x < x + width)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y = _loc1_ + height;
                        PlayState.player.velocity.y = 0;
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_LEFT)
               {
                  _loc5_ = int(x) + width - int(PlayState.player.x);
                  if(Math.abs(_loc5_) < 3 && PlayState.player.y + PlayState.player.height > y && PlayState.player.y < y + height)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y += _loc3_;
                        PlayState.player.velocity.x = 0;
                        if(_loc5_ < 0)
                        {
                           PlayState.player.x = int(x) + width;
                        }
                     }
                  }
               }
               else if(PlayState.player._gravityDir == Player.GRAV_RIGHT)
               {
                  _loc5_ = int(x) - int(PlayState.player.x + PlayState.player.width);
                  if(Math.abs(_loc5_) < 3 && PlayState.player.y + PlayState.player.height > y && PlayState.player.y < y + height)
                  {
                     if(!PlayState.player.pressedJump())
                     {
                        PlayState.player.y += _loc3_;
                        PlayState.player.velocity.x = 0;
                        if(_loc5_ > 0)
                        {
                           PlayState.player.x = int(x) - PlayState.player.width;
                        }
                     }
                  }
               }
            }
            y = _loc1_;
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
      }
   }
}
