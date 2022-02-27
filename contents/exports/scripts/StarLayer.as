 
package
{
   import org.flixel.FlxGroup;
   
   public class StarLayer extends FlxGroup
   {
       
      
      private const MAX_STARS:int = 15;
      
      public var stars:Array;
      
      public function StarLayer()
      {
         this.stars = new Array();
         super();
      }
      
      override public function destroy() : void
      {
         var _loc1_:* = null;
         super.destroy();
         for(_loc1_ in this.stars)
         {
            this.stars[_loc1_] = null;
         }
         this.stars = null;
      }
      
      public function destroyAll() : void
      {
         if(!this.stars[0])
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_STARS)
         {
            this.stars[_loc1_].kill();
            remove(this.stars[_loc1_],true);
            _loc1_++;
         }
      }
      
      public function makeStars() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_STARS)
         {
            this.stars[_loc1_] = new Star();
            add(this.stars[_loc1_]);
            _loc1_++;
         }
      }
   }
}
