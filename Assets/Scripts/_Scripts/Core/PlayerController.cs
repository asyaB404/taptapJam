﻿using Myd.Common;
using Myd.Platform.Core;
using System;
using cfg;
using UI.Panel;
using UnityEngine;
using Object = UnityEngine.Object;

namespace Myd.Platform
{
    public struct Asix
    {
        public float moveX;
        public float MoveY;
    }

    /// <summary>
    /// 玩家操作控制器
    /// </summary>
    public partial class PlayerController
    {
        private readonly int GroundMask;
        private readonly int SafeGroundMask;
        private readonly int HurtMask;
        private readonly int HurtMaskPro;
        
        // Player的最大生命，当前生命和灵力
        private float playerMaxHealth;
        private float playerHealth;
        private float playerMaxStamina;
        private float playerStamina;
        
        
        private static float cooldownTime = 1f; // 冷却时间为1秒
        private static float lastFireTime = -cooldownTime; // 上次发射时间
        
        // 能力锁定相关
        private bool dashUnlocked = false;
        public bool laserUnlocked = false;

        //临时复活点
        public Vector3 temporaryResurgencePosition=new(0,0,-100);
        //堂堂复活
        public void Resurgence(){
            // Debug.Log("复活！！");
            if(temporaryResurgencePosition.z==-100)temporaryResurgencePosition=Game.Instance.level.StartPosition; 
            // Debug.Log(temporaryResurgencePosition);
            Position=temporaryResurgencePosition;
            PlayerHealth=playerMaxHealth;
        }

        public float PlayerHealth
        {
            get => playerHealth;
            set
            {
                playerHealth = Mathf.Clamp(value, 0, this.playerMaxHealth);
                if(GamePanel.Instance && GamePanel.Instance.IsInStack) GamePanel.Instance.UpdateHealthDisPlay();
                if(playerHealth==0){
                    Resurgence();
                }
            }
        }

        public float PlayerStamina
        {
            get => playerStamina;
            set
            {
                playerStamina = Mathf.Clamp(value, 0, Constants.playerMaxStamina);
                if(GamePanel.Instance && GamePanel.Instance.IsInStack) GamePanel.Instance.UpdateStaminaDisPlay();
            }
        }


        float varJumpTimer;
        float varJumpSpeed; //
        int moveX;
        private float maxFall;
        private float fastMaxFall;

        private float beHurtCooldownTimer; // 受伤冷却时间 为0时，可以再次受伤
        private float dashCooldownTimer;                //冲刺冷却时间计数器，为0时，可以再次冲刺
        private float dashRefillCooldownTimer;          //
        public int dashes;
        public int lastDashes;
        private float wallSpeedRetentionTimer; // If you hit a wall, start this timer. If coast is clear within this timer, retain h-speed
        private float wallSpeedRetained;

        private bool onGround;
        private bool wasOnGround;
        
        public bool DashStartedOnGround { get; set; }

        public int ForceMoveX { get; set; }
        public float ForceMoveXTimer { get; set; }

        public int HopWaitX;   // If you climb hop onto a moving solid, snap to beside it until you get above it
        public float HopWaitXSpeed;

        public bool launched;
        public float launchedTimer;
        public float WallSlideTimer { get; set; } = Constants.WallSlideTime;
        public int WallSlideDir { get; set; }
        public JumpCheck JumpCheck { get; set; }    //土狼时间
        public WallBoost WallBoost { get; set; }    //WallBoost
        private FiniteStateMachine<BaseActionState> stateMachine;

