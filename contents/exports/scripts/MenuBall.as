 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   
   public class MenuBall extends FlxSprite
   {
      
      private static const WIDTH:int = 4;
      
      private static const HEIGHT:int = 4;
      
      public static const BOUNCE_WALL:int = 0;
      
      public static const BOUNCE_PADDLE:int = 1;
      
      public static const SEC_PER_TICK:Number = 0.001;
       
      
      public var elapsed:Number = 0;
      
      public function MenuBall()
      {
         super();
         loadGraphic(Art.PlayerBullet1,true,true,WIDTH,HEIGHT);
         width = WIDTH;
         height = HEIGHT;
         addAnimation("normal",[0]);
         scrollFactor.x = scrollFactor.y = 0;
      }
      
      public function playBounceFx(param1:int) : void
      {
      }
      
      public function bounceX(param1:int) : void
      {
         velocity.x *= -1;
         this.playBounceFx(param1);
      }
      
      public function bounceY(param1:int) : void
      {
         velocity.y *= -1;
         this.playBounceFx(param1);
      }
      
      override public function update() : void
      {
         if(PlayState.realState != PlayState.STATE_MENU)
         {
            this.kill();
         }
         this.elapsed += FlxG.elapsed;
         while(this.elapsed > 0)
         {
            this.elapsed -= SEC_PER_TICK;
            x += velocity.x * SEC_PER_TICK;
            y += velocity.y * SEC_PER_TICK;
         }
         if(x > FlxG.width && velocity.x > 0)
         {
            this.bounceX(BOUNCE_WALL);
         }
         else if(x < 0 && velocity.x < 0)
         {
            this.bounceX(BOUNCE_WALL);
         }
         else if(y > FlxG.height && velocity.y > 0)
         {
            this.bounceY(BOUNCE_WALL);
         }
         else if(y < 0 && velocity.y < 0)
         {
            this.bounceY(BOUNCE_WALL);
         }
      }
      
      override public function kill() : void
      {
         super.kill();
      }
   }
}
