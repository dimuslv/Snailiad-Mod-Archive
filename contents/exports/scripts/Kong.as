 
package
{
   import org.flixel.FlxG;
   
   public class Kong
   {
       
      
      public function Kong()
      {
         super();
      }
      
      public static function skillName() : String
      {
         var _loc1_:String = "Normal";
         if(PlayState.player._hardMode)
         {
            _loc1_ = "Hard";
         }
         if(PlayState.player._easyMode)
         {
            _loc1_ = "Easy";
         }
         if(PlayState.bossRush)
         {
            _loc1_ = "BossRush";
         }
         return _loc1_;
      }
      
      public static function defeatBoss(param1:int, param2:String = "") : void
      {
         if(PlayState.kongregate == null)
         {
            return;
         }
         if(param2 == "")
         {
            param2 = Kong.skillName();
         }
         var _loc3_:String = "Boss" + param1.toString() + "Defeated" + param2;
         PlayState.kongregate.stats.submit(_loc3_,1);
         if(param1 == 4)
         {
            Kong.winGame(param2);
            if(param2 == "Normal")
            {
               Kong.winGame("Easy");
            }
         }
      }
      
      public static function winGame(param1:String = "") : void
      {
         if(PlayState.kongregate == null)
         {
            return;
         }
         if(param1 == "")
         {
            param1 = Kong.skillName();
         }
         var _loc2_:String = "GameCompleted" + param1;
         PlayState.kongregate.stats.submit(_loc2_,1);
      }
      
      public static function reportMap(param1:int) : void
      {
         if(PlayState.kongregate == null)
         {
            return;
         }
         var _loc2_:String = "MapPercent";
         PlayState.kongregate.stats.submit(_loc2_,param1);
      }
      
      public static function reportItems(param1:int) : void
      {
         if(PlayState.kongregate == null)
         {
            return;
         }
         var _loc2_:String = "ItemPercent";
         PlayState.kongregate.stats.submit(_loc2_,param1);
      }
      
      public static function reportNormalTime(param1:Number) : void
      {
         if(PlayState.kongregate == null || FlxG.equal)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:String = "BestNormalTime";
         PlayState.kongregate.stats.submit(_loc2_,int(param1 * 1000));
      }
      
      public static function reportHardTime(param1:Number) : void
      {
         if(PlayState.kongregate == null || FlxG.equal)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:String = "BestHardTime";
         PlayState.kongregate.stats.submit(_loc2_,int(param1 * 1000));
      }
      
      public static function reportBossRushTime(param1:Number) : void
      {
         if(PlayState.kongregate == null || FlxG.equal)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:String = "BestBossRushTime";
         PlayState.kongregate.stats.submit(_loc2_,int(param1 * 1000));
      }
      
      public static function reportHundredPercentTime(param1:Number) : void
      {
         if(PlayState.kongregate == null || FlxG.equal)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:String = "BestHundredPercentTime";
         PlayState.kongregate.stats.submit(_loc2_,int(param1 * 1000));
      }
   }
}
