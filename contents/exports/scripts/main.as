 
package
{
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import org.flixel.FlxG;
   import org.flixel.FlxGame;
   import org.flixel.FlxState;
   
   public class main extends FlxGame
   {
       
      
      public function main()
      {
         var _loc1_:uint = 400;
         var _loc2_:uint = 240;
         var _loc3_:uint = 2;
         super(_loc1_,_loc2_,PlayState,_loc3_);
         pause = new PauseLayer();
         FlxState.bgColor = 4278190080;
         FlxG.framerate = 120;
         FlxG.showBounds = false;
         useDefaultHotKeys = false;
         this.createContextMenu();
      }
      
      public function createContextMenu() : void
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         var _loc2_:ContextMenuItem = new ContextMenuItem("Copyright 2011 Crystal Jacobs");
         var _loc3_:ContextMenuItem = new ContextMenuItem("Email: crystal@panix.com");
         _loc3_.enabled = false;
         _loc2_.enabled = false;
         _loc1_.customItems.push(_loc2_,_loc3_);
         contextMenu = _loc1_;
      }
   }
}