        public ISpriteControl SpriteControl { get; private set; }
        //特效控制器
        public IEffectControl EffectControl { get; private set; } 
        //音效控制器
        public ISoundControl SoundControl { get; private set; }
        public ICamera camera { get; private set; }
        public PlayerController(ISpriteControl spriteControl, IEffectControl effectControl)
        {
            this.SpriteControl = spriteControl;
            this.EffectControl = effectControl;

            this.stateMachine = new FiniteStateMachine<BaseActionState>((int)EActionState.Size);
            this.stateMachine.AddState(new NormalState(this));
            this.stateMachine.AddState(new DashState(this));
            this.stateMachine.AddState(new ClimbState(this));
            // 添加HurtSate
            this.stateMachine.AddState(new HurtState(this));
            this.GroundMask = LayerMask.GetMask("Ground");
            // 添加HurtMask
            this.HurtMask = LayerMask.GetMask("Hurt");
            this.HurtMaskPro= LayerMask.GetMask("HurtPro");
            this.SafeGroundMask=LayerMask.GetMask("SafeArea");

            this.Facing  = Facings.Right;
            this.LastAim = Vector2.right;
            
            // 注册事件（能力解锁相关）
            EventMgr.RegisterEvent(EventTypes.UnlockDash, UnlockDash);
            EventMgr.RegisterEvent(EventTypes.LockDash, LockDash);
            EventMgr.RegisterEvent(EventTypes.UnlockLaser, UnlockLaser);
            EventMgr.RegisterEvent(EventTypes.LockLaser, LockLaser);
            EventMgr.RegisterEvent("GetlaserUnlocked", GetlaserUnlocked);
            EventMgr.RegisterEvent("GetdashUnlocked",GetdashUnlocked);
            EventMgr.RegisterEvent(EventTypes.GetPlayerFacing, GetPlayerFacing);


        }

        public void RefreshAbility()
        {

            this.JumpCheck = new JumpCheck(this, Constants.EnableJumpGrace);

            if (!Constants.EnableWallBoost)
            {
                this.WallBoost = null;
            }
            else
            {
                this.WallBoost = this.WallBoost == null ? new WallBoost(this) : this.WallBoost;
            }
        }

        public void Init(Bounds bounds, Vector2 startPosition)
        {
            //根据进入的方式,决定初始状态
            this.stateMachine.State = (int)EActionState.Normal;
            this.lastDashes = this.dashes = 1;
            this.Position = startPosition;
            this.collider = normalHitbox;

            this.SpriteControl.SetSpriteScale(NORMAL_SPRITE_SCALE);

            this.bounds = bounds;
            this.cameraPosition = CameraTarget;
            // TODO 初始化尾巴颜色
            // Color color = NormalHairColor;
            // Gradient gradient = new Gradient();
            // gradient.SetKeys(
            //     new GradientColorKey[] { new GradientColorKey(color, 0.0f), new GradientColorKey(color, 1.0f) },
            //     new GradientAlphaKey[] { new GradientAlphaKey(1, 0.0f), new GradientAlphaKey(1, 0.6f), new GradientAlphaKey(0, 1.0f) }
            // );
            //
            // this.player.SetTrailColor(gradient);
            
            // 最大生命值和灵力值
            playerMaxHealth = Constants.playerMaxHealth;
            playerMaxStamina = Constants.playerMaxStamina;
            // 当前生命
            playerHealth = playerMaxHealth;
            // 当前灵力
            playerStamina = playerMaxStamina;
        }
        

