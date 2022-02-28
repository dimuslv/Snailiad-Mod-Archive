 
package
{
   import org.flixel.FlxG;
   import org.flixel.FlxTilemap;
   
   public class WorldMap
   {
      
      private static const FG_OFFSET:int = 1000;
      
      private static const TILE_SIZE:int = 16;
      
      private static const MAP_WIDTH:int = 676;
      
      private static const MAP_HEIGHT:int = 353;
       
      
      private const WorldMapSkyTxt:Class = WorldMap_WorldMapSkyTxt;
      
      private const WorldMapBgTxt:Class = WorldMap_WorldMapBgTxt;
      
      private const WorldMapFgTxt:Class = WorldMap_WorldMapFgTxt;
      
      private const WorldMapSpTxt:Class = WorldMap_WorldMapSpTxt;
      
      public var skymap:FlxTilemap;
      
      public var bgmap:FlxTilemap;
      
      public var fgmap:FlxTilemap;
      
      public var spmap:FlxTilemap;
      
      public var minX:int;
      
      public var minY:int;
      
      public var maxX:int;
      
      public var maxY:int;
      
      public var waterLevelY:Array;
      
      public var tileMinX:int;
      
      public var tileMinY:int;
      
      public var tileMaxX:int;
      
      public var tileMaxY:int;
      
      public var fakeMinX:Number;
      
      public var fakeMinY:Number;
      
      public var fakeMaxX:Number;
      
      public var fakeMaxY:Number;
      
      public var dFakeMinX:Number;
      
      public var dFakeMinY:Number;
      
      public var dFakeMaxX:Number;
      
      public var dFakeMaxY:Number;
      
      public function WorldMap()
      {
         super();
         this.skymap = new FlxTilemap();
         this.skymap.collideIndex = FG_OFFSET + 1;
         this.skymap.startingIndex = 1;
         this.skymap.loadMap(new this.WorldMapSkyTxt(),Art.TileSheet,TILE_SIZE,TILE_SIZE,"sky");
         this.bgmap = new FlxTilemap();
         this.bgmap.collideIndex = FG_OFFSET + 1;
         this.bgmap.startingIndex = 1;
         this.bgmap.loadMap(new this.WorldMapBgTxt(),Art.TileSheet,TILE_SIZE,TILE_SIZE,"bg");
         this.fgmap = new FlxTilemap();
         this.fgmap.collideIndex = FG_OFFSET + 1;
         this.fgmap.startingIndex = 1;
         this.fgmap.loadMap(new this.WorldMapFgTxt(),Art.TileSheet,TILE_SIZE,TILE_SIZE,"fg");
         this.spmap = new FlxTilemap();
         this.spmap.collideIndex = FG_OFFSET + 1;
         this.spmap.startingIndex = 1;
         this.spmap.loadMap(new this.WorldMapSpTxt(),Art.TileSheet,TILE_SIZE,TILE_SIZE,"sp");
      }
      
      public function destroy() : void
      {
         this.skymap = null;
         this.bgmap = null;
         this.fgmap = null;
         this.spmap = null;
      }
      
      public function checkRoomBounds(param1:Player) : void
      {
         var _loc2_:int = param1.x + param1.width / 2;
         var _loc3_:int = param1.y + param1.height / 2;
         if(this.isLethalEdge(_loc2_ / 16,_loc3_ / 16) && !param1.noCollide)
         {
            PlayState.player.hurt(9999);
            return;
         }
         if(_loc2_ > this.maxX)
         {
            param1.x += 16;
            this.findRoomBounds(param1.x + 16,param1.y);
         }
         else if(_loc2_ < this.minX)
         {
            param1.x -= 16;
            this.findRoomBounds(param1.x - 16,param1.y);
         }
         else if(_loc3_ > this.maxY)
         {
            param1.y += 16;
            this.findRoomBounds(param1.x,param1.y + 16);
         }
         else
         {
            if(_loc3_ >= this.minY)
            {
               return;
            }
            param1.y -= 16;
            this.findRoomBounds(param1.x,param1.y - 16);
         }
         PlayState.playerBulletGroups.destroyAll();
         FlxG.flash.start(2130706432,0.34);
      }
      
      public function enemySolidAt(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         if(PlayState.doors)
         {
            _loc3_ = 0;
            while(_loc3_ < PlayState.doors.length)
            {
               if(PlayState.doors[_loc3_].solid && param1 > PlayState.doors[_loc3_].x && param1 < PlayState.doors[_loc3_].x + PlayState.doors[_loc3_].width && param2 > PlayState.doors[_loc3_].y && param2 < PlayState.doors[_loc3_].y + PlayState.doors[_loc3_].height)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return this.bgmap.getTile(int(param1 / 16),int(param2 / 16)) >= FG_OFFSET || this.spmap.getTile(int(param1 / 16),int(param2 / 16)) == 387 || this.spmap.getTile(int(param1 / 16),int(param2 / 16)) == 1 || this.spmap.getTile(int(param1 / 16),int(param2 / 16)) == 396 || this.spmap.getTile(int(param1 / 16),int(param2 / 16)) == 459;
      }
      
      public function solidAt(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         if(PlayState.doors)
         {
            _loc3_ = 0;
            while(_loc3_ < PlayState.doors.length)
            {
               if(PlayState.doors[_loc3_].solid && param1 > PlayState.doors[_loc3_].x && param1 < PlayState.doors[_loc3_].x + PlayState.doors[_loc3_].width && param2 > PlayState.doors[_loc3_].y && param2 < PlayState.doors[_loc3_].y + PlayState.doors[_loc3_].height)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return this.bgmap.getTile(int(param1 / 16),int(param2 / 16)) >= FG_OFFSET;
      }
      
      public function findFirstFullNotSolidTop(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 < 0)
         {
            if(!this.solidAt(param1,param2 + param5) && !this.solidAt(param1 + param3 / 2,param2 + param5) && !this.solidAt(param1 + param3 - 1,param2 + param5))
            {
               break;
            }
            param5++;
         }
         return param5;
      }
      
      public function findFirstFullNotSolidBottom(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 > 0)
         {
            if(!this.solidAt(param1,param2 + param4 - 1 + param5) && !this.solidAt(param1 + param3 / 2,param2 + param4 - 1 + param5) && !this.solidAt(param1 + param3 - 1,param2 + param4 - 1 + param5))
            {
               break;
            }
            param5--;
         }
         return param5;
      }
      
      public function findFirstFullNotSolidLeft(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 < 0)
         {
            if(!this.solidAt(param1 + param5,param2) && !this.solidAt(param1 + param5,param2 + param4 / 2) && !this.solidAt(param1 + param5,param2 + param4 - 1))
            {
               break;
            }
            param5++;
         }
         return param5;
      }
      
      public function findFirstFullNotSolidRight(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 > 0)
         {
            if(!this.solidAt(param1 + param3 - 1 + param5,param2) && !this.solidAt(param1 + param3 - 1 + param5,param2 + param4 / 2) && !this.solidAt(param1 + param3 - 1 + param5,param2 + param4 - 1))
            {
               break;
            }
            param5--;
         }
         return param5;
      }
      
      public function findFirstNotSolidTop(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 < 0)
         {
            if(!this.solidAt(param1,param2 + param5) && !this.solidAt(param1 + param3 / 2,param2 + param5) && !this.solidAt(param1 + param3 - 1,param2 + param5))
            {
               break;
            }
            param5++;
         }
         return param5;
      }
      
      public function findFirstNotSolidBottom(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 > 0)
         {
            if(!this.solidAt(param1 + param3 / 2,param2 + param4 - 1 + param5))
            {
               break;
            }
            param5--;
         }
         return param5;
      }
      
      public function findFirstNotSolidLeft(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 < 0)
         {
            if(!this.solidAt(param1 + param5,param2 + param4 / 2))
            {
               break;
            }
            param5++;
         }
         return param5;
      }
      
      public function findFirstNotSolidRight(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         while(param5 > 0)
         {
            if(!this.solidAt(param1 + param3 - 1 + param5,param2) && !this.solidAt(param1 + param3 - 1 + param5,param2 + param4 / 2) && !this.solidAt(param1 + param3 - 1 + param5,param2 + param4 - 1))
            {
               break;
            }
            param5--;
         }
         return param5;
      }
      
      public function isLethalEdge(param1:int, param2:int) : Boolean
      {
         return this.spmap.getTile(param1,param2) == 396;
      }
      
      public function isEdge(param1:int, param2:int) : Boolean
      {
         return this.spmap.getTile(param1,param2) == 1 || this.spmap.getTile(param1,param2) == 396 || this.spmap.getTile(param1,param2) == 459;
      }
      
      public function findRoomBounds(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         param1 += 8;
         param2 += 8;
         param1 /= 16;
         param2 /= 16;
         this.tileMinX = param1;
         while(this.tileMinX > 0)
         {
            if(this.isEdge(this.tileMinX,param2))
            {
               break;
            }
            --this.tileMinX;
         }
         this.tileMaxX = param1;
         while(this.tileMaxX < this.bgmap.widthInTiles)
         {
            if(this.isEdge(this.tileMaxX,param2))
            {
               break;
            }
            ++this.tileMaxX;
         }
         this.tileMinY = param2;
         while(this.tileMinY > 0)
         {
            if(this.isEdge(param1,this.tileMinY))
            {
               break;
            }
            --this.tileMinY;
         }
         this.tileMaxY = param2;
         while(this.tileMaxY < this.bgmap.widthInTiles)
         {
            if(this.isEdge(param1,this.tileMaxY))
            {
               break;
            }
            ++this.tileMaxY;
         }
         this.minX = this.tileMinX * 16 + 16;
         this.minY = this.tileMinY * 16 + 16;
         this.maxX = this.tileMaxX * 16 + 0;
         this.maxY = this.tileMaxY * 16 + 0;
         FlxG.followBounds(this.minX,this.minY,this.maxX,this.maxY);
         if(PlayState.fixBlocks)
         {
            PlayState.fixBlocks.repairAll();
         }
         this.processSpecialTiles();
      }
      
      public function scanMiniMap() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < MiniMap.SIZE_X)
         {
            _loc2_ = 0;
            while(_loc2_ < MiniMap.SIZE_Y)
            {
               _loc3_ = 0;
               while(_loc3_ < MiniMap.ROOM_WIDTH)
               {
                  _loc4_ = 0;
                  while(_loc4_ < MiniMap.ROOM_HEIGHT)
                  {
                     _loc5_ = _loc1_ * MiniMap.ROOM_WIDTH + _loc3_;
                     _loc6_ = _loc2_ * MiniMap.ROOM_HEIGHT + _loc4_;
                     _loc7_ = this.spmap.getTile(_loc5_,_loc6_);
                     _loc8_ = _loc5_ * 16;
                     _loc9_ = _loc6_ * 16;
                     if(_loc7_ >= 93 && _loc7_ <= 332)
                     {
                        PlayState.miniMap.setTile(_loc8_,_loc9_,_loc7_ - 93);
                        PlayState.miniMap.setKnown(_loc8_,_loc9_);
                     }
                     if(_loc7_ == 30)
                     {
                        PlayState.miniMap.setSpecialSave(_loc8_,_loc9_);
                     }
                     if(_loc7_ >= 24 && _loc7_ <= 27)
                     {
                        PlayState.miniMap.setSpecialBoss(_loc8_,_loc9_);
                     }
                     _loc4_++;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function setTileBounds(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : void
      {
         FlxG.followBounds(param1 * 16 + 16,param2 * 16 + 16,param3 * 16 + 0,param4 * 16 + 0,param5);
      }
      
      public function processSpecialTiles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(PlayState.doors)
         {
            _loc3_ = 0;
            while(_loc3_ < PlayState.doors.length)
            {
               if(PlayState.doors[_loc3_] && PlayState.doors[_loc3_].fixBlocks)
               {
                  PlayState.doors[_loc3_].fixBlocks.repairAll();
               }
               _loc3_++;
            }
         }
         PlayState.enemyBulletPool.destroyAll();
         PlayState.boss4BulletGroups.destroyAll();
         PlayState.playerBulletGroups.destroyAll();
         PlayState.boss4SecondFormBulletGroups.destroyAll();
         PlayState.enemies.members = new Array();
         PlayState.enemies.members.length = 0;
         PlayState.enemiesNoCollide.members = new Array();
         PlayState.enemiesNoCollide.members.length = 0;
         PlayState.items.members = new Array();
         PlayState.items.members.length = 0;
         PlayState.solidItems.members = new Array();
         PlayState.solidItems.members.length = 0;
         PlayState.npcs.members = new Array();
         PlayState.npcs.members.length = 0;
         PlayState.emitters.members = new Array();
         PlayState.emitters.members.length = 0;
         PlayState.sprites.members = new Array();
         PlayState.sprites.members.length = 0;
         PlayState.bossBgLayer.members = new Array();
         PlayState.bossBgLayer.members.length = 0;
         PlayState.dialogue.stop();
         PlayState.hud.bossBarHud.removeBar();
         PlayState.bubbles.members = new Array();
         PlayState.bubbles.members.length = 0;
         PlayState.aiTriggerPool.destroyAll();
         PlayState.starLayer.destroyAll();
         PlayState.snowLayer.destroyAll();
         PlayState.doors = new Array();
         PlayState.fxStompActive = false;
         this.waterLevelY = new Array();
         this.fakeMinX = this.minX;
         this.fakeMaxX = this.maxX;
         this.fakeMinY = this.minY;
         this.fakeMaxY = this.maxY;
         _loc1_ = this.tileMinX + 1;
         while(_loc1_ <= this.tileMaxX - 1)
         {
            _loc2_ = this.tileMinY + 1;
            for(; _loc2_ <= this.tileMaxY - 1; _loc2_++)
            {
               _loc4_ = this.spmap.getTile(_loc1_,_loc2_);
               if(PlayState.player && PlayState.player._insaneMode)
               {
                  if(_loc4_ == 400)
                  {
                     _loc4_ = 429;
                  }
                  if(_loc4_ == 417)
                  {
                     _loc4_ = 418;
                  }
                  if(_loc4_ == 409)
                  {
                     _loc4_ = 421;
                  }
                  if(_loc4_ == 414)
                  {
                     _loc4_ = 427;
                  }
               }
               _loc5_ = _loc1_ * 16;
               _loc6_ = _loc2_ * 16;
               if(_loc4_ >= 3 && _loc4_ <= 23)
               {
                  this.makeEnemy(_loc5_,_loc6_,_loc4_ - 3);
                  continue;
               }
               if(_loc4_ >= 24 && _loc4_ <= 27)
               {
                  this.makeBoss(_loc5_,_loc6_,_loc4_ - 23);
                  continue;
               }
               if(_loc4_ >= 369 && _loc4_ <= 372)
               {
                  this.makeBossRush(_loc5_,_loc6_,_loc4_ - 368);
                  continue;
               }
               if(_loc4_ >= 33 && _loc4_ <= 72)
               {
                  PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,_loc4_ - 33));
                  continue;
               }
               if(_loc4_ >= 437 && _loc4_ <= 440)
               {
                  PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,_loc4_ - 437 + 40));
                  continue;
               }
               if(_loc4_ >= 93 && _loc4_ <= 332)
               {
                  PlayState.miniMap.setTile(_loc5_,_loc6_,_loc4_ - 93);
                  continue;
               }
               switch(_loc4_)
               {
                  case 28:
                     PlayState.items.add(new Grass(_loc5_,_loc6_));
                     break;
                  case 29:
                     break;
                  case 30:
                     PlayState.items.add(new SavePoint(_loc5_,_loc6_));
                     PlayState.miniMap.setSpecialSave(_loc5_,_loc6_);
                     break;
                  case 31:
                     PlayState.items.add(new PowerGrass(_loc5_,_loc6_));
                     break;
                  case 32:
                     PlayState.items.add(new Smoke(_loc5_,_loc6_));
                     break;
                  case 73:
                     PlayState.enemies.add(new Breakable(_loc5_,_loc6_,0));
                     break;
                  case 74:
                     PlayState.enemies.add(new Breakable(_loc5_,_loc6_,1));
                     break;
                  case 75:
                     PlayState.enemies.add(new Breakable(_loc5_,_loc6_,2));
                     break;
                  case 76:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,0));
                     break;
                  case 77:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,0));
                     break;
                  case 78:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,0));
                     break;
                  case 79:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,0));
                     break;
                  case 80:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,1));
                     break;
                  case 81:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,1));
                     break;
                  case 82:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,1));
                     break;
                  case 83:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,1));
                     break;
                  case 84:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,2));
                     break;
                  case 85:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,2));
                     break;
                  case 86:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,2));
                     break;
                  case 87:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,2));
                     break;
                  case 88:
                     PlayState.items.add(new HeartContainer(_loc5_,_loc6_));
                     break;
                  case 89:
                     PlayState.items.add(new Gun1(_loc5_,_loc6_));
                     break;
                  case 90:
                     PlayState.items.add(new Gun2(_loc5_,_loc6_));
                     break;
                  case 91:
                     PlayState.items.add(new Gun3(_loc5_,_loc6_));
                     break;
                  case 92:
                     PlayState.items.add(new HelixFragment(_loc5_,_loc6_));
                     break;
                  case 333:
                     PlayState.miniMap.setKnown(_loc5_,_loc6_);
                     break;
                  case 334:
                     PlayState.aiTriggerPool.addNew(_loc5_,_loc6_,1);
                     break;
                  case 335:
                     PlayState.aiTriggerPool.addNew(_loc5_,_loc6_,2);
                     break;
                  case 336:
                     PlayState.aiTriggerPool.addNew(_loc5_,_loc6_,3);
                     if(!this.waterLevelY[_loc5_ / 16] || this.waterLevelY[_loc5_ / 16] < _loc6_)
                     {
                        this.waterLevelY[_loc5_ / 16] = _loc6_;
                     }
                     break;
                  case 337:
                     PlayState.aiTriggerPool.addNew(_loc5_,_loc6_,4);
                     break;
                  case 338:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,3,1));
                     break;
                  case 339:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,3,1));
                     break;
                  case 340:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,3,1));
                     break;
                  case 341:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,3,1));
                     break;
                  case 342:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,3,2));
                     break;
                  case 343:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,3,2));
                     break;
                  case 344:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,3,2));
                     break;
                  case 345:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,3,2));
                     break;
                  case 346:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,3,3));
                     break;
                  case 347:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,3,3));
                     break;
                  case 348:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,3,3));
                     break;
                  case 349:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,3,3));
                     break;
                  case 350:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,3,4));
                     break;
                  case 351:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,3,4));
                     break;
                  case 352:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,3,4));
                     break;
                  case 353:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,3,4));
                     break;
                  case 354:
                     PlayState.setArea(0);
                     break;
                  case 355:
                     PlayState.setArea(1);
                     break;
                  case 356:
                     PlayState.setArea(2);
                     break;
                  case 357:
                     PlayState.setArea(3);
                     break;
                  case 358:
                     PlayState.setArea(4);
                     break;
                  case 359:
                     PlayState.setArea(5);
                     break;
                  case 360:
                     PlayState.setArea(6);
                     break;
                  case 361:
                     PlayState.starLayer.makeStars();
                     break;
                  case 362:
                     PlayState.items.add(new HiJump(_loc5_,_loc6_));
                     break;
                  case 363:
                     PlayState.items.add(new GravJump(_loc5_,_loc6_));
                     break;
                  case 364:
                     PlayState.items.add(new Devastator(_loc5_,_loc6_));
                     break;
                  case 365:
                     PlayState.items.add(new IceSnail(_loc5_,_loc6_));
                     break;
                  case 366:
                     PlayState.items.add(new TurboFire(_loc5_,_loc6_));
                     break;
                  case 367:
                     if(_loc5_ > PlayState.player.x)
                     {
                        this.fakeMaxX = _loc5_;
                        this.setTileBounds(this.tileMinX,this.tileMinY,_loc1_,this.tileMaxY,false);
                     }
                     else
                     {
                        this.fakeMinX = _loc5_;
                        this.setTileBounds(_loc1_,this.tileMinY,this.tileMaxX,this.tileMaxY,false);
                     }
                     break;
                  case 368:
                     if(_loc6_ > PlayState.player.y)
                     {
                        this.fakeMaxY = _loc6_;
                        this.setTileBounds(this.tileMinX,this.tileMinY,this.tileMaxX,_loc2_,false);
                     }
                     else
                     {
                        this.fakeMinY = _loc6_;
                        this.setTileBounds(this.tileMinX,_loc2_,this.tileMaxX,this.tileMaxY,false);
                     }
                     break;
                  case 373:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,3,5));
                     break;
                  case 374:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,3,5));
                     break;
                  case 375:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,3,5));
                     break;
                  case 376:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,3,5));
                     break;
                  case 377:
                     PlayState.bossRushComplete();
                     break;
                  case 378:
                     if(!PlayState.player._slugMode)
                     {
                        PlayState.items.add(new ShellShield(_loc5_,_loc6_));
                     }
                     break;
                  case 379:
                     PlayState.items.add(new GravityShock(_loc5_,_loc6_));
                     break;
                  case 380:
                     PlayState.items.add(new Armor(_loc5_,_loc6_));
                     break;
                  case 381:
                     PlayState.solidItems.add(new GiantBlock1(_loc5_,_loc6_));
                     break;
                  case 383:
                     PlayState.solidItems.add(new Platform4b(_loc5_,_loc6_));
                     break;
                  case 384:
                     PlayState.solidItems.add(new Platform5b(_loc5_,_loc6_));
                     break;
                  case 387:
                     break;
                  case 388:
                     PlayState.items.add(new IceSpike(_loc5_,_loc6_));
                     break;
                  case 389:
                     PlayState.items.add(new IceSpikeTop(_loc5_,_loc6_));
                     break;
                  case 390:
                     PlayState.items.add(new IceSpikeLeft(_loc5_,_loc6_,false));
                     break;
                  case 391:
                     PlayState.items.add(new IceSpikeLeft(_loc5_,_loc6_,true));
                     break;
                  case 392:
                     PlayState.enemiesNoCollide.add(new EnemyCannonBottom(_loc5_,_loc6_));
                     break;
                  case 393:
                     PlayState.enemiesNoCollide.add(new EnemyCannonLeft(_loc5_,_loc6_,false));
                     break;
                  case 394:
                     PlayState.enemiesNoCollide.add(new EnemyCannonLeft(_loc5_,_loc6_,true));
                     break;
                  case 395:
                     PlayState.enemiesNoCollide.add(new EnemyCannonTop(_loc5_,_loc6_));
                     break;
                  case 396:
                     break;
                  case 397:
                     PlayState.items.add(new Muck(_loc5_,_loc6_));
                     break;
                  case 398:
                     PlayState.enemiesNoCollide.add(new EnemyDandelion(_loc5_,_loc6_));
                     break;
                  case 399:
                     PlayState.npcs.add(new TurtleNpc(_loc5_,_loc6_));
                     break;
                  case 400:
                     PlayState.enemiesNoCollide.add(new EnemyFloatSpike(_loc5_,_loc6_));
                     break;
                  case 401:
                     if(_loc6_ > PlayState.player.y)
                     {
                        this.fakeMaxY = _loc6_;
                        this.setTileBounds(this.tileMinX,this.tileMinY,this.tileMaxX,_loc2_,false);
                     }
                     break;
                  case 402:
                     PlayState.solidItems.add(new Platform4(_loc5_,_loc6_));
                     break;
                  case 403:
                     PlayState.solidItems.add(new Platform5(_loc5_,_loc6_));
                     break;
                  case 404:
                     PlayState.enemiesNoCollide.add(new EnemyGear(_loc5_,_loc6_,EnemyGear.DIR_UP,true));
                     break;
                  case 405:
                     PlayState.enemiesNoCollide.add(new EnemyGear(_loc5_,_loc6_,EnemyGear.DIR_DOWN,true));
                     break;
                  case 406:
                     PlayState.enemiesNoCollide.add(new EnemyGear(_loc5_,_loc6_,EnemyGear.DIR_RIGHT,true));
                     break;
                  case 407:
                     PlayState.enemiesNoCollide.add(new EnemyGear(_loc5_,_loc6_,EnemyGear.DIR_LEFT,true));
                     break;
                  case 408:
                     PlayState.enemiesNoCollide.add(new EnemyBird2Generator(_loc5_,_loc6_));
                     break;
                  case 409:
                     PlayState.enemies.add(new EnemySnake(_loc5_,_loc6_));
                     break;
                  case 410:
                     PlayState.enemies.add(new EnemyPincer(_loc5_,_loc6_));
                     break;
                  case 411:
                     PlayState.enemies.add(new EnemyPincer2(_loc5_,_loc6_));
                     break;
                  case 412:
                     PlayState.enemiesNoCollide.add(new EnemyKurage(_loc5_,_loc6_));
                     break;
                  case 413:
                     PlayState.enemiesNoCollide.add(new EnemySeahorse(_loc5_,_loc6_));
                     break;
                  case 414:
                     PlayState.enemiesNoCollide.add(new EnemyTallfish(_loc5_,_loc6_));
                     break;
                  case 415:
                     PlayState.enemiesNoCollide.add(new EnemyDrone(_loc5_,_loc6_));
                     break;
                  case 416:
                     PlayState.enemiesNoCollide.add(new EnemyWalleye(_loc5_,_loc6_,false));
                     break;
                  case 417:
                     PlayState.enemiesNoCollide.add(new EnemySpider(_loc5_,_loc6_));
                     break;
                  case 418:
                     PlayState.enemiesNoCollide.add(new EnemySpider2(_loc5_,_loc6_));
                     break;
                  case 419:
                     PlayState.enemies.add(new EnemyGravTurtle(_loc5_,_loc6_,false));
                     break;
                  case 420:
                     PlayState.enemies.add(new EnemyGravTurtle(_loc5_,_loc6_,true));
                     break;
                  case 421:
                     PlayState.enemies.add(new EnemySnake2(_loc5_,_loc6_));
                     break;
                  case 422:
                     PlayState.enemies.add(new EnemyGravTurtle2(_loc5_,_loc6_,false));
                     break;
                  case 423:
                     PlayState.enemies.add(new EnemyGravTurtle2(_loc5_,_loc6_,true));
                     break;
                  case 424:
                     PlayState.enemiesNoCollide.add(new EnemyBalloonGenerator(_loc5_,_loc6_));
                     break;
                  case 425:
                     PlayState.enemiesNoCollide.add(new EnemyBat(_loc5_,_loc6_));
                     break;
                  case 426:
                     PlayState.enemies.add(new EnemyBlob4(_loc5_,_loc6_));
                     break;
                  case 427:
                     PlayState.enemiesNoCollide.add(new EnemyTallfish2(_loc5_,_loc6_));
                     break;
                  case 428:
                     PlayState.enemiesNoCollide.add(new EnemyWalleye(_loc5_,_loc6_,true));
                     break;
                  case 429:
                     PlayState.enemiesNoCollide.add(new EnemyFloatSpike2(_loc5_,_loc6_));
                     break;
                  case 430:
                     PlayState.enemies.add(new EnemySnake3(_loc5_,_loc6_));
                     break;
                  case 431:
                     PlayState.enemiesNoCollide.add(new EnemyCannonBottom2(_loc5_,_loc6_));
                     break;
                  case 432:
                     PlayState.enemiesNoCollide.add(new EnemyCannonLeft2(_loc5_,_loc6_,false));
                     break;
                  case 433:
                     PlayState.enemiesNoCollide.add(new EnemyCannonLeft2(_loc5_,_loc6_,true));
                     break;
                  case 434:
                     PlayState.enemiesNoCollide.add(new EnemyCannonTop2(_loc5_,_loc6_));
                     break;
                  case 435:
                     PlayState.enemies.add(new EnemySnelk(_loc5_,_loc6_));
                     break;
                  case 436:
                     PlayState.enemies.add(new EnemySnelk(_loc5_,_loc6_,true));
                     break;
                  case 441:
                     PlayState.enemiesNoCollide.add(new BubbleGenerator(_loc5_,_loc6_));
                     break;
                  case 442:
                     PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,45));
                     break;
                  case 443:
                     PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,46));
                     break;
                  case 444:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_RIGHT,4));
                     break;
                  case 445:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_LEFT,4));
                     break;
                  case 446:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_TOP,4));
                     break;
                  case 447:
                     PlayState.solidItems.add(new Door(_loc5_,_loc6_,Door.SIDE_BOTTOM,4));
                     break;
                  case 448:
                     PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,47));
                     break;
                  case 449:
                     PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,48));
                     break;
                  case 450:
                     PlayState.enemies.add(new Breakable(_loc5_,_loc6_,2,true));
                     break;
                  case 451:
                     PlayState.items.add(new Step(_loc5_,_loc6_,4));
                     break;
                  case 452:
                     PlayState.items.add(new Step(_loc5_,_loc6_,8));
                     break;
                  case 453:
                     PlayState.items.add(new Step(_loc5_,_loc6_,12));
                     break;
                  case 454:
                     PlayState.items.add(new Step(_loc5_,_loc6_,16));
                     break;
                  case 455:
                     PlayState.snowLayer.makeSnows();
                     break;
                  case 456:
                     PlayState.enemies.add(new EnemyBabyfish(_loc5_,_loc6_));
                     break;
                  case 457:
                     PlayState.enemies.add(new EnemyBabyfish2(_loc5_,_loc6_));
                     break;
                  case 458:
                     PlayState.npcs.add(new SnailNpc(_loc5_,_loc6_,50));
                     break;
                  case 460:
                     NgMedal.unlockSnelkHunterA();
                     break;
                  case 461:
                     NgMedal.unlockSnelkHunterB();
                     break;
                  case 462:
                     if(!PlayState.isBossDead(2))
                     {
                        PlayState.fxStompActive = true;
                     }
                     break;
                  case 463:
                     if(!PlayState.isBossDead(3))
                     {
                        PlayState.fxStompActive = true;
                     }
                     break;
                  case 1133:
                  case 1134:
                     PlayState.items.add(new Fire(_loc5_,_loc6_));
                     break;
               }
            }
            _loc1_++;
         }
         if(this.fakeMinX == this.minX)
         {
            this.fakeMinX = -10000000;
         }
         if(this.fakeMaxX == this.maxX)
         {
            this.fakeMaxX = 10000000;
         }
         if(this.fakeMinY == this.minY)
         {
            this.fakeMinY = -10000000;
         }
         if(this.fakeMaxY == this.maxY)
         {
            this.fakeMaxY = 10000000;
         }
         this.dFakeMinX = this.fakeMinX;
         this.dFakeMaxX = this.fakeMaxX;
         this.dFakeMinY = this.fakeMinY;
         this.dFakeMaxY = this.fakeMaxY;
         PlayState.miniMap.setMapLittle();
      }
      
      public function makeEnemy(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Enemy = null;
         if(PlayState.player && PlayState.player._insaneMode)
         {
            if(param3 == 2)
            {
               param3 = 3;
            }
            if(param3 == 6)
            {
               param3 = 7;
            }
            if(param3 == 9)
            {
               param3 = 11;
            }
            if(param3 == 10)
            {
               param3 = 12;
            }
         }
         switch(param3)
         {
            case 0:
               _loc4_ = new EnemyMoth(param1,param2);
               break;
            case 1:
               _loc4_ = new EnemySpike(param1,param2);
               break;
            case 2:
               _loc4_ = new EnemyBlob(param1,param2);
               break;
            case 3:
               _loc4_ = new EnemyBlob2(param1,param2);
               break;
            case 4:
               _loc4_ = new EnemyBlob3(param1,param2);
               break;
            case 5:
               _loc4_ = new EnemyBird(param1,param2);
               break;
            case 6:
               _loc4_ = new EnemyKitty(param1,param2);
               break;
            case 7:
               _loc4_ = new EnemyKitty2(param1,param2);
               break;
            case 8:
               _loc4_ = new EnemyBirdGenerator(param1,param2);
               break;
            case 9:
               _loc4_ = new EnemySpikey(param1,param2,true);
               break;
            case 10:
               _loc4_ = new EnemySpikey(param1,param2,false);
               break;
            case 11:
               _loc4_ = new EnemySpikey2(param1,param2,true);
               break;
            case 12:
               _loc4_ = new EnemySpikey2(param1,param2,false);
               break;
            case 13:
               _loc4_ = new EnemyFireball(param1,param2,true);
               break;
            case 14:
               _loc4_ = new EnemyFireball(param1,param2,false);
               break;
            case 15:
               _loc4_ = new EnemyFireball2(param1,param2,true);
               break;
            case 16:
               _loc4_ = new EnemyFireball2(param1,param2,false);
               break;
            case 17:
               _loc4_ = new EnemyDandelionGenerator(param1,param2);
         }
         if(_loc4_.collideTerrain())
         {
            PlayState.enemies.add(_loc4_);
         }
         else
         {
            PlayState.enemiesNoCollide.add(_loc4_);
         }
      }
      
      public function makeBoss(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Enemy = null;
         if(PlayState.isBossDead(param3))
         {
            return;
         }
         PlayState.miniMap.setSpecialBoss(param1,param2);
         switch(param3)
         {
            case 1:
               _loc4_ = new Boss1(param1,param2);
               break;
            case 2:
               _loc4_ = new Boss2(param1,param2);
               break;
            case 3:
               _loc4_ = new Boss3(param1,param2);
               break;
            case 4:
               _loc4_ = new Boss4(param1,param2);
         }
         PlayState.enemies.add(_loc4_);
         if(param3 != 2)
         {
            PlayState.showBossName(param3);
         }
      }
      
      public function makeBossRush(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Enemy = null;
         if(PlayState.isBossDead(param3))
         {
            return;
         }
         switch(param3)
         {
            case 1:
               _loc4_ = new Boss1Rush(param1,param2);
               break;
            case 2:
               _loc4_ = new Boss2Rush(param1,param2);
               break;
            case 3:
               _loc4_ = new Boss3Rush(param1,param2);
               break;
            case 4:
               _loc4_ = new Boss4Rush(param1,param2);
         }
         PlayState.enemies.add(_loc4_);
         if(param3 != 2)
         {
            PlayState.showBossRushName(param3);
         }
      }
      
      public function checkFakeBounds(param1:int, param2:int) : void
      {
         if(param1 >= this.fakeMaxX - 16)
         {
            this.dFakeMaxX = this.maxX;
         }
         if(param1 < this.fakeMinX + 16)
         {
            this.dFakeMinX = this.minX - 16;
         }
         if(param2 >= this.fakeMaxY - 16)
         {
            this.dFakeMaxY = this.maxY;
         }
         if(param2 < this.fakeMinY + 16)
         {
            this.dFakeMinY = this.minY - 16;
         }
         if(this.dFakeMaxX != this.fakeMaxX)
         {
            this.fakeMaxX = (this.fakeMaxX * 90 + this.dFakeMaxX * 10) / 100 + 0.4;
            if(this.fakeMaxX > this.maxX)
            {
               this.dFakeMaxX = this.fakeMaxX = this.maxX;
            }
            this.setTileBounds(this.tileMinX,this.tileMinY,this.fakeMaxX / 16,this.tileMaxY,false);
         }
         if(this.dFakeMaxY != this.fakeMaxY)
         {
            this.fakeMaxY = (this.fakeMaxY * 90 + this.dFakeMaxY * 10) / 100 + 0.4;
            if(this.fakeMaxY > this.maxY)
            {
               this.dFakeMaxY = this.fakeMaxY = this.maxY;
            }
            this.setTileBounds(this.tileMinX,this.tileMinY,this.tileMaxX,this.fakeMaxY / 16,false);
         }
         if(this.dFakeMinX != this.fakeMinX)
         {
            this.fakeMinX = (this.fakeMinX * 90 + this.dFakeMinX * 10) / 100 - 0.4;
            if(this.fakeMinX < this.minX - 16)
            {
               this.dFakeMinX = this.fakeMinX = this.minX - 16;
            }
            this.setTileBounds(this.fakeMinX / 16,this.tileMinY,this.tileMaxX,this.tileMaxY,false);
         }
         if(this.dFakeMinY != this.fakeMinY)
         {
            this.fakeMinY = (this.fakeMinY * 90 + this.dFakeMinY * 10) / 100 - 0.4;
            if(this.fakeMinY < this.minY - 16)
            {
               this.dFakeMinY = this.fakeMinY = this.minY - 16;
            }
            this.setTileBounds(this.tileMinX,this.fakeMinY / 16,this.tileMaxX,this.tileMaxY,false);
         }
      }
   }
}
