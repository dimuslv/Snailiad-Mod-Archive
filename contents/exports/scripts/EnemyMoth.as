 
package
{
   public class EnemyMoth extends Enemy
   {
      
      private static const IMG_WIDTH:int = 16;
      
      private static const IMG_HEIGHT:int = 16;
      
      private static const IMG_OFS_X:int = 0;
      
      private static const IMG_OFS_Y:int = 0;
      
      private static const MAX_HP:int = 50;
      
      private static const DEFENSE:int = 3;
      
      private static const OFFENSE:int = 6;
      
      private static const DIR_LEFT:int = 1;
      
      private static const DIR_UP:int = 2;
      
      private static const DIR_RIGHT:int = 3;
      
      private static const DIR_DOWN:int = 4;
      
      private static const MAX_SPEED:int = 8;
      
      private static const CHECK_DISTANCE:int = 10;
      
      private static const CHECK_WIDTH:int = 24;
       
      
      private var _detectRange_UL:Array;
      
      private var _detectRange_DR:Array;
      
      private var _moveDir:Array;
      
      private var _facingDir:int;
      
      private var _isAttacking:Boolean = false;
      
      private var _speed:int = 0;
      
      public function EnemyMoth(param1:int, param2:int)
      {
         super(param1,param2,MAX_HP,DEFENSE,OFFENSE);
         loadGraphic(Art.EnemyMoth,true,true,IMG_WIDTH,IMG_HEIGHT);
         width = IMG_WIDTH;
         height = IMG_HEIGHT;
         param1 -= IMG_OFS_X;
         param2 -= IMG_OFS_Y;
         addAnimation("normal",[0]);
         addAnimation("idle1",[0,1],5,true);
         addAnimation("idle2",[4,5],5,true);
         addAnimation("idle3",[8,9],5,true);
         addAnimation("idle4",[12,13],5,true);
         addAnimation("attack1",[2,3],30,true);
         addAnimation("attack2",[6,7],30,true);
         addAnimation("attack3",[10,11],30,true);
         addAnimation("attack4",[14,15],30,true);
         play("normal");
         if(PlayState.worldMap.enemySolidAt(param1 + 16,param2))
         {
            this._facingDir = DIR_LEFT;
            this._detectRange_UL = [x - CHECK_DISTANCE,y + CHECK_WIDTH];
            this._detectRange_DR = [x,y - CHECK_WIDTH];
            this._moveDir = [-1,0];
         }
         else if(PlayState.worldMap.enemySolidAt(param1 - 16,param2))
         {
            this._facingDir = DIR_RIGHT;
            this._detectRange_UL = [x,y + CHECK_WIDTH];
            this._detectRange_DR = [x + CHECK_DISTANCE,y - CHECK_WIDTH];
            this._moveDir = [1,0];
         }
         else if(PlayState.worldMap.enemySolidAt(param1,param2 - 16))
         {
            this._facingDir = DIR_DOWN;
            this._detectRange_UL = [x - CHECK_WIDTH,y];
            this._detectRange_DR = [x + CHECK_WIDTH,y - CHECK_DISTANCE];
            this._moveDir = [0,1];
         }
         else
         {
            this._facingDir = DIR_UP;
            this._detectRange_UL = [x - CHECK_WIDTH,y + CHECK_DISTANCE];
            this._detectRange_DR = [x + CHECK_WIDTH,y];
            this._moveDir = [0,-1];
         }
         play("idle" + this._facingDir);
      }
      
      override public function touch(param1:Player) : void
      {
         super.touch(param1);
         PlayState.explosionPool.boom(x - 8,y - 8,1);
         Sfx.playEnemyKilled();
         kill();
      }
      
      public function updatePosition() : void
      {
         if(this._speed < MAX_SPEED)
         {
            ++this._speed;
         }
         x += this._moveDir[0] * this._speed;
         y += this._moveDir[1] * this._speed;
      }
      
      override public function update() : void
      {
         var seesPlayer:* = undefined;
         if(PlayState.realState != PlayState.STATE_GAME)
         {
            return;
         }
         if(onScreen() && !PlayState.player.dead)
         {
            seesPlayer = false;
            switch(this._facingDir)
            {
               case 1:
                  if(Math.abs(PlayState.player.y - y) < CHECK_WIDTH)
                  {
                     seesPlayer = true;
                  }
                  break;
               case 2:
                  if(Math.abs(PlayState.player.x - x) < CHECK_WIDTH)
                  {
                     seesPlayer = true;
                  }
                  break;
               case 3:
                  if(Math.abs(PlayState.player.y - y) < CHECK_WIDTH)
                  {
                     seesPlayer = true;
                  }
                  break;
               case 4:
                  if(Math.abs(PlayState.player.x - x) < CHECK_WIDTH)
                  {
                     seesPlayer = true;
                  }
            }
            if(seesPlayer && !this._isAttacking)
            {
               play("attack" + this._facingDir);
               this._isAttacking = true;
               Sfx.playGigaWave();
            }
         }
         if(this._isAttacking)
         {
            this.updatePosition();
         }
         if(PlayState.worldMap.enemySolidAt(x + 8,y + 8))
         {
            PlayState.explosionPool.boom(x - 8,y - 8,1);
            Sfx.playEnemyKilled();
            kill();
         }
         super.update();
      }
      
      override public function hurt(param1:Number) : void
      {
         super.hurt(param1);
      }
   }
}