        public void Update(float deltaTime)
        {
            //更新各个组件中变量的状态
            {
                //Get ground
                wasOnGround = onGround;
                if (Speed.y <= 0)
                {
                    this.onGround = CheckGround();//碰撞检测地面
                }
                else
                {
                    this.onGround = false;
                }

                //Wall Slide
                if (this.WallSlideDir != 0)
                {
                    this.WallSlideTimer = Math.Max(this.WallSlideTimer - deltaTime, 0);
                    this.WallSlideDir = 0;
                }
                if (this.onGround && this.stateMachine.State != (int)EActionState.Climb)
                {
                    this.WallSlideTimer = Constants.WallSlideTime;
                }
                //Wall Boost, 不消耗体力WallJump
                this.WallBoost?.Update(deltaTime);
                
                //跳跃检查
                this.JumpCheck?.Update(deltaTime);

                //Dash
                {
                    if (dashCooldownTimer > 0)
                        dashCooldownTimer -= deltaTime;
                    if (dashRefillCooldownTimer > 0)
                    {
                        dashRefillCooldownTimer -= deltaTime;
                    }
                    else if (onGround)
                    {
                        RefillDash();
                    }
                }
                
                // BeHurt
                if (beHurtCooldownTimer > 0)
                {
                    beHurtCooldownTimer -= deltaTime;
                }
                

                //Var Jump
                if (varJumpTimer > 0)
                {
                    varJumpTimer -= deltaTime;
                }

                // 玩家的移动
                //Force Move X
                if (ForceMoveXTimer > 0)
                {
                    ForceMoveXTimer -= deltaTime;
                    this.moveX = ForceMoveX;
                }
                else
                {
                    //输入
                    this.moveX = Math.Sign(UnityEngine.Input.GetAxisRaw("Horizontal"));
                }

                //Facing
                if (moveX != 0 && this.stateMachine.State != (int)EActionState.Climb)
                {
                    Facing = (Facings)moveX;
                }
                //Aiming
                LastAim = GameInput.GetAimVector(Facing);

                //撞墙以后的速度保持，Wall Speed Retention，用于撞开
                if (wallSpeedRetentionTimer > 0)
                {
                    if (Math.Sign(Speed.x) == -Math.Sign(wallSpeedRetained))
                        wallSpeedRetentionTimer = 0;
                    else if (!CollideCheck(Position, Vector2.right * Math.Sign(wallSpeedRetained)))
                    {
                        Speed.x = wallSpeedRetained;
                        wallSpeedRetentionTimer = 0;
                    }
                    else
                        wallSpeedRetentionTimer -= deltaTime;
                }

                //Hop Wait X
                if (this.HopWaitX != 0)
                {
                    if (Math.Sign(Speed.x) == -HopWaitX || Speed.y < 0)
                        this.HopWaitX = 0;
                    else if (!CollideCheck(Position, Vector2.right * this.HopWaitX))
                    {
                        Speed.x = this.HopWaitXSpeed;
                        this.HopWaitX = 0;
                    }
                }

                //Launch Particles
                if (launched)
                {
                    var sq = Speed.SqrMagnitude();
                    if (sq < Constants.LaunchedMinSpeedSq)
                        launched = false;
                    else
                    {
                        var was = launchedTimer;
                        launchedTimer += deltaTime;

                        if (launchedTimer >= .5f)
                        {
                            launched = false;
                            launchedTimer = 0;
                        }
                        else if (Calc.OnInterval(launchedTimer, was, 0.15f))
                        {
                            EffectControl.SpeedRing(this.Position, this.Speed.normalized);
                        }
                    }
                }
                else
                    launchedTimer = 0;

            }

            //状态机更新逻辑
            stateMachine.Update(deltaTime);
            //更新位置
            UpdateCollideX(Speed.x * deltaTime);
            UpdateCollideY(Speed.y * deltaTime);

            UpdateHair(deltaTime);

            UpdateCamera(deltaTime);
        }

        //处理跳跃,跳跃时候，会给跳跃前方一个额外的速度
        public void Jump()
        {
            GameInput.Jump.ConsumeBuffer();
            this.JumpCheck?.ResetTime();
            this.WallSlideTimer = Constants.WallSlideTime;
            this.WallBoost?.ResetTime();
            this.varJumpTimer = Constants.VarJumpTime;
            this.Speed.x += Constants.JumpHBoost * moveX;
            this.Speed.y = Constants.JumpSpeed;
            //Speed += LiftBoost;
            this.varJumpSpeed = this.Speed.y;
            
            AudioMgr.PlaySound(EnumAudioClip.主角受击);
            EventMgr.ExecuteEvent(EventTypes.PlayJumpAni);
            this.PlayJumpEffect(SpritePosition, Vector2.up);
        }

        //SuperJump，表示在地面上或者土狼时间内，Dash接跳跃。
        //数值方便和Jump类似，数值变大。
        //蹲伏状态的SuperJump需要额外处理。
        //Dash->Jump->Dush
        public void SuperJump()
        {
            GameInput.Jump.ConsumeBuffer();
            this.JumpCheck?.ResetTime();
            varJumpTimer = Constants.VarJumpTime;
            this.WallSlideTimer = Constants.WallSlideTime;
            this.WallBoost?.ResetTime();

            this.Speed.x = Constants.SuperJumpH * (int)Facing;
            this.Speed.y = Constants.JumpSpeed;
            //Speed += LiftBoost;
            if (Ducking)
            {
                Ducking = false;
                this.Speed.x *= Constants.DuckSuperJumpXMult;
                this.Speed.y *= Constants.DuckSuperJumpYMult;
            }

            varJumpSpeed = Speed.y;
            //TODO 
            launched = true;

            this.PlayJumpEffect(this.SpritePosition, Vector2.up);
        }

