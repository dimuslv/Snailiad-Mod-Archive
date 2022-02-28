 
package
{
   import org.flixel.FlxGroup;
   
   public class Boss4SecondFormBulletGroups extends FlxGroup
   {
      
      private static const MAX_BULLET:Array = [120,20];
      
      private static const MAX_WEAPON:int = 2;
       
      
      public var groups:Array;
      
      public var bulletLists:Array;
      
      public function Boss4SecondFormBulletGroups()
      {
         var _loc2_:int = 0;
         this.groups = new Array();
         this.bulletLists = new Array();
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MAX_WEAPON)
         {
            this.groups[_loc1_] = new FlxGroup();
            this.bulletLists[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < MAX_BULLET[_loc1_])
            {
               this.bulletLists[_loc1_][_loc2_] = this.makeBullet(_loc1_);
               this.groups[_loc1_].add(this.bulletLists[_loc1_][_loc2_]);
               _loc2_++;
            }
            add(this.groups[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:* = null;
         super.destroy();
         for(_loc1_ in this.groups)
         {
            this.groups[_loc1_] = null;
         }
         for(_loc1_ in this.bulletLists)
         {
            this.bulletLists[_loc1_] = null;
         }
         this.groups = null;
         this.bulletLists = null;
      }
      
      public function destroyAll() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < MAX_WEAPON)
         {
            _loc2_ = 0;
            while(_loc2_ < MAX_BULLET[_loc1_])
            {
               this.bulletLists[_loc1_][_loc2_].kill();
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function makeBullet(param1:int) : Boss4Bullet
      {
         switch(param1)
         {
            case 0:
               return new Boss4Bullet4();
            case 1:
               return new Boss4Bullet7();
            default:
               throw new Error("Unknown bullet type: " + param1.toString());
         }
      }
      
      public function getBullet(param1:int) : Boss4Bullet
      {
         return this.groups[param1].getFirstAvail();
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         super.update();
      }
   }
}
