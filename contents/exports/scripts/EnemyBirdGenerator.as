 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxU;
   
   public class EnemyBirdGenerator extends Enemy
   {
       
      
      private const TIMEOUTS:Array = [0.60153,0.48509,0.70037,0.66276,0.70802,0.79541,0.62043,0.5796,0.99605,0.15058,0.72121,0.86851,0.64371,0.76708,0.89401,0.52828,0.72309,0.15963,0.15116,0.1799,0.27829,0.40878,0.92538,0.45074,0.18865,0.59797,0.4318,0.94098,0.23463,0.29221,0.59734,0.34877,0.81676,0.57617,0.14883,0.16094,0.14123,0.57931,0.85924,0.22828,0.63834,0.10387,0.54746,0.24897,0.11105,0.49748,0.54746,0.19405,0.79792,0.36023,0.53726,0.78544,0.60425,0.83512,0.01696,0.10451,0.01513,0.78678,0.51617,0.24251];
      
      private const BASE_TIMEOUT:Number = 7.0;
      
      private var timeout:Number = 0;
      
      private var listPos:int = 0;
      
      public function EnemyBirdGenerator(param1:int, param2:int)
      {
         super(param1,param2,9999,0,0);
         solid = false;
         visible = false;
         this.listPos = Math.abs(int(param1 * 23 - param2 * 17)) % this.TIMEOUTS.length;
         this.timeout = this.TIMEOUTS[this.listPos] * this.BASE_TIMEOUT;
         active = true;
      }
      
      override public function collideTerrain() : Boolean
      {
         return false;
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Enemy = null;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         this.timeout -= FlxG.elapsed;
         if(this.timeout < 0)
         {
            ++this.listPos;
            this.listPos %= this.TIMEOUTS.length;
            this.timeout = this.TIMEOUTS[this.listPos] * this.BASE_TIMEOUT;
            _loc1_ = FlxU.random() > 0.5 ? Number(-FlxG.scroll.x + FlxG.width - 8) : Number(-FlxG.scroll.x - 8);
            if(Math.abs(PlayState.player.x - _loc1_) < 75)
            {
               return;
            }
            _loc2_ = -FlxG.scroll.y + FlxU.random() * FlxG.height;
            _loc3_ = new EnemyBird(_loc1_,_loc2_);
            if(_loc3_.collideTerrain())
            {
               PlayState.enemies.add(_loc3_);
            }
            else
            {
               PlayState.enemiesNoCollide.add(_loc3_);
            }
            Sfx.playChirp();
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
         play("quiver");
      }
   }
}