        //在墙边情况下的，跳跃。主要需要考虑当前跳跃朝向
        public void WallJump(int dir)
        {
            // GameInput.Jump.ConsumeBuffer();
            // Ducking = false;
            // this.JumpCheck?.ResetTime();
            // varJumpTimer = Constants.VarJumpTime;
            // this.WallSlideTimer = Constants.WallSlideTime;
            // this.WallBoost?.ResetTime();
            // if (moveX != 0)
            // {
            //     this.ForceMoveX = dir;
            //     this.ForceMoveXTimer = Constants.WallJumpForceTime;
            // }
            //
            // Speed.x = Constants.WallJumpHSpeed * dir;
            // Speed.y = Constants.JumpSpeed;
            // //TODO 考虑电梯对速度的加成
            // //Speed += LiftBoost;
            // varJumpSpeed = Speed.y;
            //
            // //墙壁粒子效果。
            // if (dir == -1)
            //     this.PlayJumpEffect(this.RightPosition, Vector2.left);
            // else
            //     this.PlayJumpEffect(this.LeftPosition, Vector2.right);
            
        }

        public void ClimbJump()
        {
            if (!onGround)
            {
                //Stamina -= ClimbJumpCost;

                //sweatSprite.Play("jump", true);
                //Input.Rumble(RumbleStrength.Light, RumbleLength.Medium);
            }
            Jump();
            WallBoost?.Active();
        }

        //在墙边Dash时，当前按住上，不按左右时，执行SuperWallJump
        public void SuperWallJump(int dir)
        {
            GameInput.Jump.ConsumeBuffer();
            Ducking = false;
            this.JumpCheck?.ResetTime();
            varJumpTimer = Constants.SuperWallJumpVarTime;
            this.WallSlideTimer = Constants.WallSlideTime;
            this.WallBoost?.ResetTime();

            Speed.x = Constants.SuperWallJumpH * dir;
            Speed.y = Constants.SuperWallJumpSpeed;
            //Speed += LiftBoost;
            varJumpSpeed = Speed.y;
            launched = true;

            if (dir == -1)
                this.PlayJumpEffect(this.RightPosition, Vector2.left);
            else
                this.PlayJumpEffect(this.LeftPosition, Vector2.right);
        }

        public bool RefillDash()
        {
            if (this.dashes < Constants.MaxDashes)
            {
                this.dashes = Constants.MaxDashes;
                return true;
            }
            else
                return false;
        }

        
        

        public bool CanDash
        {
            get
            {
                // 增加玩家是否能Dash
                return dashUnlocked && GameInput.Dash.Pressed() && dashCooldownTimer <= 0 && this.dashes > 0;
            }
        }

        public float WallSpeedRetentionTimer
        {
            get { return this.wallSpeedRetentionTimer; }
            set { this.wallSpeedRetentionTimer = value; }
        }
        public Vector2 Speed;

        public object Holding => null;

        public bool OnGround => this.onGround;
        private Color groundColor = Color.white;
        public Color GroundColor => this.groundColor;
        public Vector2 Position { get; private set; }
        //表示进入爬墙状态有0.1秒时间,不发生移动，为了让玩家看清发生了爬墙的动作
        public void SetPosition(Vector3 v){Position=v;}
        public float ClimbNoMoveTimer { get; set; }
        public float VarJumpSpeed => this.varJumpSpeed;

        public float VarJumpTimer
        {
            get
            {
                return this.varJumpTimer;
            }
            set
            {
                this.varJumpTimer = value;
            }
        }

        public int MoveX => moveX;
        public int MoveY => Math.Sign(UnityEngine.Input.GetAxisRaw("Vertical"));

