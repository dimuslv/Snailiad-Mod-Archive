 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxText;
   
   public class Intro extends FlxGroup
   {
      
      private static const MODE_NONE:int = 0;
      
      private static const MODE_WAIT_START:int = 1;
      
      private static const MODE_STORY:int = 2;
      
      private static const MODE_END:int = 3;
       
      
      private var _bg:IntroBg;
      
      private var _pictureLayer:FlxGroup;
      
      private var _elapsed:Number = 0;
      
      private var _picture:IntroPicture;
      
      private var _picture2:IntroPicture;
      
      private var _picture3:IntroPicture;
      
      private var _skipText:FlxText;
      
      private var _mode:int = 0;
      
      private var _modeElapsed:Number = 0;
      
      private var _modeInitialized:Boolean;
      
      private var _dialogueMode:Number = 0;
      
      private var _targetAlpha:Array;
      
      private var _dialogueLayer:IntroDialogue;
      
      public function Intro()
      {
         var _loc1_:FlxText = null;
         super();
         FlxG.noPause = true;
         FlxG.mouse.hide();
         this.setMode(MODE_WAIT_START);
         this._bg = new IntroBg();
         add(this._bg);
         this._dialogueLayer = new IntroDialogue();
         add(this._dialogueLayer);
         _loc1_ = new FlxText(0,-1,FlxG.width - 2);
         _loc1_.font = Fonts.normal;
         _loc1_.size = Number(10);
         _loc1_.color = uint(16579836);
         _loc1_.shadow = uint(1);
         _loc1_.alignment = "right";
         _loc1_.scrollFactor.x = _loc1_.scrollFactor.y = Number(0);
         _loc1_.text = "ESC TO SKIP";
         _loc1_.alpha = Number(0);
         this._skipText = _loc1_;
         add(this._skipText);
         Music.playTitle();
      }
      
      override public function destroy() : void
      {
         this._bg = null;
         this._picture = null;
         this._picture2 = null;
         this._picture3 = null;
         this._pictureLayer = null;
         this._targetAlpha = null;
         this._dialogueLayer = null;
         this._skipText = null;
         super.destroy();
      }
      
      public function setMode(param1:int) : void
      {
         this._mode = param1;
         this._modeElapsed = Number(0);
         this._modeInitialized = false;
      }
      
      public function updateIntroWaitStart() : void
      {
         if(!this._bg.isFadingIn())
         {
            this.setMode(MODE_STORY);
         }
      }
      
      public function updateIntroStory() : void
      {
         var _loc1_:String = null;
         if(!this._modeInitialized)
         {
            this._modeInitialized = true;
            this._dialogueMode = Number(0);
            this._picture = new IntroPicture(1);
            add(this._picture);
         }
         switch(this._dialogueMode)
         {
            case 0:
               this._skipText.alpha = this._picture.alpha;
               if(this._picture.alpha > 0.7)
               {
                  ++this._dialogueMode;
                  this._modeElapsed = Number(0);
                  this._dialogueLayer.start("ALL WAS PEACEFUL IN SNAIL COUNTRY...\n");
               }
               break;
            case 1:
               this._skipText.alpha = this._picture.alpha;
               if(this._modeElapsed >= 5.4)
               {
                  ++this._dialogueMode;
                  this._picture.fadeOut();
               }
               break;
            case 2:
               if(this._picture.alpha == 0)
               {
                  ++this._dialogueMode;
                  remove(this._picture);
                  this._picture = new IntroPicture(2);
                  add(this._picture);
               }
               break;
            case 3:
               if(this._picture.alpha >= 0.1)
               {
                  ++this._dialogueMode;
                  this._modeElapsed = Number(0);
                  this._dialogueLayer.start(" UNTIL ONE DAY...\n" + "  IRIS CALLED FOR SUN SNAIL\'S\n" + "   PRESENCE...\n");
               }
               break;
            case 4:
               if(this._modeElapsed >= 6)
               {
                  ++this._dialogueMode;
                  this._picture.fadeOut();
               }
               break;
            case 5:
               if(this._picture.alpha == 0)
               {
                  ++this._dialogueMode;
                  remove(this._picture);
                  this._picture = new IntroPicture(1);
                  add(this._picture);
               }
               break;
            case 6:
               if(this._picture.alpha > 0.1)
               {
                  ++this._dialogueMode;
                  this._modeElapsed = Number(0);
                  this._dialogueLayer.start(" SOON AFTER...\n" + "  A GREAT SENSE OF DANGER AND\n" + "   GLOOM BEFELL SNAIL COUNTRY\n");
               }
               break;
            case 7:
               if(this._modeElapsed >= 3)
               {
                  ++this._dialogueMode;
                  this._picture2 = new IntroPicture(3);
                  add(this._picture2);
               }
               break;
            case 8:
               if(this._modeElapsed >= 5.5)
               {
                  ++this._dialogueMode;
                  this._picture3 = new IntroPicture(4);
                  add(this._picture3);
               }
               break;
            case 9:
               if(this._modeElapsed >= 8.5)
               {
                  ++this._dialogueMode;
                  this._modeElapsed = Number(0);
                  this._dialogueLayer.start(" PLUNGED INTO PERIL, THE LAND\n" + "  BECAME UNTAMED, FEW DARING TO\n" + "   PIERCE ITS INFESTED REACHES\n");
               }
               break;
            case 10:
               if(this._modeElapsed >= 8.5)
               {
                  ++this._dialogueMode;
                  remove(this._picture);
                  remove(this._picture2);
                  this._modeElapsed = Number(0);
                  _loc1_ = !!PlayState.introSlugMode ? "SLUGGY SLUG" : "SNAILY SNAIL";
                  this._dialogueLayer.start(" SENSING A CALLING AND A DISTINCT\n" + "  FEELING OF DEJA VU, " + _loc1_ + "\n" + "   SET OFF IN SEARCH OF ANSWERS...\n");
               }
               break;
            case 11:
               if(this._modeElapsed >= 8.5)
               {
                  this.setMode(MODE_END);
               }
         }
         if(FlxG.keys.pressed("ESCAPE"))
         {
            this.setMode(MODE_END);
         }
      }
      
      public function updateIntroEnd() : void
      {
         if(!this._modeInitialized)
         {
            FlxG.noPause = false;
            this._modeInitialized = true;
            FlxG.fade.start(-16760705,1,PlayState.loadGame);
            FlxG.music.fadeOut(1);
         }
      }
      
      override public function update() : void
      {
         this._modeElapsed += FlxG.elapsed;
         switch(this._mode)
         {
            case MODE_NONE:
               this.setMode(MODE_WAIT_START);
               break;
            case MODE_WAIT_START:
               this.updateIntroWaitStart();
               break;
            case MODE_STORY:
               this.updateIntroStory();
               break;
            case MODE_END:
               this.updateIntroEnd();
         }
         super.update();
      }
   }
}
