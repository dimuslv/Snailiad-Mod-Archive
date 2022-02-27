 
package
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class JayIsGames extends FlxSprite
   {
      
      private static const IMG_WIDTH:int = 93;
      
      private static const IMG_HEIGHT:int = 25;
      
      private static const _jigUrl:String = "http://jayisgames.com/";
       
      
      public function JayIsGames()
      {
         super();
         x = 0;
         y = FlxG.height - IMG_HEIGHT;
         scrollFactor.x = 0;
         scrollFactor.y = 0;
         visible = true;
         loadGraphic(Art.JayIsGames,false,false,IMG_WIDTH,IMG_HEIGHT);
         addAnimation("normal",[0]);
         play("normal");
      }
      
      public function show() : void
      {
         alpha = 1;
         visible = true;
      }
      
      public function hide() : void
      {
         alpha = 0.05;
         visible = true;
      }
      
      override public function update() : void
      {
         if(visible && !dead && alpha == 1)
         {
            if(FlxG.mouse.justPressed() && FlxG.mouse.screenX < width && FlxG.mouse.screenY >= y)
            {
               navigateToURL(new URLRequest(_jigUrl),"_self");
            }
         }
         super.update();
      }
   }
}