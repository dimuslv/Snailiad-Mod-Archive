 
package
{
   import flash.utils.clearInterval;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxObject;
   import org.flixel.FlxState;
   import org.flixel.FlxU;
   
   public class PlayState extends FlxState
   {
      
      public static var STATE_MENU:int = 1;
      
      public static var STATE_GAME:int = 2;
      
      public static var STATE_ENDING:int = 3;
      
      public static var STATE_SUBSCREEN:int = 4;
      
      public static var STATE_INTRO:int = 5;
      
      public static var STATE_SPLASH:int = 6;
      
      public static var realState:int = STATE_SPLASH;
      
      public static var startedGame:Boolean = false;
      
      public static var endingFromMenu:Boolean = false;
      
      public static var endingNum:int = 0;
      
      public static var startFromTown:int = 0;
      
      public static var hasGoodEnding:Boolean = false;
      
      public static var introSlugMode:Boolean = false;
      
      public static var hideMiniMap:Boolean = false;
      
      public static var hideTab:Boolean = false;
      
      public static var hideableHidden:Boolean = false;
      
      public static var area:int = -1;
      
      public static var hasJumped:Boolean = false;
      
      public static var bossRush:Boolean = false;
      
      public static var isBossRushComplete:Boolean = false;
      
      public static var bossRushFade:Boolean = false;
      
      public static var bossRushCompleteTimeout:Number = 0;
      
      public static const BOSS_RUSH_COMPLETE_TIMEOUT:Number = 9;
      
      public static var isGameComplete:Boolean = false;
      
      public static var gameFade:Boolean = false;
      
      public static var gameCompleteTimeout:Number = 0;
      
      public static const GAME_COMPLETE_TIMEOUT:Number = 9;
      
      public static var aiTriggerPool:AiTriggerPool;
      
      public static var boss4BulletGroups:Boss4BulletGroups;
      
      public static var boss4SecondFormBulletGroups:Boss4SecondFormBulletGroups;
      
      public static var bossRushTimer:BossRushTimer;
      
      public static var bossesKilled:Array;
      
      public static var config:Configurable;
      
      public static var controlHelp:ControlHelp;
      
      public static var damageNumberPool:DamageNumberPool;
      
      public static var bossBgLayer:FlxGroup;
      
      public static var dialogue:Dialogue;
      
      public static var doors:Array;
      
      public static var emitters:FlxGroup;
      
      public static var ending:Ending;
      
      public static var intro:Intro;
      
      public static var enemies:FlxGroup;
      
      public static var enemiesNoCollide:FlxGroup;
      
      public static var bubbles:FlxGroup;
      
      public static var enemyBulletPool:EnemyBulletPool;
      
      public static var explosionPool:ExplosionPool;
      
      public static var fixBlocks:FixBlocks;
      
      public static var gameTimeDisplay:GameTimeDisplay;
      
      public static var hud:Hud;
      
      public static var itemRateHud:ItemRateHud;
      
      public static var items:FlxGroup;
      
      public static var mainMenu:MainMenu;
      
      public static var splashLayer:SplashLayer;
      
      public static var miniMap:MiniMap;
      
      public static var npcs:FlxGroup;
      
      public static var player:Player;
      
      public static var playerBulletGroups:PlayerBulletGroups;
      
      public static var saveData:SaveData;
      
      public static var savingText:SavingText;
      
      public static var solidItems:FlxGroup;
      
      public static var sprites:FlxGroup;
      
      public static var snowLayer:SnowLayer;
      
      public static var starLayer:StarLayer;
      
      public static var uniqueBlocks:UniqueBlocks;
      
      public static var worldMap:WorldMap;
      
      public static var zzz:Zzz;
      
      public static var menuHideable:FlxGroup;
      
      public static var boss2:Boss;
      
      public static var boss2rush:Boss;
      
      public static var This:PlayState;
      
      public static var fxStompActive:Boolean = false;
      
      public static var fxStompTimeout:Number = 1.5;
       
      
      public function PlayState()
      {
         super();
      }
      
      public static function loadGame(param1:int = 0) : void
      {
         if(player)
         {
            clearInterval(player.deathFadeInterval);
            clearInterval(player.reviveInterval);
            clearInterval(player.teleportInterval);
            player._invincible = true;
            player.dead = true;
         }
         This.defaultGroup.kill();
         This.defaultGroup.members = new Array();
         area = -1;
         hasJumped = false;
         bossRush = false;
         startedGame = true;
         isBossRushComplete = false;
         startFromTown = param1;
         realState = STATE_GAME;
         setup();
         FlxG.fade.stop();
      }
      
      public static function loadGameFromTown() : void
      {
         loadGame(1);
      }
      
      public static function startBossRush() : void
      {
         if(player)
         {
            player.dead = true;
         }
         This.defaultGroup.kill();
         This.defaultGroup.members = new Array();
         bossRush = true;
         startedGame = true;
         isBossRushComplete = false;
         bossRushCompleteTimeout = BOSS_RUSH_COMPLETE_TIMEOUT;
         realState = STATE_GAME;
         setup();
      }
      
      public static function startHardNewGame() : void
      {
         saveData = new SaveData();
         saveData.eraseMostHard();
         startIntro(true);
      }
      
      public static function startInsaneNewGame() : void
      {
         saveData = new SaveData();
         saveData.eraseMostInsane();
         startIntro(false);
      }
      
      public static function startEasyNewGame() : void
      {
         saveData = new SaveData();
         saveData.eraseMostEasy();
         startIntro(false);
      }
      
      public static function startNewGame() : void
      {
         saveData = new SaveData();
         saveData.eraseMost();
         startIntro(false);
      }
      
      public static function startIntro(param1:Boolean = false) : void
      {
         introSlugMode = param1;
         realState = STATE_INTRO;
      }
      
      public static function startEnding(param1:int) : void
      {
         endingFromMenu = realState == STATE_MENU;
         endingNum = param1;
         isGameComplete = true;
         gameCompleteTimeout = GAME_COMPLETE_TIMEOUT;
      }
      
      public static function endEnding() : void
      {
         if(endingFromMenu)
         {
            realState = STATE_MENU;
         }
         else
         {
            realState = STATE_GAME;
         }
         FlxG.flash.start(-16777216,0.34);
      }
      
      public static function goToMainMenu() : void
      {
         realState = STATE_SPLASH;
         startedGame = false;
      }
      
      public static function returnToGame() : void
      {
         FlxG.flash.start(2130706432,0.34);
         realState = STATE_GAME;
      }
      
      public static function addTitleScreen() : void
      {
      }
      
      public static function setup() : void
      {
         config = new Configurable();
         if(!saveData)
         {
            saveData = new SaveData();
         }
         bossesKilled = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            bossesKilled[_loc1_] = false;
            _loc1_++;
         }
         This.defaultGroup = new FlxGroup();
         PlayState.saveData.loadAll();
         worldMap = new WorldMap();
         dialogue = new Dialogue();
         hud = new Hud();
         items = new FlxGroup();
         solidItems = new FlxGroup();
         enemies = new FlxGroup();
         bubbles = new FlxGroup();
         enemiesNoCollide = new FlxGroup();
         npcs = new FlxGroup();
         sprites = new FlxGroup();
         starLayer = new StarLayer();
         snowLayer = new SnowLayer();
         emitters = new FlxGroup();
         damageNumberPool = new DamageNumberPool();
         playerBulletGroups = new PlayerBulletGroups();
         boss4BulletGroups = new Boss4BulletGroups();
         boss4SecondFormBulletGroups = new Boss4SecondFormBulletGroups();
         enemyBulletPool = new EnemyBulletPool();
         player = new Player(playerBulletGroups);
         itemRateHud = new ItemRateHud();
         controlHelp = new ControlHelp();
         explosionPool = new ExplosionPool();
         miniMap = new MiniMap();
         fixBlocks = new FixBlocks();
         uniqueBlocks = new UniqueBlocks();
         aiTriggerPool = new AiTriggerPool();
         bossRushTimer = new BossRushTimer();
         savingText = new SavingText();
         gameTimeDisplay = new GameTimeDisplay();
         zzz = new Zzz();
         bossBgLayer = new FlxGroup();
         doors = new Array();
         menuHideable = new FlxGroup();
         uniqueBlocks.loadAll();
         miniMap.loadAll();
         This.add(worldMap.skymap);
         This.add(starLayer);
         This.add(worldMap.bgmap);
         This.add(bossBgLayer);
         This.add(player);
         This.add(sprites);
         This.add(npcs);
         This.add(worldMap.fgmap);
         This.add(zzz);
         This.add(items);
         This.add(solidItems);
         This.add(enemies);
         This.add(enemiesNoCollide);
         This.add(playerBulletGroups);
         This.add(boss4BulletGroups);
         This.add(boss4SecondFormBulletGroups);
         This.add(enemyBulletPool);
         This.add(explosionPool);
         This.add(emitters);
         This.add(aiTriggerPool);
         This.add(bubbles);
         This.add(snowLayer);
         This.add(menuHideable);
         if(!bossRush)
         {
            menuHideable.add(miniMap);
         }
         else
         {
            menuHideable.add(bossRushTimer);
         }
         menuHideable.add(damageNumberPool);
         menuHideable.add(hud);
         menuHideable.add(gameTimeDisplay);
         menuHideable.add(itemRateHud);
         menuHideable.add(controlHelp);
         menuHideable.add(dialogue);
         menuHideable.add(savingText);
         if(!bossRush)
         {
            if(!player.hasSeenHelp && !player._hardMode)
            {
               controlHelp.show();
               player.hasSeenHelp = true;
            }
         }
         if(bossRush)
         {
            setArea(7);
         }
         FlxG.follow(player,5);
         FlxG.followAdjust(0.25,0.05);
         worldMap.checkRoomBounds(player);
         miniMap.updateMiniMap(true);
         FlxG.mouse.hide();
         hasJumped = false;
      }
      
      public static function isBossDead(param1:int) : Boolean
      {
         return bossesKilled[param1];
      }
      
      public static function setBossDead(param1:int) : void
      {
         bossesKilled[param1] = true;
      }
      
      public static function triggerEnding() : void
      {
         PlayState.player.clearTime.value = PlayState.player.gameTime.value;
         var _loc1_:int = 1;
         if(PlayState.bossRush)
         {
            _loc1_ = 2;
         }
         if(PlayState.player.getPercentComplete() == 100)
         {
            _loc1_ = 3;
         }
         if(PlayState.player.gameTime.value < 30 * 60)
         {
            NgMedal.unlockSpeedrunner();
            _loc1_ = 4;
         }
         if(PlayState.player._hardMode)
         {
            _loc1_ = 5;
         }
         if(PlayState.player._easyMode)
         {
            _loc1_ = 1;
         }
         PlayState.startEnding(_loc1_);
      }
      
      public static function totalItemsInArea() : int
      {
         var _loc1_:* = area;
         if(_loc1_ >= 6)
         {
            _loc1_ = 5;
         }
         var _loc2_:Array = [16,13,11,8,2,0];
         var _loc3_:int = _loc2_[_loc1_];
         if(_loc1_ == 1 && player._slugMode)
         {
            _loc3_--;
         }
         return _loc3_;
      }
      
      public static function numOfItemsAt(param1:int, param2:int) : int
      {
         if(param1 == 220 && param2 == 72 && player._slugMode)
         {
            return 0;
         }
         return !!PlayState.worldMap.spmap.getTile(param1,param2) ? 1 : 0;
      }
      
      public static function gottenItemsInArea() : int
      {
         return totalItemsInArea() - remainingItemsInArea();
      }
      
      public static function remainingItemsInArea() : int
      {
         var _loc1_:* = area;
         if(_loc1_ >= 6)
         {
            _loc1_ = 5;
         }
         var _loc2_:int = 0;
         switch(_loc1_)
         {
            case 0:
               _loc2_ += numOfItemsAt(11,167);
               _loc2_ += numOfItemsAt(40,169);
               _loc2_ += numOfItemsAt(143,151);
               _loc2_ += numOfItemsAt(220,72);
               _loc2_ += numOfItemsAt(273,153);
               _loc2_ += numOfItemsAt(376,24);
               _loc2_ += numOfItemsAt(412,68);
               _loc2_ += numOfItemsAt(425,119);
               _loc2_ += numOfItemsAt(434,105);
               _loc2_ += numOfItemsAt(452,56);
               _loc2_ += numOfItemsAt(454,104);
               _loc2_ += numOfItemsAt(506,184);
               _loc2_ += numOfItemsAt(537,54);
               _loc2_ += numOfItemsAt(565,57);
               _loc2_ += numOfItemsAt(566,107);
               _loc2_ += numOfItemsAt(584,56);
               _loc2_ += numOfItemsAt(670,39);
               break;
            case 1:
               _loc2_ += numOfItemsAt(350,200);
               _loc2_ += numOfItemsAt(408,184);
               _loc2_ += numOfItemsAt(426,226);
               _loc2_ += numOfItemsAt(428,168);
               _loc2_ += numOfItemsAt(462,265);
               _loc2_ += numOfItemsAt(474,265);
               _loc2_ += numOfItemsAt(506,184);
               _loc2_ += numOfItemsAt(584,136);
               _loc2_ += numOfItemsAt(615,125);
               _loc2_ += numOfItemsAt(615,234);
               _loc2_ += numOfItemsAt(617,140);
               _loc2_ += numOfItemsAt(636,248);
               _loc2_ += numOfItemsAt(642,202);
               break;
            case 2:
               _loc2_ += numOfItemsAt(39,328);
               _loc2_ += numOfItemsAt(58,296);
               _loc2_ += numOfItemsAt(75,346);
               _loc2_ += numOfItemsAt(90,344);
               _loc2_ += numOfItemsAt(96,235);
               _loc2_ += numOfItemsAt(101,317);
               _loc2_ += numOfItemsAt(114,278);
               _loc2_ += numOfItemsAt(163,180);
               _loc2_ += numOfItemsAt(193,284);
               _loc2_ += numOfItemsAt(195,236);
               _loc2_ += numOfItemsAt(221,248);
               break;
            case 3:
               _loc2_ += numOfItemsAt(408,343);
               _loc2_ += numOfItemsAt(436,346);
               _loc2_ += numOfItemsAt(450,296);
               _loc2_ += numOfItemsAt(454,344);
               _loc2_ += numOfItemsAt(455,281);
               _loc2_ += numOfItemsAt(474,281);
               _loc2_ += numOfItemsAt(556,310);
               _loc2_ += numOfItemsAt(655,342);
               break;
            case 4:
               _loc2_ += numOfItemsAt(143,103);
               _loc2_ += numOfItemsAt(264,57);
               break;
            case 5:
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public static function setArea(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               Music.playTown();
               break;
            case 1:
               Music.playArea1();
               break;
            case 2:
               Music.playArea2();
               break;
            case 3:
               Music.playArea3();
               break;
            case 4:
               Music.playArea4();
               break;
            case 5:
               Music.playIsis();
               break;
            case 6:
               Music.playIsis();
               break;
            case 7:
               Music.playBoss1();
         }
         if(param1 == 6)
         {
            player.hasSeenIsis = true;
            NgMedal.unlockPilgrim();
            if(isBossDead(4) && !hasGoodEnding && player.getHelixFragments() == 30)
            {
               player.bestInsaneTime.value = player.gameTime.value;
               triggerEnding();
            }
         }
         if(area == param1)
         {
            return;
         }
         if(player.hasSeenIsis && param1 == 5)
         {
            return;
         }
         area = param1;
         var _loc2_:Array = ["SNAIL COUNTRY","MACULATA OCEAN","BEDLAM RIFT","MT. CONCHIOLIN","EPITONIUM FORTRESS","CROSSROAD CAVERN","SHRINE OF IRIS","BOSS RUSH"];
         hud.areaName.setArea(_loc2_[area]);
         hud.radar.setNumber();
      }
      
      public static function showBossName(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Array = ["there is no boss #0","SHELLBREAKER","STOMPY","SPACE BOX","MOON SNAIL"];
         var _loc4_:* = _loc3_[param1] + (!!param2 ? " DEFEATED!" : "");
         if(param2 && param1 == 4)
         {
            if(player._insaneMode)
            {
               if(player.bestInsaneTime.value == 0 || player.bestInsaneTime.value > player.gameTime.value)
               {
                  player.bestInsaneTime.value = player.gameTime.value;
                  _loc4_ += "\nNEW BEST TIME - INSANE MODE " + GameTimeDisplay.formatExact(player.bestInsaneTime.value);
                  player.hasWonInsaneMode = true;
               }
            }
            else if(player._hardMode)
            {
               if(player.bestHardTime.value == 0 || player.bestHardTime.value > player.gameTime.value)
               {
                  player.bestHardTime.value = player.gameTime.value;
                  _loc4_ += "\nNEW BEST TIME - SLUG MODE " + GameTimeDisplay.formatExact(player.bestHardTime.value);
               }
               if((player.bestInsaneTime.value == 0 || player.bestInsaneTime.value > player.gameTime.value) && player.getPercentComplete() == 100)
               {
                  player.bestInsaneTime.value = player.gameTime.value;
                  _loc4_ += "\nNEW BEST 100% TIME - " + GameTimeDisplay.formatExact(player.bestInsaneTime.value);
               }
            }
            else if(player._easyMode)
            {
               hud.areaName.setArea(_loc3_[param1] + (!!param2 ? " DEFEATED!" : ""));
            }
            else
            {
               if(player.bestMainTime.value == 0 || player.bestMainTime.value > player.gameTime.value)
               {
                  player.bestMainTime.value = player.gameTime.value;
                  _loc4_ += "\nNEW BEST TIME - NORMAL MODE " + GameTimeDisplay.formatExact(player.bestMainTime.value);
               }
               if((player.bestInsaneTime.value == 0 || player.bestInsaneTime.value > player.gameTime.value) && player.getPercentComplete() == 100)
               {
                  player.bestInsaneTime.value = player.gameTime.value;
                  _loc4_ += "\nNEW BEST TIME - 100% " + GameTimeDisplay.formatExact(player.bestInsaneTime.value);
               }
               if(!player.hasWonGame)
               {
                  _loc4_ += "\nBOSS RUSH UNLOCKED!";
                  player.hasWonGame = true;
               }
            }
         }
         hud.areaName.setArea(_loc4_);
      }
      
      public static function showBossRushName(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Array = ["there is no boss #0","SUPER SHELLBREAKER","VIS VIRES","TIME CUBE","SUN SNAIL"];
         hud.areaName.setArea(_loc3_[param1] + (!!param2 ? " DEFEATED!" : ""));
      }
      
      public static function bossRushComplete() : void
      {
         player.x -= 60;
         var _loc1_:SaveData = PlayState.saveData;
         _loc1_.loadAll();
         if(!_loc1_.isVarTrue("hasWonBossRush"))
         {
            delete _loc1_.xml.vars.hasWonBossRush;
            _loc1_.xml.vars.appendChild(<hasWonBossRush>true</hasWonBossRush>);
            hud.areaName.setArea("BOSS RUSH COMPLETE - " + bossRushTimer.getTimeExact() + "\nSLUG MODE UNLOCKED!");
            hud.areaName.increaseTimer(5);
         }
         else
         {
            hud.areaName.setArea("BOSS RUSH COMPLETE - " + bossRushTimer.getTimeExact());
         }
         if(_loc1_.xml.vars.bestBossRushTime == 0 || _loc1_.xml.vars.bestBossRushTime > PlayState.bossRushTimer.now.value)
         {
            _loc1_.xml.vars.bestBossRushTime = PlayState.bossRushTimer.now.value;
         }
         _loc1_.saveAll();
         PlayState.isBossRushComplete = true;
      }
      
      public static function loadGameFromTown2() : void
      {
         PlayState.loadGame(2);
      }
      
      override public function destroy() : void
      {
         aiTriggerPool = null;
         boss2 = null;
         boss2rush = null;
         boss4BulletGroups = null;
         boss4SecondFormBulletGroups = null;
         bossBgLayer = null;
         bossRushTimer = null;
         bossesKilled = null;
         controlHelp = null;
         dialogue = null;
         doors = null;
         emitters = null;
         enemies = null;
         enemiesNoCollide = null;
         bubbles = null;
         damageNumberPool = null;
         enemyBulletPool = null;
         explosionPool = null;
         itemRateHud = null;
         hud = null;
         items = null;
         mainMenu = null;
         miniMap = null;
         npcs = null;
         player = null;
         playerBulletGroups = null;
         saveData = null;
         savingText = null;
         solidItems = null;
         sprites = null;
         starLayer = null;
         snowLayer = null;
         menuHideable = null;
         gameTimeDisplay = null;
         zzz = null;
         bossRush = false;
         isBossRushComplete = false;
         if(config)
         {
            config.destroy();
         }
         if(uniqueBlocks)
         {
            uniqueBlocks.destroy();
         }
         if(worldMap)
         {
            worldMap.destroy();
         }
         if(fixBlocks)
         {
            fixBlocks.destroy();
         }
         config = null;
         uniqueBlocks = null;
         worldMap = null;
         fixBlocks = null;
         super.destroy();
      }
      
      override public function create() : void
      {
         This = this;
         goToMainMenu();
      }
      
      override public function update() : void
      {
         super.update();
         if(realState == STATE_SPLASH)
         {
            if(!splashLayer)
            {
               splashLayer = new SplashLayer();
               add(splashLayer);
            }
            else if(splashLayer.dead)
            {
               realState = STATE_MENU;
               splashLayer = null;
               Preloader.bg.visible = false;
            }
            return;
         }
         if(realState == STATE_MENU)
         {
            if(menuHideable)
            {
               menuHideable.visible = false;
            }
            if(mainMenu && mainMenu.endingShow)
            {
               FlxG.mouse.hide();
            }
            else
            {
               FlxG.mouse.show();
            }
            if(!startedGame)
            {
               addTitleScreen();
            }
            if(!mainMenu || !mainMenu.active)
            {
               mainMenu = new MainMenu();
               add(mainMenu);
            }
         }
         else if(realState == STATE_ENDING)
         {
            FlxG.mouse.hide();
            if(!ending || !ending.active)
            {
               ending = new Ending();
               add(ending);
            }
         }
         else if(realState == STATE_INTRO)
         {
            FlxG.mouse.hide();
            if(!intro || !intro.active)
            {
               intro = new Intro();
               add(intro);
            }
         }
         else if(realState == STATE_SUBSCREEN)
         {
            dialogue.visible = false;
            hud.areaName.visible = false;
            hud.radar.visible = false;
         }
         else if(realState == STATE_GAME)
         {
            menuHideable.visible = true;
            hud.areaName.visible = true;
            hud.radar.visible = true;
            dialogue.visible = true;
            FlxG.mouse.hide();
            if(mainMenu)
            {
               mainMenu.exists = false;
               mainMenu.active = false;
               mainMenu.kill();
               mainMenu = null;
            }
            if(ending)
            {
               FlxG.fade.stop();
               ending.exists = false;
               ending.active = false;
               ending.kill();
               ending = null;
            }
            if(intro)
            {
               intro.exists = false;
               intro.active = false;
               intro.kill();
               intro = null;
            }
            FlxU.collide(worldMap.bgmap,playerBulletGroups.groups[0]);
            FlxU.collide(worldMap.bgmap,enemyBulletPool.groups[1]);
            if(!player.noCollide)
            {
               FlxU.collide(worldMap.bgmap,player);
            }
            FlxU.collide(worldMap.bgmap,npcs);
            FlxU.collide(worldMap.bgmap,solidItems);
            if(!player.noCollide)
            {
               FlxU.overlap(player,items,this.overlapPlayerItem);
               FlxU.overlap(player,npcs,this.overlapPlayerNpc);
               FlxU.overlap(player,enemies,this.overlapPlayerEnemies);
               FlxU.overlap(player,enemiesNoCollide,this.overlapPlayerEnemies);
               FlxU.collide(player,solidItems);
            }
            FlxU.collide(enemies,solidItems);
            FlxU.overlap(enemyBulletPool,player,this.overlapEnemyBulletPlayer);
            FlxU.overlap(playerBulletGroups,enemiesNoCollide,this.overlapBulletEnemies);
            FlxU.overlap(playerBulletGroups,enemies,this.overlapBulletEnemies);
            FlxU.overlap(playerBulletGroups,solidItems,this.overlapBulletItems);
            FlxU.overlap(aiTriggerPool,enemies,this.overlapAiTriggersEnemies);
            FlxU.overlap(aiTriggerPool,enemiesNoCollide,this.overlapAiTriggersEnemies);
            FlxU.overlap(aiTriggerPool,bubbles,this.overlapAiTriggersEnemies);
            FlxU.overlap(aiTriggerPool,solidItems,this.overlapAiTriggersSolidItems);
            FlxU.collide(worldMap.bgmap,enemies);
            if(!player.dead)
            {
               worldMap.checkRoomBounds(player);
            }
            if(player.pressedJump())
            {
               hasJumped = true;
            }
            if(bossRush && isBossRushComplete)
            {
               bossRushCompleteTimeout -= FlxG.elapsed;
               if(bossRushCompleteTimeout <= 0.4 && !bossRushFade)
               {
                  FlxG.fade.start(-16777216,0.34);
                  bossRushFade = true;
                  NgMedal.unlockTheGauntlet();
               }
               if(bossRushCompleteTimeout <= 0)
               {
                  startedGame = false;
                  realState = STATE_MENU;
                  bossRushFade = false;
                  isBossRushComplete = false;
                  FlxG.fade.stop();
                  FlxG.flash.start(-16777216,0.34);
                  bossRush = false;
               }
            }
            if(!bossRush && isGameComplete)
            {
               gameCompleteTimeout -= FlxG.elapsed;
               if(gameCompleteTimeout <= 2.8 && !gameFade)
               {
                  NgMedal.unlockVictory();
                  FlxG.music.fadeOut(gameCompleteTimeout);
                  FlxG.fade.start(-16777216,gameCompleteTimeout);
                  gameFade = true;
               }
               if(gameCompleteTimeout <= 0)
               {
                  realState = STATE_ENDING;
                  gameFade = false;
                  isGameComplete = false;
               }
            }
            if(fxStompActive)
            {
               fxStompTimeout -= FlxG.elapsed;
               if(fxStompTimeout <= 0)
               {
                  fxStompTimeout += FlxU.random() * 6;
                  FlxG.quake.start(0.005);
                  Sfx.playStomp();
               }
            }
         }
      }
      
      public function overlapPlayerNpc(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:Player = null;
         var _loc4_:Npc = null;
         if(param1 is Player && param2 is Npc)
         {
            _loc3_ = param1 as Player;
            (_loc4_ = param2 as Npc).touch(_loc3_);
         }
      }
      
      public function overlapPlayerItem(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:Player = null;
         var _loc4_:Item = null;
         if(param1 is Player && param2 is Item)
         {
            _loc3_ = param1 as Player;
            (_loc4_ = param2 as Item).touch(_loc3_);
         }
      }
      
      public function overlapBulletEnemies(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:PlayerBullet = null;
         var _loc4_:Enemy = null;
         if(param1 is PlayerBullet && param2 is Enemy)
         {
            _loc3_ = param1 as PlayerBullet;
            _loc4_ = param2 as Enemy;
            _loc3_.hitEnemy(_loc4_);
         }
      }
      
      public function overlapEnemyBulletPlayer(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:EnemyBullet = null;
         var _loc4_:Player = null;
         if(param1 is EnemyBullet && param2 is Player)
         {
            _loc3_ = param1 as EnemyBullet;
            _loc4_ = param2 as Player;
            _loc3_.hitPlayer(_loc4_);
         }
      }
      
      public function overlapPlayerEnemies(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:Player = null;
         var _loc4_:Enemy = null;
         if(param1 is Player && param2 is Enemy)
         {
            _loc3_ = param1 as Player;
            (_loc4_ = param2 as Enemy).touch(_loc3_);
         }
      }
      
      public function overlapBulletItems(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:PlayerBullet = null;
         var _loc4_:Item = null;
         if(param1 is PlayerBullet && param2 is Item)
         {
            _loc3_ = param1 as PlayerBullet;
            _loc4_ = param2 as Item;
            _loc3_.hitItem(_loc4_);
         }
      }
      
      public function overlapAiTriggersEnemies(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:AiTrigger = null;
         var _loc4_:Enemy = null;
         if(param1 is AiTrigger && param2 is Enemy)
         {
            _loc3_ = param1 as AiTrigger;
            (_loc4_ = param2 as Enemy).triggerAi(_loc3_.getNumber());
         }
      }
      
      public function overlapAiTriggersSolidItems(param1:FlxObject, param2:FlxObject) : void
      {
         var _loc3_:AiTrigger = null;
         var _loc4_:Item = null;
         if(param1 is AiTrigger && param2 is Item)
         {
            _loc3_ = param1 as AiTrigger;
            (_loc4_ = param2 as Item).triggerAi(_loc3_.getNumber());
         }
      }
   }
}