        public float MaxFall { get => maxFall; set => maxFall = value; }
        public float DashCooldownTimer { get => dashCooldownTimer; set => dashCooldownTimer = value; }
        public float HurtCooldownTimer { get => beHurtCooldownTimer; set => beHurtCooldownTimer = value; }
        public float DashRefillCooldownTimer { get => dashRefillCooldownTimer; set => dashRefillCooldownTimer = value; }
        public Vector2 LastAim { get; set; }
        public Facings Facing { get; set; }  //当前朝向

        public EActionState Dash()
        {
            //wasDashB = Dashes == 2;
            this.dashes = Math.Max(0, this.dashes - 1);
            GameInput.Dash.ConsumeBuffer();
            return EActionState.Dash;
        }
        public void SetState(int state)
        {
            this.stateMachine.State = state;
        }

        /// <summary>
        /// 是否下蹲
        /// </summary>
        public bool Ducking
        {
            get
            {
                return this.collider == this.duckHitbox || this.collider == this.duckHurtbox;
            }
            set
            {
                if (value)
                {
                    this.collider = this.duckHitbox;
                    return;
                }
                else
                {
                    this.collider = this.normalHitbox;
                }
                PlayDuck(value);
            }
        }
        
        //检测当前是否可以站立
        public bool CanUnDuck
        {
            get
            {
                if (!Ducking)
                    return true;
                Rect lastCollider = this.collider;
                this.collider = normalHitbox;
                bool noCollide = !CollideCheck(this.Position, Vector2.zero);
                this.collider = lastCollider;
                return noCollide;
            }
        }

        public bool DuckFreeAt(Vector2 at)
        {
            Vector2 oldP = Position;
            Rect oldC = this.collider;
            Position = at;
            this.collider = duckHitbox;

            bool ret = !CollideCheck(this.Position, Vector2.zero);

            this.Position = oldP;
            this.collider = oldC;

            return ret;
        }
        public bool IsFall
        {
            get
            {
                return !this.wasOnGround && this.OnGround;
            }
        }
        
        
        /// <summary>
        /// 是否能受伤
        /// </summary>
        public bool CanBeHurt
        {
            get
            {
                return beHurtCooldownTimer <= 0;
            }
        }
        
        /// <summary>
        /// 发射子弹
        /// </summary>
        /// <param name="ctxPosition"></param>
        /// <param name="direction"></param>
        public void ShootBullet()
        {
            // 获取鼠标位置
            Vector3 mousePosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            mousePosition.z = 0; // 确保 z 坐标为 0

            // 计算发射方向
            Vector2 direction = (mousePosition - (Vector3)this.Position).normalized;

            // 发射子弹
            FireBullet(this.Position, direction);
        }
        
        private void FireBullet(Vector2 startPosition, Vector2 direction)
        {
            if (Time.time - lastFireTime < cooldownTime)
            {
                return; // 冷却时间未到，不能发射子弹
            }

            // 创建子弹实例（假设有一个 Bullet 类）
           Object.Instantiate(AssetMgr.LoadAssetSync<GameObject>
                ("Assets/AddressableAssets/GameRes/Prefabs/Bullet.prefab"), startPosition, Quaternion.identity);
           lastFireTime = Time.time; // 重置上次发射时间
        }
        
        
        // Dash解锁相关
        private object UnlockDash(object[] args)
        {
            Debug.Log("Dash Unlocked");;
            dashUnlocked = true;
            return null;
        }

        // Dash锁定相关
        private object LockDash(object[] args)
        {
            dashUnlocked = false;
            return null;
        }
        
        // 右键激光解锁相关
        
        private object UnlockLaser(object[] args)
        {
            laserUnlocked = true;
            return null;
        }
        // 右键激光锁定相关
        private object LockLaser(object[] args)
        {
            laserUnlocked = false;
            return null;
        }
        private object GetdashUnlocked(object[] args){
            return  dashUnlocked;
        }private object GetlaserUnlocked(object[] args){
            return  laserUnlocked;
        }

        private object GetPlayerFacing(object[] args)
        {
            return Facing == Facings.Right;
        }
    }
}