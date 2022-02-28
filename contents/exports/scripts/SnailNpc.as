 
package
{
   import org.flixel.FlxG;
   
   public class SnailNpc extends Npc
   {
      
      private static const IMG_WIDTH:int = 32;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static var talkedToCaveSnail:Boolean = false;
       
      
      private var _snailNum:int = 0;
      
      private var _talkOpen:Boolean;
      
      private var _nexted:int = 0;
      
      private var _elapsed:Number = 0;
      
      private var _hasFallen:Boolean;
      
      private var _speed:Number = 1.0;
      
      public function SnailNpc(param1:int, param2:int, param3:int)
      {
         this._speed = 1;
         this._speed = 1;
         this._speed = 1;
         this._speed = 1;
         this._speed = 1;
         this._speed = 1;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         super(param1,param2);
         loadGraphic(Art.SnailNpc,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         if(param3 == 26 && PlayState.player._slugMode)
         {
            param3 = 44;
         }
         if(param3 == 38)
         {
            if(!PlayState.bossesKilled[4])
            {
               exists = false;
            }
            else if(PlayState.player.getHelixFragments() < 30)
            {
               param3 = 49;
               y += 32;
               x += 16;
            }
         }
         addAnimation("normal",[2 * param3,2 * param3 + 1],3,true);
         play("normal");
         this._snailNum = param3;
         acceleration.y = 1200;
         if(param3 == 17)
         {
            acceleration.y = -1200;
         }
         if(param3 == 35 || param3 == 47)
         {
            acceleration.y = -1200;
         }
         if(param3 == 43)
         {
            acceleration.y = -1200;
         }
         if(param3 == 39 || param3 == 38 || param3 == 49)
         {
            acceleration.y = 0;
         }
         maxVelocity.y = PlayState.player.maxVelocity.y;
      }
      
      override public function touch(param1:Player) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:* = null;
         var _loc2_:int = this._snailNum % 4;
         var _loc3_:String = "Snaily";
         if(param1._slugMode)
         {
            _loc3_ = "Sluggy";
         }
         var _loc4_:String = "Snaily Snail";
         if(param1._slugMode)
         {
            _loc4_ = "Sluggy Slug";
         }
         var _loc5_:String = "snail";
         if(param1._slugMode)
         {
            _loc5_ = "slug";
         }
         if(!this._talkOpen)
         {
            _loc6_ = PlayState.player.getPercentComplete();
            _loc7_ = PlayState.player.getHelixFragments();
            _loc8_ = false;
            _loc9_ = "[no text yet: NPC #" + this._snailNum.toString() + "]";
            switch(this._snailNum)
            {
               case 0:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc9_ = "Hi, " + _loc3_ + "!!  Have I told you just\n" + "how much I love extensive\n" + "weapon collections?\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "Oh, nice pea shooter!  I heard\n" + "you can shoot a blue door open\n" + "with one of those!\n";
                  }
                  else if(!PlayState.player.hasWeapon(2))
                  {
                     _loc9_ = "Wow, a boomerang!  You could\n" + "break a pink door open with\n" + "just one of those!\n";
                  }
                  else if(!PlayState.player.getHasDevastator())
                  {
                     _loc9_ = "Is that a rainbow wave!?  Well,\n" + "then!  You can open a red door\n" + "with one of those!\n";
                  }
                  else if(_loc6_ < 100)
                  {
                     _loc9_ = "A devastator!?  That opens up\n" + "green doors!  It also upgrades\n" + "all three weapons!  Wow!!\n";
                  }
                  else
                  {
                     _loc9_ = "I hope the next game has more\n" + "weapons.  This game could have\n" + "used a screw attack!\n";
                  }
                  break;
               case 1:
                  if(!PlayState.player.hasWeapon(0) && !PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "Hiya, " + _loc3_ + "!  Welcome to my\n" + "personal tree branch!\n";
                  }
                  else if(_loc6_ < 100)
                  {
                     _loc9_ = "I\'m not gonna lie, " + _loc3_ + "...\n" + "This town has always given me a\n" + "case of deja vu.\n";
                  }
                  else
                  {
                     _loc9_ = "Y\'know, who knows? Maybe it\'s\n" + "just me.\n";
                  }
                  break;
               case 2:
                  if(!PlayState.player.hasWeapon(0) && !PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you finding a weapon\n" + "somewhere here in town!\n";
                  }
                  else if(!PlayState.bossesKilled[1])
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading to the right\n" + "part of the map!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "I can see the past, " + _loc3_ + "!\n" + "I see you forgot to grab the\n" + "boomerang after Shellbreaker!\n";
                  }
                  else if(!PlayState.bossesKilled[2] && !PlayState.bossesKilled[3])
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading downward!!\n";
                  }
                  else if(PlayState.bossesKilled[2] && !PlayState.bossesKilled[3])
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading to the lower\n" + "right part of the map!!\n";
                  }
                  else if(!PlayState.bossesKilled[2] && PlayState.bossesKilled[3])
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading to the lower\n" + "left part of the map!!\n";
                  }
                  else if(!PlayState.bossesKilled[4])
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading to the upper\n" + "left part of the map!!\n";
                  }
                  else if(_loc7_ < 30)
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading all over the\n" + "map, finding little shells!\n";
                  }
                  else if(!PlayState.player.hasSeenIsis)
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you heading back up to\n" + "the upper left map area!!\n";
                  }
                  else if(!PlayState.player._slugMode)
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you having 18,000,000\n" + "baby snails!!  Congratulations!!\n";
                  }
                  else
                  {
                     _loc9_ = "I can see the future, " + _loc3_ + "!\n" + "I see you having 18,000,000\n" + "baby slugs!!  Congratulations!!\n";
                  }
                  break;
               case 3:
                  if(!PlayState.player.hasGravityJump() && !PlayState.player.hasArmor())
                  {
                     _loc9_ = "Sometimes I wonder if I\'ll ever\n" + "stumble upon some mystical\n" + "pickup out in the world...\n";
                  }
                  else if(!PlayState.player.hasArmor())
                  {
                     _loc9_ = "Oh, my, you\'re a gravity " + _loc5_ + "!\n" + "You must be really good at\n" + "crawling around ceilings!!\n";
                  }
                  else if(PlayState.player.hasArmor() && !PlayState.player.hasGravityJump())
                  {
                     _loc9_ = "Oh, my, you\'re a full metal\n" + _loc5_ + "!  You must be really strong\n" + "and fire-resistant!!\n";
                  }
                  else
                  {
                     _loc9_ = "Woah, a metal gravity " + _loc5_ + "!!\n" + "You\'re amazingly versatile now,\n" + "aren\'t you?  That\'s incredible!!";
                  }
                  break;
               case 4:
                  _loc9_ = "I feel privilaged, " + _loc3_ + "! My\n" + "house is the only one this\n" + "side of town with some grass!!\n";
                  break;
               case 5:
                  if(_loc6_ < 100)
                  {
                     _loc9_ = "There\'s a lot of secrets\n" + "in and around Snail Country.\n" + "Have you found them all?\n";
                  }
                  else
                  {
                     _loc9_ = "They say Boss Rush is the\n" + "true test of snail skill.\n" + "But what about slug skill?\n";
                  }
                  break;
               case 6:
                  if(PlayState.worldMap.spmap.getTile(143,151))
                  {
                     _loc9_ = "Have you ever slipped and\n" + "fallen right through a wall?\n" + "The very idea of it scares me!!\n";
                  }
                  else
                  {
                     _loc9_ = "I always thought there was\n" + "something weird about that\n" + "wall!! Thanks, " + _loc3_ + "!!\n";
                  }
                  break;
               case 7:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc9_ = "Where are you going, " + _loc3_ + "?\n" + "Can I come with you?\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "Hey, " + _loc3_ + "!  Where\'d you get\n" + "the pea shooter?\n";
                  }
                  else if(!PlayState.player.hasWeapon(2))
                  {
                     _loc9_ = "Ooh, boomerangs!  If I had\n" + "those, I\'d try breaking the\n" + "green blocks around town!\n";
                  }
                  else if(!PlayState.player.getHasDevastator())
                  {
                     _loc9_ = "Rainbows are so pretty!\n" + "Don\'t you think so, " + _loc3_ + "?\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "I\'m scared, " + _loc3_ + "!\n" + "What\'s been going on around\n" + "the country?  Are we safe?\n";
                  }
                  else
                  {
                     _loc9_ = "Snail Country is safe again,\n" + "thanks to you, " + _loc3_ + "!\n";
                  }
                  break;
               case 8:
                  if(!PlayState.isBossDead(2))
                  {
                     _loc9_ = "I\'ve always wondered why the\n" + "town was built around this\n" + "weird tunnel...\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "Wait, there\'s a whole area\n" + "under that tunnel?  How\n" + "have I never known about this?\n";
                  }
                  else
                  {
                     _loc9_ = "Now that the country is safe,\n" + "I wanna turn that hidden area\n" + "into a tourist attraction!!\n";
                  }
                  break;
               case 9:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc9_ = "Here, " + _loc3_ + "!!  If you\'re leaving\n" + "town, you\'ll need this!!\n" + "It\'s dangerous out there!!\n";
                  }
                  else
                  {
                     _loc9_ = "Good luck out there, " + _loc3_ + "!!\n";
                  }
                  break;
               case 10:
                  _loc9_ = "" + _loc3_ + ", it\'s you!!  I\'ve been\n" + "stuck behind those blocks\n" + "for hours!  I\'m saved!!\n";
                  break;
               case 11:
                  if(!PlayState.player.hasSeenIsis)
                  {
                     _loc9_ = "Can you keep a secret, " + _loc3_ + "?\n" + "I have a little bit of a crush\n" + "on Iris...  Don\'t tell anyone!!\n";
                  }
                  else
                  {
                     _loc9_ = "What!?  You met Iris!?\n" + "Are you trying to make me\n" + "jealous, " + _loc3_ + "?\n";
                  }
                  break;
               case 12:
                  if(_loc6_ < 100)
                  {
                     _loc9_ = "One day, I wana go out there\n" + "and explore every last corner\n" + "of the world.  Mark my words!!\n";
                  }
                  else
                  {
                     _loc9_ = "Wow, " + _loc3_ + ", you went and\n" + "fulfilled my dream? How was it?\n" + "Was it worth it?\n";
                  }
                  break;
               case 13:
                  _loc9_ = "Hi, " + _loc3_ + "!  Fun fact:\n" + "the snail to my left always\n" + "lies!!\n";
                  break;
               case 14:
                  _loc9_ = "I was originally gonna say\n" + "something else, but I really\n" + "loved crashing Epsilon\'s game. :3\n";
                  break;
               case 15:
                  _loc9_ = "Hi, " + _loc3_ + "!  Fun fact:\n" + "the snail to my right always\n" + "tells the truth!!\n";
                  break;
               case 16:
                  _loc9_ = "I\'ve never liked this long\n" + "tunnel to get out of town.\n" + "Do you think it\'s safe, " + _loc3_ + "?\n";
                  break;
               case 17:
                  _loc9_ = "One day, I want an upside-down\n" + "house built just for me!!\n";
                  break;
               case 18:
                  if(!PlayState.player.hasWeapon(0))
                  {
                     _loc9_ = "Are you leaving town, " + _loc3_ + "?\n" + "I\'m afraid you can\'t without\n" + "proper protection.\n";
                  }
                  else if(!PlayState.isBossDead(1))
                  {
                     _loc9_ = "Are you leaving town, " + _loc3_ + "?\n" + "Stay safe out there!!\n";
                  }
                  else
                  {
                     _loc9_ = "Welcome back, " + _loc3_ + "!!\n" + "Good to see you\'re still\n" + "doing alright!\n";
                  }
                  break;
               case 19:
                  _loc9_ = "Welcome to the mid-world\n" + "checkpoint!!  You have clearance\n" + "to pass, " + _loc4_ + "!!\n";
                  break;
               case 20:
                  if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "Hey, you\'re from western\n" + "town, right?  Welcome!!\n";
                  }
                  else if(_loc6_ < 100)
                  {
                     _loc9_ = "I hope you\'re enjoying your\n" + "time this side of the map!!\n" + "It\'s quite expansive!!\n";
                  }
                  else
                  {
                     _loc9_ = "Hey, you came back to visit!!\n";
                  }
                  break;
               case 21:
                  if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "I\'ve heard of a scary\n" + "monster not far from here. I\'m\n" + "too afraid to see if it\'s true.\n";
                  }
                  else
                  {
                     _loc9_ = "Wow, you defeated the monster?\n" + "That\'s awesome!!  What was it\n" + "like? Was it big and scary?\n";
                  }
                  break;
               case 22:
                  if(_loc7_ < 15)
                  {
                     _loc9_ = "Have you heard about \"Helix\n" + "Fragments\"?  They\'re so pretty!\n" + "I wonder how many there are...\n";
                  }
                  else if(_loc7_ < 30)
                  {
                     _loc9_ = "Woah!!  " + _loc7_ + " Helix Fragments!?\n" + "Where did you find them all!?\n";
                  }
                  else
                  {
                     _loc9_ = "Woah!!  You found all 30 of\n" + "them!?  Amazing!!  Can I have\n" + "one?\n";
                  }
                  talkedToCaveSnail = true;
                  break;
               case 23:
                  if(PlayState.worldMap.spmap.getTile(517,67) && !talkedToCaveSnail)
                  {
                     _loc9_ = "There\'s a snail here in town\n" + "who\'s crazy about Helix\n" + "Fragments.  Have you met him?\n";
                  }
                  else if(PlayState.worldMap.spmap.getTile(517,67) && talkedToCaveSnail)
                  {
                     _loc9_ = "I can hear a Helix Fragment\n" + "nearby!  It must be somewhere\n" + "in this wall...\n";
                  }
                  else
                  {
                     _loc9_ = "Wow!  You found the\n" + "Helix Fragment?\n" + "Impressive!!\n";
                  }
                  break;
               case 24:
                  _loc9_ = "Some day, I want to see\n" + "what\'s waiting below us in\n" + "that deep, icy ocean...\n";
                  break;
               case 25:
                  _loc9_ = "My neighbor is in charge of the\n" + "checkpoint left of here. You\n" + "met her, right?\n";
                  break;
               case 26:
                  if(!PlayState.player.hasTurbo())
                  {
                     _loc9_ = "They say there\'s a cool weapon\n" + "enhancement somewhere below\n" + "town, but I can\'t find it!\n";
                  }
                  else if(_loc6_ < 100)
                  {
                     _loc9_ = "Woah, a Rapid Fire enhancement!!\n" + "I wish I had one of those!!\n";
                  }
                  else
                  {
                     _loc9_ = "I\'m bored!  Do you know of any\n" + "fun places to visit?  I\'m\n" + "itching for adventure!!\n";
                  }
                  break;
               case 27:
                  if(PlayState.player.hasArmor() || PlayState.player.hasGravityJump())
                  {
                     _loc9_ = "Hey, " + _loc3_ + "!  You came\n" + "back to visit!!  Yay!!\n";
                  }
                  else if(PlayState.player.isIcy() && PlayState.isBossDead(1))
                  {
                     _loc9_ = "Oh, " + _loc3_ + ", you\'re an Ice " + _loc5_ + "!\n" + "I wanna be one too!!  Snow and\n" + "ice are so fun!\n";
                  }
                  else if(!PlayState.isBossDead(1))
                  {
                     _loc9_ = "" + _loc3_ + ", it\'s you!!  There\'s a\n" + "scary monster up ahead!  I\n" + "can hear it from here!!\n";
                  }
                  else
                  {
                     _loc9_ = "Oh, " + _loc3_ + ", you beat the\n" + "monster!!  Thank you!!  I left my\n" + "drink in that other room!\n";
                  }
                  break;
               case 28:
                  if(!PlayState.isBossDead(2) && !PlayState.isBossDead(3))
                  {
                     _loc9_ = "" + _loc3_ + "!!  These doors are locked\n" + "tight!  This first one seems to\n" + "have feet imprinted on it!!\n";
                  }
                  else if(PlayState.isBossDead(2) && !PlayState.isBossDead(3))
                  {
                     _loc9_ = "" + _loc3_ + ", the first door unlocked!!\n" + "The next one looks like it has\n" + "a giant angry cube on it!!\n";
                  }
                  else if(!PlayState.isBossDead(2) && PlayState.isBossDead(3))
                  {
                     _loc9_ = "" + _loc3_ + ", I heard the second door\n" + "unlock!! Now we just have to open\n" + "the other door...\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "They both unlocked!!  Moon Snail\n" + "is just through the next area!\n" + "Good luck, " + _loc3_ + "!!\n";
                  }
                  else if(PlayState.isBossDead(4) && _loc7_ < 30)
                  {
                     _loc9_ = "You defeated Moon Snail!!  Please,\n" + "" + _loc3_ + ", find all the Helix\n" + "Fragments to restore his light!!\n";
                  }
                  else
                  {
                     _loc9_ = "" + _loc3_ + ", you did it!!  Sun Snail\n" + "has returned to us once again!!\n" + "Three cheers for " + _loc4_ + "!!\n";
                  }
                  break;
               case 29:
                  if(!PlayState.player.isIcy())
                  {
                     _loc9_ = "Be careful up ahead! You\'re\n" + "not properly equipped for the\n" + "next area!!\n";
                  }
                  else
                  {
                     _loc9_ = "Hail, fellow Ice Snail!!\n" + "Come to explore the depths of\n" + "deep Maculata?  Good luck!!\n";
                  }
                  _loc8_ = true;
                  break;
               case 30:
                  if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "" + _loc3_ + "!  Am I glad to see\n" + "you!  I don\'t like this place...\n" + "It gives me the creeps!!\n";
                  }
                  else
                  {
                     _loc9_ = "" + _loc3_ + ", you came back!!\n" + "Wait...  If Sun Snail returned,\n" + "what\'s gonna happen to this place?\n";
                  }
                  _loc8_ = true;
                  break;
               case 31:
                  if(!PlayState.isBossDead(3))
                  {
                     _loc9_ = "The mountain is shaking!!  There\n" + "must be something agitating\n" + "its core!!\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "The shaking stopped!  You\'ve\n" + "saved us from an eruption,\n" + _loc3_ + "!!\n";
                  }
                  else
                  {
                     _loc9_ = "So I guess we just have a\n" + "volcano now, huh?  Cool!!\n";
                  }
                  _loc8_ = true;
                  break;
               case 32:
                  if(!PlayState.player.hasArmor() || !PlayState.player.hasTurbo())
                  {
                     _loc9_ = "Watch out, " + _loc3_ + "!  You\'re not\n" + "strong enough to fight Moon\n" + "Snail yet!!  Turn back!!\n";
                  }
                  else if(_loc7_ < 30 && !PlayState.isBossDead(4))
                  {
                     _loc9_ = "If only you had the power of\n" + "Iris!  She could restore his\n" + "light once he\'s defeated!!\n";
                  }
                  else if(_loc7_ == 30 && !PlayState.isBossDead(4))
                  {
                     _loc9_ = "Use the power of Iris, " + _loc3_ + "!\n" + "Defeat Moon Snail, and restore\n" + "him to his former light!\n";
                  }
                  else if(_loc7_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc9_ = "There are 30 fragments hidden\n" + "around " + _loc3_ + " World!  Good luck\n" + "finding them, " + _loc3_ + "!!\n";
                  }
                  else
                  {
                     _loc9_ = "Amazing work, " + _loc3_ + "!!  Hey,\n" + "how\'d we get into outer space,\n" + "anyway?\n";
                  }
                  _loc8_ = true;
                  break;
               case 33:
                  if(PlayState.isBossDead(4))
                  {
                     _loc9_ = "Congratulations, " + _loc3_ + "!!  You\n" + "defeated Moon Snail!!  You\'re\n" + "the best " + _loc5_ + " ever!!\n";
                  }
                  else if(PlayState.worldMap.spmap.getTile(34,7))
                  {
                     _loc9_ = "" + _loc3_ + ", take this heart!  You\'ll\n" + "need all the help you can get\n" + "to defeat Moon Snail!\n";
                  }
                  else
                  {
                     _loc9_ = "Good luck, " + _loc3_ + "!!\n";
                  }
                  _loc8_ = true;
                  break;
               case 34:
                  if(_loc7_ < 30 || !PlayState.player.hasSeenIsis)
                  {
                     _loc9_ = "" + _loc3_ + ", search for the Helix\n" + "Fragments!  Once you have them\n" + "all, find the Shrine of Iris!\n";
                  }
                  else
                  {
                     _loc9_ = "Amazing work, " + _loc3_ + "!!  You\'ve\n" + "saved Sun Snail using the power\n" + "of Iris!!\n";
                  }
                  _loc8_ = true;
                  break;
               case 35:
                  _loc9_ = "Wow! You found the secret room\n" + "full of Snelks!! _@_v!!\n";
                  _loc8_ = true;
                  break;
               case 36:
                  _loc9_ = "Heya, " + _loc3_ + "!  Gravity shock\n" + "upgrades your gravity jump!\n" + "Pretty neat, huh?\n";
                  _loc8_ = true;
                  break;
               case 37:
                  _loc9_ = "Where are we, " + _loc3_ + "?  Do you\n" + "think they put this room in\n" + "on purpose?\n";
                  _loc8_ = true;
                  break;
               case 38:
                  _loc9_ = "..." + _loc3_ + ", is that you? Where\n" + "am I?  My head hurts...  I need\n" + "to speak with Iris...\n";
                  break;
               case 39:
                  PlayState.player.hasSeenIsis = true;
                  if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "" + _loc4_ + "?!  You\'ve come!\n" + "But how did you get past Moon\n" + "Snail?  I still feel his presence...\n";
                  }
                  else if(_loc7_ == 30)
                  {
                     _loc9_ = "" + _loc3_ + ", you did it!  Sun Snail\n" + "has returned to us!  I must speak\n" + "with him at once...\n";
                  }
                  else
                  {
                     _loc9_ = "Moon Snail is weakened, yet\n" + "yet I still feel the binding\n" + "claws of corruption around him...\n";
                  }
                  break;
               case 40:
                  if(!PlayState.isBossDead(2))
                  {
                     _loc9_ = "Be careful, " + _loc3_ + "!!  I\'ve heard\n" + "some scary stuff happening in\n" + "the next room!!\n";
                  }
                  else
                  {
                     _loc9_ = "Wow!!  You defeated the evil\n" + "monster??  You\'re my hero,\n" + _loc4_ + "!!\n";
                  }
                  break;
               case 41:
                  if(!PlayState.isBossDead(1))
                  {
                     _loc9_ = "Watch out, " + _loc4_ + "!!\n" + "A fierce monster is hiding\n" + "in the next room!!\n";
                  }
                  else if(!PlayState.player.hasWeapon(1))
                  {
                     _loc9_ = "Oh hey, that grey door below\n" + "and to the left opened up!\n" + "I wonder what\'s inside?\n";
                  }
                  else if(param1._slugMode)
                  {
                     _loc9_ = "Good luck, " + _loc3_ + "!\n";
                  }
                  else if(!PlayState.isBossDead(4))
                  {
                     _loc9_ = "Good luck, " + _loc3_ + "!  I\'ll wait\n" + "here for you!!  Let\'s have lots\n" + "of baby snails later, okay?\n";
                  }
                  else
                  {
                     _loc9_ = _loc4_ + ", you came\n" + "back!!  Yay!!\n";
                  }
                  break;
               case 42:
                  if(!PlayState.player.hasTurbo())
                  {
                     _loc9_ = "Hey, " + _loc3_ + "!  I heard a rumor\n" + "that the next room is too hard\n" + "without \"Rapid Fire\"!!\n";
                  }
                  else if(!PlayState.isBossDead(3))
                  {
                     _loc9_ = "Moon Snail brought me here!\n" + "Isn\'t he nice?  All the pink\n" + "grass I could ever eat!!\n";
                  }
                  else
                  {
                     _loc9_ = "What?  There was a monster\n" + "in the next room??  Are you\n" + "trying to scare me, " + _loc3_ + "??\n";
                  }
                  break;
               case 43:
                  if(!PlayState.player.hasGravityJump())
                  {
                     _loc9_ = "I can\'t seem to crawl around\n" + "these corners!  I wonder if\n" + "I\'ll ever be able to do it...\n";
                  }
                  else
                  {
                     _loc9_ = "Ooh, " + _loc3_ + ", can you crawl\n" + "around ceiling corners now??\n" + "I wish I were a Gravity Snail!\n";
                  }
                  break;
               case 44:
                  if(param1._slugMode)
                  {
                     return;
                  }
                  break;
               case 45:
                  if(!PlayState.player.hasArmor())
                  {
                     _loc9_ = "Hey, " + _loc3_ + "!  If you grab the\n" + "powerup ahead, you\'ll only take\n" + "half damage from enemies!!\n";
                  }
                  else if(!PlayState.player._slugMode)
                  {
                     _loc9_ = "Ooh, a Full Metal Snail!  Now\n" + "you\'re as tough as iron, and as\n" + "quick as Mercury!\n";
                  }
                  else
                  {
                     _loc9_ = "Ooh, a Full Power Slug, the\n" + "fastest slug on earth!!\n";
                  }
                  _loc8_ = true;
                  break;
               case 46:
                  _loc9_ = "Walleyes can\'t hurt you, " + _loc3_ + "!\n" + "You can just crawl right past\n" + "them, right on the same wall!\n";
                  break;
               case 47:
                  _loc9_ = "So many secret snelks!  Have\n" + "you found the other secret\n" + "snelk room yet?  _@_v!!\n";
                  _loc8_ = true;
                  break;
               case 48:
                  if(this._nexted == 0)
                  {
                     _loc9_ = "Hey, " + _loc3_ + ", what\'s up?\n";
                  }
                  else if(this._nexted == 1)
                  {
                     _loc2_ = 3;
                     _loc9_ = "YEEEEEEEEEEEEEEEEEEEEEEEEEE\n" + "EEEEEEEEEEEEEEEEEEEEEEEEEEE\n" + "EEEEEEEEEEEEEEEEEEEEEEEEEEE\n";
                  }
                  else if(this._nexted == 2)
                  {
                     _loc9_ = "Whew!!  That was scary!!\n";
                  }
                  break;
               case 49:
                  _loc9_ = "...      n-no...   \n" + "   nngh...     \n" + "       ...g-get... back...\n";
                  break;
               case 50:
                  _loc9_ = "Have you tried hitting the\n" + Player.STRAFE_KEY + " key yet?  It lets you\n" + "shoot while holding still!\n";
            }
            PlayState.dialogue.start(_loc9_,_loc2_,_loc8_,this._speed,this._snailNum);
         }
         this._talkOpen = true;
      }
      
      public function stopTalking() : void
      {
         PlayState.dialogue.stop(this._snailNum);
         this._talkOpen = false;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(this._snailNum == 39 || this._snailNum == 38)
         {
            this._elapsed += FlxG.elapsed;
            offset.y = Number(Math.sin(this._elapsed * 0.5) * 5);
         }
         if(this._talkOpen)
         {
            switch(this._snailNum)
            {
               case 48:
                  if(y > 171 * 16 && this._nexted == 0)
                  {
                     this._speed = Number(Number(Number(2)));
                     this._nexted = 1;
                     this.stopTalking();
                     break;
                  }
                  if(y > 199 * 16 && velocity.y < 150 && this._nexted == 1)
                  {
                     this._speed = Number(Number(Number(1)));
                     this._nexted = 2;
                     this.stopTalking();
                     break;
                  }
                  break;
            }
            _loc1_ = PlayState.player.x - x;
            _loc2_ = PlayState.player.y - y;
            if(_loc1_ * _loc1_ + _loc2_ * _loc2_ > 120 * 120)
            {
               this.stopTalking();
            }
         }
         super.update();
         if(this._snailNum == 44 || this._snailNum == 49)
         {
            facing = RIGHT;
         }
         else
         {
            facing = uint(uint(uint(PlayState.player.x < x ? uint(LEFT) : uint(RIGHT))));
         }
      }
      
      override public function kill() : void
      {
         super.kill();
         if(this._talkOpen)
         {
            PlayState.dialogue.stop();
         }
      }
   }
}
