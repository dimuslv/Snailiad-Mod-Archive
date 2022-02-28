 
package
{
   import flash.utils.ByteArray;
   
   public class Configurable
   {
       
      
      private var configXmlFile:Class;
      
      private var _xml:XML;
      
      public function Configurable()
      {
         this.configXmlFile = Configurable_configXmlFile;
         super();
         var _loc1_:ByteArray = new this.configXmlFile();
         var _loc2_:String = _loc1_.readUTFBytes(_loc1_.length);
         this._xml = new XML(_loc2_);
      }
      
      public function destroy() : void
      {
         this._xml = null;
         this.configXmlFile = null;
      }
      
      public function getPlayerStartX(param1:int = 0) : int
      {
         this.updateCoords();
         if(PlayState.bossRush)
         {
            return PlayState.playerBrStartX;
         }
         return PlayState.playerStartX;
      }
      
      public function getPlayerStartY(param1:int = 0) : int
      {
         this.updateCoords();
         if(PlayState.bossRush)
         {
            return PlayState.playerBrStartY;
         }
         return PlayState.playerStartY;
      }
      
      public function updateCoords() : void
      {
         if(!PlayState.bossRush)
         {
            if(PlayState.isStartOld)
            {
               var _loc1_:int = 0;
               var _loc2_:int = 0;
               PlayState.isStartOld = false;
               while(_loc1_ < PlayState.worldMap.spmap.widthInTiles)
               {
                  _loc2_ = 0;
                  while(_loc2_ < PlayState.worldMap.spmap.heightInTiles)
                  {
                     if(PlayState.worldMap.spmap.getTile(_loc1_,_loc2_) == 2)
                     {
                        PlayState.playerStartX = _loc1_;
                        PlayState.playerStartY = _loc2_;
                        return;
                     }
                     _loc2_++;
                  }
                  _loc1_++;
               }
               PlayState.playerStartX = 299;
               PlayState.playerStartY = 166;
            }
            return;
         }
         if(PlayState.isBrStartOld)
         {
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            PlayState.isBrStartOld = false;
            while(_loc3_ < PlayState.worldMap.spmap.widthInTiles)
            {
               _loc4_ = 0;
               while(_loc4_ < PlayState.worldMap.spmap.heightInTiles)
               {
                  if(PlayState.worldMap.spmap.getTile(_loc3_,_loc4_) == 337)
                  {
                     PlayState.playerBrStartX = _loc3_;
                     PlayState.playerBrStartY = _loc4_;
                     return;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
            PlayState.playerBrStartX = Player.BOSSRUSH_STARTX;
            PlayState.playerBrStartY = Player.BOSSRUSH_STARTY;
         }
      }
   }
}
